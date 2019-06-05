Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C33BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310F6206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfFEPGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:06:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:28134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFEPGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:06:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 08:06:47 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 08:06:47 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 755CC5800BD;
        Wed,  5 Jun 2019 08:06:46 -0700 (PDT)
Subject: Re: [PATCH 02/14] ALSA: hdac: fix memory release for SST and SOF
 drivers
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
 <20190605134556.10322-3-amadeuszx.slawinski@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <190f5c09-e6ae-918e-3fcc-d91a72a895da@linux.intel.com>
Date:   Wed, 5 Jun 2019 10:06:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605134556.10322-3-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 8:45 AM, Amadeusz Sławiński wrote:
> During the integration of HDaudio support, we changed the way in which
> we get hdev in snd_hdac_ext_bus_device_init() to use one preallocated
> with devm_kzalloc(), however it still left kfree(hdev) in
> snd_hdac_ext_bus_device_exit(). It leads to oopses when trying to
> rmmod and modprobe. Fix it, by just removing kfree call.
> 
> SOF also uses some of the snd_hdac_ functions for HDAudio support but
> allocated the memory with kzalloc. A matching fix is provided
> separately to align all users of the snd_hdac_ library.

There are stability issues with this change (already shared in a 
separate series) and additional findings reported by Libin so this 
should not be applied for now.

> 
> Fixes: 6298542fa33b ("ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init")
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/hda/ext/hdac_ext_bus.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
> index c203af71a099..f33ba58b753c 100644
> --- a/sound/hda/ext/hdac_ext_bus.c
> +++ b/sound/hda/ext/hdac_ext_bus.c
> @@ -170,7 +170,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
>   void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
>   {
>   	snd_hdac_device_exit(hdev);
> -	kfree(hdev);
>   }
>   EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
>   
> 

