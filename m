Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D2C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B922086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S04hC3KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfJAANh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:13:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40675 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfJAANg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:13:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so1210087wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wwTw3vVfH8I3EdzLkli6/NyxE/mGvGVdUXswQ4O7G4=;
        b=S04hC3KEuIop9xDfT2QMFAt5HgTU5MVm8NayvPQvE3Vp/UNWc9zpWGKMux7nYoqTvL
         zhCj+2hjYqK4kv6CmffBsMGSfegqRVgZZ+3DsHEqcowQSfKV61WfP3PDqkSB7NMpIZDG
         1+mcUjwDIQPNRF50vQAucG0pbmAap5BRNda4VKrql+71aoZ98Dt7M11cI49xQhgCT+hc
         lrfasIyDwsqeebh0n/OD6Pc1jH9rz+zbL5/TwbqdOj2UQ0sfQH8h5jtiUSgZsVGvKkU6
         ZP8HD+uCKIRtsSHiRzN/tcinu8pmoq9w3OLNvp2S1mOHMhYrNIIgeQBZuVxZ20UTUvkf
         knuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wwTw3vVfH8I3EdzLkli6/NyxE/mGvGVdUXswQ4O7G4=;
        b=SiS3ZndwZ3qUOHbLF9dxhr3J2FvWMR7TwpY5KutFFRfmy1rZzF5jlfj4RigM0Cu3Ar
         2M1DKtp+h2ZSV3P+NlLZ1yyVNRsct+ufg8KV05XPVHxuUf7CJZ+kvY/pX9s9Qwn2nTSZ
         wWd5AJSfxPNQvFIM7E7ACbbqs8FGgYqo9xuRYDBkW7xvzxHoZOLITTU5jwltRGg+hdPZ
         09+eWm1xgqxqwQMB0Cwrgl4U0mhK878ZUr+g6SnKp5yB9zHgFkTEQUIWBnY3yHoxpsZJ
         eCTql0YufHJ0a5+thZAIJJm3Amq45tdGE6Y3PVKaA5tGSX37Xb1OV5HOS7zCdOiWBjJP
         AQBQ==
X-Gm-Message-State: APjAAAVKJW9UGtFeJlCSpqcZLJxsfiq059K8+UjPt3TKxbG6Kv6b/7xQ
        981CL5zFyiDrmr5AtaJhaoFF251R6OeKWf7IcXZVyA==
X-Google-Smtp-Source: APXvYqwVhs/hhLdXs+8CRIBVPaEg2ilc/2Kco/5xb7YmWHiV0B2fVua2NpvBkfnqmDnJZXid0hecuae4b00DTYYx0Es=
X-Received: by 2002:a7b:c403:: with SMTP id k3mr1288500wmi.89.1569888814438;
 Mon, 30 Sep 2019 17:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
 <c0d9d434-1f47-66a0-1129-5003f2f2eb5c@infradead.org>
In-Reply-To: <c0d9d434-1f47-66a0-1129-5003f2f2eb5c@infradead.org>
From:   "David F." <df7729@gmail.com>
Date:   Mon, 30 Sep 2019 17:13:23 -0700
Message-ID: <CAGRSmLv-9dtPWmANMD64E7Lv++L4_y5anJ2SPWsw9J1kiDuegw@mail.gmail.com>
Subject: Re: What populates /proc/partitions ?
To:     Randy Dunlap <rdunlap@infradead.org>, masneyb@onstation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the replies.   I'll see if I can figure this out.   I know
with the same kernel and older udev version in use that it didn't add
it, but with the new udev (eudev) it does (one big difference is the
new one requires and uses devtmpfs and the old one didn't).

I tried making the floppy a module but it still loads on vmware player
and the physical test system I'm using that doesn't have one but
reports it as existing (vmware doesn't hang, just adds fd0 read errors
to log, but physical system does hang while fdisk -l, mdadm --scan
runs, etc..).

As far as the log, debugging udev output, it's close to the same, the
message log (busybox) not much in there to say what's up.   I even
tried the old .rules that were being used with the old udev version,
but made no difference.

On Mon, Sep 30, 2019 at 4:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/30/19 3:47 PM, David F. wrote:
> > Hi,
> >
> > I want to find out why fd0 is being added to /proc/partitions and stop
> > that for my build.  I've searched "/proc/partitions" and "partitions",
> > not finding anything that matters.
>
> /proc/partitions is produced on demand by causing a read of it.
> That is done by these functions (pointers) in block/genhd.c:
>
> static const struct seq_operations partitions_op = {
>         .start  = show_partition_start,
>         .next   = disk_seqf_next,
>         .stop   = disk_seqf_stop,
>         .show   = show_partition
> };
>
> in particular, show_partition().  In turn, that function uses data that was
> produced upon block device discovery, also in block/genhd.c.
> See functions disk_get_part(), disk_part_iter_init(), disk_part_iter_next(),
> disk_part_iter_exit(), __device_add_disk(), and get_gendisk().
>
> > If udev is doing it, what function is it call so I can search on that?
>
> I don't know about that.  I guess in the kernel it is about "uevents".
> E.g., in block/genhd.c, there are some calls to kobject_uevent() or variants
> of it.
>
> > TIA!!
>
> There should be something in your boot log about "fd" or "fd0" or floppy.
> eh?
>
> --
> ~Randy
