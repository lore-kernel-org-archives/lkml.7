Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGyLsJRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfC1Xsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:48:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37215 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC1Xsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:48:37 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so1098959itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrG0xVXFW6lpwZPzipOxZqZ/XiI7RlykZHu1woLN+7c=;
        b=kGyLsJReFwopGKFWbTKr1bVsq/gGxA0wF323f1/btuYXdqKZ1cCxszrv3onUCdRIPz
         0P5DKM4Dw7GoXdGN+OYw7UsuoyJiMQriZ2+DhbVRYDi83z3JuyVvnfLZbfLY8EH40sBs
         v0L8lUX131ZckJ06TuCrtJQE0ff84XJWDeihzx7VzQxPA4/CZ5w+EpFMk7oB+NR2sbds
         n89/PW7Y/O8fto6UUzWqFs/FiEyzvRvZJZiokIgL/d7wQLWXCWLT/uhHRvXUEtOLf+Yu
         TNWlA5Pp0m5VGS3nbpC/taEKBF8eVk8V5KOnFcrNxoO/oj0vLASOPvW67bgjRjSElcSq
         00oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrG0xVXFW6lpwZPzipOxZqZ/XiI7RlykZHu1woLN+7c=;
        b=SWpREFCbHxDDJaCxYoe95eJ6SEksms3hTurymWJgFPCcQFad8VGhUDbvm9ZTEF6H3Z
         KF9UTUtdDlhYc+SddBs5B3HSS6AIk+ZSdx9Xcui4cO90DoJran7ymxTrHGkTUhz6JN24
         XKgREgDWpMjzwocGpA1IMJY7+jX7/6QlwRWSjY5azm6tOZfUfmhIR4yy22v9LdZVrul+
         84DOOtfPAyTEcVqDD/N6wVbnwtDy8+s+aI8988bXgUiF4CD3Bmme8z0Z1Bz7dhyL/OUD
         FihCeVnEDomujnlIF3vrTYUKXAbpT3e37tg0aVLPSwDrF4mpTfuxUBNZUjQC7VSg5X7B
         5j3w==
X-Gm-Message-State: APjAAAV9xUs15zqfGWeniTKiahE5b0uB/+/exsRMUjr50ws1jmHKULbo
        dTkpN6vKFt+LlLZUcfSXzUUZBWE6zN4YgwYomeMqmw==
X-Google-Smtp-Source: APXvYqwNSAgl28Rjo0R/g8YaJI1KTruScuJ9Zrk59I8E9SNXHszjThPbCf7bvw8nqNEM5oC3KjUCRs+Gfdl2CiVP1Yo=
X-Received: by 2002:a24:c106:: with SMTP id e6mr2302037itg.21.1553816916536;
 Thu, 28 Mar 2019 16:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190320222844.134765-1-furquan@google.com> <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
 <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com>
 <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com>
 <CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com> <CAJZ5v0jPJYM6n0OWBM17d3MF5h5B+an+LSRiXTHqboXZuXkcvw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jPJYM6n0OWBM17d3MF5h5B+an+LSRiXTHqboXZuXkcvw@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Thu, 28 Mar 2019 16:48:24 -0700
Message-ID: <CAEGmHFHvOJWOjgEz3mYBKGeb4+r_QfuLaWb=NW8mq7GTXdefVA@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
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

On Thu, Mar 28, 2019 at 1:57 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 28, 2019 at 1:46 AM Furquan Shaikh <furquan@google.com> wrote:
> >
> > On Wed, Mar 27, 2019 at 5:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan@google.com> wrote:
> > > >
> > > > On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
> > > > > >
> > > > > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > > > > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > > > > > of event status bits unconditionally on suspend and resume paths. This
> > > > > > was done because of an issue
> > > > > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> > > > > > lid status stays closed even on resume (which happens because event
> > > > > > status bits are cleared unconditionally on resume). Though this change
> > > > > > fixed the issue on suspend path, it introduced regressions on several
> > > > > > resume paths.
> > > > > >
> > > > > > First regression was reported and fixed on S5 path by the following
> > > > > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > > > > > entering S5"). Next regression was reported and fixed on all legacy
> > > > > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > > > > > events when entering sleep states"). However, regression still exists
> > > > > > on S0ix sleep path since it does not follow the legacy sleep path.
> > > > >
> > > > > What exactly is failing?
> > > >
> > > > Here is the failure scenario:
> > > >
> > > > 1. Consider the case of trackpad which acts as a wake source.
> > > > 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> > > > during normal interrupts as well (i.e. during probe at boot or when
> > > > using the trackpad)
> > >
> > > I don't quite understand this.
> > >
> > > Is the same GPE used for signaling trackpad events in the system
> > > working state and for wakeup?
> >
> > Yes. The same pad is being configured for interrupts (i.e. routed to
> > APIC) during S0 as well as configured for GPE (i.e. routed for SCI) to
> > cause wakes when in S0ix/S3. This pad is externally connected to
> > trackpad interrupt line.
>
> And the way the system is wired up causes the GPE status to be set
> when it is enabled, I suppose?

That is correct.

>
> So effectively, you need to disable the active-state IRQ, then clear
> the GPE status and enable it for wakeup.
>
> OK, I'll queue up the patch (and talk to the upstream ACPICA people
> about taking it in there).

Thank you!

>
> Thanks!
