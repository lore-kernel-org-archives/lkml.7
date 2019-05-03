Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAB9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ECF2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVKOra8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfECR1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:27:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45919 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfECR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:27:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id q23so1199855lfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JD/+KRFZYiJzz1j6lF2eo7yI0q7TdGtFXXsyT5+MfK4=;
        b=jVKOra8vfuCU5mccq/lFKnIzApNW6ra6COBEgkuUKz+2BZ18QfAWGfZ/diR/dKxPPZ
         Ja1RG0Kis4sKSE3iDE2HFsJ4v9jobsh4vfXEAZ1kltpc14mLw0HRxkMzxStlD+Y8CEYA
         lP+t9NeY6JM9acjIeD2wpS3to5Up7n1WGezxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JD/+KRFZYiJzz1j6lF2eo7yI0q7TdGtFXXsyT5+MfK4=;
        b=Uep7B1irYHDimX1uFK3tQ8Q+6VKpSZcSHf2Sm8SuKHYPx8CyJDTL1fsepdZ9BgoJl2
         OqoLWTbvH5Qza4nhpcZZ7lV/zqdHaZrkVZUHn0gIz3fWRJa8h6K4rHK0CJ/NKOy5d+Mm
         iCl3R/JEc8UfZnPi+2dZ0h3o3JstILDkh+7fqiXvS+DUpxFw/GUvqU7dCfneXPG1lq1e
         YXYEUFGZnB7oN8r6CCsorfWo0XpTc51tG/efdra2L6BCZYs1coEjzUnBOwie4wzatjMI
         MTS7UCZ9FAnRuzYF83kEN7i+pugZbFWDtwPIHoGpWb3KHPIOTJXoUy5ALVfXQEybJSY7
         iduA==
X-Gm-Message-State: APjAAAXokTtMskrU36FgQ0Ax+7Bq1YiLQuO7tU9DiE4HuBbucT1ybvlN
        txd73YVqWAP/oGehIposB+dE/CA6TaE=
X-Google-Smtp-Source: APXvYqx4BsrW1AoDrmO1sa5sSlDESyQzuLpwbyGd56xC/VhqvH9/lcsduZpuGweTkE/EBbcI1DK6Hg==
X-Received: by 2002:a19:550d:: with SMTP id n13mr5621818lfe.127.1556904472245;
        Fri, 03 May 2019 10:27:52 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b2sm501530ljk.75.2019.05.03.10.27.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 10:27:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id b12so5882416lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:27:51 -0700 (PDT)
X-Received: by 2002:a2e:834d:: with SMTP id l13mr5938995ljh.97.1556904470714;
 Fri, 03 May 2019 10:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190430165626.31639-1-andriy.shevchenko@linux.intel.com> <6f789244-64b9-bd1f-6a9e-e5aeacbf2407@linux.intel.com>
In-Reply-To: <6f789244-64b9-bd1f-6a9e-e5aeacbf2407@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 May 2019 10:27:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft5vUoMpabMyw8u5W65FNiKiNdVSoNgwprwaE+E=K+y-0Q@mail.gmail.com>
Message-ID: <CAE=gft5vUoMpabMyw8u5W65FNiKiNdVSoNgwprwaE+E=K+y-0Q@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: Add Intel Comet Lake PCI IDs
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 12:14 AM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 4/30/19 7:56 PM, Andy Shevchenko wrote:
> > Intel Comet Lake has the same LPSS than Intel Cannon Lake.
> > Add the new IDs to the list of supported devices.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > - update i2c info
> >   drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Tested-by: Evan Green <evgreen@chromium.org>
