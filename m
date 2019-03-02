Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA13C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF920830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S6e3r1Ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCBK3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:29:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38276 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCBK3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:29:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so245912oic.5;
        Sat, 02 Mar 2019 02:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFS8iN791dAHXkv5uIHJZIdjxpznm7Am3E/GPQELsSw=;
        b=S6e3r1TaBOfYkoTrY7OmY6W7HIJLC8/6YAnMog+h6K6fgxI7qKOQnk09xcw0zNoBpa
         eV535ci2yTLWRIiR4pXjRtJIicz7MlK2S7KoBsmB8R3VDYQ1Y7kWH+9Z1APu6TFEZIo2
         P5wuZ4vvbsz2oRt2tTOjh4Tsuu8LAfLaQL8/ejQ8/0cPjn4RKTpj6yizFDTDbuhpjTxN
         xoiH4ekIP/QQ5ThKFmKimVJVyvzILH9NtyfMfuhnulTM77UX/7r9ffB4j01HRdpAAfbo
         9uYf25Q4ZjhKXUlh5PSNwM++s0uVfcOvJSXgHJcQdAC+t2e8UnvjcQUfzVQ1yAzGp+Pk
         zSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFS8iN791dAHXkv5uIHJZIdjxpznm7Am3E/GPQELsSw=;
        b=ro1AzxG5bV+/MABQXFyIrl1mvBIhCM9AUKFjkRjouTKEBHz6ICRGCtIvPRbr2rCxrT
         r2n7BVb55maim3tsYEUwEsjuVXhVLp6jprQVTGDCjHHScOTJCGrS8YLWdoNjlImyE3kh
         T6He+JXhOTTV9oiM1PR6LDTOiGi6RxmQsSRmSdJcFIK64TiyjYXRiWM/oqEkmgtAEyD2
         ZtNBfOnrAG4J6QLPZR/f4J9JKxzv/hFgCqVjJ4HByVjf7xi82Xl+IeCQZUoaFDeunZ6F
         WL9KnxqJAibdEJA/5Zrd11YPljRjTBHVbJjP9TBHM+gJWCJFI2X7oS9y1NcK4Y3b9Omn
         S0rg==
X-Gm-Message-State: AHQUAuYfVnYsxIrT+x+hm4QkLg+fWV/gt7jN1UoSaUjGUgg4H9PRAa83
        M+rW6KT1+u3UaIlO9HVD3EDI7wRqB6CcfzU+nwxD6kE2
X-Google-Smtp-Source: AHgI3IYZdpDzaozOuPlNBcZ437nMyI3Gzf3CWXvrhZ3Ikqn98FHIX6LoGznlvanc5HCWvIhza2NzlldVe71vCKUoih8=
X-Received: by 2002:aca:aacb:: with SMTP id t194mr6283612oie.129.1551522553134;
 Sat, 02 Mar 2019 02:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-9-narmstrong@baylibre.com> <CAFBinCBoahGTbnii0Dhfj75YC8u2HjodAqFWwtD=K3xOZ-wGPw@mail.gmail.com>
In-Reply-To: <CAFBinCBoahGTbnii0Dhfj75YC8u2HjodAqFWwtD=K3xOZ-wGPw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 2 Mar 2019 11:29:01 +0100
Message-ID: <CAFBinCDjFJS58+6yqxrsyHvhycsg2sC4tTtRj8O=GkcPJpR5Tg@mail.gmail.com>
Subject: Re: [PATCH 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> > +static int dwc3_meson_g12a_debugfs_init(struct dwc3_meson_g12a *priv)
> > +{
> > +       priv->root = debugfs_create_dir("dwc3-meson-g12a", NULL);
> > +       if (IS_ERR(priv->root))
> > +               return PTR_ERR(priv->root);
> > +
> > +       debugfs_create_file("mode_force", 0600, priv->root, priv,
> > +                           &dwc3_meson_g12a_mode_force_fops);
> > +
> > +       debugfs_create_file("otg_id", 0400, priv->root, priv,
> > +                           &dwc3_meson_g12a_otg_id_fops);
> > +
> > +       return 0;
> > +}
I just stumbled across the "USB role switch framework", see [0]
it seems to provide a userspace API as well and two in-kernel drivers
are using this framework already
(drivers/usb/gadget/udc/renesas_usb3.c,
drivers/usb/roles/intel-xhci-usb-role-switch.c)


[0] https://elixir.bootlin.com/linux/v5.0-rc8/source/drivers/usb/roles/class.c#L246
