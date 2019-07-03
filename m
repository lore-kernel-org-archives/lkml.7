Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66065C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E2620673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwp8ivzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCEFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:05:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35524 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfGCEFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:05:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so484852pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bm9umS6vs/dbbokDnbGJE7RR1jt4/TW8qx98n8+rRXs=;
        b=lwp8ivzrlsxLLgRlaT62i3vqrLwkdKgS7nSCUiMXz6cLeSlSGmHtCrk1acO9r4NXgZ
         fzRiFfltg50O42MTfX838YI6NXHyPqDAMy6U88E2UtGVqiAjFKmYirTmp8pt6EJVZ3Kc
         zd5JmV2q9PZTe58ovR7q4HVMtLykh5iQ058j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bm9umS6vs/dbbokDnbGJE7RR1jt4/TW8qx98n8+rRXs=;
        b=GV48Qk9Ee9aD7VA8VBg3foKqeYo4DPndbV01gfStm/QXhwrWejWdswF5WWdQgoGyg1
         TDFlKHKMybbG+1sURFlTLV9HF6HH9JjphT2YjsUBTNtyJoxFxSZ0hGmAoFhGXnErp04D
         EeTKMcUGtxgn7V1MhPTLv7iqfLhrXRvu1IRzXoIolbew91atlzuJMGvu4UV1Aq6xg99M
         n6ip2PIy63EuJibliXFP/EILnk1IqEGxNL6fq9r30EX4RnrXWty137ewiYnIWAxVA44q
         iZ4mvAWDFCr12cIX2lnfoejwyNS758oINAVYs639WWv0fFbv+ocxMNlS8RK2NP3NUhzJ
         q5Cw==
X-Gm-Message-State: APjAAAUFcObesA4x0GosWVCFXnLhjyI60UuamEQcKnKFM9ncVckmztO3
        URITL5MKAyKkY4wkAWc1nlwA3w==
X-Google-Smtp-Source: APXvYqxSlvON1XYRESOb0HHRr/tTmlELefeQMA9+YaZ4lD8Nb2hIdAPpf8KZVxNsWdVkLy7H8dN7ow==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr5469866pgp.72.1562126705767;
        Tue, 02 Jul 2019 21:05:05 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id w16sm608327pfj.85.2019.07.02.21.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 21:05:05 -0700 (PDT)
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
Subject: [PATCH v7 3/3] arm64: kexec_file: add rng-seed support
Date:   Wed,  3 Jul 2019 12:01:39 +0800
Message-Id: <20190703040135.169843-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703040135.169843-1-hsinyi@chromium.org>
References: <20190703040135.169843-1-hsinyi@chromium.org>
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
change log v6->v7:
* Use stack for rng_seed to avoid allocation failing.
---
 arch/arm64/kernel/machine_kexec_file.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..81b5baad97aa 100644
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
@@ -102,6 +104,19 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add rng-seed */
+	if (rng_is_initialized()) {
+		u8 rng_seed[RNG_SEED_SIZE];
+		get_random_bytes(rng_seed, RNG_SEED_SIZE);
+		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
+				RNG_SEED_SIZE);
+		if (ret)
+			goto out;
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_RNG_SEED);
+	}
+
 out:
 	if (ret)
 		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
@@ -110,7 +125,8 @@ static int setup_dtb(struct kimage *image,
 }
 
 /*
- * More space needed so that we can add initrd, bootargs and kaslr-seed.
+ * More space needed so that we can add initrd, bootargs, kaslr-seed, and
+ * rng-seed.
  */
 #define DTB_EXTRA_SPACE 0x1000
 
-- 
2.20.1

