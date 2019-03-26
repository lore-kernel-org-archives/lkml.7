Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1C22070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582153;
	bh=0BevEbcUqAL/lG1+DqN9AZPw05PpPgoig7F1chCrLv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PtLF2q82jUuA4NxvAr0qeBsqUaeWR8otPfgrV3suJMjMbs0s3doDIUZDtqGUlqIiD
	 MbPI+QxRbhB9i69adLmN+7EMcqJzceumizaCk10lLy0No7WNsqbSCfa9t56G3qFtLf
	 8OFRdN07c+rIfRf56U+6FrJlaEk+/ty9OBHjtijI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfCZGfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfCZGft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:49 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6035C2070B;
        Tue, 26 Mar 2019 06:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582147;
        bh=0BevEbcUqAL/lG1+DqN9AZPw05PpPgoig7F1chCrLv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKv2NoCkKxg6m+8bkKVGwDs4IqbDwayiQkhglWWXuGqt/kJ6y3y5ODeg8NPS3pXk5
         ijNZusi41GQSyODRrxeFWa5TcGsKMntxqo8fPKmqvuy+6BzwujPsKwGIvu+bwLB79u
         y8z39YbiYYVnBv/Vmm0I9jvek5yc/Hi24sP+53n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 04/45] mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"
Date:   Tue, 26 Mar 2019 15:29:47 +0900
Message-Id: <20190326042702.923889703@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shiyan <shc_work@mail.ru>

commit 2b77158ffa92b820a0c5da9a3c6ead7aa069c71c upstream.

This reverts commit b189e7589f6d3411e85c6b7ae6eef158f08f388f.

Unable to handle kernel paging request at virtual address c8358000
pgd = efa405c3
[c8358000] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT ARM
CPU: 0 PID: 711 Comm: kworker/0:2 Not tainted 4.20.0+ #30
Hardware name: Freescale i.MX27 (Device Tree Support)
Workqueue: events mxcmci_datawork
PC is at mxcmci_datawork+0xbc/0x2ac
LR is at mxcmci_datawork+0xac/0x2ac
pc : [<c04e33c8>]    lr : [<c04e33b8>]    psr: 60000013
sp : c6c93f08  ip : 24004180  fp : 00000008
r10: c8358000  r9 : c78b3e24  r8 : c6c92000
r7 : 00000000  r6 : c7bb8680  r5 : c7bb86d4  r4 : c78b3de0
r3 : 00002502  r2 : c090b2e0  r1 : 00000880  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: a68a8000  DAC: 00000055
Process kworker/0:2 (pid: 711, stack limit = 0x389543bc)
Stack: (0xc6c93f08 to 0xc6c94000)
3f00:                   c7bb86d4 00000000 00000000 c6cbfde0 c7bb86d4 c7ee4200
3f20: 00000000 c0907ea8 00000000 c7bb86d8 c0907ea8 c012077c c6cbfde0 c7bb86d4
3f40: c6cbfde0 c6c92000 c6cbfdf4 c09280ba c0907ea8 c090b2e0 c0907ebc c0120c18
3f60: c6cbfde0 00000000 00000000 c6cbb580 c7ba7c40 c7837edc c6cbb598 00000000
3f80: c6cbfde0 c01208f8 00000000 c01254fc c7ba7c40 c0125400 00000000 00000000
3fa0: 00000000 00000000 00000000 c01010d0 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c04e33c8>] (mxcmci_datawork) from [<c012077c>] (process_one_work+0x1f0/0x338)
[<c012077c>] (process_one_work) from [<c0120c18>] (worker_thread+0x320/0x474)
[<c0120c18>] (worker_thread) from [<c01254fc>] (kthread+0xfc/0x118)
[<c01254fc>] (kthread) from [<c01010d0>] (ret_from_fork+0x14/0x24)
Exception stack(0xc6c93fb0 to 0xc6c93ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e3500000 1a000059 e5153050 e5933038 (e48a3004)
---[ end trace 54ca629b75f0e737 ]---
note: kworker/0:2[711] exited with preempt_count 1

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Fixes: b189e7589f6d ("mmc: mxcmmc: handle highmem pages")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/mxcmmc.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -292,11 +292,8 @@ static void mxcmci_swap_buffers(struct m
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(data->sg, sg, data->sg_len, i) {
-		void *buf = kmap_atomic(sg_page(sg) + sg->offset);
-		buffer_swap32(buf, sg->length);
-		kunmap_atomic(buf);
-	}
+	for_each_sg(data->sg, sg, data->sg_len, i)
+		buffer_swap32(sg_virt(sg), sg->length);
 }
 #else
 static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
@@ -613,7 +610,6 @@ static int mxcmci_transfer_data(struct m
 {
 	struct mmc_data *data = host->req->data;
 	struct scatterlist *sg;
-	void *buf;
 	int stat, i;
 
 	host->data = data;
@@ -621,18 +617,14 @@ static int mxcmci_transfer_data(struct m
 
 	if (data->flags & MMC_DATA_READ) {
 		for_each_sg(data->sg, sg, data->sg_len, i) {
-			buf = kmap_atomic(sg_page(sg) + sg->offset);
-			stat = mxcmci_pull(host, buf, sg->length);
-			kunmap(buf);
+			stat = mxcmci_pull(host, sg_virt(sg), sg->length);
 			if (stat)
 				return stat;
 			host->datasize += sg->length;
 		}
 	} else {
 		for_each_sg(data->sg, sg, data->sg_len, i) {
-			buf = kmap_atomic(sg_page(sg) + sg->offset);
-			stat = mxcmci_push(host, buf, sg->length);
-			kunmap(buf);
+			stat = mxcmci_push(host, sg_virt(sg), sg->length);
 			if (stat)
 				return stat;
 			host->datasize += sg->length;


