Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04770C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F8C2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clwxjaqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfC0KBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:01:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45927 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfC0KBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:01:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so17998087qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxwvMwPRR/kW60NJy/oGOH1LXGfdyo9R5AHxVtcWyyE=;
        b=ClwxjaqihMkrQXqIIOrKao0c39iOSw7Ho1lXceLqeulvL+mMBtPGX5+Ev2zYdNOYrw
         IaPwLB+O3G0vZGZxiyR0pYFkQfSoLy1NvMDKz2jOe/gaq/3KhAUg1L41vBMUarMAKk9N
         EaxEZ/jY8dldExHE6XWTk4aMNZdg1k5lTnXzeR47wXJ2DvtvPKMPT1Z2HvZetMWydPsO
         ZrqfiJgzRZzHQNwG08OjDdZ6UvTLriZdoIREuJJTuGRtk5PliDLby3oB43mZLV+EWu1j
         lni5bg6DgspSqxtZOU4CSRU1sSIwX99gxPx5sMw88b4ydSAl/VJGWiHxZL/JhSAuNvCE
         vSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxwvMwPRR/kW60NJy/oGOH1LXGfdyo9R5AHxVtcWyyE=;
        b=g7A/3kf95AwuFdJHojoSe559mruAcYSguhiBxq0eDahaXMYy6Y7V7Z1cZy1U8nIBGT
         WgCdCQfacOJl6WgqcakrhmOSGLDOxhj5vCDPpExUJPjS95S6zoLXx9OEaFh2tIfM/4SV
         ugN4cqtm4yStftQLFxU5YZlzpUDG6lrwFqOz+QrVIT15ZxjjwMAaoXvwqGKVC9TLMcI7
         559sc2sK5FLs48tocnwaQ7PzEw0rWCRbE6CcB66gLDBxJxiNnblp7Jw2iF8Ry3c4slTL
         thLv87e2GdqjNf27p8L14+4pJnsjRarRyc3gERczTsLzonNKSHMvLC/Jwo2QqdjY7+nW
         pD3w==
X-Gm-Message-State: APjAAAUwW0l9lOpT9eAiXV/wX8RPYEtYx+4+tYRZCq7gX73WVmXD+3GX
        PO08ujvdf5xnnGsjce8MoAI=
X-Google-Smtp-Source: APXvYqxprxidzXzQ4S79UIQkNVeyz93gN4gNz6hSHHV5T+NUgGhiDEqVOoBhCdbHHy6yJB8Vv+Px0A==
X-Received: by 2002:ac8:f6e:: with SMTP id l43mr30129361qtk.322.1553680883870;
        Wed, 27 Mar 2019 03:01:23 -0700 (PDT)
Received: from centos-dev.localdomain (pool-173-66-89-81.washdc.fios.verizon.net. [173.66.89.81])
        by smtp.gmail.com with ESMTPSA id e22sm13618137qte.42.2019.03.27.03.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 03:01:23 -0700 (PDT)
Date:   Wed, 27 Mar 2019 06:00:14 -0400
From:   Ryan Thibodeaux <thibodux@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190327100014.GA9663@centos-dev.localdomain>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
 <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
 <20190323114151.5cebf31b@sweethome>
 <20190325130530.56603806@luca64>
 <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
 <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
 <907547fa-a7e8-8dca-dabf-dd063705f196@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907547fa-a7e8-8dca-dabf-dd063705f196@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:21:31PM -0400, Boris Ostrovsky wrote:
> On 3/26/19 5:13 AM, Dario Faggioli wrote:
> > On Mon, 2019-03-25 at 09:43 -0400, Boris Ostrovsky wrote:
> >> On 3/25/19 8:05 AM, luca abeni wrote:
> >>> The picture shows the latencies measured with an unpatched guest
> >>> kernel
> >>> and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary
> >>> small
> >>> value :).
> >>> All the experiments have been performed booting the hypervisor with
> >>> a
> >>> small timer_slop (the hypervisor's one) value. So, they show that
> >>> decreasing the hypervisor's timer_slop is not enough to measure low
> >>> latencies with cyclictest.
> >> I have a couple of questions:
> >> * Does it make sense to make this a tunable for other clockevent
> >> devices
> >> as well?
> >>
> > So, AFAIUI, the thing is as follows. In clockevents_program_event(), we
> > keep the delta between now and the next timer event within
> > dev->max_delta_ns and dev->min_delta_ns:
> >
> >   delta = min(delta, (int64_t) dev->max_delta_ns);
> >   delta = max(delta, (int64_t) dev->min_delta_ns);
> >
> > For Xen (well, for the Xen clock) we have:
> >
> >   .max_delta_ns = 0xffffffff,
> >   .min_delta_ns = TIMER_SLOP,
> >
> > which means a guest can't ask for a timer to fire earlier than 100us
> > ahead, which is a bit too coarse, especially on contemporary hardware.
> >
> > For "lapic_deadline" (which was what was in use in KVM guests, in our
> > experiments) we have:
> >
> >   lapic_clockevent.max_delta_ns = clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
> >   lapic_clockevent.min_delta_ns = clockevent_delta2ns(0xF, &lapic_clockevent);
> >
> > Which means max is 0x7FFFFF device ticks, and min is 0xF.
> > clockevent_delta2ns() does the conversion from ticks to ns, basing on
> > the results of the APIC calibration process. It calls cev_delta2ns()
> > which does some scaling, shifting, divs, etc, and, at the very end,
> > this:
> >
> >   /* Deltas less than 1usec are pointless noise */
> >   return clc > 1000 ? clc : 1000;
> >
> > So, as Ryan is also saying, the actual minimum, in this case, depends
> > on hardware, with a sanity check of "never below 1us" (which is quite
> > smaller than 100us!)
> >
> > Of course, the actual granularity depends on hardware in the Xen case
> > as well, but that is handled in Xen itself. And we have mechanisms in
> > place in there to avoid timer interrupt storms (like, ahem, the Xen's
> > 'timer_slop' boot parameter... :-P)
> >
> > And this is basically why I was also thinking we can/should lower the
> > default value of TIMER_SLOP, here in the Xen clock implementation in
> > Linux.
> 
> What do you think would be a sane value? 10us? Should we then still keep
> this patch?
> 
> My concern would be that if we change the current value and it turns out
> to be very wrong we'd then have no recourse.
> 
> 
> -boris
> 

Speaking out of turn but as a participant in this thread, I would not
assume to change the default value for all cases without significant
testing by the community, touching a variety of configurations.

It feels like changing the default has a non-trivial amount of 
unknowns that would need to be addressed.

Not surprisingly, I am biased to the approach of my patch which
does not change the default but offers flexibility to all.

- Ryan
