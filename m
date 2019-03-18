Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150CF2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552949843;
	bh=tOakBhxTZcSpjQIHAuzGsw0oiRtfDcz86KllfF95L98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ROw1A3WfElbUD+KARF5zvKzKD0wHDts61Ncggh7ADLkt7HHXO6J9ZN6qaKAnmtB4E
	 P0gA015KzkElzgoC1eA/++ve07VUnWx+L8glrGcpCmex/whYVTdBxLfKv11GJrJT4b
	 Xiw+X6oEQZpi/jP1ZuP/C1cfPWQYFe3P25J42xz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCRW5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:57:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38284 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCRW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:57:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id w137so2487293oiw.5;
        Mon, 18 Mar 2019 15:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeqP637Hz4xL9ZEIDmXfZ9/I4SB257smyiUbRjYKimI=;
        b=DuyNrWari3kEFjVzG2rGNR4myA3DFsscDzyKHQYYI8vOEfZWvunzsCNQn9UisqS5pV
         r7s2uZbDTsPCBbjtlokp5IUdMBL0+aAHHh5R7Y9KftA0JjJq9oIwEFau5mKKqJzDkiKT
         xBwq2HKY9XdpZlHZRq/CWKQYpa4vI5+667wA5gc3pDEO12tNW6pEHxNgrD42XihjTS+m
         0RFkkH618HNQOi314USluBj20qPuBgNZl2GVRKfB9j36pE/xM9dIfk6o0Na0paV8QZkc
         dn+xRIWxWe+Ip3MxcjcdRkfYgsKFRAv71mCcpeJCsvzS6gvT66UczGNC5KT7t47BYmLK
         bj/g==
X-Gm-Message-State: APjAAAXqIalL+zHd61+0s9GA8F1oyZvd2zR4gKtT+4TznpQv5wUToVHa
        W2dFqk3Q+P/PiH4MUBfG560mYqbOZ0qrpA1mRFw=
X-Google-Smtp-Source: APXvYqyTWHsUX1LiC2D3XE3pDWbEEUI2GwlLzHtf/vfbf+/aIe98PDnx7VQGYpS4bExaGXASTgSGVGr+4uThI3RJl7U=
X-Received: by 2002:aca:355:: with SMTP id 82mr18990oid.30.1552949839921; Mon,
 18 Mar 2019 15:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <6369897.qxlu8PgE1t@house> <2616815.TtRSCVe66q@house>
 <CAJZ5v0jAY8OcTMKu4fn7NKVn0E+MqnWSUbSBLUjg0+2adnJ+7Q@mail.gmail.com> <3100343.nkNWlhakcz@house>
In-Reply-To: <3100343.nkNWlhakcz@house>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Mar 2019 23:57:08 +0100
Message-ID: <CAJZ5v0if=ypE-0j6baq4uTkDp5Ew_WO68oqL0dOi+tZhoP-4mQ@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 2:22 PM Thomas Renninger <trenn@suse.de> wrote:
>
> On Monday, March 18, 2019 12:40:46 PM CET Rafael J. Wysocki wrote:
> > On Mon, Mar 18, 2019 at 12:15 PM Thomas Renninger <trenn@suse.de> wrote:
>
> ...
>
> > And who's BIOS, really?  I guess you mean the OEM?  Note, however,
> > that the user and the OEM may not agree on that, but whatever.
>
> I mean both!
> The OEM.
> And the user who might choose a "performance" BIOS setting.
>
> > > > Yes, the kernel replaces whatever the original BIOS setting is with
> > > > its own one.
> > >
> > > No, it only replaces the "performance" (0) value with "normal" (6).
> > > This does not makes sense and is broken.
>
> Both know it better than this...
>
> > OK, fair enough.
> >
> > I guess it would have been better to set it to 6 unconditionally.
>
> No, I guess keeping the original value is the only sane thing to do.
> Sorry, Rafael, I have to insist on this.

Which doesn't make your argument more convincing at all.

> There might be secrets Len and you cannot share with public, but you
> should at least explain this privately then in a way that the current
> code could somehow make sense. I absolutely cannot see that.

Anyway, I just wanted to say that using the same initial value in all
cases would have been more consistent than what the current code does.

> > What about the systems that will misbehave when it is left at 0?
>
> Good question.
> What exactly happens there? The CPU is faster in general?
> And may consume a tiny bit more of power.
> I had reports that Turbo Mode is not entered on some server CPUs when
> perf BIAS is switched back to normal mode.
> It is hard to identify what Intel implemented in microcode, but it's not
> that much altogether. It would be nice if Intel would be a bit more verbose
> about this and show some performance vs powersave figures.

Can you please stop insinuating things? That really doesn't help or
make the discussion clearer.

