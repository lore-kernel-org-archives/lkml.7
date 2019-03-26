Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581951;
	bh=vfzNr8yPe3yVCwXK+f3Hq9CEcNsR4EOkSeWLWBD40XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xovmSSKwjl3Fw30BHnv8y/7zcVaF+4BqKBlVu/OS8bAGaSbcJ/9JtsHoqUDGkoI7y
	 he95yGYZTfk+PJKD5Zr4yHVnxIaXfbO9SmxI3Ud5YLEZBJH0GfEp8XendzU7x51k68
	 taMBkhs77Adpdt8fuFRixV9MezjzX5SjUoOMFMRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCZGca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfCZGc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:27 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E87720857;
        Tue, 26 Mar 2019 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581947;
        bh=vfzNr8yPe3yVCwXK+f3Hq9CEcNsR4EOkSeWLWBD40XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe2rebOVBeKvCF0ngBW+ogtsgUtOPVs9b2vIwBRMoFbCVJdKL0XAnFOZlUblUQp03
         bvxJRYfyxNG23UVXMAdSHxvqQ1aeHusTtIxMmV25h/RcahGvB4ZV/OVYE2q/nDEwvb
         ncbTq5+n0F87bQT+/yZPZS2CUuAnQYhgE+3qAuSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 15/30] Bluetooth: Fix decrementing reference count twice in releasing socket
Date:   Tue, 26 Mar 2019 15:29:54 +0900
Message-Id: <20190326042608.089012550@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myungho Jung <mhjungk@gmail.com>

commit e20a2e9c42c9e4002d9e338d74e7819e88d77162 upstream.

When releasing socket, it is possible to enter hci_sock_release() and
hci_sock_dev_event(HCI_DEV_UNREG) at the same time in different thread.
The reference count of hdev should be decremented only once from one of
them but if storing hdev to local variable in hci_sock_release() before
detached from socket and setting to NULL in hci_sock_dev_event(),
hci_dev_put(hdev) is unexpectedly called twice. This is resolved by
referencing hdev from socket after bt_sock_unlink() in
hci_sock_release().

Reported-by: syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_sock.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -826,8 +826,6 @@ static int hci_sock_release(struct socke
 	if (!sk)
 		return 0;
 
-	hdev = hci_pi(sk)->hdev;
-
 	switch (hci_pi(sk)->channel) {
 	case HCI_CHANNEL_MONITOR:
 		atomic_dec(&monitor_promisc);
@@ -849,6 +847,7 @@ static int hci_sock_release(struct socke
 
 	bt_sock_unlink(&hci_sk_list, sk);
 
+	hdev = hci_pi(sk)->hdev;
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			/* When releasing an user channel exclusive access,


