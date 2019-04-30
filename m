Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBDAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B1620835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfD3IgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:36:10 -0400
Received: from mail5.windriver.com ([192.103.53.11]:39538 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3IgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:36:10 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3U8Wxfo014580
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 30 Apr 2019 01:33:15 -0700
Received: from [128.224.162.229] (128.224.162.229) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Apr 2019
 01:32:49 -0700
Message-ID: <5CC8082F.4090903@windriver.com>
Date:   Tue, 30 Apr 2019 16:32:47 +0800
From:   Liwei Song <liwei.song@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Takashi Iwai <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, Yu Zhao <yuzhao@google.com>,
        Mark Brown <broonie@kernel.org>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda: check RIRB to avoid use NULL pointer
References: <1556604653-47363-1-git-send-email-liwei.song@windriver.com> <s5himuwhru3.wl-tiwai@suse.de>
In-Reply-To: <s5himuwhru3.wl-tiwai@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2019 03:31 PM, Takashi Iwai wrote:
> On Tue, 30 Apr 2019 08:10:53 +0200,
> Song liwei wrote:
>>
>> From: Liwei Song <liwei.song@windriver.com>
>>
>> Fix the following BUG:
>>
>> BUG: unable to handle kernel NULL pointer dereference at 000000000000000c
>> Workqueue: events azx_probe_work [snd_hda_intel]
>> RIP: 0010:snd_hdac_bus_update_rirb+0x80/0x160 [snd_hda_core]
>> Call Trace:
>>  <IRQ>
>>  azx_interrupt+0x78/0x140 [snd_hda_codec]
>>  __handle_irq_event_percpu+0x49/0x300
>>  handle_irq_event_percpu+0x23/0x60
>>  handle_irq_event+0x3c/0x60
>>  handle_edge_irq+0xdb/0x180
>>  handle_irq+0x23/0x30
>>  do_IRQ+0x6a/0x140
>>  common_interrupt+0xf/0xf
>>
>> The Call Trace happened when run kdump on a NFS rootfs system.
>> Exist the following calling sequence when boot the second kernel:
>>
>> azx_first_init()
>>    --> azx_acquire_irq()
>>                       <-- interrupt come in, azx_interrupt() was called
>>    --> hda_intel_init_chip()
>>       --> azx_init_chip()
>>          --> snd_hdac_bus_init_chip()
>>               --> snd_hdac_bus_init_cmd_io();
>>                     --> init rirb.buf and corb.buf
>>
>> Interrupt happened after azx_acquire_irq() while RIRB still didn't got
>> initialized, then NULL pointer will be used when process the interrupt.
>>
>> Check the value of RIRB to ensure it is not NULL, to aviod some special
>> case may hang the system.
>>
>> Fixes: 14752412721c ("ALSA: hda - Add the controller helper codes to hda-core module")
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> 
> Oh, that's indeed a race there.
> 
> But I guess the check introduced by the patch is still error-prone.
> Basically the interrupt handling should be moved after the chip
> initialization.  I suppose that your platform uses the shared
> interrupt, not the MSI?

This is the information from /proc/interrupt
134:          0        102          0          0  IR-PCI-MSI 514048-edge      snd_hda_intel:card0


> 
> In anyway, alternative (and likely more certain) fix would be to move
> the azx_acquir_irq() call like the patch below (note: totally
> untested).  Could you check whether it works?

Yes, It works.

Considering a previous patch like the one you provide will import some issue, 
so I choose check the invalid value to low the risk, but just as you mentioned,
It is not a good solution.

commit 542cedec53c9e8b73f3f05bf8468823598c50489
Author: Yu Zhao <yuzhao@google.com>
Date:   Tue Sep 11 15:12:46 2018 -0600

    Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
    
    This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.
    
    The patch doesn't fix accessing memory with null pointer in
    skl_interrupt().
    
    There are two problems: 1) skl_init_chip() is called twice, before
    and after dma buffer is allocate. The first call sets bus->chip_init
    which prevents the second from initializing bus->corb.buf and
    rirb.buf from bus->rb.area. 2) snd_hdac_bus_init_chip() enables
    interrupt before snd_hdac_bus_init_cmd_io() initializing dma buffers.
    There is a small window which skl_interrupt() can be called if irq
    has been acquired. If so, it crashes when using null dma buffer
    pointers.

Thanks,
Liwei.


> 
> 
> thanks,
> 
> Takashi
> 
> 
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1788,9 +1788,6 @@ static int azx_first_init(struct azx *chip)
>  			chip->msi = 0;
>  	}
>  
> -	if (azx_acquire_irq(chip, 0) < 0)
> -		return -EBUSY;
> -
>  	pci_set_master(pci);
>  	synchronize_irq(bus->irq);
>  
> @@ -1904,6 +1901,9 @@ static int azx_first_init(struct azx *chip)
>  		return -ENODEV;
>  	}
>  
> +	if (azx_acquire_irq(chip, 0) < 0)
> +		return -EBUSY;
> +
>  	strcpy(card->driver, "HDA-Intel");
>  	strlcpy(card->shortname, driver_short_names[chip->driver_type],
>  		sizeof(card->shortname));
> 
> 
