Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4701DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB822166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439019AbfJXLad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:30:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436509AbfJXLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:30:33 -0400
Received: from [113.5.8.176] (helo=[192.168.43.4])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1iNbK3-0002ko-9X; Thu, 24 Oct 2019 11:30:31 +0000
Subject: Re: [PATCH v2] ALSA: hda/realtek - Fix 2 front mics of codec 0x623
To:     Aaron Ma <aaron.ma@canonical.com>, perex@perex.cz, tiwai@suse.com,
        kailang@realtek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20191022153855.14368-1-aaron.ma@canonical.com>
 <20191024111850.31137-1-aaron.ma@canonical.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <24766a9d-3328-b70b-abd1-1a88470b08c0@canonical.com>
Date:   Thu, 24 Oct 2019 19:30:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024111850.31137-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/24 下午7:18, Aaron Ma wrote:
> These 2 ThinkCentres installed a new realtek codec ID 0x623,
> it has 2 front mics with the same location on pin 0x18 and 0x19.
>
> Apply fixup ALC283_FIXUP_HEADSET_MIC to change 1 front mic
> location to right, then pulseaudio can handle them.
> One "Front Mic" and one "Mic" will be shown, and audio output works
> fine.
>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   sound/pci/hda/patch_realtek.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index a0c237cc13d4..173a7867bb45 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -7221,6 +7221,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
>   	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
>   	SND_PCI_QUIRK(0x17aa, 0x3151, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
> +	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
> +	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),

Please sort them in numerical order, 0x3176 is ahead of 0x3178.

thanks

>   	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
>   	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
>   	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
