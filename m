Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7312C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E62D2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553763452;
	bh=EROZdJfd6EE6W9XxTLeEb7P+1vhW3cEkXb4ZBDypzdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WiZpeamuNIZg5jQy0ZlF21Q1W1QUpaP0VayOWBaebqKg1OfgOiS1KRMwVQyvIF77i
	 ncLE/2Ss8OsJRq5WwLgq7Ztu5oxeIBXYKVVZol/fnh4NwWF/FAVmxgXfpkcMc0rrlr
	 v/Y0slXXt4eg6J7B2unhYnsHYaVkemgi+sHKC8P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfC1I5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:57:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42702 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC1I5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:57:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so17576860otd.9;
        Thu, 28 Mar 2019 01:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EROZdJfd6EE6W9XxTLeEb7P+1vhW3cEkXb4ZBDypzdY=;
        b=N/U4PtzzK2++sDcyLgaRGEyYfJdR2jxcTmrHMSeUera4VkVEgvNq5StoBxfTEapEqZ
         e9tAfrfpLVLIs+mPROhfBFxPfNt/E42tBCsdpUbw+HB0DwK3Zrl7Vhjifjwnux9IEmVF
         U0YvfX7f9xD00HsqAqd/x/Oqi0/04m8hSAdTHC3CQ2o7vnCmJdF6e6njQSxhjWhbS7KZ
         tkvy98ki0IR0+YKSgIfwUQLrZjTsQfVhQakRnTLfTtErbbY2FXJMzmBrJzQbi04JO9tv
         8VJAQeQsJTGNJ/Um/qA/o4o/UQaCuORslR9XDstbccsuhlMjGRPpGxNUGVpeyXm48ixu
         HQ5Q==
X-Gm-Message-State: APjAAAXqhVJ9Ve8eP5ywzJzihgw4In1cPAdZw/vSfa+4feVnuFjSEoT5
        oloxeUGRHV6Eml+UFUg78i1x7k4agTec8Y5xSbE=
X-Google-Smtp-Source: APXvYqyoefmmqWRgCK/1PUIUgOAIENnkD1IB672+QeDNWHD7w7aFsZ4pLeWc8nsF1natR3vfXJDzoBRFznMCE2ZwnOo=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr30755915otl.343.1553763450279;
 Thu, 28 Mar 2019 01:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com> <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
 <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com>
 <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com> <CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com>
In-Reply-To: <CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Mar 2019 09:57:18 +0100
Message-ID: <CAJZ5v0jPJYM6n0OWBM17d3MF5h5B+an+LSRiXTHqboXZuXkcvw@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Evan Green <evgreen@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:46 AM Furquan Shaikh <furquan@google.com> wrote:
>
> On Wed, Mar 27, 2019 at 5:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan@google.com> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
> > > > >
> > > > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > > > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > > > > of event status bits unconditionally on suspend and resume paths. This
> > > > > was done because of an issue
> > > > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> > > > > lid status stays closed even on resume (which happens because event
> > > > > status bits are cleared unconditionally on resume). Though this change
> > > > > fixed the issue on suspend path, it introduced regressions on several
> > > > > resume paths.
> > > > >
> > > > > First regression was reported and fixed on S5 path by the following
> > > > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > > > > entering S5"). Next regression was reported and fixed on all legacy
> > > > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > > > > events when entering sleep states"). However, regression still exists
> > > > > on S0ix sleep path since it does not follow the legacy sleep path.
> > > >
> > > > What exactly is failing?
> > >
> > > Here is the failure scenario:
> > >
> > > 1. Consider the case of trackpad which acts as a wake source.
> > > 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> > > during normal interrupts as well (i.e. during probe at boot or when
> > > using the trackpad)
> >
> > I don't quite understand this.
> >
> > Is the same GPE used for signaling trackpad events in the system
> > working state and for wakeup?
>
> Yes. The same pad is being configured for interrupts (i.e. routed to
> APIC) during S0 as well as configured for GPE (i.e. routed for SCI) to
> cause wakes when in S0ix/S3. This pad is externally connected to
> trackpad interrupt line.

And the way the system is wired up causes the GPE status to be set
when it is enabled, I suppose?

So effectively, you need to disable the active-state IRQ, then clear
the GPE status and enable it for wakeup.

OK, I'll queue up the patch (and talk to the upstream ACPICA people
about taking it in there).

Thanks!
