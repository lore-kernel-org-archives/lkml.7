Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7061DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE9B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120297;
	bh=kZM2JED21ul2A+ZNE+d9uOulIkH/RnsK04+h0ddyi3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z8Tn5joaDnJKqDQMmUQuB8Vs96piqMFDXaihw84hmoPZS7mHBZCRZYY8ZR6ouqWKN
	 vKbQdpc6J0ePBpbOQTUu6Eof8eyfzLW9JwDxVqfyF5eLRjqIFwCPkinpDu/6pYg4EY
	 pBWeAP8YqDVC7m5vseYoGWwjpQo9pV1ZXELchSDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfCTWSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:18:15 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43294 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:18:15 -0400
Received: by mail-oi1-f174.google.com with SMTP id 67so3136036oif.10;
        Wed, 20 Mar 2019 15:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEjcFnZj4SLhGx6f1FBW+wz7ljQx0oSs/w2Wb6sJnPI=;
        b=mz8kSefCX8reUJW01Jg56obz309/GbBAjJ2IkICK269q3MVicQg+ZZbA/4qHbyDwJk
         vcItgaDa3ywWhlScnRXUfqBpV43GmxUkeqgCHIvJxFjgqrSbQ6aXBdvsYbgMPymaCbMF
         vHBYzlzVYQRdU/FpCaUxe7aELkqzTWz8rXimuCR8/M/Eq4K7s8k1yyDniVFYtEHp2Ahg
         OMsr+mftk2Hhki4Y2swk2Le1YpvyIPAvtpW3EVKMjKEcvN3qda78MhjJ6b5uTeB8y5v1
         yt38ZyVnApqqwfrP1Y6obXZyJM49PuxvUzlAUULb+w0VmpbwnIPwf97SP1BpYZ/N/s7x
         65qA==
X-Gm-Message-State: APjAAAUd/BRT9eeSEuUiQsPj59V9P1Em7kIMrpzvMeeSNFH5aGvz1HOz
        qYy88BSdP0UPEMPFOEHdKblqiVRBiweFmtJch50=
X-Google-Smtp-Source: APXvYqyPtwhcnUVdXiS34ZlODxlv4uVdA7liO1vl3PyReP5FU0rfG9Mc6IlxC5ohphN190wdrDgR8FvpaTPUw8ksAa4=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr203636oib.95.1553120294392;
 Wed, 20 Mar 2019 15:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <6369897.qxlu8PgE1t@house> <3100343.nkNWlhakcz@house>
 <CAJZ5v0if=ypE-0j6baq4uTkDp5Ew_WO68oqL0dOi+tZhoP-4mQ@mail.gmail.com> <2885751.XIsKOnZRY2@house>
In-Reply-To: <2885751.XIsKOnZRY2@house>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Mar 2019 23:18:03 +0100
Message-ID: <CAJZ5v0h6tx_swhuQhZFsayszqtE2k3rO45VoDcrSieB6Z9NBgg@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
To:     Thomas Renninger <trenn@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Simon Schricker <sschricker@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 3:17 PM Thomas Renninger <trenn@suse.de> wrote:
>
> Rafael,
>
> I top post the general things and answer in only a few sentences embedded in
> context below:
>
> I very much honour your work and your neutral opinions and reasoning and
> I always have.
>
> This patch is a resend and while I try to come up with alternative hacks,
> there still is no solution, not even a suggestion.

I have a patch to rework the EPB handling to avoid the offline/online
and suspend/resume issues which I'm going to post shortly.  It doesn't
change the current behavior on the first CPU bring-up, however, so
feel free to adjust it to your needs.

> I sent the patch 3 years ago:
> https://lkml.org/lkml/2016/2/26/675
> And I found this when doing performance analysis with Mel (Gorman).
>
> This time Hannes (Reinicke) stumbled over it, while he was working on
> performance tests on NVE over fabrics.
>
> We need this fixed and I am going to repush this into our kernel(s) now.

I'd recommend to wait for a while with that.

> On Monday, March 18, 2019 11:57:08 PM CET Rafael J. Wysocki wrote:
> > On Mon, Mar 18, 2019 at 2:22 PM Thomas Renninger <trenn@suse.de> wrote:
> > > On Monday, March 18, 2019 12:40:46 PM CET Rafael J. Wysocki wrote:
> > > > On Mon, Mar 18, 2019 at 12:15 PM Thomas Renninger <trenn@suse.de> wrote:
> > > ...
>
> ...
>
> > > > > > It may not match every setup perfectly, but at least it
> > > > > > is consistent.  Why exactly is it worse than whatever the BIOS has
> > > > > > set?
> > > > >
> > > > > Because there may be BIOS settings for the CPU which justify
> > > > > initialization
> > > > > of the Perf BIAS value by BIOS.
> > > >
> > > > Well, the EPB is there for users to set it via the OS.  The BIOS
> > > > setting is not guaranteed to work for all users anyway.
> > >
> > > Who says that?
> >
> > I do.
>
> And this is the reason you do not see much patches from myself anymore over
> the last years.
> It's certainly not your fault. I had quite some discussions with Len about
> specification and BIOS breakages.
>
> Especially in the CPU powersave area, idle states and cpufreq drivers, Intel
> was doing it differently all time long the last 5 years. Ignoring their own
> specifications, ignoring possible BIOS settings and changing kernel and
> userspace interfaces all the time.

It looks like you are generally frustrated and hopefully this isn't my fault.

I would like you to be more specific, though.

> And now I have the discussion again...

What discussion?

> While it is related to this patch, it gets off topic.
> I guess there should be a more general thread on lkml:
> "Do not change APIs every second day"
> Up to userspace, but also to BIOS.

I have no idea what you mean here, sorry.

> > And then we can get back to the initial setting discussion.
>
> Let's stick to this topic in this thread.
> There is no reason to not find a proper fix for this meanwhile.
>
> Overriding the BIOS setting should IMO only take place:
> - if lifetime of CPU could be affected as you mentioned. But in this case the
>   affected CPUs should be matched
> - if we expect that there are BIOSes which "want to set this value to 6,
>   but may have forgotten to do so", as mentioned in the original patch
>   from Len. BIOSes where this is the case should get a quirk to set it to 6.

On all of the laptops in my office where EPB is present the initial
value of it is 0 and I don't honestly think that this is really
intentional.  It looks to me like they don't initialize the EPB at
all, which unfortunately is hard to distinguish from an intentional
'performance' setting.

>
> Still, ideally the whole overriding and the message should vanish IMO.

We may consider doing that, but let's fix clear bugs first.

> Last time I sent this patch your answer was:
> "I need to talk to Len about that,"
> https://lkml.org/lkml/2016/3/4/371
>
> But as this is x86 kernel core code, I guess this should be discussed and
> pushed by the general x86 maintainers anyway. Sigh.
