Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD72C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551852081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098649;
	bh=6LL9S0Uxsj0fj25dKAsoqKo7KsJPE5e1KeQC7KL+JZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PKUz4ixzS4nL1njiHbyR57p5kxsKWzx97V7XqkmlSChEv212+CG1oNC6ktvu7zZ/R
	 QQPt4SD57O5lz0AsDcjbQ76woxzWHVzvXfVTkVNZuNBFvKFWlbU4nEJ46XHMxpHM/w
	 5e/R3BpnlI2XNZ0BC0UADlas2H3/eND7Qf1+ZsNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfFIQoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfFIQoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6223320833;
        Sun,  9 Jun 2019 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098645;
        bh=6LL9S0Uxsj0fj25dKAsoqKo7KsJPE5e1KeQC7KL+JZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KG0qeemyzbQz6DoBUdI66HO3HFDMO3TAI6CEfP8TPOt9WM9Orq/OaH1HDuitJjYhj
         Xtp7SpMBszZEOXfLz9wv7E+FCnzqACMBXJKxEiFHMu1R76T0eujbROebJJh5WGkPQA
         WCQtTj6OAZdzhdNvv3FloGek0PtTGicA4cEYvEHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matteo Croce <mcroce@redhat.com>
Subject: [PATCH 5.1 10/70] pktgen: do not sleep with the thread lock held.
Date:   Sun,  9 Jun 2019 18:41:21 +0200
Message-Id: <20190609164128.063017165@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 720f1de4021f09898b8c8443f3b3e995991b6e3a ]

Currently, the process issuing a "start" command on the pktgen procfs
interface, acquires the pktgen thread lock and never release it, until
all pktgen threads are completed. The above can blocks indefinitely any
other pktgen command and any (even unrelated) netdevice removal - as
the pktgen netdev notifier acquires the same lock.

The issue is demonstrated by the following script, reported by Matteo:

ip -b - <<'EOF'
	link add type dummy
	link add type veth
	link set dummy0 up
EOF
modprobe pktgen
echo reset >/proc/net/pktgen/pgctrl
{
	echo rem_device_all
	echo add_device dummy0
} >/proc/net/pktgen/kpktgend_0
echo count 0 >/proc/net/pktgen/dummy0
echo start >/proc/net/pktgen/pgctrl &
sleep 1
rmmod veth

Fix the above releasing the thread lock around the sleep call.

Additionally we must prevent racing with forcefull rmmod - as the
thread lock no more protects from them. Instead, acquire a self-reference
before waiting for any thread. As a side effect, running

rmmod pktgen

while some thread is running now fails with "module in use" error,
before this patch such command hanged indefinitely.

Note: the issue predates the commit reported in the fixes tag, but
this fix can't be applied before the mentioned commit.

v1 -> v2:
 - no need to check for thread existence after flipping the lock,
   pktgen threads are freed only at net exit time
 -

Fixes: 6146e6a43b35 ("[PKTGEN]: Removes thread_{un,}lock() macros.")
Reported-and-tested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/pktgen.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3066,7 +3066,13 @@ static int pktgen_wait_thread_run(struct
 {
 	while (thread_is_running(t)) {
 
+		/* note: 't' will still be around even after the unlock/lock
+		 * cycle because pktgen_thread threads are only cleared at
+		 * net exit
+		 */
+		mutex_unlock(&pktgen_thread_lock);
 		msleep_interruptible(100);
+		mutex_lock(&pktgen_thread_lock);
 
 		if (signal_pending(current))
 			goto signal;
@@ -3081,6 +3087,10 @@ static int pktgen_wait_all_threads_run(s
 	struct pktgen_thread *t;
 	int sig = 1;
 
+	/* prevent from racing with rmmod */
+	if (!try_module_get(THIS_MODULE))
+		return sig;
+
 	mutex_lock(&pktgen_thread_lock);
 
 	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
@@ -3094,6 +3104,7 @@ static int pktgen_wait_all_threads_run(s
 			t->control |= (T_STOP);
 
 	mutex_unlock(&pktgen_thread_lock);
+	module_put(THIS_MODULE);
 	return sig;
 }
 


