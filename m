Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EDDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483902054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfE1Nhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:37:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40633 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfE1Nhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:37:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id t4so11994953wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m2qPHQm43QctCDy78MWmofRRcuxf1aPMw9YFIL0J0Ck=;
        b=qqvkaK1Lrf+tC9QgzuNS04DfizermkxVcLOrwM1a8Ei7J2wO4duTrBW4ogyQUaTHbe
         8ZqEQfLoKLAtT79Rjw7+vwnQ7WvA+p3xr+6ESgQ1CdVqVLJkVaUuc2VhpWyVM2ksFBZf
         89qvxE5nIVI15ek9JeZhJJUV0aLPBlGDDuELa8KGd+PjwYCE6RPX55qw0iyiZnDF/4V3
         wCkhCVM+BNKA5CpxMTQQfP/kgrMB1dmZBo6fHfMCI9MHu8PUUC52pK51FR7JQANKfhYZ
         5YHOa64xStF64qKuthCAc89znH9wZFJKL7cMuOn6UsNf5FoigVbIvfWrc+7Bh8EWW57a
         iNpQ==
X-Gm-Message-State: APjAAAU79T3tqpIwZ5qdhv4H0D+aQkTDBmBFG9P04Lne90ksUngd0MtF
        cEO5WJDxwo8GPa6ufVi8H6D/nA==
X-Google-Smtp-Source: APXvYqyJieBlJHKtBSnwIUat5SX3zBPMeEfKw0zbnorY2//qE2po8IRvKsNewJGpt6sgBOlWakHrCQ==
X-Received: by 2002:adf:cf03:: with SMTP id o3mr14878644wrj.5.1559050654539;
        Tue, 28 May 2019 06:37:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w10sm1651499wrr.67.2019.05.28.06.37.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 06:37:33 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus-wmi: Only Tell EC the OS will handle
 display hotkeys from asus_nb_wmi
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
References: <20190521062837.3887-1-hdegoede@redhat.com>
 <CAHp75Vf6qzq3O1qz481FRuT1MN2EZOV43FpoSCC-vqATzyRF8w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0018e660-c1d4-2c42-837f-ceb13d575b86@redhat.com>
Date:   Tue, 28 May 2019 15:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf6qzq3O1qz481FRuT1MN2EZOV43FpoSCC-vqATzyRF8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24-05-19 18:43, Andy Shevchenko wrote:
> On Tue, May 21, 2019 at 9:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Commit 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will
>> handle the display off hotkey") causes the backlight to be permanently off
>> on various EeePC laptop models using the eeepc-wmi driver (Asus EeePC
>> 1015BX, Asus EeePC 1025C).
>>
>> The asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL) call added
>> by that commit is made conditional in this commit and only enabled in
>> the quirk_entry structs in the asus-nb-wmi driver fixing the broken
>> display / backlight on various EeePC laptop models.
>>
> 
> Hmm... doesn't apply.

That is likely because your review-andy branch contain a whole-bunch
of asus-wmi patches.

Since this is a patch fixing a regression this should go to the fixes
branch. As the other patches so far are only in your review-andy branch
it is probably best to merge this patch to for-next + fixes first and
then rebase the set you have in review-andy on top, so that this can go
to fixes without getting a merge conflict when the rest of the patches
show up...

Regards,

Hans







> 
>> Cc: João Paulo Rechi Vita <jprvita@endlessm.com>
>> Fixes: 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/asus-nb-wmi.c | 8 ++++++++
>>   drivers/platform/x86/asus-wmi.c    | 2 +-
>>   drivers/platform/x86/asus-wmi.h    | 1 +
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>> index b6f2ff95c3ed..59f3a37a44d7 100644
>> --- a/drivers/platform/x86/asus-nb-wmi.c
>> +++ b/drivers/platform/x86/asus-nb-wmi.c
>> @@ -78,10 +78,12 @@ static bool asus_q500a_i8042_filter(unsigned char data, unsigned char str,
>>
>>   static struct quirk_entry quirk_asus_unknown = {
>>          .wapf = 0,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_q500a = {
>>          .i8042_filter = asus_q500a_i8042_filter,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   /*
>> @@ -92,26 +94,32 @@ static struct quirk_entry quirk_asus_q500a = {
>>   static struct quirk_entry quirk_asus_x55u = {
>>          .wapf = 4,
>>          .wmi_backlight_power = true,
>> +       .wmi_backlight_set_devstate = true,
>>          .no_display_toggle = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_wapf4 = {
>>          .wapf = 4,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_x200ca = {
>>          .wapf = 2,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_ux303ub = {
>>          .wmi_backlight_native = true,
>> +       .wmi_backlight_set_devstate = true,
>>   };
>>
>>   static struct quirk_entry quirk_asus_x550lb = {
>> +       .wmi_backlight_set_devstate = true,
>>          .xusb2pr = 0x01D9,
>>   };
>>
>>   static struct quirk_entry quirk_asus_forceals = {
>> +       .wmi_backlight_set_devstate = true,
>>          .wmi_force_als_set = true,
>>   };
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index ee1fa93708ec..a66e99500c12 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -2131,7 +2131,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>                  err = asus_wmi_backlight_init(asus);
>>                  if (err && err != -ENODEV)
>>                          goto fail_backlight;
>> -       } else
>> +       } else if (asus->driver->quirks->wmi_backlight_set_devstate)
>>                  err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>>
>>          status = wmi_install_notify_handler(asus->driver->event_guid,
>> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
>> index 6c1311f4b04d..57a79bddb286 100644
>> --- a/drivers/platform/x86/asus-wmi.h
>> +++ b/drivers/platform/x86/asus-wmi.h
>> @@ -44,6 +44,7 @@ struct quirk_entry {
>>          bool store_backlight_power;
>>          bool wmi_backlight_power;
>>          bool wmi_backlight_native;
>> +       bool wmi_backlight_set_devstate;
>>          bool wmi_force_als_set;
>>          int wapf;
>>          /*
>> --
>> 2.21.0
>>
> 
> 
