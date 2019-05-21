Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9FEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543A7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oYE7JAF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfEUNh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:37:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37055 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUNh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:37:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id f4so12804634oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+BSjdKHMeiIAULb/QyaUOTkRt09BUDaEnpHHqHJQHo=;
        b=oYE7JAF3d5Xd55jYiP+FFNL6Ut3yy6uqIgip8mEGC8oTz1+IvRYcsGTOaUU5j8VFyi
         qlIZN4YmYuLrs5eY9gkBjWkzNagvcbXivOL+g55DksVqlPngfPyWIjsECXhDpaTdLVRa
         LltBxjxk+TjU9uoUpHMSUpwVOz7Qcw67t+Fhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+BSjdKHMeiIAULb/QyaUOTkRt09BUDaEnpHHqHJQHo=;
        b=igB6E7f9bJoPCTOyE8Mc6hDuzzxLomgCA/uVsvYxRg+ER0y13LRdiY/0imH3TUuxE1
         sgDICq2t3Vcq9akPGiaqsz89rDRaJJ+Zd+uxh9QtBzgRXrvL9CAdlVx1j1YlcU1lBgIg
         8TG0qwn+lviBmuUpzDTePHmnuSRQLBi0fz55+D5c5R7xNk4qWUPPPNWZRNjeRSXx5nc/
         22nQBgofEZGrueJWox9rLOJVyeuAvlu8DODfa7z43/0DnPFxC6xVXSRCn/+q28IwNano
         hfoulTYPNprkdi85veWNbCMo4SV0on1ttVk3qURgo/eszI7yI+2MGBnz7CQylJGJH36u
         3DJA==
X-Gm-Message-State: APjAAAV3AbuMsBEsK19kb83ogFENq6NOwUto+V+L/IX+L0uA9lpGHPh4
        pW7mI8dd6pXJ3TIR9rbmaBy6+FpVt2A=
X-Google-Smtp-Source: APXvYqzB6fHrcTq3SMQEx5DdNBNDnC3OyvicOdBPVuItA6SdsZf6uKzxVY/iKXBiLy/UESFc7WCSZg==
X-Received: by 2002:aca:7511:: with SMTP id q17mr3479862oic.138.1558445845574;
        Tue, 21 May 2019 06:37:25 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 23sm7617100otc.77.2019.05.21.06.37.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:37:24 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 66so16379396otq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:37:24 -0700 (PDT)
X-Received: by 2002:a9d:58c5:: with SMTP id s5mr19522642oth.153.1558445844462;
 Tue, 21 May 2019 06:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520224124.153005-1-mathewk@chromium.org>
In-Reply-To: <20190520224124.153005-1-mathewk@chromium.org>
From:   Jett Rink <jettrink@chromium.org>
Date:   Tue, 21 May 2019 07:37:13 -0600
X-Gmail-Original-Message-ID: <CAK+PMK47_OE-BgOYD_TD0kwxD4RG+nS9Wstg4ydUy7yV9nVmHQ@mail.gmail.com>
Message-ID: <CAK+PMK47_OE-BgOYD_TD0kwxD4RG+nS9Wstg4ydUy7yV9nVmHQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-vbtn: Report switch events when
 event wakes device
To:     Mathew King <mathewk@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:41 PM Mathew King <mathewk@chromium.org> wrote:
>
> When a switch event, such as tablet mode/laptop mode or docked/undocked,
> wakes a device make sure that the value of the swich is reported.
> Without when a device is put in tablet mode from laptop mode when it is
> suspended or vice versa the device will wake up but mode will be
> incorrect.
>
> Tested by suspending a device in laptop mode and putting it in tablet
> mode, the device resumes and is in tablet mode. When suspending the
> device in tablet mode and putting it in laptop mode the device resumes
> and is in laptop mode.
>
> Signed-off-by: Mathew King <mathewk@chromium.org>
>
> ---
> Changes in v2:
>   - Added comment explaining why switch events are reported
>   - Format so that checkpatch is happy
> ---
>  drivers/platform/x86/intel-vbtn.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index 06cd7e818ed5..a0d0cecff55f 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -76,12 +76,24 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>         struct platform_device *device = context;
>         struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
>         unsigned int val = !(event & 1); /* Even=press, Odd=release */
> -       const struct key_entry *ke_rel;
> +       const struct key_entry *ke, *ke_rel;
>         bool autorelease;
>
>         if (priv->wakeup_mode) {
> -               if (sparse_keymap_entry_from_scancode(priv->input_dev, event)) {
> +               ke = sparse_keymap_entry_from_scancode(priv->input_dev, event);
> +               if (ke) {
>                         pm_wakeup_hard_event(&device->dev);
> +
> +                       /*
> +                        * Switch events like tablet mode will wake the device
> +                        * and report the new switch position to the input
> +                        * subsystem.
> +                        */
Thanks for adding the comment; This looks good to me.

> +                       if (ke->type == KE_SW)
> +                               sparse_keymap_report_event(priv->input_dev,
> +                                                          event,
> +                                                          val,
> +                                                          0);
>                         return;
>                 }
>                 goto out_unknown;
> --
> 2.21.0.1020.gf2820cf01a-goog
>

Reviewed-by: Jett Rink <jettrink@chromium.org>
