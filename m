Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E695CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21632189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGDX1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 19:27:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfGDX1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:27:16 -0400
Received: from [114.252.212.168] (helo=[192.168.1.106])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <hui.wang@canonical.com>)
        id 1hjB89-00053a-18; Thu, 04 Jul 2019 23:27:09 +0000
Subject: Re: audio lost from speaker after reboot from windows on the device
 ALC295
To:     "He, Bo" <bo.he@intel.com>,
        "kailang@realtek.com" <kailang@realtek.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "chiu@endlessm.com" <chiu@endlessm.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <c37fa9bd-071c-6c10-55a6-933a4937fa87@canonical.com>
Date:   Fri, 5 Jul 2019 07:27:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe your machine has an external amplifier which needs to be set by 
software before it can work.

On 2019/7/4 下午8:02, He, Bo wrote:
> Hi, patch_realtek.c maintainer:
> 	I see one issue that reboot from windows and boot to ubuntu, the audio lost from speaker, I suspect there are some bugs in patch_realtek.c drivers,  the device is ALC295 and the device id is 0x10ec0295.
>
> I have done the below experiments:
> 1. reboot from windows to windows, the audio is persist .
> 2. reboot from windows to ubuntu, the audio lost from speaker, but can hear if I hotplug one earphone.
> 3. if the issue reproduce after reboot from windows, reboot the ubuntu can't restore the audio, I suspect it's warm reset.
> 4. if I write the port 0xcf9 with 0xe to do cold reset, the audio can restore.
> 5. if I do suspend/resume, the audio can restore, I suspect do cold boot and suspend will trigger the platform reset to reset the ALC295.
> 6. if I do double function reset (write the verb 0x7ff in alc_init), the audio is still can't restore.
> snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /* Function reset */
> snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /* double Function reset */
> 7. the issue is first found on kernel 4.19.50, I still see the issue with the latest kernel 5.2-rc2, is it possible windows change some default registers, but ALC295 don't initialize the register?
>
