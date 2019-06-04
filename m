Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C4B24CF2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfFDHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:51:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35019 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfFDHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:51:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so12687092qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqIlI5O8hd56oi1jVcbN1ep6F55Q4saz/S25/rjw/n4=;
        b=QC38mbis7nODVf0Mb5sKf2VhmziWy8Vv/mzpBAncmstV0gEFhkLTh+3KcIeFqSa9dD
         MqsOWoHlMt80LKIxnwGlxibfUwsc6OOVN5urRMmh3UxBUtoKGhy0lGbfGtYRfTuGqj/X
         sFf3CZYQrDtaWEtd/WdZKmp+vJHPuA4zmIKikiqEmayXXsdlzVf+K4uiRzVz5WKhKVfg
         vewbHV+UX7NHwwPkP8cMWwqrG5GlGOchYLJLDL98tKgrfOWLYwiTLeBVogpJew84IJYD
         P2Nwq/gQ8jiql8PqYYRxVjnWsYfkQPuSKPV5GZ6LGzhM1jIMWzIXzP92An4po0M7PCHy
         a7og==
X-Gm-Message-State: APjAAAXm8HEfvBOnLnUTBlJILWl6vP1jtuSnKHE0IxQBRQtZOImZjZQ1
        BLuc1b0W7wq06CyNQzukEW3bb4vywcMN8/lPUYnqwg==
X-Google-Smtp-Source: APXvYqw/MwvBnXAraK0ip2eY92tgob99ALlGPmPR9g21Z+XBlVdHAWOrXBCIJnsOHaCAd7fu1hYtryzeTaWXC2Rh6sg=
X-Received: by 2002:a0c:fde5:: with SMTP id m5mr6700361qvu.192.1559634676267;
 Tue, 04 Jun 2019 00:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
 <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com> <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com>
In-Reply-To: <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 4 Jun 2019 09:51:03 +0200
Message-ID: <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com>
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 4:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-06-19 15:55, Benjamin Tissoires wrote:
> > On Mon, Jun 3, 2019 at 11:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Again,
> >>
> >> On 03-06-19 11:11, Hans de Goede wrote:
> >> <snip>
> >>
> >>>> not sure about the rest of logitech issues yet) next week.
> >>>
> >>> The main problem seems to be the request_module patches. Although I also
> >
> > Can't we use request_module_nowait() instead, and set a reasonable
> > timeout that we detect only once to check if userspace is compatible:
> >
> > In pseudo-code:
> > if (!request_module_checked) {
> >    request_module_nowait(name);
> >    use_request_module = wait_event_timeout(wq,
> >          first_module_loaded, 10 seconds in jiffies);
> >    request_module_checked = true;
> > } else if (use_request_module) {
> >    request_module(name);
> > }
>
> Well looking at the just attached dmesg , the modprobe
> when triggered by udev from userspace succeeds in about
> 0.5 seconds, so it seems that the modprobe hangs happens
> when called from within the kernel rather then from within
> userspace.
>
> What I do not know if is the hang is inside userspace, or
> maybe it happens when modprobe calls back into the kernel,
> if the hang happens when modprobe calls back into the kernel,
> then other modprobes (done from udev) likely will hang too
> since I think only 1 modprobe can happen at a time.
>
> I really wish we knew what distinguished working systems
> from non working systems :|
>
> I cannot find a common denominator; other then the systems
> are not running Fedora. So far we've reports from both Ubuntu 16.04
> and Tumbleweed, so software version wise these 2 are wide apart.

I am trying to reproduce the lock locally, and installed an opensuse
Tumbleweed in a VM. When forwarding a Unifying receiver to the VM, I
do not see the lock with either my vanilla compiled kernel and the rpm
found in http://download.opensuse.org/repositories/Kernel:/HEAD/standard/x86_64/

Next step is install Tumbleweed on bare metal, but I do not see how
this could introduce a difference (maybe USB2 vs 3).

>
> >>> have 2 reports of problems with hid-logitech-dj driving the 0xc52f product-id,
> >>> so we may need to drop that product-id from hid-logitech-dj, I'm working on
> >>> that one...
> >>
> >> Besides the modprobe hanging issue, the only other issues all
> >> (2 reporters) seem to be with 0xc52f receivers. We have a bug
> >> open for this:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203619
> >>
> >> And I've asked the reporter of the second bug to add his logs
> >> to that bug.
> >
> > We should likely just remove c52f from the list of supported devices.
> > C52f receivers seem to have a different firmware as they are meant to
> > work with different devices than C534. So I guess it is safer to not
> > handle those right now and get the code in when it is ready.
>
> Ack. Can you prepare a patch to drop the c52f id?

Yes. I have an other revert never submitted that I need to push, so I
guess I can do a revert session today.

I think I'll also buy one device with hopefully the C52F receiver as
the report descriptors attached in
https://bugzilla.kernel.org/show_bug.cgi?id=203619 seems different to
what I would have expected.

Cheers,
Benjamin
