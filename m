Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00FC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695372075B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 19:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxAsnpKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfGFTJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 15:09:23 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53722 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfGFTJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 15:09:23 -0400
Received: by mail-wm1-f54.google.com with SMTP id x15so12089345wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56oSEf1QWNflez9DrQkV2EMn6gSxdG1QuQYkE8nqcsI=;
        b=qxAsnpKE8vKRlRIsHwFuYF0aeYKdxZunhe24J8fHm01P1aIrNrtsL1F3xGo5Ov0ltF
         Tl8jbaZvbLwmaD5Y8E/CGzPRn8/1QkjhDm0obOzaIcbiy+V0m9U8hfsu7u+ypKzmFwEk
         u+fPRB6ie1ij6u6zhjyglANy+Qmk8W25G/B9mQw9yJgkvOi/zXNANMDfr7qtM0GZQk11
         KWz2RzVS5pElEF2O7ZCZxsEulz7lbo+ax0c6G8fq4A0EsXRCpD8bRW9Kpv0RP5YoxtVX
         FVm+n7K0NKQnMyd4ReCJpMMsroAVs1ElwaNTfHcmhEV5QyNIbxpxpqhTtVvweXb1Y20H
         WjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56oSEf1QWNflez9DrQkV2EMn6gSxdG1QuQYkE8nqcsI=;
        b=nWB2DMSIoKuCQfMtGaS2+6X7O2S8gkqgiwIRY8CpLLYjhFC1DRpFWq9rKw4wECPLqj
         yTuUZQuAOQBbwUaH9XMjXafOGxDB4YS3Z74JfjDE0WTSJhTS/1H4az51uZxNCTjfpvTR
         4aijBXhSRmAiWik7T/qIsNRsnTazWZIZRt9N+xlhl3Y5kTCPQD4/1EY2hLtLjoMtYdpl
         t4Wzg9AXX1awaCYHRp9rUAcTrBRrP9+LAZDoJqV3r1zZw0Qn2rdl4H3Mcg1DkJgLS20z
         mq/jbPjLus8moMxw7cWzKkwnR4H64bTWccq/errZtf/+ZGZg1FQ/yizOH1i8IGi5GGjh
         3olA==
X-Gm-Message-State: APjAAAVdCilbijQpKZhY/QrQz1L6T9Mz4KvbbQ0DNtkRi+chsTSj/MQM
        5SFwb4U3orLb71k+oxSigHE=
X-Google-Smtp-Source: APXvYqylQU3EYMEgK+2bMp4vAZyYHpHm9d8euLRfo0WZfiOxmUiP4UQFnzsb6OO7atSx85Q2SUzQiw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr8672908wmb.39.1562440160482;
        Sat, 06 Jul 2019 12:09:20 -0700 (PDT)
Received: from narunkot ([176.24.221.95])
        by smtp.gmail.com with ESMTPSA id u1sm11061348wml.14.2019.07.06.12.09.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 12:09:19 -0700 (PDT)
Date:   Sat, 6 Jul 2019 20:08:57 +0100
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        Simon Dickson <simonhdickson@gmail.com>
Subject: Re: Staging status of speakup
Message-ID: <20190706200857.22918345@narunkot>
In-Reply-To: <20190316031831.GA2499@kroah.com>
References: <20190315130035.6a8f16e9@narunkot>
        <20190316031831.GA2499@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 20:18:31 -0700
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 15, 2019 at 01:01:27PM +0000, Okash Khawaja wrote:
> > Hi,
> > 
> > We have made progress on the items in TODO file of speakup driver in
> > staging directory and wanted to get some clarity on the remaining
> > items. Below is a summary of status of each item along with the
> > quotes from TODO file.
> > 
> > 1. "The first issue has to do with the way speakup communicates
> > with serial ports.  Currently, we communicate directly with the
> > hardware ports. This however conflicts with the standard serial
> > port drivers, which poses various problems. This is also not
> > working for modern hardware such as PCI-based serial ports.  Also,
> > there is not a way we can communicate with USB devices.  The
> > current serial port handling code is in serialio.c in this
> > directory."
> > 
> > Drivers for all external synths now use TTY to communcate with the
> > devices. Only ones still using direct communication with hardware
> > ports are internal synths: acntpc, decpc, dtlk and keypc. These are
> > typically ISA cards and generally hardware which is difficult to
> > make work. We can leave these in staging.  
> 
> Ok, that's fine.
> 
> > 2. "Some places are currently using in_atomic() because speakup
> > functions are called in various contexts, and a couple of things
> > can't happen in these cases. Pushing work to some worker thread
> > would probably help, as was already done for the serial port
> > driving part."
> > 
> > There aren't any uses of in_atomic anymore. Commit d7500135802c
> > "Staging: speakup: Move pasting into a work item" was the last one
> > that removed such uses.  
> 
> Great, let's remove that todo item then.
> 
> > 3. "There is a duplication of the selection functions in
> > selections.c. These functions should get exported from
> > drivers/char/selection.c (clear_selection notably) and used from
> > there instead."
> > 
> > This is yet to be done. I guess drivers/char/selection.c is now
> > under drivers/tty/vt/selection.c.  
> 
> Yes, someone should update the todo item :)
> 
> > 4. "The kobjects may have to move to a more proper place in /sys.The
> > discussion on lkml resulted to putting speech synthesizers in the
> > "speech" class, and the speakup screen reader itself
> > into /sys/class/vtconsole/vtcon0/speakup, the nasty path being
> > handled by userland tools."
> > 
> > Although this makes logical sense, the change will mean changing
> > interface with userspace and hence the user space tools. I tried to
> > search the lkml discussion but couldn't find it. It will be good to
> > know your thoughts on this.  
> 
> I don't remember, sorry.  I can review the kobject/sysfs usage if you
> think it is "good enough" now and see if I find anything
> objectionable.
> 
> > Finally there is an issue where text in output buffer sometimes gets
> > garbled on SMP systems, but we can continue working on it after the
> > driver is moved out of staging, if that's okay. Basically we need a
> > reproducer of this issue.
> > 
> > In addition to above, there are likely code style issues which will
> > need to be fixed.
> > 
> > We are very keen to get speakup out of staging both, for settling
> > the driver but also for getting included in distros which build
> > only the mainline drivers.  
> 
> That's great, I am glad to see this happen.  How about work on the
> selection thing and then I can review the kobject stuff in a few
> weeks, and then we can start moving things for 5.2?

Hi Greg,

Apologies for the delay. I de-duplicated selection code in speakup to
use code that's already in kernel (commit ids 496124e5e16e and
41f13084506a). Following items are what remain now:

1. moving kobjects location
2. fixing garbled text

I couldn't replicate garbled text but Simon (also in CC list) is
looking into it.

Can you please advise on the way forward?

Thanks,
Okash
