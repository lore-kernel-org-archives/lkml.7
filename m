Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CECC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33352083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnENka0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDKPMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:12:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40296 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:12:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3600924pfc.7;
        Thu, 11 Apr 2019 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IWQcftR6mH8d1KaUspZb8lK78X37q469Ady0BoKgdz8=;
        b=JnENka0uLW4/bYOvKYXucMlA0PqmhaQN4jjoSSPtLZgun9glviYOrJYqWEW3Vj/Lr5
         QG6gpe3m2SVTNy7B4+paCcUwbFC5PezIDayv7Xxalr7VvgwDEHLuX3GP9MmnQv2G+pve
         Gxv4wi6006IbHxeBMWFuwrrny5QpDU2nExPD5fJj6gKmR3nmXFYXjrL1uQN/kSkqtqFg
         t9b4Hg7fjV+It+BIoVd4QGePOIpMlxZbRwjpGQZH/zSZDBZaKwfNsLZSB+08rVQomHgT
         To7wlOARDh0wXBhfsLCzzaU6KE8+K8sHELq+lBeADieE8yiR6NIkaFnriOyW7pEQM2k6
         CNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IWQcftR6mH8d1KaUspZb8lK78X37q469Ady0BoKgdz8=;
        b=d36KkyBUOg+ENiEObMN3i4bkVZFiWL5PMuhEtjyl8ikZEe2hWsh8N1sLyYB6aZGW94
         +hreq18wZIbxHEvfShY3ZgrA5aCDSxv5ck4ztqwfnsAa1YOadHHbIq1THUHDpv3jTRKf
         ptDQaQoHqpXsXOjTLEggPy0xX9l3QUZ5QjTotn7r6ZbzyxDcx58KFwg8hDXhqf2VFTGq
         iqIih+ix2SvDF3d8A7EcIkqBnpufROq9zFwRbcPSKDMW6WD4L6dlFVOGyFvQWCWZYSC0
         I4EwRxS14l1s0sno4QuM52pusDDKdDiYdXBszrfweNrSeMWL8l30kTMix1oswFOifTZX
         POTQ==
X-Gm-Message-State: APjAAAXbIdM7HIGeKb8QIF9sZI+BB+RqE3V/gLHJ7EgJrGNhz5UD9lcA
        OVlxrDmiWpEf7nptXXHUDuA=
X-Google-Smtp-Source: APXvYqw5S5JCU7PeLgtcxICw1HN/OU/WskTXIm/GKqIQpZzK6MPJ77+RPnXBn0E3YBi+H77Idhye2A==
X-Received: by 2002:a63:f212:: with SMTP id v18mr46169864pgh.231.1554995564657;
        Thu, 11 Apr 2019 08:12:44 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id w11sm27887221pfi.37.2019.04.11.08.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 08:12:43 -0700 (PDT)
Date:   Thu, 11 Apr 2019 23:12:36 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190411151234.fvowhdqbfmwc6icr@mail.google.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
 <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
 <20190403133613.13f3fd75@lwn.net>
 <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
 <20190409152638.5b20c77f@lwn.net>
 <CAJZ5v0jgbvixMJTVPfEHMX0z-ssc9ZcMRCwS-QEyqtkFWcNh5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgbvixMJTVPfEHMX0z-ssc9ZcMRCwS-QEyqtkFWcNh5Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:44:11PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 9, 2019 at 11:26 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > On Tue, 9 Apr 2019 18:42:59 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > > Hardware guide
> > >
> > > This is more about documenting the expectations regarding the platform
> > > firmware, so what about firmware-guide instead?
> >
> > I had imagined a slightly wider focus, but this seems OK for now.  We can
> > always rename it later :)
> >
> > > So what about this:
> > >
> > > - Create a new firmware-guide under Documentation and add an acpi/
> > > directory to it for starters.  Put the following files into it:
> > >
> > >          acpi-lid
> > >          aml-debugger
> > >          debug (ditto)
> > >          DSD-properties-rules
> > >          gpio-properties
> > >          i2c-muxes
> > >
> > > - Add an acpi/ subdirectory to Documentation/admin-guide and put the
> > > following files into it:
> > >
> > >          cppc_sysfs
> > >          initrd_table_override
> > >          dsdt-override
> >
> > I do wonder if, rather than creating a new directory, we shouldn't just
> > make a single acpi.rst and put that information into it?
> >
> > > - Add an acpi/ subdirectory to Documentation/driver-api and put the
> > > following files into it:
> > >
> > >          enumeration
> > >          scan_handlers
> >
> > ...and something similar here?  I guess that would be my preference, but I
> > don't feel all that strongly about it if there's reasons to do otherwise.
> 
> The primary reason would be to retain the correspondence between the
> old and the new files.
> 
> I guess they could be combined, but that would be two sort of
> different changes in one go.
> 
> > In general the plan seems good.
> 
> OK, thanks!
> 
> Cheers,
> Rafael
Ok, if we have reached this greement, I probably do it this weekend. Thanks for your
comments.

-- 
Cheers,
Changbin Du
