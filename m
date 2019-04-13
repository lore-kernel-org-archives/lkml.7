Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63075C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2362520869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDMIms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:42:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44017 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfDMIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:42:48 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hFEFJ-0007fs-A4
        for linux-kernel@vger.kernel.org; Sat, 13 Apr 2019 08:42:45 +0000
Received: by mail-pf1-f197.google.com with SMTP id l74so7928170pfb.23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zNC59q3314LGY6Pim7xf56YnM8DIYGw/Ls72f7XLyPg=;
        b=KUOxZqW647PoPVP1lI1Hp509KQwSLopnTTylEQUfu73GCDSgk30kkBG+OTwwX6rBKH
         jN+k4g2dThlA1pvHC8JsUXgy3gNFXktUTM1GLu7tlsnrVDhdoP183y9BeBzlBzM76RbH
         1tnifAToXs8MFsjHo2ORYpcxLJ68wIe0/D/MjSe13xIVSuq8634G8PzjqThlcIhoCYWg
         HAo8w6SfuITDHjCQBlgkVBvjvCP8lC+RpTi8eYT1CK5JZucnr4KDqcScc39+cXw+sZtE
         LcH2eIxXFp9xbwym/YB8owegq6s9FLNq0AR1l2e08FbzoNkkSqmWss0iW5wze+wCYvIa
         oqJQ==
X-Gm-Message-State: APjAAAWsLDmFLgdSN/qjGMFnlAC5mQKidWDDOUmCjEUp4zUeWV+yFkZa
        Xwi9SK2gUnaqWZ7YQwMAhOBJi6PccRDAtRgzarzYFGCZQdaDVen5cfer90QbpLuVPvuRm8HUk6i
        n1xGP89lAAio3mjkrxRIW9V9u1C8cLjcXRVDRrCwMjw==
X-Received: by 2002:a63:4101:: with SMTP id o1mr55533786pga.17.1555144963520;
        Sat, 13 Apr 2019 01:42:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwLHDzJUC4ydlul2ukAJJ12eueoKKu19JyEXsUS1mOwzir62IOWw6DU0Bnz2TJZOmJ9ssgYHQ==
X-Received: by 2002:a63:4101:: with SMTP id o1mr55533757pga.17.1555144963143;
        Sat, 13 Apr 2019 01:42:43 -0700 (PDT)
Received: from 2001-b011-380f-14b9-0cdd-c2aa-122a-8204.dynamic-ip6.hinet.net (2001-b011-380f-14b9-0cdd-c2aa-122a-8204.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:cdd:c2aa:122a:8204])
        by smtp.gmail.com with ESMTPSA id v20sm56629141pfe.118.2019.04.13.01.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 01:42:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <LcKqhgD--3-1@tutanota.com>
Date:   Sat, 13 Apr 2019 16:42:38 +0800
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Vladislav Dalechyn <vlad.dalechin@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Swboyd <swboyd@chromium.org>,
        Bigeasy <bigeasy@linutronix.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <385F448C-463D-4EF0-BCFB-8386D043F189@canonical.com>
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
 <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com> <LbI7kio--3-1@tutanota.com>
 <a58ebeb8-10fd-29d0-1562-4ed8d84f2239@redhat.com> <LbZjy9p--3-1@tutanota.com>
 <B7A141A3-613C-4EB8-8BB4-F845A0AC8F23@canonical.com>
 <LcKqhgD--3-1@tutanota.com>
To:     hotwater438@tutanota.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 16:40, <hotwater438@tutanota.com> <hotwater438@tutanota.com> wrote:

> Hi.
>
> I've applied this patch, but still getting incomplete report messages.

Does the patch fix the other two issues:
- Five finger tap kill's module so you have to restart it;
- Two finger scoll is working incorrect and sometimes even when you
raised one of two finger still thinks that you are scrolling.

Kai-Heng

