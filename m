Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A510524679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD46Onh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLTKdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:33:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727261AbfLTKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576838008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dmt13RMD5aQ2MYXVw19Ilk0o7Wyai72pdtMpv4qPTtU=;
        b=PD46Onh2nranXSwvue/xkQzxF32Cl/5SZEA8EG17aotJJqiJjvDK3gVu6m9v3Wv775Mc0+
        G7x5Unn8jyreAdNisSMztUApXVEyGGWmBiiSYWxvpokA7J+iaQqezfHktnj7NS9Po2UkFA
        3lnxny6BITrDoaC+6TSYJN3tsRxOWKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-KtAjJ_fCPsOZtZpjG_-gCQ-1; Fri, 20 Dec 2019 05:33:26 -0500
X-MC-Unique: KtAjJ_fCPsOZtZpjG_-gCQ-1
Received: by mail-wr1-f70.google.com with SMTP id f17so3621015wrt.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 02:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dmt13RMD5aQ2MYXVw19Ilk0o7Wyai72pdtMpv4qPTtU=;
        b=IPl+4+S3QwfAS1gb/OxQ5cmig42Ua+cDO8+pznnS3IdGkguVd0C0SiY0Qw1U/GN7F6
         pjYT9b/uO/1Pq79Cdy8SNC9Apy7+SJ+YGaRgGThH6VbXGBvAoomVZlt5mBsWUtqWs1pW
         lw2qjqtYNxLN8ruC5SUwYY7GJANDjBtyZT6Y884Oav9QI6FLrRrfh97/eRgxY/bB8ILv
         nkEiEjKc4tlUdl6pl5Xlfau3ttcjHGY6SkQ6WRuMLD1NP3N3iyMhxYIJWnOGEyPcNTSb
         yBwp5ZfVCIxUmbHWRdC0y38s4h97DYPMdgmW5Ey7WIVqmZ0ErOg/jFH49NfCvmH20RAB
         7gRg==
X-Gm-Message-State: APjAAAVNxVPQHisngqx3Z8i00Jy8zxm60BOWDtwqtqcSw6VzkoePWYt4
        55Jvs6uX0HeVmRL0EqSaniBIpoaZZjlmqozN/YnUa2Na93ndHRyE3wXe9pXvQZ8Gdpui/dwG4lj
        I+NreCt+Gbtj3ZFymn/vkK3Rw
X-Received: by 2002:a1c:f008:: with SMTP id a8mr15213396wmb.81.1576838005181;
        Fri, 20 Dec 2019 02:33:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyB4vPOIpSM6TUqmZkQcgXydkp+Elfj9aDQamKhs/Gp3u5seTgc+/4nLCHzGTUPriKNTsW42w==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr15213377wmb.81.1576838004922;
        Fri, 20 Dec 2019 02:33:24 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id v188sm9858559wma.10.2019.12.20.02.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 02:33:24 -0800 (PST)
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191206175409.335568-1-jason@jlekstrand.net>
 <3565c99f-3cc4-32cb-1cac-98c7b0392e5c@redhat.com>
 <CAOFGe95h-eKPiS-7D8_Lg3wcOR-yuQQNkunw21K_rQ64DtCMJw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6a75a89-5650-8e50-ec2b-f5da8b633b81@redhat.com>
Date:   Fri, 20 Dec 2019 11:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOFGe95h-eKPiS-7D8_Lg3wcOR-yuQQNkunw21K_rQ64DtCMJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-12-2019 04:02, Jason Ekstrand wrote:
> Sorry for the late reply.  The e-mail got filtered and I didn't see it until now. :-(

No problem.

> On Sun, Dec 8, 2019 at 8:05 AM Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi,
> 
>     On 06-12-2019 18:54, Jason Ekstrand wrote:
>      > Running evemu-record on the lid switch event shows that the lid reports
>      > the first close but then never reports an open.  This causes systemd to
>      > continuously re-suspend the laptop every 30s.  Resetting the _LID to
>      > open fixes the issue.
> 
>     Sorry to be a bit nitpicky here, but the LID does work normally right,
>     so it does signal an event when it gets closed a second time right.
> 
> 
> What I observed with evemu-record is exactly what I wrote above.  Without this patch, I see one LID event when I close the laptop lid the first time and never see another LID event again, either open or close.

Right, but I assume that with the fix to assume the LID is "open" on resume, that
suspending by LID does work a second (and third, etc.) time, so the LID is
sending events more then once, it just is only sending close events. Where as
your current comment and commit messages to me sound as if it only sends an
event once.

If closing the LID does properly suspend a second time, then the issue is
that it always reports close, even when queried to sync the state on resume,
so in essence the same as on the Medion Akoya E2215T, which uses the following
comment in its dmi entry:

         {
                 /*
                  * Medion Akoya E2215T, notification of the LID device only
                  * happens on close, not on open and _LID always returns closed.
                  */
                 .matches = {
                         DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
                         DMI_MATCH(DMI_PRODUCT_NAME, "E2215T MD60198"),
                 },
                 .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
         },

So assuming that I have correctly understood that the LID does suspend the
system a second time when closed a second time (and a third, etc.) then
IMHO the comment for the Razer Blade Stealth 13 late 2019 should be
something like the above comment (and idem for the commit msg).

I hope this explains better what I tried to say in my first email,
if not let me know.

Regards,

Hans



> 
>     Your current commit message and comment suggest closing the LID only
>     works once. So perhaps something like this for the comment:
> 
> 
> The commit message and comment are different from our IRC conversations because I updated them after running evemu-record and seeing slightly different behavior than we discussed on IRC.  Our earlier conversations were based mostly on guesses from me seeing spurious suspend issues and looking at the types of ACPI bugs I'd seen reported for other machines.
> 
> --Jason
> 
>     /*
>        * Razer Blade Stealth 13 late 2019, _LID always reports closed,
>        * even when opened.
>        */
> 
>     And adjust the comment accordingly.
> 
>     Regards,
> 
>     Hans
> 
> 
> 
>      > Signed-off-by: Jason Ekstrand <jason@jlekstrand.net <mailto:jason@jlekstrand.net>>
>      > ---
>      >
>      > Re-sending due to a typo in my own e-mail address. :(
>      >
>      >   drivers/acpi/button.c | 11 +++++++++++
>      >   1 file changed, 11 insertions(+)
>      >
>      > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>      > index 662e07afe9a1..f7ca94e41c48 100644
>      > --- a/drivers/acpi/button.c
>      > +++ b/drivers/acpi/button.c
>      > @@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>      >               },
>      >               .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>      >       },
>      > +     {
>      > +             /*
>      > +              * Razer Blade Stealth 13 late 2019, _LID reports the first
>      > +              * close but never resets to open.
>      > +              */
>      > +             .matches = {
>      > +                     DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
>      > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
>      > +             },
>      > +             .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>      > +     },
>      >       {}
>      >   };
>      >
>      >
> 

