Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECCF20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNzotIbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEORC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:02:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36948 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfEORC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:02:26 -0400
Received: by mail-yb1-f194.google.com with SMTP id p134so116987ybc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgKKSA6QWnKM9w2WATnSBKQOf8B+4H5QEt42dEz2xX8=;
        b=ZNzotIbOROqejpCSG4RO3XsEMuNhgoglYkyfg+sXCHaOY++9NiPwk9mwkVfPrG6Czz
         redeLLRyaI28QeV/1tCfU1FVqqePbpe7/sjFi1sm4qWWfy2LJA6wL2HV+qlBJSATsFhw
         fm8aYKkAFmGsvQ07CAxJoAdjnSGIQhWdFu9vaOYVPfuoapCW3TRRnum1Jm4dfGdUvV3R
         BzvVZP8vWkzGmsZZnSrd9LWpAaN2n1FyDTy/Ce0XA9/zszr1PsRWO4ypHQdm8x4VcWI7
         eyCECA6U24VueLwdwa6FtZe3L91RURsUhUdTnbmcnnolQToG8O52UVNZfl/OYFp+68Db
         aYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgKKSA6QWnKM9w2WATnSBKQOf8B+4H5QEt42dEz2xX8=;
        b=bpm3UYfYKgEsQe9O0z6pVefBHueZOHaws81gJHn5rgS1obrvLUlebnaV0BPnDqFAhl
         B4IPCwTjy41ptY/Z0RxycIag+Lk/2OfKOBR8Cn5/9b1N3sBDNbombh+s7wnUJYkpNBeB
         EqjCVFplUGRQareYq1u3nVcNGleDE4toIODMd0wtgsx4Hg5PAcATs3MybULEv7gxke2y
         LdyThOy/xubVQmprGiZHd1FVyOUoWSrf0jVoQxZJ/HYJ3JHgeUFMfxK+EvmYW4sYGJFh
         7mDM5egngcGRZVcxYIzB/qDkoRhXlIxyMN+cJYk3k0H1dGw29jGam6ywP5p9x78ro4EQ
         FzLA==
X-Gm-Message-State: APjAAAXqYttbW93RmnEj7uaIi9Hl+kfJvZaJu+QjU8M/UNZvFNzacA7g
        mVUCF0pg2GZhXZ9GBlRNQUOo5OJ1SS+qrb4rRISnxw==
X-Google-Smtp-Source: APXvYqyvi3/cNTCrSEjs52nlUKK5ZUZFTaLrz2SiGqE+m+tY4GI87XGdh18E8bLpxD90eqafcq4aZQ4QD57otGWBXag=
X-Received: by 2002:a5b:887:: with SMTP id e7mr20208062ybq.414.1557939745588;
 Wed, 15 May 2019 10:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190515164814.258898-1-dianders@chromium.org> <20190515164814.258898-2-dianders@chromium.org>
In-Reply-To: <20190515164814.258898-2-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 May 2019 10:02:12 -0700
Message-ID: <CABXOdTeCtwFSOvHbBTaSqjv0+rzfbc2mVm=PjtZgid_xRAwwtA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] platform/chrome: cros_ec_spi: Move to real time
 priority for transfers
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 9:48 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> In commit 37a186225a0c ("platform/chrome: cros_ec_spi: Transfer
> messages at high priority") we moved transfers to a high priority
> workqueue.  This helped make them much more reliable.
>
> ...but, we still saw failures.
>
> We were actually finding ourselves competing for time with dm-crypt
> which also scheduled work on HIGHPRI workqueues.  While we can
> consider reverting the change that made dm-crypt run its work at
> HIGHPRI, the argument in commit a1b89132dc4f ("dm crypt: use
> WQ_HIGHPRI for the IO and crypt workqueues") is somewhat compelling.
> It does make sense for IO to be scheduled at a priority that's higher
> than the default user priority.  It also turns out that dm-crypt isn't
> alone in using high priority like this.  loop_prepare_queue() does
> something similar for loopback devices.
>
> Looking in more detail, it can be seen that the high priority
> workqueue isn't actually that high of a priority.  It runs at MIN_NICE
> which is _fairly_ high priority but still below all real time
> priority.
>
> Should we move cros_ec_spi to real time priority to fix our problems,
> or is this just escalating a priority war?  I'll argue here that
> cros_ec_spi _does_ belong at real time priority.  Specifically
> cros_ec_spi actually needs to run quickly for correctness.  As I
> understand this is exactly what real time priority is for.
>
> There currently doesn't appear to be any way to use the standard
> workqueue APIs with a real time priority, so we'll switch over to
> using using a kthread worker.  We'll match the priority that the SPI
> core uses when it wants to do things on a realtime thread and just use
> "MAX_RT_PRIO - 1".
>
> This commit plus the patch ("platform/chrome: cros_ec_spi: Request the
> SPI thread be realtime") are enough to get communications very close
> to 100% reliable (the only known problem left is when serial console
> is turned on, which isn't something that happens in shipping devices).
> Specifically this test case now passes (tested on rk3288-veyron-jerry):
>
>   dd if=/dev/zero of=/var/log/foo.txt bs=4M count=512&
>   while true; do
>     ectool version > /dev/null;
>   done
>
> It should be noted that "/var/log" is encrypted (and goes through
> dm-crypt) and also passes through a loopback device.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>
