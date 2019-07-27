Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5112C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A392085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LXeFyCNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfG0RhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:37:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39971 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfG0RhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:37:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so21168274oie.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0VcUvigVHWGBC8li8r0Gqa12uFZQAgt8PU9s9KJNdc=;
        b=LXeFyCNucSi/3hlEQmsO8pgXTKJEehdGTDO2HP62g1xnKMPFsJpKbQriXEyIt6tdi/
         Mfbh/6W3uNzXDwb7scHYKkqCVB5H/PJXQMFbtvjTDIuFrWmsRDkdaQGStv4g6Vv9EFfG
         Zy7TRUUXOqPrGOzBVdFAp9dsH/qkXJ77dr9+ry9qQ8vVymwgrGIgWg+32/tJC2NfRiw4
         tSIHSsG1KqVci4cTK8gWpseFKbNfG2T0tr2u3skn6guKv37sXtso8Ruo6xHHEGP/sXjf
         mFGrm1OELKEPJ5OxwABazHH6gIOe2riDehBf7dElcXAWDP9Le2iROCyzuZtEuE5XEp4g
         jKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0VcUvigVHWGBC8li8r0Gqa12uFZQAgt8PU9s9KJNdc=;
        b=dfpKnTdB1VrCRHXupf2n/AA2uz94uY0nUAdqkf2Pi7497hgRAbnQZlPk8gCBl42XlC
         7lLZpsXJivzCaTuljGPX7y1MOU8R3cILSNlHLDudoaAef9kF/O4FSa77dZyo7n+BHJLP
         N3pnR5zb2W0y4yDoAYqeTa77Nm26bG7KiEoxi3Ebj2Mx61okAaYa4QAcyOIyr5+Is/JI
         Vm88PudKOzq52/UlhSA1DZFZsj9bOY+xjIQe7nCCep7obPlXGs2kdI5pqxJD/JeRoLS7
         zeo0vyD6yjAVOtos53k1/+RvrKSBrQZf5QaUIILhqzq8gcr/9Xjc7SqBoGiVXbC01FsN
         HWhA==
X-Gm-Message-State: APjAAAUYUn6DnVTPQf3/aLHodLdQzouabUTfxxtM1PVVFM8ac7j/BmO2
        /GooAfi5Wo93s4KTaldjn5Rtwrgt2FlTPdzsKt8=
X-Google-Smtp-Source: APXvYqyNv7y/6X5zyIAn36VOoLWNDm86uV9fDmdmYUdjNzjtOTCzl/wZuq/8yw7vkhA84DzOKgfS6F5ol7vhovv0Ogs=
X-Received: by 2002:aca:af55:: with SMTP id y82mr47866890oie.172.1564249038760;
 Sat, 27 Jul 2019 10:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190727011040.89582-1-swboyd@chromium.org> <CAJZ5v0hroRuGQ5N42Z8=yFVXiJPdid3wJrHoKqr2BZVx=sfnBQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hroRuGQ5N42Z8=yFVXiJPdid3wJrHoKqr2BZVx=sfnBQ@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Sat, 27 Jul 2019 10:37:07 -0700
Message-ID: <CANA+-vDNkSG39SLd0_B_L8gkDkfQ2uJLcuvCaRgHkU8DiBzMTw@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Avoid dev_name collisions in wakeup class
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 6:10 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jul 27, 2019 at 3:11 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > If a device is wakeup capable and the driver calls device_wakeup_init()
> > on it during probe and then userspace writes 'enabled' to that device's
> > power/wakeup file in sysfs we'll try to create the same named wakeup
> > device in sysfs. The kernel will complain about duplicate file names.

Thanks for reporting the issue, Stephen!
> >
> > sysfs: cannot create duplicate filename '/devices/virtual/wakeup/1-1.1'
> > kobject_add_internal failed for 1-1.1 with -EEXIST, don't try to register things with the same name in the same directory.
> >
> > It may be advantageous to not write 'enabled' to the wakeup file (see
> > wakeup_store()) from userspace for these devices because we allocate
> > devices and register them and then throw them all away later on if the
> > device driver has already initialized the wakeup attribute. The
> > implementation currently tries to avoid taking locks here so it seems
> > best to optimize that path in a separate patch.
> >
> > Let's rename the wakeup class devices as 'wakeupN' with an IDA that's
> > simple enough to just return some sort of number. In addition, let's
> > make the device registering the wakeup the parent and include a 'name'
> > attribute in case userspace wants to figure out the type of wakeup it is
> > (in the case of virtual wakeups) or the device associated with the
> > wakeup. This makes it easier for userspace to go from /sys/class/wakeup
> > to a place in the device hierarchy where the wakeup is generated from
> > like an input device.
> >
> > Cc: Tri Vo <trong@android.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> I'd rather change the commit that introduced this issue which is only
> in linux-next for now.

Raphael, could you roll back my patch? I'll work with Stephen to fix it.
