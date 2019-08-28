Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111FE20828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfH1IZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:25:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34375 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:25:16 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2tGT-0005iL-W0
        for linux-kernel@vger.kernel.org; Wed, 28 Aug 2019 08:25:14 +0000
Received: by mail-pg1-f200.google.com with SMTP id b18so1216289pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yDQMhkjBqvMckIaETJ30I1V3/odVpy6UAuG1t5GavCg=;
        b=tML5X8vxcJZ6Gv7QiheNOdmvQp1bVXfMH2vkH8GGkOsqG7Up5RcYC8ie6pGM5rn9kV
         yDgfUpcCTzTJSBWboGOhy4FyCWVtIDGNDihqhNe9veVjBhPyvP7ouWrstpW2TGrOOkRx
         Lu0gPk49Z6GT7SCH65G+pNebufLcWBRyUpX3186SLU3wIfdHMx9qogpPF8ZumExqWSrz
         a27z5ivJjMbsuyMsM8Octx7rX6WSluQ3zuuDkYutq/fM3qTTHKmCH05LCG7GcK5tFi8r
         iAZ+gU5XZDcEWURSYjHvjAvS3xvmNuETI/dQ3o4NT9sjIQrSWAae/Rk4ZxvnpGUbvPwV
         K1jA==
X-Gm-Message-State: APjAAAWpdph3YhKXmCB2VKWH6JiP2L54ZOuRGB2rrL4wHtoRrqlzUGEe
        UqLvRMUkWFxP3siP/tF+/0K/EKslzEN5vg2elwl+FIgZNnUnr7nve3l8PkEsKsNGPkvLYhQNbIk
        60dJtjnJ8f2owc3WzxshQ1vJA5bmllpkzyrCpaKG6aQ==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3053419plk.91.1566980712710;
        Wed, 28 Aug 2019 01:25:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg3xPhlxpHv0Jw3q47+NdHNvNzyyatg4MSCzNk9Lkvz07TQuVYjHaH9aQx5W+/tAUeIxm73Q==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3053407plk.91.1566980712363;
        Wed, 28 Aug 2019 01:25:12 -0700 (PDT)
Received: from 2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net (2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:f8f8:a260:49a8:d1ed])
        by smtp.gmail.com with ESMTPSA id y9sm1820302pfn.152.2019.08.28.01.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 01:25:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190827223125.GB9987@google.com>
Date:   Wed, 28 Aug 2019 16:25:08 +0800
Cc:     tiwai@suse.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <66C43B81-0A08-437F-B099-1C757A42E912@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190827134756.10807-2-kai.heng.feng@canonical.com>
 <20190827223125.GB9987@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

at 06:31, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Aug 27, 2019 at 09:47:56PM +0800, Kai-Heng Feng wrote:
>> It's a common practice to let dGPU unbound and use PCI port PM to
>> disable its power through _PR3. When the dGPU comes with an HDA
>> function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
>> power can't be disabled.
>
> Just a terminology question:
>
> I thought "using PCI port PM" meant using the PCI Power Management
> Capability in config space to directly change the device's power
> state, e.g., in pci_raw_set_power_state().

What I meant is to use pcieport.ko directly.

>
> And I thought using _PS3, _PR3, etc would be part of "platform power
> management”?

Ok, will update the wording.

>
> And AFAICT, _PR3 merely returns a list of power resources; it doesn't
> disable power itself.

Yes, through its _PS3 and _OFF. I’ll update the wording.

Kai-Heng

>
>> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
>> discrete GPU") only allows HDA to be runtime-suspended once GPU is
>> bound, to keep APU's HDA working.
>>
>> However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
>> the runtime suspend requirement for dGPU's HDA function, to save lots of
>> power.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1840835
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  sound/pci/hda/hda_intel.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 99fc0917339b..d4ee070e1a29 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
>>  		dev_info(chip->card->dev,
>>  			 "Handle vga_switcheroo audio client\n");
>>  		hda->use_vga_switcheroo = 1;
>> -		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
>> +		/* cleared in gpu_bound op */
>> +		hda->need_eld_notify_link = !pci_pr3_present(p);
>>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>>  		pci_dev_put(p);
>>  	}
>> -- 
>> 2.17.1


