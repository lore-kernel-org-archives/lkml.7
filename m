Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB68C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D3217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfC2MSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:18:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40499 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfC2MSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:18:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so1831608edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 05:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCUHTq+ZztQjBx96pC5WdDDF8o6CE3Wf4ZgQXc4yO5E=;
        b=s1zJR39zDChD/dZ/avX+GrXxT9MTV/71DWQijJxExTibdahiH8KNGHCWb15IZ7xQrt
         Czl2NOLp+anar0rpS7yiGKv1cQx+XdSI2uMtIXEPPddE+fVZAeBA+Uo6qqwvn+MYLDUA
         GWCBfDgPm8s6Iji5KxTW77nE4Y93XOT1QLMNv2p+xPPynQGvTlvjnM1HmnK6Eks6+Pwh
         B62T1TyZDjzQUIv5WR5uHeHJVXKGu5AVnsBgU7uo5r3EUHco6H5k7EJb8O92a1md8mFM
         cDemj96w1FWgWpMaH8W0O0j0Qot7glIYyvZgi+qBUEaU5bnfdRBdO9732Y30RcLMUBAt
         Ha0g==
X-Gm-Message-State: APjAAAV6rXjL3WuV8FSclg35sRT5tPeFytksYMr8v7S1xetg0eigFnf5
        q9TjQUqgQvViLZdmXxZvAb7ZYg==
X-Google-Smtp-Source: APXvYqzWDVbstm7sUEoiCmLgpKsKu3W4alJIcsqXVRlymk2qQNWXaeDuA+wjg/k/tJKwDg29bbDywg==
X-Received: by 2002:a17:906:3482:: with SMTP id g2mr27437810ejb.214.1553861901974;
        Fri, 29 Mar 2019 05:18:21 -0700 (PDT)
Received: from localhost.localdomain ([62.140.137.96])
        by smtp.gmail.com with ESMTPSA id g20sm337207ejk.72.2019.03.29.05.18.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 05:18:21 -0700 (PDT)
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Vladislav Dalechyn <vlad.dalechin@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com,
        swboyd@chromium.org, bigeasy@linutronix.de,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
 <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com>
Date:   Fri, 29 Mar 2019 13:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/25/19 5:56 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Mon, Mar 25, 2019 at 9:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Dmitry,
>>
>> On 25-03-19 17:02, Dmitry Torokhov wrote:
>>> Hi Vladislav,
>>>
>>> On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
>>> <vlad.dalechin@gmail.com> wrote:
>>>>
>>>> From: Vladislav Dalechyn <hotwater438@tutanota.com>
>>>>
>>>> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
>>>> caused by an error setting the correct IRQ_TRIGGER flag:
>>>> - i2c_hid incoplete error flood in journalctl;
>>>> - Five finger tap kill's module so you have to restart it;
>>>> - Two finger scoll is working incorrect and sometimes even when you
>>>> raised one of two finger still thinks that you are scrolling.
>>>>
>>>> Fix all of these with a new quirk that corrects the trigger flag
>>>> announced by the ACPI tables. (edge-falling).
>>>
>>> I do not believe this is right solution. The driver makes liberal use
>>> of disable_irq() and enable_irq() which may lead to lost edges and
>>> touchpad stopping working altogether.
>>>
>>> Usually the "extra" report is caused by GPIO controller clearing
>>> interrupt condition at the wrong time (too early), or in unsafe or
>>> racy fashion. You need to look there instead of adding quirk to
>>> i2c-hid.
>>
>> The falling-edge solution was proposed by Elan themselves.
>>
>> Also if you look at: https://bugzilla.redhat.com/show_bug.cgi?id=1543769
>>
>> And esp. the "cat /proc/interrupts" output there, then you will see
>> that the interrupt seems to be stuck at low level, which according
>> to the ACPI tables is its active level.
> 
> So how does it generate a new edge if it is stuck at low?
> 
> Is it bad touchpad firmware that does not deassert interrupt quickly
> enough?

I do not believe it is not de-asserting it quick enough (I believe
the amount of interrups is too high for that.

It seems to simply be low most of the time, or it is really really
slow with de-asserting.

Vladislav can you check the output of /cat/interrupts on a kernel
without the patch and while *not* using the touchpad; and check
if the amount of touchpads-interrupts still keeps increasing in this
case?

Also I believe that you had contact with Elan about this and they
told you to change the interrupt type to falling-edge as work-around,
right?  Can you ask them why?

This is quite unususal, I've collected quite a few DSDTs over time
and I've just checked about 40 of them all with a PNP0C50 in
some form (and in many cases multiple such devices) and NONE of
them is using edged-interrupts in the ACPI config.

<speculation>

I think that the Elan touchpad firmware supports a mode to
work on devices which only support edge interrupts and that
this mode is accidentally enabled in this firmware.

I think that the interrupt line is simply low all the time
and gets pulsed high then low again when the touchpad detects
a finger. Hopefully it does this pulsing on every event and not
only when its event "fifo" is empty.

</speculation>

> I scrolled through the bug but I do not see if it had been
> confirmed that original windows installation actually uses edge (it
> may very well be using it; Elan engineers pushed us to use edge in a
> few cases, but they all boiled down to an issue with pin control/GPIO
> implementation).

This has not been checked on Windows AFAIK.

>> As for this being a GPIO chip driver problem, this is using standard
>> Intel pinctrl stuff, which is not showing this same issue with many
>> other i2c-hid touchpads.
> 
> Well, there have been plenty of issues in intel drivers, coupled with
> "interesting" things done by firmware and boards.
> 
> If you want to keep on using edge you need to make sure that i2c-hid
> never loses edge, as replaying of previously disabled interrupts in
> not at all reliable. So you need to "kick" the device after
> enable_irq() by initiating read from it and be ready to not get any
> data or get valid data and process accordingly.

That is a good point and I agree.

Vladislav, let me explain this a bit. Normally the touchpad
driver the IRQ line low when it has touch-data to respond, which means
that if touch-data is reported before the driver loads (or while
the driver has the irq disabled during e.g. suspend), it will immediately
see an interrupt. If we use edge mode then the IRQ will only trigger
when the IRQ line goes from high to low, if this happens when the driver
is not listening then we do not see the edge. And since we never read the
pending touch-data, the IRQ line never goes high again (which it does
when we have read all available data), so we will never see a negative-edge
and then things are stuck.

It would be good, if running a kernel with your patch, you can try
to trigger this by:

1) Suspending the machine by selecting suspend from a menu in your
desktop environment, or by briefly pressing the power-button, do
not close the lid
2) As soon as the system starts suspending and while it is suspended, move
your finger around the touchpad
3) Wake the system up with the powerbutton while moving your finger around
4) Check if the touchpad still works after this

Or by:

1) Using ctrl + alt + f3 to switch to a text console
2) Move finger around on touchpad, keep moving it around
3) Switch back to X11 with alt + f2 or alt + f7, while still moving the finger
4) Check if the touchpad still works after this

If neither causes the touchpad to stop working, then at least the problem Dmitry
fears is not easy to trigger, but we should probably still prepare to deal
with it; and we really should try to better understand the problem here, so
if you can answer my questions above, then that would be great.

Regards,

Hans

