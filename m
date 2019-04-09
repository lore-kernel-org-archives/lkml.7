Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431272082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554846264;
	bh=dEcAxGi0H60qEc6JxJsEF2pi0smjTNNRgJJPyeEUu08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0aVwpZZw4ywLG8uN61QlDxLdwZcRruT4g1v7WO8CBGPglpG4zQqvkEuUwEVnkF8dj
	 i/o2rqw7lzII7ytVZJ/3rBpHGaAW8uJLRP0vW/7seuPw9Ujs0N+7lCOyG8qIvN01jl
	 Ngv+refzKDY2NsyeBZNS2v6hUfSFj8LAS3lHfU24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfDIVoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:44:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38033 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfDIVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:44:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id a6so14925763oie.5;
        Tue, 09 Apr 2019 14:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaU7Kse6oI90K95oJ18/4wpIyqlOThlUTNk97fVKCzA=;
        b=kjXZcW65SHDQUZMQ+kWsI02wvmKodYOchuS6qTjPkajI92/TVm5s85+pru2KeuJhje
         utRvnEjdJGORybtxTqPO/D1gSoHvaZ++yzTotgLAk5ucpt2OgqV7LHVFE3rUYBfjYhaw
         6ISkR7odYlZkhHEOL+L6T7pzO8XgIIikZpQC8f3UTijFkimVRECKTzoZqLD+zQw9vtp2
         E0O5lahuUIX3mKwAxnOzu4dK1FWLLVsOI1NVTzgLUghN/CzIacSZVOTdpeoR8WsPOArP
         ng7KRJHNlESUqR1dKqxCwqOL+DlZ56RtPcy7yCWDrnyxyxZyUJPyB6ecEZBxqP2hyL2O
         HiMA==
X-Gm-Message-State: APjAAAV5BCGDhD4Ojm5J97b1u1zFeJLn3s2lhBTqk/5myTvrw49cnO8D
        JeMRGGcGrsfMl6T75/F5QEn8JmYO3YipIsS1hCAJfA==
X-Google-Smtp-Source: APXvYqx1u6w53L/ZIk/dti33GtY2xN0WC9Zt/x1cjwpW725PWK4Cw5GyRo2oQx9SmZweaqYpOSxPpPk5u3VKYY5WNWQ=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr376887oii.76.1554846261808;
 Tue, 09 Apr 2019 14:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190329001135.15847-1-changbin.du@gmail.com> <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
 <20190403133613.13f3fd75@lwn.net> <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
 <20190409152638.5b20c77f@lwn.net>
In-Reply-To: <20190409152638.5b20c77f@lwn.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 23:44:11 +0200
Message-ID: <CAJZ5v0jgbvixMJTVPfEHMX0z-ssc9ZcMRCwS-QEyqtkFWcNh5Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:26 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 9 Apr 2019 18:42:59 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > > Hardware guide
> >
> > This is more about documenting the expectations regarding the platform
> > firmware, so what about firmware-guide instead?
>
> I had imagined a slightly wider focus, but this seems OK for now.  We can
> always rename it later :)
>
> > So what about this:
> >
> > - Create a new firmware-guide under Documentation and add an acpi/
> > directory to it for starters.  Put the following files into it:
> >
> >          acpi-lid
> >          aml-debugger
> >          debug (ditto)
> >          DSD-properties-rules
> >          gpio-properties
> >          i2c-muxes
> >
> > - Add an acpi/ subdirectory to Documentation/admin-guide and put the
> > following files into it:
> >
> >          cppc_sysfs
> >          initrd_table_override
> >          dsdt-override
>
> I do wonder if, rather than creating a new directory, we shouldn't just
> make a single acpi.rst and put that information into it?
>
> > - Add an acpi/ subdirectory to Documentation/driver-api and put the
> > following files into it:
> >
> >          enumeration
> >          scan_handlers
>
> ...and something similar here?  I guess that would be my preference, but I
> don't feel all that strongly about it if there's reasons to do otherwise.

The primary reason would be to retain the correspondence between the
old and the new files.

I guess they could be combined, but that would be two sort of
different changes in one go.

> In general the plan seems good.

OK, thanks!

Cheers,
Rafael
