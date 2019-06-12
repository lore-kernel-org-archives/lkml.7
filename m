Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E39CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047B020896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nqTKRZCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfFLEfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:35:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39813 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfFLEfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:35:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so8193470pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJn1YZ706aJfrT07Hn2oI2Mia8615vCPrYsCrOsg17g=;
        b=nqTKRZCKIs+8kG9Liz37bjElzQMgiWIkqbp++oZGf4NKeWcTbix2jRPp8mGO/hAgR6
         4+HNZHFyqoG6vx+pkuGWDOYH/mueiggyXED2gqRaFTKHeVEUfGhAMGncR0Y61bP1+Jng
         XWbBDY7gsgQmfzGku7MtRuYYrk4EaxY1CoudU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJn1YZ706aJfrT07Hn2oI2Mia8615vCPrYsCrOsg17g=;
        b=qlhIglcvnuQNtT4P5FRY0apMtLzLZu9y4ndaO0cqhX88toW3abMk3T/S1D1UAefZ+i
         rV5S9GDCcBPp7YvcMv2ZGdX1kmmUIjNQSbo9HuWA31+Kvu3p/JwNDwPeXXyAoi3Vjh2W
         3FPlxdg88d7qedmniFjiLb2RjpRShuSwK8kK1+mOz0+MReLO+N81H+6Zl6BH9HBJOWWz
         iNvIN2GalLTdKYd0sDbEqxZJYyWNd3NQoWDajvZ0u7vGUO4euGKxxjjarYQSQoiPW75U
         OqY3U5tRau3AmTUPU66z+dhICeK7l43Q6SNHBwhalGZRSxLITYfgmkZE0ZgWhU1oSCDO
         amlQ==
X-Gm-Message-State: APjAAAVGRykDQzo/8O3jPPr7qvhEeBiqX7Xl+47DGEb67VtUKj22T+nC
        jQZzEx1x7SNfV8lJg/0Eg3jOyg==
X-Google-Smtp-Source: APXvYqy6WDq4Lk5pwGNHojTbI4ATefffHsAeuBNNuE8NFwZSff+br4DhRCYcJDdPXvX4l1j7ZaLK6w==
X-Received: by 2002:a65:63c6:: with SMTP id n6mr18294203pgv.370.1560314110645;
        Tue, 11 Jun 2019 21:35:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id k8sm15285998pfi.168.2019.06.11.21.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 21:35:10 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 3/3] arm64: kexec_file: add rng-seed support
Date:   Wed, 12 Jun 2019 12:33:02 +0800
Message-Id: <20190612043258.166048-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612043258.166048-1-hsinyi@chromium.org>
References: <20190612043258.166048-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "rng-seed" to dtb. It's fine to add this property if original
fdt doesn't contain it. Since original seed will be wiped after
read, so use a default size 128 bytes here.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
change log v5->v6:
* no change
---
 arch/arm64/kernel/machine_kexec_file.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..d40fde72a023 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -27,6 +27,8 @@
 #define FDT_PROP_INITRD_END	"linux,initrd-end"
 #define FDT_PROP_BOOTARGS	"bootargs"
 #define FDT_PROP_KASLR_SEED	"kaslr-seed"
+#define FDT_PROP_RNG_SEED	"rng-seed"
+#define RNG_SEED_SIZE		128
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -102,6 +104,23 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add rng-seed */
+	if (rng_is_initialized()) {
+		void *rng_seed = kmalloc(RNG_SEED_SIZE, GFP_ATOMIC);
+		get_random_bytes(rng_seed, RNG_SEED_SIZE);
+
+		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
+				RNG_SEED_SIZE);
+		kfree(rng_seed);
+
+		if (ret)
+			goto out;
+
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_RNG_SEED);
+	}
+
 out:
 	if (ret)
 		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
@@ -110,7 +129,8 @@ static int setup_dtb(struct kimage *image,
 }
 
 /*
- * More space needed so that we can add initrd, bootargs and kaslr-seed.
+ * More space needed so that we can add initrd, bootargs, kaslr-seed, and
+ * rng-seed.
  */
 #define DTB_EXTRA_SPACE 0x1000
 
-- 
2.20.1

