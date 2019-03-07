Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8913C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60CA20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVnnyjyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCGXH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:07:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34182 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:07:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id y18so46289lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB7/0a2E9BzFbgGC/gbvxAFQ2SqMkQRXHWKhdlJRuc0=;
        b=wVnnyjyf3seKBXPdSs0JsEKNgZfo+JmGUnFp/yh8H09TZtUda22ENwMsZKOQKIU+Vc
         mCLBDdLER60GK6FZY03J7YM5wBNvKjQVxrYJbOVX/rpzOGB6rOPKxckKESiVumPqw5z9
         FOoqT4jaOAm0y7QFum5SY5svRGYohIrQW6lrf0PKvwcmwrqHa/SAkhMUefMIqO6MaAiZ
         pwokzCpAP0OLKrY8IJHViPlrnrbqT1cBSW9/hRV8phdDrBhSjM4B+IV2FaM4UBrj+x30
         3Nx0xwlMFL871eRe8XuxH4w/BfHDSaP8zIMTqFwznxZJu54ka5kytuDAEazNNI6ue/Ny
         My4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB7/0a2E9BzFbgGC/gbvxAFQ2SqMkQRXHWKhdlJRuc0=;
        b=JRyBOB9s7wPk5ZdjpEB+5ahLeJe54jqu1B5otmAJODuxPdBXXRhffo+mOXpXYGh2jS
         MCLutbUqFYbOakqIzRwBOA8fPr/WUX9r73lJhoxXjiIN5cePz8wt42RVB0xyvLdjIl/Q
         GytIW1aHXgoPIlT/dJo/28Q9qhU1G4hEx+VVeIzdXP+KJ8/1Yf72m8jIdydQMLywVg1r
         Rptj/1Pb9OFsopjNbt4dK11G566nk1YMv/SjulGCzURUu4PviS76GG3BKkgQxoU40MqS
         MXbMSJyB+sMrm9Ici4DkC4XOOfOWUOvpwtIkajmOYpEWy+4md80hIThXAoGLdTIhC85M
         vXUg==
X-Gm-Message-State: APjAAAX7uuiTHwLZOYSWreE2n/LP//dN1B8YY6jsF4MKNEU9sO/Fajtq
        GnP8NuVjaJ4Lt+wt7CBE6SAu+ssJorNshB+H9SzuaQ==
X-Google-Smtp-Source: APXvYqy2+QJC9qQVSHFr9SqejPUmdUXYPF+gfpPgNnHEcOGLaWDbCZFlRwqZGMskg4u6kAVU7tWj+Nzqdxk4F8tkBNM=
X-Received: by 2002:ac2:52ae:: with SMTP id r14mr8976981lfm.66.1552000073495;
 Thu, 07 Mar 2019 15:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
 <20180730152256.GF1206094@devbig004.ftw2.facebook.com> <bf4b860c-6f82-4a3f-8b81-5f5c93f4389e@redhat.com>
 <20180730173345.GI1206094@devbig004.ftw2.facebook.com> <CAMHSBOVOK15nchZRFGTZUu8KSbBiK3SFzgW1amLjXb1iv_gJ5g@mail.gmail.com>
 <54d2b8e6-332b-117a-b982-77a535152246@redhat.com>
In-Reply-To: <54d2b8e6-332b-117a-b982-77a535152246@redhat.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 7 Mar 2019 15:07:16 -0800
Message-ID: <CACK8Z6GzOHJbh-M=0AxNbBoi3TqVehrs5xYsi2cUhW_dxz6vxg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, alan.cox@intel.com,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 7, 2019 at 12:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 07-03-19 21:27, Gwendal Grignou wrote:
> > Srinivas,
> >
> > I am looking at problem on a laptop machine that suspends to S01x, but
> > link_management is set to max_performance, because the machine is
> > connected to a charger.
>
> What is setting it to max_performance when charging?  I assume chrome-os is
> running something in userspace to do this (like TLP, but I guess you are not
> using TLP) ?

Yes, we have a udev script that does this.

>
> Have you run benchmarks with max_performance vs the default?
> I seriously doubt there will be a significant difference, esp.
> with a chrome-os style workload.
>
> > Given DVLSP must be set before the laptop suspends ["""One of the
> > requirement for modern x86 system to enter lowest power mode  (SLP_S0)
> > is SATA IP block to be off."""], the machine never reaches S01x.
> > Does it make sense to change the target_lpm_policy at suspend
> > (ata_port_suspend()) to min_power and bring it back to the original
> > value on resume?
>
> If userspace messes with the setting, then userspace should also
> put it back before suspending...
>
> The upstream kernel's default behavior is to have the target level set
> to a fixed level independent of the charging state. Could it be this
> fixed level is actually max-performance ? If that is the default the
> kernel comes up with, that would indicate a kernel bug.

Side note: max-performance indeed can be the default forced by the
kernel for some (broken) SATA devices:

        if (dev->horkage & ATA_HORKAGE_NOLPM) {
                ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
                dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
        }

So definitely these systems won't be able to go into S0ix today.

But I think the main idea that we are asking is:

1) Yes, we acknowledge that the userspace has set it max-performance.

2) However, given that the kernel already knows that:
       - while in suspend, there is no real value in retaining the
max-performance.
       - On the contrary, we know system will fail to go into lower
power mode because of max-suspend.

3) Does it not make sense to use this knowledge and switch to
min_power when we are actually going to suspend (even if user
specified max-performance), and restore max-performance on resume?

Or may be there are issues that this causes, that we're not aware of?
Can you please provide us some pointers?

Thanks,

Rajat

>
> Regards,
>
> Hans
>
>
>
> >
> > Gwendal.
> >
> >
> > On Mon, Jul 30, 2018 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
> >>
> >> On Mon, Jul 30, 2018 at 05:26:45PM +0200, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 30-07-18 17:22, Tejun Heo wrote:
> >>>> On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
> >>>>> Hi Tejan,
> >>>>>
> >>>>> On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> >>>>>> Some minor fixes to be able to correctly set devslp register
> >>>>>> to optimize power.
> >>>>>>
> >>>>>> Srinivas Pandruvada (2):
> >>>>>>    ata: libahci: Correct setting of DEVSLP register
> >>>>>>    ata: libahci: Allow reconfigure of DEVSLP register
> >>>>>>
> >>>>> Are you applying this series?
> >>>>
> >>>> I was waiting for Hans's reviews.  Hans, what do you think?
> >>>
> >>> Ah I missed that this was another series. With the caveat that
> >>> I do not really know that much about devslp, both patches
> >>> seem sensible to me, so both are:
> >>>
> >>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Applied 1-2 to libata/for-4.19.
> >>
> >> Thanks.
> >>
> >> --
> >> tejun
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
