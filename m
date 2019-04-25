Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAFAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53557217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfDYFQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:16:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60372 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfDYFQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:16:35 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hJWkL-0005Fg-NE
        for linux-kernel@vger.kernel.org; Thu, 25 Apr 2019 05:16:33 +0000
Received: by mail-pg1-f198.google.com with SMTP id e12so13624625pgh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1KXHauvhLR2XJXnUSb0nmr8aDrvOQhGb1tQ04wF2KCE=;
        b=AmWc/ujU57Vhgx6XKT1rfNDOEnQ61V3lXYHz7176Gn0XC2pDmmk4CP3lWhkAmpAhpf
         PEUdOOiQ9D07RxBSdO8T+ItcdDm0getRjsUv0+AFz89hGvfY4QMU2h1DO/qQHF4pRJ7r
         qzbCf0JnL0a2muLcS6N/pE4V9ZZEsNdUIxrhmx1oDqK3tCjbtUolKc6Yu4tZ+ccpeKxz
         VMIdPUbTNk/oDzW+3Ts/iu/C6yaxO03T3nqDunSvOyrqQJZxkAtgZp4BWmNHjoHjw+Kb
         lR2oAL+geSTmd3Z+2KH222WMmkTFSio9xroFj2W3gHWQVtiSbEJNQCJnxSaAZlCqP0Tb
         YXew==
X-Gm-Message-State: APjAAAVRI19hC2EEu/Gzw3Zm2CraaaSABpzWO7f+DBDUkoHmSS8RIDwd
        8h5xaZW77aMCEBg1ThKrqaKYZXnmS+Xnx3d588L1+gGnd7uTOcwfd0mqwivdgY4Uz8iQzxTGNGY
        Y2XzkheSuhcFB9m2KNNHofdS4gFWArpKj64KPCaLwTw==
X-Received: by 2002:a62:1c87:: with SMTP id c129mr13133371pfc.113.1556169392272;
        Wed, 24 Apr 2019 22:16:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEhloLsHibTeQEQt0D12RYIFb7XMAFJ7ADwhLP/wouz2mG08C/i3MMT3ng4LDCKqAxdiX7IQ==
X-Received: by 2002:a62:1c87:: with SMTP id c129mr13133314pfc.113.1556169391529;
        Wed, 24 Apr 2019 22:16:31 -0700 (PDT)
Received: from [10.101.46.46] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id p3sm5369124pff.63.2019.04.24.22.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 22:16:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Ld9SLAo--3-1@tutanota.com>
Date:   Thu, 25 Apr 2019 13:16:25 +0800
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hdegoede <hdegoede@redhat.com>,
        Linux Gpio <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <14E5638C-0C4C-4406-BF91-8DF48377F3DB@canonical.com>
References: <20190422044539.16085-1-kai.heng.feng@canonical.com>
 <Ld5HCy5--3-1@tutanota.com>
 <EA207DE8-E89A-427B-B910-A36170A76031@canonical.com>
 <Ld8QGex--3-1@tutanota.com> <20190423090816.GN2654@lahna.fi.intel.com>
 <Ld8ZLG1--3-1@tutanota.com>
 <3BE5F007-CD9C-486A-90EE-326AAB807D5B@canonical.com>
 <Ld9SLAo--3-1@tutanota.com>
To:     hotwater438@tutanota.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 9:49 PM, <hotwater438@tutanota.com> <hotwater438@tutanota.com> wrote:

> Hi. I did the suggested echo and, if I clearly understood, switched to  
> s2idle mode without deep-mode.
> For tests I use 4.19.28 on Debian-like system (Parrot OS).
>
> If the system defaults to use S2I, then it’s better to stick with it.
>
> Lots of ODM/OEM don’t really test S3.
> So S3 is the same as S2 but with deep mode enabled?
> The default switches to s2idle based on FADT flag and _DSM on relative  
> new kernels.
> Are those some SSDT flags?
> It actually sounds weird to me, why restarting touchpad after deep  
> suspend affects it work. I mean, if it starts sucessfully at boot, why it  
> doesn't after suspend? Can we debug it somehow?

Can you see if i2c_hid_hwreset() helps? Refer to [1] as an example.

Anyway, the resume issue is a different bug. If possible please merge this  
patch.

[1] https://lore.kernel.org/lkml/20190211070040.4569-1-jbroadus@gmail.com/

Kai-Heng

>
> Regards,
> Vladislav.
> Apr 23, 2019, 12:47 PM by kai.heng.feng@canonical.com:
> at 17:40, <hotwater438@tutanota.com> <hotwater438@tutanota.com> wrote:
> Hi. Thank's for a hint!
> So catting this file gives me next content:
> s2idle [deep]
>
> Which kernel version do you use?
>
>
> Most systems preload with Windows 8.1 should default to use s2idle.
>
> So I suppose I have s2idle with deep-mode available?
>
> I've tried to select deep by creating mem_sleep_default file, but I can't  
> (Permission error).
>
> Could you explain how do I switch suspend mode in Linux, if you know?
>
> # echo s2idle > /sys/power/mem_sleep
> And to be honest, I don't think that's a correct fix of touchpad problem.
>
>
>
> Can we somehow cut off the power by hands or send a signal to a system to  
> shut off a touchpad? Or there are no approaches like that?
>
> I don’t think it’s possible.
>
> Kai-Heng
>
> Regards,
> Vladislav.
>
>
> Apr 23, 2019, 12:08 PM by mika.westerberg@linux.intel.com:
> On Tue, Apr 23, 2019 at 11:00:48AM +0200, hotwater438@tutanota.com wrote:
> Hi.
>
> Honestly, I can't find any information about my acpi suspend type.
> There are no options in my BIOS to change it, and I can't determine
> which exactly I have. But I suppose I have a S3 because I have suspend
> issue.
>
> Can I somehow determine it in Linux? I did a research but found nothing
> on the internet.
>
> You can read the default mode from /sys/power/mem_sleep. "s2idle" means,
> well suspend-to-idle and "deep" means S3.


