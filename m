Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A85222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633174AbfJYQ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:57:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:15672 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633153AbfJYQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:57:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 09:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="373604667"
Received: from davidpat-mobl2.amr.corp.intel.com (HELO [10.251.153.16]) ([10.251.153.16])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2019 09:57:27 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level function
 for rt5514
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        "M, Naveen" <naveen.m@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
References: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
 <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C740320822@PGSMSX108.gar.corp.intel.com>
 <219281e5-d685-d584-0d22-5dcf3ca2bec2@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C74032096B@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <618b3202-6418-a7e2-9b8e-bc32c01d46ed@linux.intel.com>
Date:   Fri, 25 Oct 2019 11:57:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C74032096B@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/19 11:14 AM, Lu, Brent wrote:
>>
>> Can you clarify if the rt5514 needs the MCLK while it's doing the hotword
>> detection?
> 
> No, running the detection does not raise the bias level so the set_bias_level
> will not be called. The mclk is only turned on then off in mixer control's handler
> (rt5514_dsp_voice_wake_up_put) when enabling the hotword detection.
> 
>>
>> My point is really that this patch uses a card-level BIAS indication, and I'd like
>> to make sure this does not interfere with the audio DSP being in D3 state.
> 
> The function checks the name of dapm so it would only react when rt5514's
> bias level is changing. And also the idle_bias_off of the codec driver is true so
> it's target_bias_level should not be overwritten in the dapm_power_widgets()
> function. The behavior should be similar to the previous patch which is using
> supply widget.

Ah yes, I did miss this test:

+	if (!component || strcmp(component->name, RT5514_DEV_NAME))
+		return 0;

Looks good then, thanks for the explanations.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

