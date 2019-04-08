Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4668BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192E820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDHDoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:44:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40159 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDHDoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:44:22 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hDLCm-0005XP-Ct
        for linux-kernel@vger.kernel.org; Mon, 08 Apr 2019 03:44:20 +0000
Received: by mail-qt1-f199.google.com with SMTP id z34so11625357qtz.14
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 20:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2JIaDBayuL3uBjV+gAUXNn7OjCmpE8H2R4sqnbLcGE4=;
        b=s7kDtic7QHaaoVqLZNs2HiugJsl9f+2onU6ByElaCesi2oLDJFZeJJL1AQ1VHyLaan
         yo6mnWqdnotsgR9ZbMABeV0grOpcBj95SnrQQw2HN+g7WYu1d0krYN5HcoNliDn4RhiK
         Dwy3M2dlaoHQFflXKPI+1ZngcZ3HjiPIlus5kpKth+r+GYdEeYNuEgBQmaBdLH1DsLIb
         bHF1AHoKoAK8bDY48rGuYXib/7rbSEwE9geoJL7g/kKWFmCqrTzvIgVFZZKpV9UuKB7d
         NsiiRn7KcMNYviYgVsGhvHUr12beH7CbeK1YISjtMUWXKPrfXfSk2XqHfpjr2g85nNmO
         tPwg==
X-Gm-Message-State: APjAAAWVoVxuU+XCSTEUdjNkzAlDLLpbnFlRaV4msxyOeNhL79+ESr1d
        XQkBshvv8fIY83fSM0w+iFLBcV8KewsCTg3d6Z/qFpQBoV9ZGpDGWNNclb3HfLR+r6C8/5BrGmX
        4Bw49kFzI95jPvPU+VEuOzcAzTcryP2/PESjuS67XAg==
X-Received: by 2002:ac8:27b0:: with SMTP id w45mr22444508qtw.341.1554695059561;
        Sun, 07 Apr 2019 20:44:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0gWZ8l9nizdbXOcxT+d8cxm7PyDkpnIXppndq0PQ7+geFE2V6DklqMKly2eMmC48Krahxtw==
X-Received: by 2002:ac8:27b0:: with SMTP id w45mr22444492qtw.341.1554695059296;
        Sun, 07 Apr 2019 20:44:19 -0700 (PDT)
Received: from [10.101.46.46] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id v8sm17730005qtc.69.2019.04.07.20.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 20:44:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
Date:   Mon, 8 Apr 2019 11:44:11 +0800
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <EE3052A4-7566-4C92-B5FC-93918B297465@canonical.com>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
To:     "Robert R. Howell" <RHowell@uwyo.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 4:58 AM, Robert R. Howell <RHowell@uwyo.edu> wrote:

> On 4/3/19 2:54 AM, Hans de Goede wrote:
>
>> Hi,
>>
>> On 03-04-19 07:43, Kai-Heng Feng wrote:
>>> i2c-designware-platdrv fails to work after the system restored from
>>> hibernation:
>>> [ 272.775692] i2c_designware 80860F41:00: Unknown Synopsys component  
>>> type: 0xffffffff
>>>
>>> Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
>>> resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
>>> on BYT/CHT as resume_from_noirq is set. This means dw_i2c_plat_resume()
>>> doesn't gets called by acpi_lpss_resume_early(), and this causes the
>>> issue.
> ...
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
> I did try applying your (Hans') patch to a 5.0.0 and a 5.1-rc3 kernel,  
> instead of what I had
> been doing previously, which was reverting commit 02e45646d53b.  I tested  
> it on an ASUS T100TA
> and unfortunately with both kernels after resume from hibernation I still  
> get errors like those
> listed below, and sound no longer works.  I also tried applying the patch  
> from Kai-Heng Feng
> (instead of Hans' patch or my revert) on both kernels and again in both  
> cases I get these same errors.

Hmm, Hans’ works for me, as acpi_lpss_resume_noirq() calls  
acpi_lpss_do_resume_early() for S4.

>
> In contrast, on the 5.0.0 kernel when I revert 02e45646d53b, the problem  
> is fixed.  Because
> of changes in adjacent code in 5.1-rc3, I haven't yet found a way to  
> merge the new code
> and the 02e45646d53b revert without causing worse problems. But that's  
> probably because
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

Is it possible to attach full dmesg? Thanks.

Kai-Heng

>
> Bob Howell


