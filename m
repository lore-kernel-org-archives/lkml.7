Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53321726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgcKz7Iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfDEOpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:45:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37024 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:45:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so3154898ply.4;
        Fri, 05 Apr 2019 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSobiwhSicZO2v13qvj2ulj+R9mnYfza+QmYpFGujDk=;
        b=TgcKz7IvrJ8TBMTktTpFfLRls8tozIbD1zCJ0l4ea9JZSBI5iwWn49ziNrzQ7Po7o+
         ry4t7GsjdvIAwgeJHXW+c/PjZsWk4xaF3VU6zyECAoz6seqpFUelZGiSUVfoRIdPg7dr
         z2i9Oc6Vf0y4ggPXhMG6jymLD2MEmMu25KnxFmLLGNCQt6wsAVJj2AGF7HmJD9kBOou9
         MqNxCWVhmEjJI7xpFJHqmjpQfdmV6BOjhUAN2kBF62vj8581c0zQlNx/m1F+fa6TwIro
         26IvHcBm9GYGGS+N1DL+SeJ3FK6FLk/ky1gFeCCtVHuFerH6Z32f2BzHXQGnAd4AV4pI
         CZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSobiwhSicZO2v13qvj2ulj+R9mnYfza+QmYpFGujDk=;
        b=Ku5Gyu/q/GTn2UYerwGS/cwzykPz6yn3/USv2sBI53u48+IESzBE4Pqp13HyKoMkrv
         6md4dX7wCKTYgOq+ceuYbEXfXajPzLx5oWI+KQ3VIvHi7Qzpq/mG2vGGIrNnF15pkGsD
         zkM9sF13T6fRPQpGs8DINTGGflDR1IVGvEBgv87lg1krzA90OO/AcfBmuAwhUw2/Jghx
         8S9FttmjeMrl9A8YHel7lnTJsCItNv1Y0Air5ObhyqT3gblDZqtCn1noQaz/Ckn+sfkB
         WPo2M3ORdKYyr0rZL7JaI8WztJkPEmsB6bAJarXPpDLjc9iD6E3mJb6IQxFOlyOvvHSm
         Qirg==
X-Gm-Message-State: APjAAAUIalsGL2JjRkrURugdW7WbRZXHNCVIoodckRfNpcvEl/65K7HJ
        Kc5ksdw9y36KcgBfqGt/23kiv1upZzwm+YlqHg8=
X-Google-Smtp-Source: APXvYqwBqADPRqKTAuFbV/S6HnWVUtyrCfHqqGq30erQJK2dRM3z8eyhAiDlYNc9nouY6xIDzBZCu++UnPZyTpC2aRE=
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr13024961plk.282.1554475545611;
 Fri, 05 Apr 2019 07:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <1553632152-18888-1-git-send-email-linux@roeck-us.net> <4554bd3e-fabb-44aa-fc82-52ec9cbf9b2c@linux.intel.com>
In-Reply-To: <4554bd3e-fabb-44aa-fc82-52ec9cbf9b2c@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Apr 2019 17:45:32 +0300
Message-ID: <CAHp75VfKYCnYdvpvkGgdjXJNRRKWOW-ps99ROWZZSH_NZAOMLg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Mark local function static
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 2:47 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
>
> On 27-Mar-19 1:59 AM, Guenter Roeck wrote:
> > 0day reports:
> >
> > drivers/platform/x86/intel_pmc_core.c:833:5: sparse:
> >       symbol 'quirk_xtal_ignore' was not declared. Should it be static?
>
> Looks good to me.

Please, give a corresponding tag.
Meanwhile I will apply it to my review and testing queue for robots to
play with, thanks!

>
> > Mark the function static since it is indeed only called locally.
> >
> > Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> > Fixes: 238f9c11351f ("platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >   drivers/platform/x86/intel_pmc_core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> > index f2c621b55f49..9908d233305e 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -828,7 +828,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
> >    * the platform BIOS enforces 24Mhx Crystal to shutdown
> >    * before PMC can assert SLP_S0#.
> >    */
> > -int quirk_xtal_ignore(const struct dmi_system_id *id)
> > +static int quirk_xtal_ignore(const struct dmi_system_id *id)
> >   {
> >       struct pmc_dev *pmcdev = &pmc;
> >       u32 value;



-- 
With Best Regards,
Andy Shevchenko
