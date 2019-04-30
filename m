Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB990C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739132147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfD3Ojo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:39:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38352 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3Ojn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:39:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so5804294edl.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 07:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQMzOEOjxZHMvmO5FLHBwq+9oHa3heGRya7YM30RNyY=;
        b=EhM3PvG4eAi+BxPpYdxsVAmzFEvMjuOyOL+UhC2bwgCuNfNxM62MNSwqdg4hIvRfBu
         Qg9vnagovFy7fdd/20DjTu3/wIRhpPUcglDFA8ALUxt40/oHBNHO04+p7j17mC5BsM8L
         T4O0XkJBB10qHPxaQvIPKpIZrD6W6zD/5lohZOOTmJIWXtGPzYqWIJaSc0v3tdYQT/pG
         rrX6PPGCLrKbWWNmE8aXxmnwMyZJGJfuGhdSp4rPH8IUX/AqOgCFAyl7OPYnoWp7Bb3N
         UmC2IDDODQu5m3phZUaTG/tSE70jnnreXOLj9Y2ICZYyPtehiROl1gq644NWxRUbfZtJ
         qHDA==
X-Gm-Message-State: APjAAAVgyhHzL0970J/k5mAOuk3ap5bY9VJ/lXQdsueboY7dLILGOebl
        5kbLNwM/685a05X1xJez5ZMC84ZGNXg=
X-Google-Smtp-Source: APXvYqx1234fcMrjFMGVa57IO9+f/eGJhGqA7xKgDp/OcA5okjHSezGYQusujlljNqw6mmalBOE25A==
X-Received: by 2002:a17:906:9a9:: with SMTP id q9mr26741022eje.171.1556635181153;
        Tue, 30 Apr 2019 07:39:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id s11sm6323208ejq.59.2019.04.30.07.39.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 07:39:40 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Robert R. Howell" <RHowell@uwyo.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
 <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
 <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
 <CAJZ5v0jJEovXXiqs-tzPC7FsGjGL+qxfXCxbTrQZqAxSCv1oyQ@mail.gmail.com>
 <beab21cb-9f89-b934-e0a4-2fd85c69f4e6@uwyo.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4fb5fc2e-e5af-6732-0228-8c73beed1afb@redhat.com>
Date:   Tue, 30 Apr 2019 16:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <beab21cb-9f89-b934-e0a4-2fd85c69f4e6@uwyo.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/19 6:38 PM, Robert R. Howell wrote:
> On 4/24/19 1:20 AM, Rafael J. Wysocki wrote:
> 
>> On Tue, Apr 23, 2019 at 10:03 PM Robert R. Howell <RHowell@uwyo.edu> wrote:
>>>
>>> On 4/23/19 2:07 AM, Rafael J. Wysocki wrote:
>>>>
>>>> On Sat, Apr 20, 2019 at 12:44 AM Robert R. Howell <RHowell@uwyo.edu> wrote:
>>>>>
>>>>> On 4/18/19 5:42 AM, Hans de Goede wrote:
>>>>>
>>>>>>> On 4/8/19 2:16 AM, Hans de Goede wrote:>
>>>>>>>>
>>>>>>>> Hmm, interesting so you have hibernation working on a T100TA
>>>>>>>> (with 5.0 + 02e45646d53b reverted), right ?
>>>>>>>>
>>>>>
>>>>>
>>>>> I've managed to find a way around the i2c_designware timeout issues
>>>>> on the T100TA's.  The key is to NOT set DPM_FLAG_SMART_SUSPEND,
>>>>> which was added in the 02e45646d53b commit.
>>>>>
>>>>> To test that I've started with a 5.1-rc5 kernel, applied your recent patch
>>>>> to acpi_lpss.c, then apply the following patch of mine, removing
>>>>> DPM_FLAG_SMART_SUSPEND.  (For the T100 hardware I need to apply some
>>>>> other patches as well but those are not related to the i2c-designware or
>>>>> acpi issues addressed here.)
>>>>>
>>>>> On a resume from hibernation I still see one error:
>>>>>    "i2c_designware 80860F41:00: Error i2c_dw_xfer called while suspended"
>>>>> but I no longer get the i2c_designware timeouts, and audio does now work
>>>>> after the resume.
>>>>>
>>>>> Removing DPM_FLAG_SMART_SUSPEND may not be what you want for other
>>>>> hardware, but perhaps this will give you a clue as to what is going
>>>>> wrong with hibernate/resume on the T100TA's.
>>>>
>>>> What if you drop DPM_FLAG_LEAVE_SUSPENDED alone instead?
>>>>
>>>
>>> I did try dropping just DPM_FLAG_LEAVE_SUSPENDED, dropping just
>>> DPM_FLAG_SMART_SUSPEND, and dropping both flags.  When I just drop
>>> DPM_FLAG_LEAVE_SUSPENDED I still get the i2c_designware timeouts
>>> after the resume.  If I drop just DPM_FLAG_SMART_SUSPEND or drop both,
>>> then the timeouts go away.
>>
>> OK, thanks!
>>
>> Is non-hibernation system suspend affected too?
> 
> I just ran some tests on a T100TA, using the 5.1-rc5 code with Hans' patch applied
> but without any changes to i2c-designware-platdrv.c, so the
> DPM_FLAG_SMART_PREPARE, DPM_FLAG_SMART_SUSPEND, and DPM_FLAG_LEAVE_SUSPENDED flags
> are all set.
> 
> Suspend does work OK, and after resume I do NOT get any of the crippling
> i2c_designware timeout errors which cause sound to fail after hibernate.  I DO see one
>    "i2c_designware 80860F41:00: Error i2c_dw_xfer call while suspended"
> error on resume, just as I do on hibernate.  I've attached a portion of dmesg below.
> The "asus_wmi:  Unknown key 79 pressed" error is a glitch which occurs
> intermittently on these machines, but doesn't seem related to the other issues.
> I had one test run when it was absent but the rest of the messages were the
> same -- but then kept getting that unknown key error on all my later tries.

