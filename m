Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111FBC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C177D2332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceZEG8+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfHTWKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:10:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35004 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTWKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:10:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id g17so201523otl.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhPvtlC17u44ufmkUxOTA4i7NI0WexPiKwUB/fujZ0c=;
        b=ceZEG8+XIftpTwQRtvjUwrogG2VUTQXOzeaZt7AihCTnOQXaSJdwj5EOaUCXRzz4Sm
         ux2jGvCpVkPXrAzgJq4hXsuPLx4oQrD1Zm52YDaH5anfmtOUsMINt6JxrI9mzyY37hzc
         9BkjYAbi97w0xvwYfqmkUzzYdCnNZ8squFoYb/FUns5faQRKkrhSxmoh0FS+Wl5oQ8No
         wnaYy1A1UcjVd/ZTO0KPjBSdMuxBNtmt6Q/1WrVFApt2Bybq4pCNfJQlqC9nvhgPGg5m
         3E4JDWmNN5a1iqQnKmtZOyzZYuAJR4Lg+Z1VehcXcEHQc2g18wC/VLDwXgsXPcFh3TdF
         IgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhPvtlC17u44ufmkUxOTA4i7NI0WexPiKwUB/fujZ0c=;
        b=bIiS1qCXcupynH+yeaywvxPJs0/CH5lG7cHXrOtWbXKBwqPMtDFnEHAHelgVqXJX+/
         l3OzqZRKMm5C0qVFKJDps4xnJHk8jmJvoOvAIdtaCkzNZjxN9CoaAavSPMBMoYTzZzth
         6tkzRqVqm+9w/N2K8M2CJdqJhoaAncZGwF2OdghdFEl33h9WCfbhxxbkU7qnlgwIR45v
         WKKfXqZGyQxuji6tQzH1Fy4+7F1jJe1dXRHXU6depFsbiRjXv52UpyjtQ9W/Rod9N5n5
         8WbaE0cWmx44tHCdiWFMldrSuxpAhgnTwleOK4LwxgsEq0pGU/5/EBE9NgR6dv3qT5Dy
         7IjQ==
X-Gm-Message-State: APjAAAX0IW/E0FpYuQci7awOzcXqbjodUE9yOCyCGAJFosTDrLA4o9S/
        235p2CH2eXKzMAqObNtjDNePCmOQya4TeyU+T4+Pjg==
X-Google-Smtp-Source: APXvYqzwRi7EhxrfrGazsfQHIS+TEXp7A+J1AGcntOEjY/jJkakPZnqU53EYWe/f0W45hDHyufhDbj2shmZWeY0GIic=
X-Received: by 2002:a05:6830:54:: with SMTP id d20mr21760645otp.225.1566339029143;
 Tue, 20 Aug 2019 15:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com> <20190724001100.133423-4-saravanak@google.com>
 <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com> <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
 <19c99a6e-51c3-68d7-d1d6-640aae754c14@gmail.com> <CAGETcx-XcXZq7YFHsFdzBDniQku9cxFUJL_vBoEKKhCH+cDKRw@mail.gmail.com>
 <74931824-f8a1-0435-e00a-5b5cdbe8a8a2@gmail.com> <CAGETcx8UHA9kNkjjnBXcf_OYXaaPO9ky60M01Cfz3NFb1c1FZw@mail.gmail.com>
 <15ab4fb0-7e69-9cc1-4a79-cff06767f7d9@gmail.com>
