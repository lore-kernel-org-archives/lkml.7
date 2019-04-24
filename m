Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6386FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF920652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129190;
	bh=VOb9Bwitmue9DiAYWxTTRHG6niZSlzsQsKGb8HdT0Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehs+LPtgQHeRvJDBU16TbzwyYMEy/0kfwLtBdI6Q/GyMqg7oNpR3uVdC0KA5UKJOP
	 h5WGxOQrlfhQO0FaKs8bQvRVG8Paxy7EgRiwYh5uFuqdBsLkU2R+ZvfRywhhVn8GKA
	 rFbhlQStjkQz9J9I6kfj3p4stCWr4Z/YZVVrs+Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfDXRRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388715AbfDXRRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:47 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99723218B0;
        Wed, 24 Apr 2019 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126267;
        bh=VOb9Bwitmue9DiAYWxTTRHG6niZSlzsQsKGb8HdT0Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRvVFgBYdrQcz9mXLLQFLcqsjxBaj0+SxnreCPy5iO9izBTDOifN9wqCSnk4q20jR
         fD9BX1fL6s6nJZdWOAZFjG3xbyx7SpbtSfPYdJqnPrhCe6HnLgxGMWI+lv+u6rPFoF
         xPD0f2hEoakKFd6wzucP8GMl5gVrNd65NljAWdms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 008/168] Bluetooth: Fix decrementing reference count twice in releasing socket
Date:   Wed, 24 Apr 2019 19:07:32 +0200
Message-Id: <20190424170923.969536865@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_sock.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -558,13 +558,12 @@ static int hci_sock_release(struct socke
 	if (!sk)
 		return 0;
 
-	hdev = hci_pi(sk)->hdev;
-
 	if (hci_pi(sk)->channel == HCI_CHANNEL_MONITOR)
 		atomic_dec(&monitor_promisc);
 
 	bt_sock_unlink(&hci_sk_list, sk);
 
+	hdev = hci_pi(sk)->hdev;
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			/* When releasing an user channel exclusive access,