> > > > It may not match every setup perfectly, but at least it
> > > > is consistent.  Why exactly is it worse than whatever the BIOS has
> > > > set?
> > >
> > > Because there may be BIOS settings for the CPU which justify
> > > initialization
> > > of the Perf BIAS value by BIOS.
> >
> > Well, the EPB is there for users to set it via the OS.  The BIOS
> > setting is not guaranteed to work for all users anyway.
>
> Who says that?

I do.

If users have different needs, the single BIOS-provided value may not
work for all of them just as well as the value set by the kernel
doesn't.  IOW, it really doesn't matter who sets the initial value,
the BIOS or the kernel.  In both cases it may not work for everybody.

> Is this documented?
>
> I would say it is exactly the other way around. Energy Perf BIAS hint is
> a MSR which must be changed in Ring 0 kernel environment.
>
> x86_energy_perf_policy is a nice tool to play with and to try out what
> this value is for. But for example in secure boot mode userspace must not
> modify this HW setting in any way.
> So it would not be possible for a secure booted server to switch this
> setting back to performance mode.

I suspect that this was the real motivation for the reverts. :-)

Well, if x86_energy_perf_policy doesn't work in hardened environments,
then this is a problem, but making all systems use BIOS-provided
values is not the most straightforward way to address it in my view.

> > > What sense does it make to unconditionally set perf BIAS value from
> > > performance to balanced?
> > > Why is this done?
> >
> > Basically, for HW health reasons AFAICS.
> >
> > Apparently, on some systems EPB=0 is (was?) special and means (meant?)
> > very aggressive use of turbo etc. which is not healthy in general.
>
> Hmm, maybe you want to explain this privately.
> Performance is a valid setting.
> x86_energy_perf_policy tool has a "performance" string for this and I expect it is very used.
> I would switch to it if I am constantly connected to AC.
> man x86_energy_perf_policy
> also does not tell the user anything about "be careful with performance setting"
>
> And until today every CPU online/offline cycle or machine resume cycle switches
> the value back to performance (if kernel tried to switch to 6).
>
> ...
>
> > > There may be BIOSes initialzing it via BIOS options. And this is a very
> > > valid thing to do.
> >
> > Yes, and there may be BIOSes leaving it at 0 with the assumption that
> > the OS will adjust it.  The kernel cannot know which is the case.
>
> Correct. The kernel cannot know.
>
> You know this better than anyone else:
> - A specific Microsoft version is doing it wrong.
> - We adopt.
> - Microsoft is doing it correctly with the next version
> - We are busted
>
> I am ok with leaving the message as a hint, I would still check
> ACPI prefered profile variable that we are not running on a server.
> On these systems the message would be wrong rather sure and performance is intended.

So yes, ACPI profiles could be used in there as they also are used
elsewhere in a similar context.

>
> ...
>
> > > No. You must not ignore BIOS settings. Even worse, you must not override
> > > these without any sane reason.
> >
> > While there are BIOS settings that better should not be overridden,
> > the EPB is not one of them.
>
> Again: Why or where is this documented?

In the SDM if you will, under "Performance and Energy Bias Hint support":

"Software can use whatever criteria it sees fit to program the MSR
with an appropriate value."

If that doesn't mean "Yes, the OS can override the BIOS setting", then
I'm not sure what would.

> > > Your assumption above might be right. But we want to do it better, right?
> > >
> > > ...
> > >
> > > > The system-wide resume part will still not be working properly after
> > > > the reverts.
> > >
> > > But it must never blindly (unconditionally) be set to specific value.
> > > Correct?
> >
> > Yes.  I've already said that.
>
> How about below solution then for the initial boot up sequence?

The MSR would never be written to with that change, is that intentional?

> > > You mean the kernel should store the pre-hibernation perf BIAS value
> > > in NVRAM and write it back when waking up again?
> >
> > Or in the image and yes, it should write it back.
>
> Can you point me to a similar case where a variable is stored through
> hibernation?
> If it's not too much I can try to come up with an (compiled but untested) patch.
>
> > > This would make sense.
> > >
> > > It would also mean perf BIAS never really worked, at least did not survive
> > > suspend.
> >
> > Right.
> >
> > > On servers (no hibernation) it would works but is overridden
> > > to a value you typically do not want to have on a server...
> > > So the current situation is rather broken in the kernel.
> >
> > Well, you can say so, but fixing it really means something more than
> > reverting the commits that your patch is reverting and *that* is my
> > point.
> >
> > Yes, I think that this needs to be fixed.
> >
> > No, I don't think that the reverts you are proposing are the way to go here.
>
> Why?
> It is the first step to go.

Well, I'll just go and fix the real problems here I guess, that will
be way more productive than just talking about them ...

And then we can get back to the initial setting discussion.
