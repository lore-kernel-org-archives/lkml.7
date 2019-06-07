Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E163BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2E2208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfFGUIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:08:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:45809 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfFGUIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:08:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 13:08:46 -0700
X-ExtLoop1: 1
Received: from sbreyer-mobl.amr.corp.intel.com (HELO [10.252.201.95]) ([10.252.201.95])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2019 13:08:45 -0700
Subject: Re: [alsa-devel] next/master boot bisection: next-20190528 on
 sun8i-h3-libretech-all-h3-cc
To:     Mark Brown <broonie@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        tomeu.vizoso@collabora.com, mgalka@collabora.com,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org
References: <5cef9f66.1c69fb81.39f30.21e8@mx.google.com>
 <s5hr28gszvj.wl-tiwai@suse.de>
 <8ca25787-fc03-7942-0705-3ec7d88862a6@collabora.com>
 <20190607190021.GK2456@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6959db6d-1ab4-8f94-7e58-57606b8b42f6@linux.intel.com>
Date:   Fri, 7 Jun 2019 15:08:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607190021.GK2456@sirena.org.uk>
Content-Type: multipart/mixed;
 boundary="------------00ECFFF18126FC8F2B9D28E7"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------00ECFFF18126FC8F2B9D28E7
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/19 2:00 PM, Mark Brown wrote:
> On Fri, Jun 07, 2019 at 05:31:12PM +0100, Guillaume Tucker wrote:
>> On 30/05/2019 16:53, Takashi Iwai wrote:
> 
>>>> +	mutex_lock(&client_mutex);
>>>>   	for_each_rtdcom(rtd, rtdcom) {
>>>>   		component = rtdcom->component;
>>>>   
>>>>   		if (component->driver->remove_order == order)
>>>>   			soc_remove_component(component);
>>>>   	}
>>>> +	mutex_unlock(&client_mutex);
> 
>>> Ranjani, which code path your patch tries to address?  Maybe better to
>>> wrap client_mutex() in the caller side like snd_soc_unbind_card()?
> 
>> Is anyone looking into this issue?
> 
>> It is still occurring in next-20190606, there was a bisection
>> today which landed on the same commit.  There just hasn't been
>> any new bisection reports because they have been temporarily
>> disabled while we fix some issues on kernelci.org.
> 
> I was expecting that Ranjani or one of the other Intel people was
> looking into it...

Ack. We've all been underwater this week and this wasn't addressed, 
sorry about the delay. It's probably wise to revert this commit at this 
point while we look for an alternate solution?

There was an initial proposal submitted on GitHub [1] (patch attached) 
which implemented what Takashi suggested in his comments. This proposal 
was later optimized further, it could be that the optimization was one 
bridge too far.

Could you let us know if this attached patch has any negative effects on 
non-Intel platforms?

Thanks!

[1] 
https://github.com/thesofproject/linux/commit/9fd09dd417bc8be7a4a8bdd1621558151f8d117b

--------------00ECFFF18126FC8F2B9D28E7
Content-Type: text/x-patch;
 name="9fd09dd417bc8be7a4a8bdd1621558151f8d117b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="9fd09dd417bc8be7a4a8bdd1621558151f8d117b.patch"

From 9fd09dd417bc8be7a4a8bdd1621558151f8d117b Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 22 May 2019 10:52:40 -0700
Subject: [PATCH] ASoC: core: lock client_mutex while removing link components

Removing link components results in topology unloading. So,
acquire the client_mutex before removing components in
snd_soc_unbind_card(). This will prevent lockdep warning
when the dai link is removed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2403bec2fccf3..5609398f05d80 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2839,12 +2839,14 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
 
+		mutex_lock(&client_mutex);
 		/* remove all components used by DAI links on this card */
 		for_each_comp_order(order) {
 			for_each_card_rtds(card, rtd) {
 				soc_remove_link_components(card, rtd, order);
 			}
 		}
+		mutex_unlock(&client_mutex);
 
 		soc_cleanup_card_resources(card);
 		if (!unregister)

--------------00ECFFF18126FC8F2B9D28E7--
