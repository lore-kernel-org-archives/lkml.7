Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51775C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D07120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHIQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:16:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44393 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDHIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:16:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id d11so10794867edp.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3jdec/y4d1M3n4G3sJX8VFOgMY2jpDnSCJj4KB3r7us=;
        b=ae7uCPVHCPaa5ivyFbMApiXqrjviYgHF9Si6ohX7M563ztBQQpwN4w2/NA7j9LFTnu
         YkyNcdIpH5moabmBHFMBuwm9EYv1eiadX6w/iyb5ucnu/OgglFBve0z86cu4II7d7tgD
         Z4F/2Gmy1KH0w53va+SYwc8z2lwWTpkodG9GrvqaMN7NADnRBOjgeFMNc95ng38Jaf4s
         aXMbGO+PrS6mQbtZMNSNZN+U6Qm6LLB4Gk62GUtWvP4JNkUUxLPU2Uvikckj3JP3LkBM
         M9jvfzKLTC6wa3DhJt7Mnwd7kptjyp3P1BqVgnZAZ67Lcb8BuFnUQXPw84r2KCoTHczr
         eVxg==
X-Gm-Message-State: APjAAAVdPjgcsHi7pZN6SlNy+lAjhIarK80YtsDtVzt8tfyA5nWlXZba
        +tn0zPZy2ioXDkXEcRuCmWaGRBL5lw4=
X-Google-Smtp-Source: APXvYqyPJ4EgyOOqArbJcqQ8LSOJqOPqnu+SNOYAFQmfd0HDsybu9nfXPqbYOVWx5BeCowSwsmNqAA==
X-Received: by 2002:a50:cf49:: with SMTP id d9mr18395485edk.214.1554711384082;
        Mon, 08 Apr 2019 01:16:24 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e9sm5280381ejl.14.2019.04.08.01.16.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 01:16:23 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Robert R. Howell" <RHowell@uwyo.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
Date:   Mon, 8 Apr 2019 10:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-04-19 22:58, Robert R. Howell wrote:
> On 4/3/19 2:54 AM, Hans de Goede wrote:
> 
>>
>> Hi,
>>
>> On 03-04-19 07:43, Kai-Heng Feng wrote:
>>> i2c-designware-platdrv fails to work after the system restored from
>>> hibernation:
>>> [ 272.775692] i2c_designware 80860F41:00: Unknown Synopsys component type: 0xffffffff
>>>
>>> Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
>>> resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
>>> on BYT/CHT as resume_from_noirq is set. This means dw_i2c_plat_resume()
>>> doesn't gets called by acpi_lpss_resume_early(), and this causes the
>>> issue.
>>>
> ...
>>
>> The ordering problem fixed by commit 48402cee6889 can hit hibernate too,
>> so I think it would be better to do this instead to fix this problem:
>>
>> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> index 1e2a10a06b9d..cf768608437e 100644
> ...
>> If people affected by the problem can give my version of the fix a test,
>> then that would be great.
>>
>> Regards,
>>
>> Hans
> 
> I did try applying your (Hans') patch to a 5.0.0 and a 5.1-rc3 kernel, instead of what I had
> been doing previously, which was reverting commit 02e45646d53b.  I tested it on an ASUS T100TA
> and unfortunately with both kernels after resume from hibernation I still get errors like those
> listed below, and sound no longer works.  I also tried applying the patch from Kai-Heng Feng
> (instead of Hans' patch or my revert) on both kernels and again in both cases I get these same errors.
> 
> In contrast, on the 5.0.0 kernel when I revert 02e45646d53b, the problem is fixed.  Because
> of changes in adjacent code in 5.1-rc3, I haven't yet found a way to merge the new code
> and the 02e45646d53b revert without causing worse problems. But that's probably because
> I don't really understand the details of that code.
> 
> [  120.690428] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  120.690442] rt5640 i2c-10EC5640:00: Failed to write 13d = 3600: -110
> [  120.712860] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  120.737389] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  120.759657] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  120.781797] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  120.804153] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  120.826467] i2c_designware 80860F41:01: timeout waiting for bus ready
> [  121.965886] i2c_designware 80860F41:01: timeout in disabling adapter
> .....
> [  132.782634] i2c_designware 80860F41:01: controller timed out
> [  133.806538] i2c_designware 80860F41:01: controller timed out
> [  134.830991] i2c_designware 80860F41:01: controller timed out
> [  135.855183] i2c_designware 80860F41:01: controller timed out
> 
> Let me know if I can do any other testing to help.

Hmm, interesting so you have hibernation working on a T100TA
(with 5.0 + 02e45646d53b reverted), right ?

I must admit I never try hibernation myself, in experience it tends to
have more issues then regular suspend/resume and there are already enough
other issues to worry about on Bay and Cherry Trail based devices.

But if it works on the T100TA and 02e45646d53b broke it then I will
try to fix this, I've a T100TA myself. Currently my T100TA is at my
local hackerspace, so I will not have access to it until coming Friday.

Regards,

Hans

