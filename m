Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59853C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242182075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB0XnPDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfDPVeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:34:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43977 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:34:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so11018337pfd.10;
        Tue, 16 Apr 2019 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q5aoI7m36qw89TPVJD90BaAONE0ERgN6P+QLtAN79gk=;
        b=qB0XnPDTsE51xjAfasmehrRnMnQ0LJR78BCa9N6a0bcjprq7K3XBqZbwphbWThpzEq
         sGDyCPaJ7Si+hv35ALJoN9VUZcMrxwkTcJLCxma2vcFl5O5y5mM8tNRZmayqq2TyIh/2
         mL9JL/XdulCl8WtBu6Wem229iP9cidldYA3p2kqZZhVb02PHxk06ANdTR3nbgnMQfUrt
         7vSsOIek9L877ZNwDbLZSh6GdhHwOcWfaGtt+tH5NOuklidd1MtmS8qarZNG4SbBuZvW
         87cr+wFsUCzNWgfVlUamBc2nW42atfghsVl/mFAbn3pYsi72bxfFKpVQrKiZp6H9heBU
         W+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q5aoI7m36qw89TPVJD90BaAONE0ERgN6P+QLtAN79gk=;
        b=d6NstLadg+mI83eQH3L1sHdjLSrLfsgLfJ+P/zNMBYpjmRAGrMLlQoOl6Cylp2hdf1
         f6QDClAwwaLGqa999a0dD65LLz0PTAcH786YqfnJOcbpoaXGzPGZlUNVj4qdTD5kArm5
         FHHROLyckmqyOgOSA0QUP2jQcKq+q+7hhXqWmlbusndgTQS1yuAmEs/j9CfBucoE5eD8
         x6HzeXKlLyk/rBQ6l2bvZT+d4UltlW7LBdJ6wyUeKRRyVx+FdhWyMkWwfhe7B8rRo8W+
         Cgoj3HhfuSP5UhQl98tK+ME2CRgtq7CSCgIva4/YowuhmTeObNv+L/WXLE/d7oEm/SFN
         tv3Q==
X-Gm-Message-State: APjAAAVL5Dq0wJ74FFAAMAdeK0lOQAIXP2NoA1IeC2K1Br4rob+xMT8L
        NjLG2AWzNfILl4Cts9GlmVAIUjWG
X-Google-Smtp-Source: APXvYqx3AynBcagFsCwV3wySOROGpXVLx8XKPMRjtNAFSfL5l2YC3Cg7xsZ9s98cpzybg6rS6F3AOw==
X-Received: by 2002:a62:e315:: with SMTP id g21mr84944658pfh.2.1555450450590;
        Tue, 16 Apr 2019 14:34:10 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id y23sm74242127pfn.25.2019.04.16.14.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 14:34:09 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-edac@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
Date:   Tue, 16 Apr 2019 14:33:50 -0700
Message-Id: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ce_arr.array[] is always within the range [0, ce_arr.n-1].
However, the binary search code in __find_elem() uses ce_arr.n
as the maximum index, which could lead to an off-by-one
out-of-bound access right after the while loop. In this case,
we should not even read it, just return -ENOKEY instead.

Note, this could cause a kernel crash if ce_arr.n is exactly
MAX_ELEMS.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/ras/cec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..a4ff54e50673 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -204,10 +204,11 @@ static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 	if (to)
 		*to = min;
 
-	this_pfn = PFN(ca->array[min]);
-
-	if (this_pfn == pfn)
-		return min;
+	if (min < ca->n) {
+		this_pfn = PFN(ca->array[min]);
+		if (this_pfn == pfn)
+			return min;
+	}
 
 	return -ENOKEY;
 }
-- 
2.20.1

