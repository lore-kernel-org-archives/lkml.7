Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B1C32793
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0AB20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 03:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN+KwSQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfJADjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 23:39:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51074 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfJADjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 23:39:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so1558310wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WaM61durTUCJ9gtJy39A13xkdum8vegyHiHhxWy1wpw=;
        b=fN+KwSQ+Gj8YtzgTeMTjKXgzvhO6+3j1XBLCHXwQNRn8nDl6XSI0dpvomx6JXkMRm/
         yh70SDobdSJpEXxViJhWwsb6Ppe9/FdPikTRFEAzdtQC+hvhkEBUqdhm/qZ32Y7oG3oa
         W9ZLTucqFcsWxRBQAQEOWmr2HpitVzb8QmwsoKY2gJRYdoO0WTj5hSHclA4IyeI2Dn1Y
         9ZmC9sWNitf4VPbhSS6J79/YPSsIm+wLFyrx9sxEeVTYdyLNXyEVfOwD1WZgSHIWjadn
         YPfntraaAashQqLbtM47hNuQGD5zW4f3HU4kAQvM5t0XYPDn8FswCrR7dD+GMeZ5/Bhv
         VpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WaM61durTUCJ9gtJy39A13xkdum8vegyHiHhxWy1wpw=;
        b=WVGEW89QKikzf/4t6hfzYUiDoFWXpHOVI9uO+4DWro6nHVH6i3XnGZXXXS2K6TcrAZ
         0BpMr8Hcjdr9VYkLLsNQKE6bdU45KzdvjL3CGLYPJZ4V2dRj5mCBZuD9oEiiFAc8rgV5
         2T4ZYoYxLMVeYDEnAiM7pzCizji5Wpo71FmPEXCkgx/Cf7BiV7kk3urO2rvZSUVvKgnB
         R2G0VGlCSBvpY8PL6iAaQXyE8Rgj4PahK6RdsX8UNUitz7GqVn90NSRP8LlMOLXG3z+L
         HmapJ1L4iGabxRjEMsIlb8Ibp32iqnjt2jI6NaPt8q/l5cyhuB44DfZRVFDL8l/YOb44
         jWjg==
X-Gm-Message-State: APjAAAUM2Mf7jSzvGYE2y6aqQzj2mh8l9S823U6hSTxWjlMSaPa8V6Ik
        HUfS4uSzsOCPFlPNvks81GLWHXj+DHOQgWzrObitgg==
X-Google-Smtp-Source: APXvYqwE6PScBlXhMbPdxsTSf6LsbJHqsVwiJa+e9xBd3bpqcXGscHlk0/zTftcSxUtn27TgULYLHYv2zi2tAxCYuv4=
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr1832686wmt.81.1569901142201;
 Mon, 30 Sep 2019 20:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
 <c0d9d434-1f47-66a0-1129-5003f2f2eb5c@infradead.org> <CAGRSmLv-9dtPWmANMD64E7Lv++L4_y5anJ2SPWsw9J1kiDuegw@mail.gmail.com>
In-Reply-To: <CAGRSmLv-9dtPWmANMD64E7Lv++L4_y5anJ2SPWsw9J1kiDuegw@mail.gmail.com>
From:   "David F." <df7729@gmail.com>
Date:   Mon, 30 Sep 2019 20:38:50 -0700
Message-ID: <CAGRSmLuChjV8nXuOvu54kY9ejSZT1akGo_axAzD2mn++zHJXWw@mail.gmail.com>
Subject: Re: What populates /proc/partitions ?
To:     Randy Dunlap <rdunlap@infradead.org>, masneyb@onstation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's not straightforward.  No direct calls, it must be somehow
when kmod is used to load the module.  The only difference I see in
the udevadm output is the old system has attribute differences
capability new==11, old==1, event_poll_msec new=2000, old=-1.  I
figured if i could set the "hidden" attribute to 1 then it looks like
/proc/partitions won't list it (already "removable"attribute), but
udev doesn't seem to allow changing the attributes, only referencing
them. unless I'm missing something?

On Mon, Sep 30, 2019 at 5:13 PM David F. <df7729@gmail.com> wrote:
>
> Thanks for the replies.   I'll see if I can figure this out.   I know
> with the same kernel and older udev version in use that it didn't add
> it, but with the new udev (eudev) it does (one big difference is the
> new one requires and uses devtmpfs and the old one didn't).
>
> I tried making the floppy a module but it still loads on vmware player
> and the physical test system I'm using that doesn't have one but
> reports it as existing (vmware doesn't hang, just adds fd0 read errors
> to log, but physical system does hang while fdisk -l, mdadm --scan
> runs, etc..).
>
> As far as the log, debugging udev output, it's close to the same, the
> message log (busybox) not much in there to say what's up.   I even
> tried the old .rules that were being used with the old udev version,
> but made no difference.
>
> On Mon, Sep 30, 2019 at 4:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 9/30/19 3:47 PM, David F. wrote:
> > > Hi,
> > >
> > > I want to find out why fd0 is being added to /proc/partitions and stop
> > > that for my build.  I've searched "/proc/partitions" and "partitions",
> > > not finding anything that matters.
> >
> > /proc/partitions is produced on demand by causing a read of it.
> > That is done by these functions (pointers) in block/genhd.c:
> >
> > static const struct seq_operations partitions_op = {
> >         .start  = show_partition_start,
> >         .next   = disk_seqf_next,
> >         .stop   = disk_seqf_stop,
> >         .show   = show_partition
> > };
> >
> > in particular, show_partition().  In turn, that function uses data that was
> > produced upon block device discovery, also in block/genhd.c.
> > See functions disk_get_part(), disk_part_iter_init(), disk_part_iter_next(),
> > disk_part_iter_exit(), __device_add_disk(), and get_gendisk().
> >
> > > If udev is doing it, what function is it call so I can search on that?
> >
> > I don't know about that.  I guess in the kernel it is about "uevents".
> > E.g., in block/genhd.c, there are some calls to kobject_uevent() or variants
> > of it.
> >
> > > TIA!!
> >
> > There should be something in your boot log about "fd" or "fd0" or floppy.
> > eh?
> >
> > --
> > ~Randy
