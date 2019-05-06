Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A03C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A38A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfEFPu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:50:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:23937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEFPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:50:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 08:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="155608363"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 08:50:54 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 2CC5158010A;
        Mon,  6 May 2019 08:50:53 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers
 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
To:     Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>,
        Nariman <narimantos@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jordy Ubink <jordyubink@hotmail.nl>, broonie@kernel.org,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-4-user@elitebook-localhost>
 <s5ha7g1l4oq.wl-tiwai@suse.de>
 <b9ea51f6-29fb-5ae8-607b-a047eba4bac0@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b8ced03c-4137-0be6-1c2b-705caba3bbc1@linux.intel.com>
Date:   Mon, 6 May 2019 10:50:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b9ea51f6-29fb-5ae8-607b-a047eba4bac0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 10:40 AM, Hans de Goede wrote:
> Hi,
> 
> On 05-05-19 09:51, Takashi Iwai wrote:
>> On Sat, 04 May 2019 17:16:52 +0200,
>> Nariman wrote:
>>>
>>> From: Jordy Ubink <jordyubink@hotmail.nl>
>>>
>>> The snprintf calls filling byt_rt5651_cpu_dai_name / 
>>> byt_rt5651_cpu_dai_name always fill them with the same string 
>>> (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers 
>>> around and making the cpu_dai_name / codec_dai_name point to this, 
>>> simply update the foo_dai_name pointers to directly point to a string 
>>> constant containing the desired string.
>>>
>>> Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
>>
>> If you submit a patch, please give your own sign-off as well as the
>> author's one, even if the patch is not written by you.  This is a
>> legal requirement.
> 
> Sorry, that is my bad, Nariman and the author authors of the patches
> are a group of students doing some kernel work for me and this is
> a warm-up assignment for them to get used to the kernel development
> process.
> 
> I forgot to point out to Nariman that since he is sending
> out the entire series for all 4 of them, he needs to add his
> S-o-b.

One suggestion for additional cleanups: can we try and remove all these 
static variables and move them to the context structure? It's been on my 
TODO list for a while.
