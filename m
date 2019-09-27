Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE1C21850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfI0NOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:14:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:10968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfI0NOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:14:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 06:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="183972918"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2019 06:13:59 -0700
Received: from jastaffa-mobl3.amr.corp.intel.com (unknown [10.251.18.83])
        by linux.intel.com (Postfix) with ESMTP id 661845801E6;
        Fri, 27 Sep 2019 06:13:58 -0700 (PDT)
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: prevent memory leak in
 snd_skl_parse_uuids
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190925161922.22479-1-navid.emamdoost@gmail.com>
 <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com>
 <20190927025526.GD22969@cs-dulles.cs.umn.edu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com>
Date:   Fri, 27 Sep 2019 08:14:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190927025526.GD22969@cs-dulles.cs.umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 9:55 PM, Navid Emamdoost wrote:
> On Wed, Sep 25, 2019 at 12:05:28PM -0500, Pierre-Louis Bossart wrote:
>> On 9/25/19 11:19 AM, Navid Emamdoost wrote:
>>> In snd_skl_parse_uuids if allocation for module->instance_id fails, the
>>> allocated memory for module shoulde be released. I changes the
>>> allocation for module to use devm_kzalloc to be resource_managed
>>> allocation and avoid the release in error path.
>>
>> if you use devm_, don't you need to fix the error path as well then, I see a
>> kfree(uuid) in skl_freeup_uuid_list().
>>
>> I am not very familiar with this code but the error seems to be that the
>> list_add_tail() is called after the module->instance_id is allocated, so
>> there is a risk that the module allocated earlier is not freed (since it's
>> not yet added to the list). Freeing the module as done in patch 1 works,
>> using devm_ without fixing the error path does not seem correct to me.
>>
> Thanks for the feedback, then it's your call if you can accept patch 1 as
> fix.

Cezary, it's really your call.

> Navid.
>>>
>>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>>> ---
>>> Changes in v2:
>>> 	- Changed the allocation for module from kzalloc to devm_kzalloc
>>> ---
>>>    sound/soc/intel/skylake/skl-sst-utils.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
>>> index d43cbf4a71ef..ac37f04b0eea 100644
>>> --- a/sound/soc/intel/skylake/skl-sst-utils.c
>>> +++ b/sound/soc/intel/skylake/skl-sst-utils.c
>>> @@ -284,7 +284,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>>>    	 */
>>>    	for (i = 0; i < num_entry; i++, mod_entry++) {
>>> -		module = kzalloc(sizeof(*module), GFP_KERNEL);
>>> +		module = devm_kzalloc(ctx->dev, sizeof(*module), GFP_KERNEL);
>>>    		if (!module) {
>>>    			ret = -ENOMEM;
>>>    			goto free_uuid_list;
>>>
>>

