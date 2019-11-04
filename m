Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43990CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFE8204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905868;
	bh=QziZ4j+8RK8f2BmIJU3EU/bYyEBqCTLtXBLdOT5SdDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u4x+5o2A34YTYqK11CBE6/k1PzWafi/DO5Syu/m/HdmPY1QMKQoNvWPZJnIW42wNk
	 p1S4YaxpabSFQlcc+ckXUO/wIYwyw+Hgdc5tVifu3+WPvBOT9qi+Kz9y8qfXU97RVc
	 Arx+Pk0DX6+SJLVNRbbLLhMy+renA0B4bckVOt48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbfKDWRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbfKDWCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:02:23 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1076217F4;
        Mon,  4 Nov 2019 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904942;
        bh=QziZ4j+8RK8f2BmIJU3EU/bYyEBqCTLtXBLdOT5SdDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyUkSZhqiQaLWSmLJgYU+HZnl0yz/G9JFou+uKQXx1c5oU2pfsIWOrVwQ7Xd0vn3T
         lK3ZrYxD3mzEKaEOd1PgxR8kiaQ93TcRNIvh21ZSmOfZ2aeGoFZBqMd8UW5uxikVXk
         2TI2aHGIt6hz2Uc/YZoJFvrdC0xzE6XUthv171As=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 122/149] scsi: target: cxgbit: Fix cxgbit_fw4_ack()
Date:   Mon,  4 Nov 2019 22:45:15 +0100
Message-Id: <20191104212144.845622925@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit fc5b220b2dcf8b512d9bd46fd17f82257e49bf89 upstream.

Use the pointer 'p' after having tested that pointer instead of before.

Fixes: 5cadafb236df ("target/cxgbit: Fix endianness annotations")
Cc: Varun Prakash <varun@chelsio.com>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191023202150.22173-1-bvanassche@acm.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -1832,7 +1832,7 @@ static void cxgbit_fw4_ack(struct cxgbit
 
 	while (credits) {
 		struct sk_buff *p = cxgbit_sock_peek_wr(csk);
-		const u32 csum = (__force u32)p->csum;
+		u32 csum;
 
 		if (unlikely(!p)) {
 			pr_err("csk 0x%p,%u, cr %u,%u+%u, empty.\n",
@@ -1841,6 +1841,7 @@ static void cxgbit_fw4_ack(struct cxgbit
 			break;
 		}
 
+		csum = (__force u32)p->csum;
 		if (unlikely(credits < csum)) {
 			pr_warn("csk 0x%p,%u, cr %u,%u+%u, < %u.\n",
 				csk,  csk->tid,


