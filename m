Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CCFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8E52075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfI0WZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:25:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:43622 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfI0WZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:25:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 15:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="219948342"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2019 15:25:40 -0700
Received: from jastaffa-mobl3.amr.corp.intel.com (unknown [10.251.18.83])
        by linux.intel.com (Postfix) with ESMTP id 23629580127;
        Fri, 27 Sep 2019 15:25:39 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: Skylake: prevent memory leak
 in snd_skl_parse_uuids
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Enrico Weigelt <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>
References: <20190925161922.22479-1-navid.emamdoost@gmail.com>
 <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com>
 <20190927025526.GD22969@cs-dulles.cs.umn.edu>
 <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com>
 <6966df25-e82c-1abe-6a0f-ff497dcda23b@intel.com>
 <20190927153304.GS32742@smile.fi.intel.com>
 <2e8ef4df-9c5f-f6e0-23ee-32d3bc555330@linux.intel.com>
 <CAHp75Veung3v41RMmBoQHE7TFWUccE2oXsVnNgUt0JE0naTfLw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3428d5e2-3246-7e1c-cb4d-59351193e4de@linux.intel.com>
Date:   Fri, 27 Sep 2019 17:25:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Veung3v41RMmBoQHE7TFWUccE2oXsVnNgUt0JE0naTfLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/19 3:39 PM, Andy Shevchenko wrote:
> On Fri, Sep 27, 2019 at 7:39 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>> The problem with solution #1 is freeing orphaned pointer. It will work,
>>> but it's simple is not okay from object life time prospective.
>>
>> ?? I don't get your point at all Andy.
>> Two allocations happens in a loop and if the second fails, you free the
>> first and then jump to free everything allocated in the previous
>> iterations. what am I missing?
> 
> Two things:
>   - one allocation is done with kzalloc(), while the other one with
> devm_kcalloc()
>   - due to above the ordering of resources is reversed

Ah yes, I see your point now, sorry for being thick.
Indeed it'd make sense to use devm_ for both allocations, but then the 
kfree needs to be removed in the error handling.

