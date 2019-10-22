Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F3CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AE0205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6gaYXo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfJVTBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:01:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38366 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbfJVTBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:01:21 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so21766777iom.5;
        Tue, 22 Oct 2019 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfxSHYvmdEv1sm79e3HTi1RwgAIgEe7zqfMJ263x0xg=;
        b=m6gaYXo+SBJ6yxQUD50EHP8m/o2zWCUkcm4zfRYWPqsxcCaBtfI4gR70AjPI0kgvRn
         oCBJaeHHmvWwyrNPxa4K3iZBQtYc/YciryW1xokRbVbPel4OAQ7wD3RdVFT+QbqAs+F5
         PNNim372/STeko7kwHy7AUVu0XinaDph2biqSG7OFr66mu66wVP9slSSX6L8361YyVbX
         OToJI9/0WCGDmYz1T7ylnPlyUNEkU0JcnkGqSYmNelV95xkG9izQyosIY7Lsb5CeSKKA
         +/XTgAK8JkkRzYT4SgeRBxN3/f6/fF8O8r7Gz0ca473uHMql5bZDE40m1U3Nq0GX1mEe
         Pi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfxSHYvmdEv1sm79e3HTi1RwgAIgEe7zqfMJ263x0xg=;
        b=lTsSZHPjuXU+p6N7MfZ79GghAdLjSjitYQiozhsEc9amPVuAENnNWDQV7JIsrdWO+9
         ZDCRQuEzxXDiEMOF1VR9CnFlXyLSZZyDZkXWpj8o+A13L1SExtdZKdOA8KcIhTX2yvyM
         LSYUpRbyOkAaAHUjLLVwmkHgdNb+aMKKPvXKLLFqxYL024iPG/LKyMatIeA3eCAWbsvU
         kKQ/OSKD8zipOXsReixdz5xr9SXGFYWmRgGzv87X6GCFA5mrykP+aRJeWO0lDaW0O651
         Ht7kmNUlfylwlbVj4P8vda9uyubMAhjFLQxe5hiz4ji+95NJtNUXYGIEnAgJ4Qki3q5m
         MdOw==
X-Gm-Message-State: APjAAAVosGGHqL6eFiAumZYqB3/Gi+QHkQLn2uAwMYr4yJQ0VPKP2uV5
        Y+BpRxoemX9WwfaqtBquchGn2eC3N/8lOpS/vnU=
X-Google-Smtp-Source: APXvYqzQASMPJfj+YZm2OBbuJQoz80q16/O9naj7kf1/88RbHylyV8nyZmARfqkPQXvQ0Q9vaSY+MetI2GXnLHntuLQ=
X-Received: by 2002:a02:c519:: with SMTP id s25mr5378905jam.3.1571770880220;
 Tue, 22 Oct 2019 12:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191007220540.30690-1-aford173@gmail.com> <20191022162223.GU5610@atomide.com>
In-Reply-To: <20191022162223.GU5610@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 22 Oct 2019 14:01:08 -0500
Message-ID: <CAHCN7xLy975mxX+cm56PMx-TKODEZjYPfMHb=byspKxYXXq7OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:22 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Adam Ford <aford173@gmail.com> [191007 15:06]:
> > The some in the OMAP3 family have a bandgap thermal sensor, but
> > omap2plus has it disabled.
> >
> > This patch enables the OMAP3_THERMAL by default like the rest of
> > the OMAP family.
>
> Looks like this breaks off mode during idle for omap3, and that's
> probably why it never got enabled. The difference in power
> consumption during idle is about 7mW vs 32mW for the SoC as
> measured from torpedo shunt for main_battery_som.
>
> I think the right fix might be simply to add handling for
> CPU_CLUSTER_PM_ENTER to the related thermal driver to disable
> it during idle like we have for gpio-omap.c for example.

I am not sure I know where to start on fixing that issue.  Would you
entertain enabling the driver if we set the device tree to 'disabled'
by default?  This way if people want to to use it, it can be enabled
on a per-device option.  Once the power stuff gets resolved, we might
be able to enable it by default.  For people who are planning on using
the DM3730 @ 1GHz in high temp environments, I am not sure they'll
care about low power.

I'll try to look into it when I have time, but I was hoping a
compromise might be a reasonable work-around.

adam
>
> Regards,
>
> Tony
>
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index 8f1c2b6f9e56..7e14a8c8bb29 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -292,6 +292,7 @@ CONFIG_THERMAL_GOV_FAIR_SHARE=y
> >  CONFIG_THERMAL_GOV_USER_SPACE=y
> >  CONFIG_CPU_THERMAL=y
> >  CONFIG_TI_THERMAL=y
> > +CONFIG_OMAP3_THERMAL=y
> >  CONFIG_OMAP4_THERMAL=y
> >  CONFIG_OMAP5_THERMAL=y
> >  CONFIG_DRA752_THERMAL=y
> > --
> > 2.17.1
> >
