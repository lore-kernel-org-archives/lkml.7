Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BD12070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582474;
	bh=DvrZ+cuFMyPWMLjOVt5f/7qKuNdPg/URmGxbkQVsgL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZfGwatUoyu/Lf24Q1Xu3uTUX05wtxt6/BgraAzgtmGboyRx/aWKjHN0xtJh8a8iF
	 H+COvsvEzIWrj62wuNrLmNiboHLz+jN4oCtcmDGgS+oMjBS/k8RI9rA890CJ1SQQlg
	 iY5VCxTCtUXa+YABU5Jsh26pQID5D890F32mpmYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfCZGlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732431AbfCZGlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:41:04 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA172087C;
        Tue, 26 Mar 2019 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582464;
        bh=DvrZ+cuFMyPWMLjOVt5f/7qKuNdPg/URmGxbkQVsgL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxZMlr8WWPgIt1ZNNZvXDfAQXoQKbd9q6z9N5VMaOumPtSyu8EozwZ4xtBygbKohg
         QcpcpitszBy0Z7Ek4W9PaIffsza1xY5NL95CdE/7YDUS6YoiTnE2fr/NS+Lo562n8H
         mqh4Ya50IJTfEDYIN2CTu0C+tce1ciALj2Am7yhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+017a32f149406df32703@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.0 37/52] Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf()
Date:   Tue, 26 Mar 2019 15:30:24 +0900
Message-Id: <20190326042702.959977113@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myungho Jung <mhjungk@gmail.com>

commit 1dc2d785156cbdc80806c32e8d2c7c735d0b4721 upstream.

h4_recv_buf() callers store the return value to socket buffer and
recursively pass the buffer to h4_recv_buf() without protection. So,
ERR_PTR returned from h4_recv_buf() can be dereferenced, if called again
before setting the socket buffer to NULL from previous error. Check if
skb is ERR_PTR in h4_recv_buf().

Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/h4_recv.h |    4 ++++
 drivers/bluetooth/hci_h4.c  |    4 ++++
 2 files changed, 8 insertions(+)

--- a/drivers/bluetooth/h4_recv.h
+++ b/drivers/bluetooth/h4_recv.h
@@ -60,6 +60,10 @@ static inline struct sk_buff *h4_recv_bu
 					  const struct h4_recv_pkt *pkts,
 					  int pkts_count)
 {
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;
 
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -174,6 +174,10 @@ struct sk_buff *h4_recv_buf(struct hci_d
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	u8 alignment = hu->alignment ? hu->alignment : 1;
 
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;
 


