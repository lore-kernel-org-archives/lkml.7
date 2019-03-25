Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D7BC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfCYNSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:18:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:14755 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbfCYNSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="217355751"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2019 06:18:06 -0700
Received: from cknaussx-mobl2.amr.corp.intel.com (cknaussx-mobl2.amr.corp.intel.com [10.254.185.157])
        by linux.intel.com (Postfix) with ESMTP id 639FE58011C;
        Mon, 25 Mar 2019 06:18:05 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b6d2bdc5-d0e8-dee7-52be-fa7f3a36fa9f@linux.intel.com>
Date:   Mon, 25 Mar 2019 09:18:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325121232.GF7284@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 8:12 AM, Mark Brown wrote:
> On Sat, Mar 23, 2019 at 09:55:46AM -0400, Pierre-Louis Bossart wrote:
> 
>> I'd like to highlight that there is a fundamental flaw in the way the
>> machine drivers are handled. Since we don't have a hook for the machine
>> driver in the BIOS, the DSP driver creates a platform_device which will
>> instantiate the machine driver. When errors happen in the machine driver
>> probe, they are suppressed due to a 'feature' of the device model, so you
>> can end-up with a broken configuration that is still reported as a
>> successful strobe.
> 
> These are driver specific issues not device model issues as far as I can
> see?  The issue fixed by this as is that you're storing a pointer in the
> ASoC level (not device model level) probe that you don't free when the
> component is unbound, causing you to dereference it later during
> suspend.  There is absolutely no problem with the machine driver not
> being guaranteed to bind at the time it's initially registered, that's
> perfectly normal and should cause no problems.

Agree, what I was referring is that if the machine probe and card 
registration fails (not just deferred), the parent acpi/pci driver isn't 
notified - there is just no means to provide that information and that 
leads to all kinds of configuration issues.
