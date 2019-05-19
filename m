Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D8C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62092206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="myLhk+2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfESRGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:06:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfESRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:06:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so5595385pgi.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w75P38v9z8QHVdxS6R3Brz2jpMYqR+5eP/w8pQb1nPA=;
        b=myLhk+2HXFCrC8o/7PfbYOhTcA2jCqzU4GnMO+/qE7+tzW5/ihlU7K3wVqAd3P3qFp
         xICCMbgzhgD631AA2NeQrSpXLwscwnDUO0aBm5iHLE0zRWfGzEbHCzknrCjQkhuHMmxX
         hGH4+kQwZHWBpzmD1p050soj0o6GVYepZs0Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w75P38v9z8QHVdxS6R3Brz2jpMYqR+5eP/w8pQb1nPA=;
        b=SnWJVjjhxxwJVdJ2O0CTS8kj+Io9g+ECTapGXSp6ul8EGMZby6/r0hm7gxpA5GSvHQ
         zHUqVOGKXOpRUCCne2YI+mhZ02qbvNYH7y7xGxc2wXR6/rasursAuMSa7/AOyQSRm7NP
         gwalcvyprN/ycPPT5kLsIte307ZtCBzC0isM8fGPeeLm0TXcrDJ/GwfaHKQjkXKAbm/k
         mNLQlX81BNXHqlxawacn4wZfkk7k81E9o2epFAMF1lPi067p0I3bvewhKCaSU91kl5tE
         mR3az8pIvpiUThynMh7kZdt+LNTsfxuGkDkk28a9yrqUQK7h8iLRIGJ9dAqASgqWC9lP
         C16A==
X-Gm-Message-State: APjAAAWaKbKo9YD/0P11UgXYRN4pBeZ+I98XhO/j8YidJkVfIoPASJHk
        FXEaHO37+JlP9JZ4Il8gEELRlYBacfJaug==
X-Google-Smtp-Source: APXvYqwrm3lDeGRnJx7g5EY5lJ5ZBzglEq7ClMbsGc6X8fVoF80Kv6SGb8mBvxA9elUTdo5UIIKIrw==
X-Received: by 2002:a63:6884:: with SMTP id d126mr70417545pgc.154.1558281916225;
        Sun, 19 May 2019 09:05:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id b23sm17547007pfi.6.2019.05.19.09.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 09:05:15 -0700 (PDT)
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
Subject: [PATCH v4 3/3] arm64: kexec_file: add rng-seed support
Date:   Mon, 20 May 2019 00:04:46 +0800
Message-Id: <20190519160446.320-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519160446.320-1-hsinyi@chromium.org>
References: <20190519160446.320-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "rng-seed" to dtb. It's fine to add this property if original
fdt doesn't contain it. Since original seed will be deleted after
read, so use a default size 128 bytes here.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
* Will add corresponding part to userspace kexec-tools if this is accepted.
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

