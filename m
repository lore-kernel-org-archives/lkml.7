Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8ECC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A38020989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GSaTH3xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfHSG1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:27:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40168 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:27:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so582310pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=ySzu59s/U1eiWpVmmgYwQiavhmlNAIEAzQrYGIeZiaE=;
        b=GSaTH3xqIx0fcNAst0wFBoQF7XlF1iEig8cebhEWi6II6J2cfIilr4ndJNdslWehGM
         HNAvm+AUj6gtNMikHXIy4baLDhssNB203dRE47iqrrJIEtbc6OUsy5RoI6anw3oXb0fz
         H6PxtJejPSJaW83HzZBkwvE43ytx02ggIKoDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=ySzu59s/U1eiWpVmmgYwQiavhmlNAIEAzQrYGIeZiaE=;
        b=PICeugANIjFtMwW73XhrK3KUjJqMs5Vqibgbf53D4eJgT3Sl9aKagzKSs78RlKZhDH
         K3/ZqrCh2YN/pwlyX9aQ6AiYw7CJs+Pa1tDEaRL4Sz1CIWFukjstQzaGLFRKfN7QnMkw
         XoZG+gzN8+mQsSdnxwI+ZQ97wGoTriS6MS8chqVLB/dcw0jaRln55NDz7XZHJMnRopIP
         6PpAyAAbnSMTGFGV3uenX026mIfpyIauS/mBxamPVgx9uRzePe6tHgcC7Lu2Gx7L3l2b
         LXRj23aKxXOQ6urA4Q3axrdPmyxTrp/y5XrQTJaqZ1eh0BluyP5NyUIO7Hr8toyEEzYz
         Rc9A==
X-Gm-Message-State: APjAAAVoAFeDy+xX5GVu22sJ2UKclz+Z/3qyXenA8Av44JPEoSDdg0FO
        14m/iTFN2nhkBN9xXfxlhQNyabie7aMThw==
X-Google-Smtp-Source: APXvYqwxh6EpDsR4gSDgYaivhvwiyY/TcdbBNxdN/wU3uNqa+Z8Ujc87bSOhINz7830RArvtp3tOoQ==
X-Received: by 2002:a62:1444:: with SMTP id 65mr22259254pfu.145.1566196048820;
        Sun, 18 Aug 2019 23:27:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t11sm19934188pgb.33.2019.08.18.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 23:27:28 -0700 (PDT)
Message-ID: <5d5a4150.1c69fb81.3faa2.eee8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49fc7c64-88c0-74d0-2cb3-07986490941d@ti.com>
References: <49fc7c64-88c0-74d0-2cb3-07986490941d@ti.com>
Subject: Re: Suspend/Resume Broken on AM43/AM33 Platforms
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kristo, Tero" <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>
To:     Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        herbert@gondor.apana.org.au
User-Agent: alot/0.8.1
Date:   Sun, 18 Aug 2019 23:27:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keerthy (2019-08-18 21:24:58)
> Hi Stephen,
>=20
> commit 03a3bb7ae63150230c5de645dc95e673ebf17e1a
> Author: Stephen Boyd <swboyd@chromium.org>
> Date:   Mon Aug 5 16:32:41 2019 -0700
>=20
>      hwrng: core - Freeze khwrng thread during suspend
>=20
> Commit seems to be breaking suspend/resume on TI AM43/AM33 platforms.
>=20
>=20
> rtcwake: wakeup from "mem" using /dev/rtc0 at Sun Nov 18 02:12:12 2018
> [   54.033833] PM: suspend entry (deep)
> [   54.037741] Filesystems sync: 0.000 seconds
> [   54.062730] Freezing user space processes ... (elapsed 0.001 seconds) =

> done.
> [   54.071313] OOM killer disabled.
> [   54.074572] Freezing remaining freezable tasks ...
> [   74.083121] Freezing of tasks failed after 20.003 seconds (1 tasks=20
> refusing to freeze, wq_busy=3D0):
> [   74.092257] hwrng           R  running task        0   289      2=20
> 0x00000020
> [   74.099511] [<c08c64c4>] (__schedule) from [<c08c6a10>]=20
> (schedule+0x3c/0xc0)
> [   74.106720] [<c08c6a10>] (schedule) from [<c05dbd8c>]=20
> (add_hwgenerator_randomness+0xb0/0x100)
> [   74.115358] [<c05dbd8c>] (add_hwgenerator_randomness) from=20
> [<bf1803c8>] (hwrng_fillfn+0xc0/0x14c [rng_core])

Thanks for the report. I suspect we need to check for freezer in
add_hwgenerator_randomness(). I find it odd that there's another caller
of add_hwgenerator_randomness(), but maybe the ath9k driver can be
converted to some sort of hwrng driver instead of calling into the
kthread directly.

Anyway, can you try this patch?

---8<---
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..e2e85ca16410 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2429,6 +2429,7 @@ void add_hwgenerator_randomness(const char *buffer, s=
ize_t count,
 				size_t entropy)
 {
 	struct entropy_store *poolp =3D &input_pool;
+	bool frozen =3D false;
=20
 	if (unlikely(crng_init =3D=3D 0)) {
 		crng_fast_load(buffer, count);
@@ -2439,9 +2440,12 @@ void add_hwgenerator_randomness(const char *buffer, =
size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
+	wait_event_interruptible(random_write_wait,
+			kthread_freezable_should_stop(&frozen) ||
 			ENTROPY_BITS(&input_pool) <=3D random_write_wakeup_bits);
-	mix_pool_bytes(poolp, buffer, count);
-	credit_entropy_bits(poolp, entropy);
+	if (!frozen) {
+		mix_pool_bytes(poolp, buffer, count);
+		credit_entropy_bits(poolp, entropy);
+	}
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
