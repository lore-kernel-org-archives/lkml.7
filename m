Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B0C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mb31X2uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfFUT1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:27:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43290 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfFUT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:27:03 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so210190ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7qxT+JyYemN2hqE07BFZyjlht15uSkSm2YTk/bCQH0=;
        b=mb31X2uNEiuhmlvxhmDHThl7mXed7roK4NpDrZdWL7O7D7j+OVqXumpvzGacwpsmlQ
         /jyBV+LH7UFWBTz9UKUsuCm+HDezOuVOw0u7EmWIyrPNdJttFWBH38798aIqqwY3nKl4
         zJme8EeOphK0YtRMs1aeVPg9lssrz1TSz4IsDl6YFEpPNf9Qac1uqQAkvb/UXsyQLnSm
         IKUFMEVrUsBWgMj8r/+J/bDg5+kRLFBizc3hw8yp9DrPWd/ePAiYMWgIuIahfuaGwE0H
         TZ/t4oWhdT/47YhLERjc3+atxojsDZ3AliE5wu4iU2FhCR4T8WK+RiS+S5Jcptqoa0FP
         a1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7qxT+JyYemN2hqE07BFZyjlht15uSkSm2YTk/bCQH0=;
        b=Gt1468IxTvGrEhnssYn2iXoqbBkNyhoyEjJF+ttwUZf2V3GVaMZauCjpimsXTTVktY
         EoGOVtd/4zCuudur16JSmVbjl9NVIGbYpoViodcSVkMisZiRTI4ppZCNCEpKvqj/kwUA
         X1KMoDPFeC47ZDggxfUFuVuaKB4iWuwJ8vFlpO+Nkuw48ebLuADEIT9ZEt0xRgWZuuyK
         4D/EkGd3KHtlu09ppLkOmBkTWWGFtmuWJmUmjPCOhrnWqDf7+cueZ7CgG/UEROkUm5Ds
         9JfHVDNxz5Rw0SOExNAdP2lV6pg/6OBFPwjCSriFYiYrLEX4JjDpcVUeG4GRL3Ig/Rwt
         Z1tw==
X-Gm-Message-State: APjAAAWoQlD6nUpsFARFIg30kDI4Ljtrr/lCy/GDV0AWZywE+i+Wm15h
        YacOe1+McYlV4rPeq3+P9zSg6MUAa7VXZgZw/pha2Q==
X-Google-Smtp-Source: APXvYqyfSRt0VN0F67v9bYAsbajgYq9ujyLc8WQMLPb1z/n18RF6urK76ioBlJHR5T1fzpSnrjOXxxe0P3vvvHwLX+8=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr19008846ion.104.1561145222426;
 Fri, 21 Jun 2019 12:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-2-matthewgarrett@google.com> <201906202010.49D16E03@keescook>
In-Reply-To: <201906202010.49D16E03@keescook>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 12:26:51 -0700
Message-ID: <CACdnJuu5SvLndNs9GBm724wLOz+QFuu3agbH4Prndt9LG=Xcbw@mail.gmail.com>
Subject: Re: [PATCH V33 01/30] security: Support early LSMs
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 8:22 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 20, 2019 at 06:19:12PM -0700, Matthew Garrett wrote:
> > The lockdown module is intended to allow for kernels to be locked down
> > early in boot - sufficiently early that we don't have the ability to
> > kmalloc() yet. Add support for early initialisation of some LSMs, and
> > then add them to the list of names when we do full initialisation later.
>
> So, if I'm reading correctly, these "early LSMs":
>
> - start up before even boot parameter parsing has happened
> - have their position in the LSM ordering ignored
> - are initialized in boot order
> - cannot use kmalloc, as well as probably lots of other things

Accurate. I've expanded the description.

> >       pr_info("Security Framework initializing\n");
>
> I'd rather this was kept in security_init() since it's the string to
> search for when debugging normal LSM initialization.

Ok.

> >
> > @@ -343,6 +342,30 @@ int __init security_init(void)
> >            i++)
> >               INIT_HLIST_HEAD(&list[i]);
> >
> > +     for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> > +             if (!lsm->enabled)
> > +                     lsm->enabled = &lsm_enabled_true;
> > +             initialize_lsm(lsm);
> > +     }
>
> This should call prepare_lsm() before initialize_lsm(). While not needed
> for this specific LSM, it would be nice to at least do the blog size
> calculations and keep everything the same as other LSMs.

Ok.

> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * security_init - initializes the security framework
> > + *
> > + * This should be called early in the kernel initialization sequence.
> > + */
> > +int __init security_init(void)
> > +{
> > +     struct lsm_info *lsm;
> > +
> > +     /* Append the names of the early LSM modules now */
>
> I would clarify this comment more: "... that kmalloc() is available."

Ok,
