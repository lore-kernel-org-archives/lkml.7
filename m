Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2447AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D642070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582042;
	bh=88Zd9Vu4cuW9cvnJF6y0OEBFnoOGcmuQvo9LpmTL2aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yyFqr6GKZhOmwCPepnJyv5vc9bOcXVyCJ90zCMSWAQgsopJ1WqkkfBX3e6KUVgu7Z
	 hHV33eb8J8yibb9aU6v5EmjqgelYq+x7nJfyzLOln4ZTap1HWTvQGqBCXmB8RvebYI
	 x3jVV+jB72hhsQbEM/2Qfd6odUlWBRhFaNW7NySc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfCZGeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbfCZGd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:58 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9185020857;
        Tue, 26 Mar 2019 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582038;
        bh=88Zd9Vu4cuW9cvnJF6y0OEBFnoOGcmuQvo9LpmTL2aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHLflrHRlpIHE3ODi4Ey2BSWI2ymiwvFoPsSFoIWxTHrV5aG8Wi5gyoJu+i20H0mt
         Ut/J9vn82cM7/tiQtp2adfZsCd46thaF7lfu/AAo11eXtyRgApMf7yW3qwyiTZseSZ
         fd4pns14WvE7TeLQGt8WugLyJpBZmLly7kpjEuyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+017a32f149406df32703@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 19/41] Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf()
Date:   Tue, 26 Mar 2019 15:29:56 +0900
Message-Id: <20190326042650.963542802@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/bluetooth/hci_h4.c |    4 ++++
 1 file changed, 4 insertions(+)

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
 