In-Reply-To: <15ab4fb0-7e69-9cc1-4a79-cff06767f7d9@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 20 Aug 2019 15:09:52 -0700
Message-ID: <CAGETcx-F7VoQsDihvJ1FY=Pw8Rhu69zh6pBzkV4nSabwYRvbZw@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 9:26 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 8/19/19 5:09 PM, Saravana Kannan wrote:
> > On Mon, Aug 19, 2019 at 2:30 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 8/19/19 1:49 PM, Saravana Kannan wrote:
> >>> On Mon, Aug 19, 2019 at 10:16 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
> >>>>> On Wed, Aug 7, 2019 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>>>
> >>>>>> On 7/23/19 5:10 PM, Saravana Kannan wrote:
> >>>>>>> Add device-links after the devices are created (but before they are
> >>>>>>> probed) by looking at common DT bindings like clocks and
> >>>>>>> interconnects.
> >>>>
> >>>>
> >>>> < very big snip (lots of comments that deserve answers) >
> >>>>
> >>>>
> >>>>>>
> >>>>>> /**
> >>>>>>  * of_link_property - TODO:
> >>>>>>  * dev:
> >>>>>>  * con_np:
> >>>>>>  * prop:
> >>>>>>  *
> >>>>>>  * TODO...
> >>>>>>  *
> >>>>>>  * Any failed attempt to create a link will NOT result in an immediate return.
> >>>>>>  * of_link_property() must create all possible links even when one of more
> >>>>>>  * attempts to create a link fail.
> >>>>>>
> >>>>>> Why?  isn't one failure enough to prevent probing this device?
> >>>>>> Continuing to scan just results in extra work... which will be
> >>>>>> repeated every time device_link_check_waiting_consumers() is called
> >>>>>
> >>>>> Context:
> >>>>> As I said in the cover letter, avoiding unnecessary probes is just one
> >>>>> of the reasons for this patch. The other (arguably more important)
> >>>>
> >>>> Agree that it is more important.
> >>>>
> >>>>
> >>>>> reason for this patch is to make sure suppliers know that they have
> >>>>> consumers that are yet to be probed. That way, suppliers can leave
> >>>>> their resource on AND in the right state if they were left on by the
> >>>>> bootloader. For example, if a clock was left on and at 200 MHz, the
> >>>>> clock provider needs to keep that clock ON and at 200 MHz till all the
> >>>>> consumers are probed.
> >>>>>
> >>>>> Answer: Let's say a consumer device Z has suppliers A, B and C. If the
> >>>>> linking fails at A and you return immediately, then B and C could
> >>>>> probe and then figure that they have no more consumers (they don't see
> >>>>> a link to Z) and turn off their resources. And Z could fail
> >>>>> catastrophically.
> >>>>
> >>>> Then I think that this approach is fatally flawed in the current implementation.
> >>>
> >>> I'm waiting to hear how it is fatally flawed. But maybe this is just a
> >>> misunderstanding of the problem?
> >>
> >> Fatally flawed because it does not handle modules that add a consumer
> >> device when the module is loaded.
> >
> > If you are talking about modules adding child devices of the device
> > they are managing, then that's handled correctly later in the series.
>
> They may or they may not.  I do not know.  I am not going to audit all
> current cases of devices being added to check that relationship and I am
> not going to monitor all future patches that add devices.  Adding devices
> is an existing pattern of behavior that the new feature must be able to
> handle.
>
> I have not looked at patch 6 yet (the place where modules adding child
> devices is handled).  I am guessing that patch 6 could be made more
> general to remove the parent child relationship restriction.

Please do look into it then. I think it already handles all cases.

> >
> > If you are talking about modules adding devices that aren't defined in
> > DT, then right, I'm not trying to handle that. The module needs to
> > make sure it keeps the resources needed for new devices it's adding
> > are in the right state or need to add the right device links.
>
> I am not talking about devices that are not defined in the devicetree.

In that case, I'm sure my patch series handle all the scenarios
correctly. Here's why:
1. For all the top level devices the patches you've reviewed already
show how it's handled correctly.
2. All other devices in the DT are by definition the child devices of
the top level devices and patch 6 handles those cases.

Hopefully this shows to you that all DT cases are handled correctly.

> >>> In the text below, I'm not sure if you mixing up two different things
> >>> or just that your wording it a bit ambiguous. So pardon my nitpick to
> >>> err on the side of clarity.
> >>
> >> Please do nitpick.  Clarity is good.
> >>
> >>
> >>>
> >>>> A device can be added by a module that is loaded.
> >>>
> >>> No, in the example I gave, of_platform_default_populate_init() would
> >>> add all 3 of those devices during arch_initcall_sync().
> >>
> >> The example you gave does not cover all use cases.
> >>
> >> There are modules that add devices when the module is loaded.  You can not
> >> ignore systems using such modules.
> >
> > I'll have to agree to disagree on that. While I understand that the
> > design should be good and I'm happy to work on that, you can't insist
> > that a patch series shouldn't be allowed because it's only improving
> > 99% of the cases and leaves the other 1% in the status quo. You are
> > just going to bring the kernel development to a grinding halt.
>
> No, you do not get to disagree on that.  And you are presenting a straw
> man argument.
>
> You are proposing a new feature that contributes fragility and complexity
> to the house of cards that device instantiation and driver probing already
> is.

Any piece of code is going to "add complexity". It's a question of
benefits vs complexity. Also, I'm mostly reusing existing device links
API. The majority of the complexity is in parsing DT. The driver core
maintainers seem to be fine with adding sync_state() support for
device links (that is independent of DT).

> The feature is clever but it is intertwined into an area that is already
> complex and in many cases difficult to work within.
>
> I had hoped that the feature was robust enough and generic enough to
> accept.

What I'm doing IS the most generic solution instead of doing the same
work multiple times at a framework level. Also, for multi-function
devices, framework level solutions would be worse.

> The proposed feature is a hack to paper over a specific problem
> that you are facing.  I had hoped that the feature would appear generic
> enough that I would not have to regard it as an attempt to paper over
> the real problem.  I have not given up this hope yet but I still am
> quite cautious about this approach to addressing your use case.
>
> You have a real bug.  I have told you how to fix the real bug.  And you
> have ignored my suggestion.  (To be honest, I do not know for sure that
> my suggestion is feasible, but on the surface it appears to be.)

I'd actually say that your proposal is what's trying to paper over a
generic problem by saying it's specific to one or a few set of
resources. And it looks feasible to you because you haven't dove deep
into this issue.

> Again,
> my suggestion is to have the boot loader pass information to the kernel
> (via a chosen property) telling the kernel which devices the bootloader
> has enabled power to.  The power subsystem would use that information
> early in boot to do a "get" on the power supplier (I am not using precise
> power subsystem terminology, but it should be obvious what I mean).
> The consumer device driver would also have to be aware of the information
> passed via the chosen property because the power subsystem has done the
> "get" on the consumer devices behalf (exactly how the consumer gets
> that information is an implementation detail).  This approach is
> more direct, less subtle, less fragile.

I'll have to disagree on your claim. You are adding unnecessary
bootloader dependency when the kernel is completely capable of
handling this on its own. You are requiring explicit "gets" by
suppliers and then hoping all the consumers do the corresponding
"puts" to balance it out. Somehow the consumers need to know which
suppliers have parsed which bootloader input. And it's barely
scratching the surface of the problem.

You are assuming this has to do with just power when it can be clocks,
interconnects, etc. Why solve this repeated for each framework when
you can have a generic solution?

Also, while I understand what you mean by "get" it's not going to be
as simple as a reference count to keep the resource on. In reality
you'll need more complex handling. For example, having to keep a
voltage rail at or above X mV because one consumer might fail if the
voltage is < X mV. Or making sure a clock never goes about the
bootloader set frequency before all the consumer drivers are probed to
avoid overclocking one of the consumers. Trying to have this
explicitly coordinated across multiple drivers would be a nightmare.
It gets even more complicated with interconnects.

With my patch series, the consumers don't need to do anything. They
just probe as usual. The suppliers don't need to track or coordinate
with any consumers. For example, regulator suppliers just need to keep
the voltage rail at (or above) the level that the boot loader left it
on at and then apply the aggregated requests from their APIs once they
get the sync_state() callback. And it actually works -- tested for
regulators and clocks (and maybe even interconnects -- I forgot) in a
device I have.

> >>>
> >>>>  In that case the device
> >>>> was not present at late boot when the suppliers may turn off their resources.
> >>>
> >>> In that case, the _drivers_ for those devices aren't present at late
> >>> boot. So that they can't request to keep the resources on for their
> >>> consumer devices. Since there are no consumer requests on resources,
> >>> the suppliers turn off their resources at late boot (since there isn't
> >>> a better location as of today). The sync_state() call back added in a
> >>> subsequent patche in this series will provide the better location.
> >>
> >> And the sync_state() call back will not deal with modules that add consumer
> >> devices when the module is loaded, correct?
> >
> > Depends. If it's just more devices from DT, then it'll be fine. If
> > it's not, then the module needs to take care of the needs of devices
> > it's adding.>
> >>>
> >>>> (I am assuming the details since I have not reviewed the patches later in
> >>>> the series that implement this part.)
> >>>>
> >>>> Am I missing something?
> >>>
> >>> I think you are mixing up devices getting added/populated with drivers
> >>> getting loaded as modules?
> >>
> >> Only some modules add devices when they are loaded.  But these modules do
> >> exist.
> >
> > Out of the billions of Android devices, how many do you see this happening in?
>
> The Linux kernel is not just used by Android devices.

Ofcourse Linux is used by more than just Android. And Android is just
an ARM64(32) distribution. But how many platforms do you have where a
module adds devices that are not part of DT (because I'm handling the
DT part fine -- see other emails)? How does that count compare to
millions of products that can use this feature? And I'm not breaking
any of the existing platforms that don't use DT either. So saying I
have to fix this for 100% of the use cases for Linux before I can
remove the roadblocks for a common ARM64 kernel that can run on any
ARM64 platform seems like an unreasonable position.

-Saravana
