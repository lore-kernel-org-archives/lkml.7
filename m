Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E1C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6953820663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYX5m4GJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfFXPwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:52:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39805 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfFXPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:52:55 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so1874200iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkjGLeZUAfuY8DZSj9f0m0KvGyff5YQvvo5e4Golg5M=;
        b=gYX5m4GJ4yG/mZPswVx6eRxlw7sAVUkNCN3Im8k3dSk2ZoWzwKuaMutdF4FxdpsAMl
         Zisq3TVygA6ypft7AGBN0IZUIWpMNe4a/ppsQoSLpIDVm8jjP1DM0PWWwRhJvkfe+k25
         9tWdTjW/puS4CwqKDjHjO5U5J4aCyt1HB2Myw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkjGLeZUAfuY8DZSj9f0m0KvGyff5YQvvo5e4Golg5M=;
        b=MKxOE5HcbdHahhtNlT7SE5VxXGHnZ3AAyJ1QxvYUgNjvEF5TdFpQrU1slXCrYjfNVB
         8ix5qk43aVxF7onkUY1v4Fe0H/vBX/bten2iqpNjxWFnrAYgy1FDuaRvt57gqwxPFTGH
         aiel2hJkvlUEXakiJ785q0mikhBHmXcvoA4HE0qfG5D/ps2KOm914/CsvI+nhaXaCW6e
         UY9dzlbRWSSd7IMcAEVxeb5HgQwA+ARJTgBbv3STNgNFMzYQQtiv7MD9DxpQTuPXBSDr
         WDYvkww2iJxiCY+KBcfn+92Ov5JpThfD6wQMpiekDbO36ia8DbnEFwiaob07OO78E98k
         KG/Q==
X-Gm-Message-State: APjAAAUMNC+6fPiLACuZCuXMxinqZ6fW19Wm/A3Wwwe2E1E1Xsqp3acS
        FevEwrx6Ig3mf2mG71fXitoTgoV+MLM=
X-Google-Smtp-Source: APXvYqyApYU+AP1vyw81yh9RAKkuBDH/F1y4MWzsNk6ijJK2Y4JWkJaWoYG2of8+Jque8izQt8mOgg==
X-Received: by 2002:a6b:7606:: with SMTP id g6mr1343652iom.288.1561391574473;
        Mon, 24 Jun 2019 08:52:54 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id p25sm13590439iol.48.2019.06.24.08.52.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:52:53 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id e3so2715910ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:52:52 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr39732767iop.58.1561391572659;
 Mon, 24 Jun 2019 08:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <92d97c68-d226-6290-37d6-f46f42ea604b@free.fr>
In-Reply-To: <92d97c68-d226-6290-37d6-f46f42ea604b@free.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jun 2019 08:52:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XE=rdqUhFD-5ZynhfgkDXN4HNs=JcKgLiqeN3Aapnj9w@mail.gmail.com>
Message-ID: <CAD=FV=XE=rdqUhFD-5ZynhfgkDXN4HNs=JcKgLiqeN3Aapnj9w@mail.gmail.com>
Subject: Re: [PATCH v1] phy: qcom-qmp: Raise qcom_qmp_phy_enable() polling delay
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 13, 2019 at 8:28 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> readl_poll_timeout() calls usleep_range() to sleep between reads.
> usleep_range() doesn't work efficiently for tiny values.
>
> Raise the polling delay in qcom_qmp_phy_enable() to bring it in line
> with the delay in qcom_qmp_phy_com_init().
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Vivek, do you remember why you didn't use the same delay value in
> qcom_qmp_phy_enable) and qcom_qmp_phy_com_init() ?
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index bb522b915fa9..34ff6434da8f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1548,7 +1548,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>         status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>         mask = cfg->mask_pcs_ready;
>
> -       ret = readl_poll_timeout(status, val, val & mask, 1,
> +       ret = readl_poll_timeout(status, val, val & mask, 10,
>                                  PHY_INIT_COMPLETE_TIMEOUT);

I would agree that the existing code is almost certainly wrong, since,
as you said, trying to sleep for 1 us is likely pointless.  I quickly
coded up a test and ran it on sdm845-cheza.  It looked like this:

--

  ktime_t a, b, c;

  a = ktime_get();
  b = ktime_get();
  usleep_range(1, 1);
  c = ktime_get();

  pr_info("DOUG: %d ns, %d ns\n", (int)ktime_to_ns(ktime_sub(b, a)),
          (int)ktime_to_ns(ktime_sub(c, b)));

--

At bootup I got:

[    4.121247] DOUG: 52 ns, 9479 ns
[    4.144990] DOUG: 52 ns, 9636 ns
[    4.328168] DOUG: 0 ns, 11667 ns
[    4.332659] DOUG: 52 ns, 7136 ns
[    4.358833] DOUG: 0 ns, 6666 ns
[    4.362095] DOUG: 52 ns, 8229 ns

So basically the existing code is already waiting 5-10 us between
polls but it's spending all of that time context switching.  Changing
the above to:

  usleep_range(5, 10);

Give me instead:

[    4.120781] DOUG: 52 ns, 16927 ns
[    4.144626] DOUG: 53 ns, 17447 ns
[    4.327932] DOUG: 52 ns, 11302 ns
[    4.332501] DOUG: 0 ns, 7395 ns
[    4.357912] DOUG: 0 ns, 6823 ns
[    4.361175] DOUG: 52 ns, 9063 ns

...and that seems fine to me.

--

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
