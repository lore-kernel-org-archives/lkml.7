Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E59520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biMSM7Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfCFKtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:49:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38382 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfCFKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:49:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so8101477pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egjR5LHpoq9DWtyI6KtfcBA3jqVQzBSKEJYRcKx5t7s=;
        b=biMSM7TpyaIzBRyDpBwjZElO7R70lXIpVg6yjXq+PmKft/IJWTpmjiVFPU2zq9aGfU
         2w1Kml3d8+4riXyI50JnSLyK7cGNJ7X3s63+zGWbxyCts3ReBdDOaWqgtG1NN+V9Zafo
         d8F/z1H9Rp6ZnpnwAsitwQWEM4jTMGuEhJuugz56uXUDyQxw22HdH4R+Wk33OJZDrxCn
         oBVQM9CMVlvDuDi3bAk8ll9++QOrIgpao7pBUqvFtL5/MnzvxHUeSzaGXor+hFsn02kP
         +KYoUyjCGonO+KrS63eeiKPsKQuAoH9lYh84pdEUoiwH9NtAOYKuihl7Yor02ogvnVDG
         BA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egjR5LHpoq9DWtyI6KtfcBA3jqVQzBSKEJYRcKx5t7s=;
        b=dAS8r9ks/+u507RqWoCgMCYs2R3a24T/8x7eSRZpaOyYvxolUEfrj/fgZEoMFVNc4R
         KhFcHU5rb2UlmFVTlE2SopoB+LpF0FNXSMB0fXDEn05EUlOIpCJjjYGKCGVOy8SxFwE6
         Vv+tb9Vn8cXNkRBo7R4djo3OpjcpGXN8TRosHEY7v3pfcV8ilkzaQfMdR8ePz4uXPnrQ
         qRkrxOCKnjnoS+XNznMdWhMoPgeKgtP//G8rF+a5SGSdZVCqOfMisiVU6OdfLoNEf9Q8
         5cXFsIHFqN2Dq+qMgX1r25rFBQsxZlPgh2WxU9T8ACP44G6NMXjluAA5gn3LhCMYAojm
         EJFw==
X-Gm-Message-State: APjAAAX9OmrYAWwKfKrDxIj0it8mckNJGqu4RjhLrfn+3SOFRNiQcTA+
        AD24i94bzEkQAGVtebUfFTkKFovDwmOMlYBEYI8=
X-Google-Smtp-Source: APXvYqxXoVypsenBIujXHXhmO5in+XHxdig43yAcf7967DPxj38gZdv3anMXzwVtndvZlaLoJioS6m+sPjbKMkDEf/g=
X-Received: by 2002:a63:2004:: with SMTP id g4mr5728589pgg.337.1551869392319;
 Wed, 06 Mar 2019 02:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de> <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
In-Reply-To: <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Mar 2019 12:49:40 +0200
Message-ID: <CAHp75Vc_Nfm7tAwGtLuYgrPGPFQzx3a4ppx0+mXhF=q_X8jT7w@mail.gmail.com>
Subject: Re: Smarter Kconfig help
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peng Hao <peng.hao2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:52 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Mar 06, 2019 at 10:45:52AM +0100, Lucas Stach wrote:
> > Am Dienstag, den 05.03.2019, 17:31 +0000 schrieb Russell King - ARM Linux admin:

> > While I totally agree that the irqsteer driver should only default Y on
> > 64bit i.MX SoCs, I'm not really sure what to do about the Kconfig help
> > text.
> >
> > Enumerating SoCs in the Kconfig of a IP block driver is always prone to
> > get outdated. Just as the first example I've been able to come up with,
> > the MMC_SDHCI_ESDHC_IMX help text says: "This selects the Freescale
> > eSDHC/uSDHC controller support found on i.MX25, i.MX35 i.MX5x and
> > i.MX6x.", while the same IP block is to be found on i.MX7 and various
> > i.MX8.
> >
> > For the Kconfig user, who needs to decide if an option is relevant,
> > outdated SoC information is probably just as bad as no information at
> > all.
>
> How about "This option does not apply to AArch32 based SoCs" or

Negative is usually error prone.

> "This option should be enabled for i.MX7 and later SoCs" ?

Why it should be? It can / could be I guess.

-- 
With Best Regards,
Andy Shevchenko