>
> Regards,
> Vladislav
>
> Apr 11, 2019, 7:17 PM by kai.heng.feng@canonical.com:
> Hi,
>
> at 05:18, <hotwater438@tutanota.com> <hotwater438@tutanota.com> wrote:
> Hi.
>
> 1) Run "cat /proc/interrupts | grep ELAN" , note down the value
> 2) Very quickly/briefly touch the touchpad once
> 3) Run "cat /proc/interrupts | grep ELAN" , note down the value again
> 4) Subtract result from 1. from result from 3, this difference is
> the value we are interested in. E.g. my testing got 254 and 257, so
> a difference of 3.
> I've tested that, main diffs are 30, 24, 16 (the most frequent), 2 (the  
> least frequent).
>
> I was using 4.19.13 kernel, because I use ParrotOS (which happens to be  
> Debian distribution).
> But I've installed experimental 5.0.0 kernel and I can't say right now if  
> suspend problem is resolved (i have to rebuild latest kernel with patch).
>
> Can you try below fix?
>
> This can solve what commit 1475af255e18 ("HID: i2c-hid: Ignore input  
> report if there's no data present on Elan touchpanels”) tries to  
> workaround.
>
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c  
> b/drivers/pinctrl/intel/pinctrl-intel.c
> index c19a4c45f7bb..30e3664f1ae5 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -957,6 +957,10 @@ static void intel_gpio_irq_mask_unmask(struct  
> irq_data *d, bool mask)
> reg = community->regs + community->ie_offset + gpp * 4;
>
> raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> + if (!mask)
> + writel(BIT(gpp_offset), community->regs + community->is_offset + gpp *  
> 4);
> +
> value = readl(reg);
> if (mask)
> value &= ~BIT(gpp_offset);
>
>
> Regards,
> Vladislav.
>
> Apr 3, 2019, 2:18 PM by hdegoede@redhat.com:
> Hi,
>
> On 31-03-19 11:50, hotwater438@tutanota.com wrote:
> Hi. I've done everything you said, here are results:
>
> Vladislav can you check the output of /cat/interrupts on a kernel
> without the patch and while *not* using the touchpad; and check
> if the amount of touchpads-interrupts still keeps increasing in this
> case?
>
> IWI or IRQ work interrupts keep increasing with speed at least 3  
> interrupts/s.
>
> I'm really only interested in the touchpad related IRQs, so e.g. the line
> about "intel-gpio 129 ELAN1200:00", if you're seeing 3 interrupts/s on
> some others that is fine, so I take it the ELAN1200:00 interrupt count
> does not increase on an *unpatched* kernel, unless you use the touchpad?
> Also when I am moving touchpad IR-IO-APIC 14-fasteoi INT345D:00 get's  
> triggered and increased.
>
> That is the GPIO controller interrupt, so that one increasing is normal.
>
> If I understand things correctly then this all means that the IRQ indeed
> is a normal level IRQ and Dmitry is likely correct that there is an
> pinctrl / gpiochip driver problem here.
>
> Can you try the following with an *unpatched* kernel? :
>
> 1) Run "cat /proc/interrupts | grep ELAN" , note down the value
> 2) Very quickly/briefly touch the touchpad once
> 3) Run "cat /proc/interrupts | grep ELAN" , note down the value again
> 4) Subtract result from 1. from result from 3, this difference is
> the value we are interested in. E.g. my testing got 254 and 257, so
> a difference of 3.
>
> The goal here is to get an as low as possible difference. Feel free
> to repeat this a couple of times.
>
> On an Apollo Lake laptop with an I2C hid mt touchpad I can get the
> amount of interrupts triggered for a single touch down to 3,
> given the huge interrupt counts of 130000+ reported in:
> https://bugzilla.redhat.com/show_bug.cgi?id=1543769
>
> I expect you to get a much bigger smallest possible difference
> between 2 "cat /proc/interrupts | grep ELAN" commands, note a
> difference of 0 means your touch did not register.
>
> Assuming you indeed see much more interrupts for a very quick
> touch + release, then we indeed have an interrupt handling problem
> we need to investigate further.
> I don't know if it's important or not, but for some reason these  
> interrupts keep popping only on CPU2 (i have 4cpu processor).
>
> That does not matter.
> 1) Suspending the machine by selecting suspend from a menu in your
> desktop environment, or by briefly pressing the power-button, do
> not close the lid
> 2) As soon as the system starts suspending and while it is suspended, move
> your finger around the touchpad
> 3) Wake the system up with the powerbutton while moving your finger around
> 4) Check if the touchpad still works after this
>
> It works, but as it seems, looses edge. JournalCTL is being flooded with  
> i2c_hid_get_input: incomplete report (16/65535)
>
> That is probably a different issue. If you loose the edge IRQ, then the  
> touchpad
> would stop working without any messages. I believe that the suspend /  
> resume
> issue may be fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52cf93e63ee672a92f349edc6ddad86ec8808fd8
>
> Does your kernel have this commit? (please always use the latest kernel  
> while
> testing).
> Also a thing to notice, that after manually removing and modprobing  
> i2c_hid module, it says next in journalctl:
>
> i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vdd not found, using  
> dummy regulator
> i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vddl not found, using  
> dummy regulator
>
> Those messages can safely be ignored.
>
> Regards,
>
> Hans


