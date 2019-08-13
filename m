Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9741520665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWWrNVi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfHMJrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:47:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35085 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfHMJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:47:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so79200089qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kc38QbcHV7pkptm5fiPW3dVekfJJ+xCxwUWXKBIaN8U=;
        b=RWWrNVi9zhN6jA53rD5YyEnuQ3736IwlQbfyNGthICPxreJz/TAJi7/YoKrFormYA3
         xXViBLLAdVjnrUBe82FiPrJrV871oPvdim/1uM1KHWarwvpyontipCCoptsjCa6GSN3C
         JXL97YxRXUApdUZCHhynLD4frQIcK6FPX9pp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kc38QbcHV7pkptm5fiPW3dVekfJJ+xCxwUWXKBIaN8U=;
        b=hggQf/sAn6NfQOZ5cdJ0VFf/DcmDq3lXC5QQUoaU7/SesGR7S1ehZirTLsUn6C9o+R
         LOGfhPKWGb1sm9z7R5KeoE4M7SYyaN0eoMR/8uDGZY6wcUIGc0evx5HWCFIDWvMax1P5
         Lx8MfI/Sb13Eivs3cCh7l95XQ/gYRc/xcUTgJRvnz8A4MhlSnBxB1527H3BnZ0ue3LNl
         b+jKhXxoow8OaLARVqnDjmH9kdWh/xEuTuZr8LTPp4Ik3y2riHwHxef/WcIiK/Whk+SG
         vO86eoaOjz8lFvOb42k7GTXoHCt+eX3/SsQBxkg/xXhIsmElAEfyRkPtKQG3N/hN22gY
         49JQ==
X-Gm-Message-State: APjAAAXO5s+osxqGce++XCymlrBWEvKKnQwxII0P4DOVFE0C3oeUnVAC
        8/4dS1QuNgV66/2X9QsEZWem0CV5iNw/T4lutcIe5w==
X-Google-Smtp-Source: APXvYqxXFONLv0MJfh+N2hROFpIG7VWcScq3DFuMkmvG7aRa+F5ZRj+wqMfPnVrfEPQp0iLTZ1ClWWx1CBcp6Ze1N0c=
X-Received: by 2002:a37:5ec7:: with SMTP id s190mr22499051qkb.299.1565689654858;
 Tue, 13 Aug 2019 02:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190813093821.74158-1-fshao@chromium.org>
In-Reply-To: <20190813093821.74158-1-fshao@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 13 Aug 2019 17:47:22 +0800
Message-ID: <CANMq1KCNFfWA=ApVUFoPctgTftHDSAvGjtk-Xu2hcKWBq9R1zw@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Add back missing mask for event_type
To:     Fei Shao <fshao@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Ting Shen <phoenixshen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 5:38 PM Fei Shao <fshao@chromium.org> wrote:
>
> In the previous patch we didn't mask out event_type in case statement,
> so switches are always picked instead of buttons, which results in
> ChromeOS devices misbehaving when power button is pressed.
> This patch adds back the missing mask.
>
> Fixes: d096aa3eb604 ("Input: cros_ec_keyb: mask out extra flags in event_type")
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 38cb6d82d8fe..bef7bee6f05e 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -226,6 +226,8 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  {
>         struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
>                                                   notifier);
> +       uint8_t mkbp_event_type = ckdev->ec->event_data.event_type &
> +                                 EC_MKBP_EVENT_TYPE_MASK;
>         u32 val;
>         unsigned int ev_type;
>
> @@ -237,7 +239,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>         if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>                 return NOTIFY_OK;
>
> -       switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
> +       switch (mkbp_event_type) {
>         case EC_MKBP_EVENT_KEY_MATRIX:
>                 pm_wakeup_event(ckdev->dev, 0);
>
> @@ -264,7 +266,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>         case EC_MKBP_EVENT_SWITCH:
>                 pm_wakeup_event(ckdev->dev, 0);
>
> -               if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
> +               if (mkbp_event_type == EC_MKBP_EVENT_BUTTON) {
>                         val = get_unaligned_le32(
>                                         &ckdev->ec->event_data.data.buttons);
>                         ev_type = EV_KEY;
> --
> 2.23.0.rc1.153.gdeed80330f-goog
