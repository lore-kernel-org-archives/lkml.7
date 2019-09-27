Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D65C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424A92146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfI0PK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:10:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:21776 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfI0PK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:10:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="219808427"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.6.245]) ([10.252.6.245])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2019 08:10:20 -0700
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: prevent memory leak in
 snd_skl_parse_uuids
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
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
 <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <6966df25-e82c-1abe-6a0f-ff497dcda23b@intel.com>
Date:   Fri, 27 Sep 2019 17:10:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-27 15:14, Pierre-Louis Bossart wrote:
> On 9/26/19 9:55 PM, Navid Emamdoost wrote:
>> On Wed, Sep 25, 2019 at 12:05:28PM -0500, Pierre-Louis Bossart wrote:
>>> On 9/25/19 11:19 AM, Navid Emamdoost wrote:
>>>> In snd_skl_parse_uuids if allocation for module->instance_id fails, the
>>>> allocated memory for module shoulde be released. I changes the
>>>> allocation for module to use devm_kzalloc to be resource_managed
>>>> allocation and avoid the release in error path.
>>>
>>> if you use devm_, don't you need to fix the error path as well then, 
>>> I see a
>>> kfree(uuid) in skl_freeup_uuid_list().
>>>
>>> I am not very familiar with this code but the error seems to be that the
>>> list_add_tail() is called after the module->instance_id is allocated, so
>>> there is a risk that the module allocated earlier is not freed (since 
>>> it's
>>> not yet added to the list). Freeing the module as done in patch 1 works,
>>> using devm_ without fixing the error path does not seem correct to me.
>>>

Good catch, Pierre.

>> Thanks for the feedback, then it's your call if you can accept patch 1 as
>> fix.
> 
> Cezary, it's really your call.
> 

Actually, not the best person to ask about "objective decisions" here as 
my vision is clouded by changes done internally. This code no longer 
exists in our internal repo. It's better for host to send MODULE_INFO 
request rather than understanding firmware binary structure and parse it 
directly.

I'm fine with solution #1 as I guess asking to wait for refactor is not 
an option. Code deployment is delayed due to range of administrative 
decisions, some of which should be uncovered on alsa-devel soon enough.

Czarek
