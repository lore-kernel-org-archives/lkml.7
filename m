Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4122084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCLS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:18:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38461 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:18:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id q14so14527163edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 04:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7C5DbOP2hJmLC4ys1i/uqZ3NAYvwkPf2YkOgSPKEEY=;
        b=YAf1uBFeTn3ZQzyH5dw1w/Xx7PJi2/dFwa/AJj0+yRYrCv8VjwdCj9CJ9igiJtSN8R
         CtMCBNcviNbVk5tXvGvGdzJdXnKlleOlheIc7SIUDe3hQGKqQcsHau4IMRQoh9D0UPBC
         axh3xxrrV0/0IYGD8HN3LiFFa4tad2/iuvlzvdhUHnuXjHJposa0hfCv2eRzEjJqMDe7
         6Yw4pipMU2IG3/9mRXdkEJvMlyVPG3wcmxi5gKmcXW7exBG7Bxu9LcWODdYmsjjFld9I
         Boc/b3uien5m20kVe1YM1+76Ku33AU7dkqaUlVLYM7a/AbiEw2AMUawtTFIgNZYSYWAl
         DLGg==
X-Gm-Message-State: APjAAAXxA7jT0rCyinrrDQs15eX98BIAQYY+WMc6m97JD0HIuon6yPAz
        6jfElzpfILZ1SjaTuGXFc/4U94a6OuE=
X-Google-Smtp-Source: APXvYqwmszBLwL2xa8UhSaG9E9FLgHpiBIEIenmY2SeCs0V9HCNvAdHiHIvdu0Nenx2OpJvaONeKzw==
X-Received: by 2002:a50:91d3:: with SMTP id h19mr51390425eda.218.1554290305217;
        Wed, 03 Apr 2019 04:18:25 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a38sm4889993eda.71.2019.04.03.04.18.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:18:24 -0700 (PDT)
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     hotwater438@tutanota.com
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Vladislav Dalechyn <vlad.dalechin@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
 <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com> <LbI7kio--3-1@tutanota.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a58ebeb8-10fd-29d0-1562-4ed8d84f2239@redhat.com>
Date:   Wed, 3 Apr 2019 13:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <LbI7kio--3-1@tutanota.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-03-19 11:50, hotwater438@tutanota.com wrote:
> Hi. I've done everything you said, here are results:
> 
>     Vladislav can you check the output of /cat/interrupts on a kernel
>     without the patch and while *not* using the touchpad; and check
>     if the amount of touchpads-interrupts still keeps increasing in this
>     case?
> 
> IWI or IRQ work interrupts keep increasing with speed at least 3 interrupts/s.

I'm really only interested in the touchpad related IRQs, so e.g. the line
about "intel-gpio  129  ELAN1200:00", if you're seeing 3 interrupts/s on
some others that is fine, so I take it the ELAN1200:00 interrupt count
does not increase on an *unpatched* kernel, unless you use the touchpad?

> Also when I am moving touchpad IR-IO-APIC 14-fasteoi INT345D:00 get's triggered and increased.

That is the GPIO controller interrupt, so that one increasing is normal.

If I understand things correctly then this all means that the IRQ indeed
is a normal level IRQ and Dmitry is likely correct that there is an
pinctrl / gpiochip driver problem here.

Can you try the following with an *unpatched* kernel? :

1) Run "cat /proc/interrupts | grep ELAN" , note down the value
2) Very quickly/briefly touch the touchpad once
3) Run "cat /proc/interrupts | grep ELAN" , note down the value again
4) Subtract result from 1. from result from 3, this difference is
    the value we are interested in. E.g. my testing got 254 and 257, so
    a difference of 3.

The goal here is to get an as low as possible difference. Feel free
to repeat this a couple of times.

On an Apollo Lake laptop with an I2C hid mt touchpad I can get the
amount of interrupts triggered for a single touch down to 3,
given the huge interrupt counts of 130000+ reported in:
https://bugzilla.redhat.com/show_bug.cgi?id=1543769

I expect you to get a much bigger smallest possible difference
between 2 "cat /proc/interrupts | grep ELAN" commands, note a
difference of 0 means your touch did not register.

Assuming you indeed see much more interrupts for a very quick
touch + release, then we indeed have an interrupt handling problem
we need to investigate further.

> I don't know if it's important or not, but for some reason these interrupts keep popping only on CPU2 (i have 4cpu processor).

That does not matter.

>     1) Suspending the machine by selecting suspend from a menu in your
>     desktop environment, or by briefly pressing the power-button, do
>     not close the lid
>     2) As soon as the system starts suspending and while it is suspended, move
>     your finger around the touchpad
>     3) Wake the system up with the powerbutton while moving your finger around
>     4) Check if the touchpad still works after this
> 
> It works, but as it seems, looses edge. JournalCTL is being flooded with i2c_hid_get_input: incomplete report (16/65535)

That is probably a different issue. If you loose the edge IRQ, then the touchpad
would stop working without any messages. I believe that the suspend / resume
issue may be fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52cf93e63ee672a92f349edc6ddad86ec8808fd8

Does your kernel have this commit?  (please always use the latest kernel while
testing).

> Also a thing to notice, that after manually removing and modprobing i2c_hid module, it says next in journalctl:
> 
> i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vdd not found, using dummy regulator
> i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vddl not found, using dummy regulator

Those messages can safely be ignored.

Regards,

Hans
