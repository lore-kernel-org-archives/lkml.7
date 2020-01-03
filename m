Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82679C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5914122B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578069575;
	bh=KcvtLb+TfRw1uY1bkvdvgbpsv4uEyCRqJ6XVxzKKvF0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KrCR/8pAYLOT+bEDNN08jHSZ9wkr/fFN/3MfyvB3nGqqRTLnOky/jsbDekbiNiXNZ
	 RnQlhDOOr75+wcfivyl2eXBOKpkCd9h6AqgWU8Cw9s4S/RtOe2ZHbWv8XUkTMZ7ldd
	 414OUTHcx8P4M7xrl7rnZCuVGj+RZGOkF9pGoTls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgACQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgACQjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:39:33 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4208206DB;
        Fri,  3 Jan 2020 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578069573;
        bh=KcvtLb+TfRw1uY1bkvdvgbpsv4uEyCRqJ6XVxzKKvF0=;
        h=From:To:Cc:Subject:Date:From;
        b=LOZmr+i4jRgwSxWi5VgUA43TvKSnrW8qnE6mK25b30xr16UOeTUcaErQWMoD9qcpg
         8B/9TLXN7UCk8ZoD7SaC9Lv1rS4KYBHAbPSV1IVdIYgkbR7YAiiy66zDTa79ID0zPH
         zGq/Ij7X9oIc//Otvl1X7ZH6i8D5CQFRYN32r1dY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] parisc: Use proper printk format for resource_size_t
Date:   Fri,  3 Jan 2020 17:39:25 +0100
Message-Id: <20200103163925.3967-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resource_size_t should be printed with its own size-independent format
to fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    arch/parisc/kernel/drivers.c: In function 'print_parisc_device':
    arch/parisc/kernel/drivers.c:892:9: warning:
        format '%p' expects argument of type 'void *',
        but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/parisc/kernel/drivers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index a6c9f49c6612..a154de424421 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -889,8 +889,8 @@ static void print_parisc_device(struct parisc_device *dev)
 	static int count;
 
 	print_pa_hwpath(dev, hw_path);
-	pr_info("%d. %s at 0x%px [%s] { %d, 0x%x, 0x%.3x, 0x%.5x }",
-		++count, dev->name, (void*) dev->hpa.start, hw_path, dev->id.hw_type,
+	pr_info("%d. %s at %pa[p] [%s] { %d, 0x%x, 0x%.3x, 0x%.5x }",
+		++count, dev->name, &(dev->hpa.start), hw_path, dev->id.hw_type,
 		dev->id.hversion_rev, dev->id.hversion, dev->id.sversion);
 
 	if (dev->num_addrs) {
-- 
2.17.1