I've just tried to reproduce the "Error i2c_dw_xfer call while suspended" error
on suspend/resume on my own T100TA and I could not reproduce this.

Can you try without the BT keyboard paired and waking up from suspend using the
tablet part's power-button ?

Also do you still have the scripts to rmmod some modules before suspend ?

> I did notice the "2sidle" in the following rather than "shallow" or "deep".  A
> cat of /sys/power/state shows "freeze mem disk" but a
> cat of /sys/power/mem_sleep" shows only "[s2idle] so it looks like shallow and deep
> are not enabled for this system.  I did check the input power (or really current)
> as it went into suspend and the micro-usb power input drops from about
> 0.5 amps to 0.05 amps.  But clearly a lot of devices are still active, as movement
> of a bluetooth mouse (the MX Anywhere 2) will wake it from suspend.  That presumably is
> why suspend doesn't trigger the same i2c_designware problems as hibernate.

s2idle is the normal / expected suspend condition on these tablet devices.

As for how much energy is consumed during suspend, the device should use
S0i3 and then you should get ok (so not great, but also not too much) power
consumption during suspend:

[root@dhcp-43-189 ~]# cat /sys/kernel/debug/pmc_atom/sleep_state
S0IR Residency: 156256us
S0I1 Residency: 3968us
S0I2 Residency: 0us
S0I3 Residency: 70557440us
S0   Residency: 11826052384us

After being suspended for a couple of seconds, you should see a significant
(large) value in S0I3 like above.

Regards,

Hans






> 
> Let me know if I can do any other tests.
> 
> Bob Howell
> 
> ----DMESG OUTPUT ON SUSPEND------------------
> [   71.791495] NET: Registered protocol family 38
> [   73.150736] input: MX Anywhere 2 Keyboard as /devices/virtual/misc/uhid/0005:046D:B013.0005/input/input24
> [   73.156612] input: MX Anywhere 2 Mouse as /devices/virtual/misc/uhid/0005:046D:B013.0005/input/input25
> [   73.159504] hid-generic 0005:046D:B013.0005: input,hidraw4: BLUETOOTH HID v0.07 Keyboard [MX Anywhere 2] on 74:D0:2B:DF:77:E9
> [  102.719170] asus_wmi: Unknown key 79 pressed
> [  102.897214] asus_wmi: Unknown key 79 pressed
> [  104.298409] PM: suspend entry (s2idle)
> [  104.298414] PM: Syncing filesystems ... done.
> [  105.410883] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [  105.413556] OOM killer disabled.
> [  105.413558] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [  123.353720] i2c_designware 80860F41:00: Error i2c_dw_xfer call while suspended
> [  123.635028] ACPI: button: The lid device is not compliant to SW_LID.
> [  124.086421] OOM killer enabled.
> [  124.086491] Restarting tasks ... done.
> [  124.120647] PM: suspend exit
> [  124.939566] asus_wmi: Unknown key 79 pressed
> 
