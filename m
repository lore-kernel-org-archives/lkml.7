Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03887C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8BA20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCGLVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:21:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36705 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:21:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so13119310eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 03:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfbNEMDZSjewYqhzFxrobaAzmgPNaFmOIXJC013vE6E=;
        b=EsqyJ5V0a0AxRjdW5BwnojIIqg7bm+xGdRvGhd/9Gvo0OWzV5QuC+HclMtUwgcmEQV
         2nxK0orqnNTZD65HxfzyCpHIFBPRVNYPB5vRYC31KZGFB7hx/fBoHsmT6yx9M1mR57Ii
         JX1jqNz4KCpXwTBq1sCbReKR+7djlyKOTNdZOIDTfIHTmn8Ofqfv9UaMnUeg+rBf26bM
         djepolepKMrtx3hi9ADyU5+I8e/daEYyQTFcbB0TGE/Kw96AN+r8YcoKHy2djzTdwm1/
         Pch9AN1gcxm/ZjafOFR8rYn65orcuQkbReZNqaxTcABxz/26MsDG+ju37L1+EDZ1RDQ1
         3lSg==
X-Gm-Message-State: APjAAAU5jJOO4o9ifktFi6TEFC4UbLSDbdsnMBDRq7VqFgKdyC/1y33c
        SFelyEWo9zOHe5WRNQliVbuhqw==
X-Google-Smtp-Source: APXvYqxjCTKlXWEBhBccNwuoe6xcYuncAD8sMP/hkbujKsAiCBL5TdovifpllAjd/2EuIIhC+/t8xQ==
X-Received: by 2002:a17:906:1fda:: with SMTP id e26mr7244746ejt.53.1551957658616;
        Thu, 07 Mar 2019 03:20:58 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id gl18sm833180ejb.49.2019.03.07.03.20.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 03:20:57 -0800 (PST)
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
 <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
 <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com>
 <6fbcd261-f9e2-1685-1ef7-f148007aab9d@redhat.com>
 <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com>
 <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com>
 <92a886e1-1eca-7b94-2c62-9f42abc66bcf@redhat.com>
 <20190305195432.GI8256@zn.tnic>
 <e8d1128f-ff81-3dc9-90ae-86ce5d8f69b2@redhat.com>
 <alpine.DEB.2.21.1903061112350.1646@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f73c1410-db9c-deb7-6a23-5d54e2b9dcc7@redhat.com>
Date:   Thu, 7 Mar 2019 12:20:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903061112350.1646@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-03-19 11:14, Thomas Gleixner wrote:
> Hans,
> 
> On Wed, 6 Mar 2019, Hans de Goede wrote:
>> On 05-03-19 20:54, Borislav Petkov wrote:
>>> On Tue, Mar 05, 2019 at 08:40:02PM +0100, Hans de Goede wrote:
>>>> Finger pointing at the firmware if there are multiple vendors involved
>>>> is really not going to help here. Esp. since most OEMs will just respond
>>>> with "the machine works fine with Windows"
>>>
>>> Yes, because windoze simply doesn't report that spurious IRQ, most
>>> likely.
>>
>> So maybe we need to lower the priority of the do_IRQ error from pr_emerg
>> to pr_err then ?  That will stop throwing the errors in the users face each
>> boot on distros which have chosen to set the quiet loglevel to such a level
>> that pr_err messages are not shown on the console (*).
> 
> Well, we rather try to understand and fix the issue.
> 
> So if Tom's theory holds, then the patch below should cure it.

Thank you for the patch, unfortunately the messages still happen
with a kernel with the patch applied:

[    0.741479] smp: Bringing up secondary CPUs ...
[    0.741654] x86: Booting SMP configuration:
[    0.741655] .... node  #0, CPUs:        #1
[    0.742231] TSC synchronization [CPU#0 -> CPU#1]:
[    0.742231] Measured 3346474670 cycles TSC warp between CPUs, turning off TSC
  clock.
[    0.742231] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.321639] do_IRQ: 1.55 No irq handler for vector
[    0.743371]   #2
[    0.321639] do_IRQ: 2.55 No irq handler for vector
[    0.743598]   #3
[    0.321639] do_IRQ: 3.55 No irq handler for vector
[    0.744306]   #4
[    0.321639] do_IRQ: 4.55 No irq handler for vector
[    0.744531]   #5
[    0.321639] do_IRQ: 5.55 No irq handler for vector
[    0.745241]   #6
[    0.321639] do_IRQ: 6.55 No irq handler for vector
[    0.745467]   #7
[    0.321639] do_IRQ: 7.55 No irq handler for vector
[    0.745627] smp: Brought up 1 node, 8 CPUs
[    0.745627] smpboot: Max logical packages: 2
[    0.745627] smpboot: Total of 8 processors activated (35133.37 BogoMIPS)

I also tried suspend/resume. In that case there are no
extra "No irq handler for vector" printed, this seems to
only trigger once per CPU on boot only.

I do get these messages during resume, but I guess these are unrelated:

[  167.034247] ACPI: Low-level resume complete
[  167.034247] ACPI: EC: EC started
[  167.034247] PM: Restoring platform NVS memory
[  167.034247] Enabling non-boot CPUs ...
[  167.034247] x86: Booting SMP configuration:
[  167.034247] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  167.034247]  cache: parent cpu1 should not be sleeping
[  167.034281] microcode: CPU1: patch_level=0x08101007
[  167.034542] CPU1 is up
[  167.034583] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  167.035347]  cache: parent cpu2 should not be sleeping
[  167.035484] microcode: CPU2: patch_level=0x08101007
[  167.035690] CPU2 is up
[  167.035703] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  167.036447]  cache: parent cpu3 should not be sleeping
[  167.036580] microcode: CPU3: patch_level=0x08101007
[  167.036819] CPU3 is up
[  167.036843] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  167.038227]  cache: parent cpu4 should not be sleeping
[  167.038384] microcode: CPU4: patch_level=0x08101007
etc.

Regards,

Hans


> 8<---------------------
> 
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1642,6 +1642,7 @@ static void end_local_APIC_setup(void)
>    */
>   void apic_ap_setup(void)
>   {
> +	clear_local_APIC();
>   	setup_local_APIC();
>   	end_local_APIC_setup();
>   }
> 
