Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhwssDkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfHWG1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:27:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46059 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbfHWG1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:27:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so4983756plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 23:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kb0kqD1qhyP3JWsvYXGZaOdpUgrW0FO979UbW1Fs5iA=;
        b=PhwssDkl7Y7jDDT/G4EwxHxtS6Hwww3jOrLJzmhAMy4og3YXDKwNL8APxYsP2XBL5i
         +c+GQeAthDApB/ypQSegIIKFiuc2WCHlpiVoAZ/4pp02r2MTphJvBYLE56bgJtzUnfj4
         F8aHbHSuvVlFQp2GeDu1fOz0dCXGRI5u4zf7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kb0kqD1qhyP3JWsvYXGZaOdpUgrW0FO979UbW1Fs5iA=;
        b=PY+7NL3IbhLc8rgmKtLnVqoaUTAhQ0O71laAqPLif07/GfH5W9snI8wgjHspXQPEXM
         Lm5+LmCor32TYVbaG7f+p4cMp47mp7GoFnaArgFjCBHzGoKDh4ESNYBERdQCteH2pRCB
         1D3t4iCyPayi3v2spqE+A1rBOBVlSVEaLwivBU/dyAfOPhJLYf1HWD+xyNn9rPm51hWN
         hXmAmf6+/zMFvgxI3GPcBuvXBu/myqnNgBhM8f4LSALuaIHRuGYlI74oBdKHJ71g4m/K
         LpJ/yT9hiQY97SvrG8mczuyEHZ99PwzH1L0/GHiuPwtGxc5jDtdqKEPs5Rk0lyxqAAKh
         EzOQ==
X-Gm-Message-State: APjAAAXBC7O0agAy62asul9qvByo+moTES87pp0YmkHJ8WE6gFNRtCKb
        FkqXVX/gqwZSGtLGm7d7OJNN0w==
X-Google-Smtp-Source: APXvYqx+zIgHFtGZH2QgUnrJeYCDf1BjoDBgZXNPumUmqhYMd5HWMViEsafTartyaLR5Je6tf/TcQw==
X-Received: by 2002:a17:902:d684:: with SMTP id v4mr2988291ply.238.1566541661720;
        Thu, 22 Aug 2019 23:27:41 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id q13sm2139671pfl.124.2019.08.22.23.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 23:27:41 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/3] arm64: kexec_file: add rng-seed support
Date:   Fri, 23 Aug 2019 14:24:52 +0800
Message-Id: <20190823062452.127528-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823062452.127528-1-hsinyi@chromium.org>
References: <20190823062452.127528-1-hsinyi@chromium.org>
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
No change since v7
---
 arch/arm64/kernel/machine_kexec_file.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index ba78ee7ca990..7b08bf9499b6 100644
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

