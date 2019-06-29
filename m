Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48CCC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937CD215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3c5PRK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF2OSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:18:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41803 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfF2OSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:18:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so4364565pff.8;
        Sat, 29 Jun 2019 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TueofaNrt5ApDuSOVktMj9KHv4fYZr58pNUpGFN5EEg=;
        b=K3c5PRK2DBwgX5OPGu3eaY3z29hUSjL5EER/VPUoZ+NV/sCZHsdUqHl1VY9gy9aCD4
         A3xM6mm5WQ7IA9LN06mRuloytnBCEfdDOMzY/fwY5MlOAsCUgUen2A9ku/tgmQ3f80w2
         9rKpDb8KtV+Bat2LOACJD1+UE8CN6Sb+vKz8pKgQV+lxLe2QVkXNaqV+qRTdMPlJSi3y
         5wGnVIzgToKcb8eHjfFyxf1kjBVA5Fn+N1ift9cBiM00tQxFapcVfI85ePTkpHbtznfg
         ia6zwFc0+Q+aLCX+p7/9VfdW48BgSMVF+9XSeU3l/SgIleM5rWSwq6IJ6pvuCQqtwBiM
         4D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TueofaNrt5ApDuSOVktMj9KHv4fYZr58pNUpGFN5EEg=;
        b=XKxzqhgF+2g8dcrgbi0fNtrwneduQkM5bXKd/6tcHMKpwU9MTNzj0a711lNZSdR2Tm
         6c3PDGtvGyQZk1IP7HGlqGKStrpeT8Mn6FMH4a8fCBpUI+R9Ipig5DvDERa20eg7lfk6
         /Q7oNWPGk1MOBnuFCMkD38eS3qYtf4OwCHKHZxwYLDZCGxGAfCuu4quRsCp3WGKTsRVN
         7DKQl1O8vGixot/bq+8Dphgz4e7+GO12PVcnPfKL06JPSARSsp7dpDUBECWU9I6mxqM5
         wvWWLYRCJxG8F9MMLq7qFaS8zsNzw+kEsXSDU8oGVQ8Ne/RxRm4WYedPrrUZkWT8YdKu
         NM8A==
X-Gm-Message-State: APjAAAVk4gOR+sdnqrf9IRG2tPAFMBRhl4jCLUuzdCCralX87NLpsohI
        zNxxeMfS8SNOyeayJJc60N2hh4eUFzdsMfNmSDc=
X-Google-Smtp-Source: APXvYqzeEJBbIfcvRZw2Q8SBHBej6B3PZhF/eC73Lp0rClzMxntIOGvVUos3bMGlvbUCF3AJEQVAmlCrb0jhc+FEwK8=
X-Received: by 2002:a63:c0e:: with SMTP id b14mr14713106pgl.4.1561817918572;
 Sat, 29 Jun 2019 07:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190620115056.4169-1-luzmaximilian@gmail.com>
In-Reply-To: <20190620115056.4169-1-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 17:18:26 +0300
Message-ID: <CAHp75VcSDvjnS57mS2HyEvUyBRGv68yxXt7wCbJHK3pw98UiOg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for buttons on newer MS Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 2:51 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> This series adds suport for power and volume buttons on 5th and 6th
> generation Microsoft Surface devices. Specifically, it adds support for
> the power-button on the Surface Laptop 1 and Laptop 2, as well as
> support for power- and (on-device) volume-buttons on the Surface Pro 5
> (2017), Pro 6, and Book 2.
>
> These devices use the same MSHW0040 device as on the Surface Pro 4,
> however, whereas the Pro 4 uses an ACPI notify handler, the newer
> devices use GPIO interrupts to signal these events.
>
> The first patch of this series ensures that the surfacepro3_button
> driver, used for MSHW0040 on the Pro 4, does not probe for the newer
> devices. The second patch adapts soc_button_array to implement the
> actual button support.
>
> I think the changes to soc_button_array in the second patch warrant a
> thorough review. I've tried to make things a bit more generic to be able
> to integrate arbitrary ACPI GPIO power-/volume-button devices more
> easily, I'm not sure if there may be reasons against this.
>
> These patches have also been tested on various Surface devices via the
> github.com/jakeday/linux-surface patchset.
>

Pushed to my review and testing queue, thanks!

> Maximilian Luz (2):
>   platform: Fix device check for surfacepro3_button
>   input: soc_button_array for newer surface devices
>
>  drivers/input/misc/soc_button_array.c     | 134 ++++++++++++++++++++--
>  drivers/platform/x86/surfacepro3_button.c |  38 ++++++
>  2 files changed, 160 insertions(+), 12 deletions(-)
>
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
