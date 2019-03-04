Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4933320823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfCDKOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:14:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:15413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfCDKOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:14:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 02:14:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="151834657"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2019 02:14:04 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] log2: make is_power_of_2() integer constant expression when possible
In-Reply-To: <20190301122659.1776b678fadcc16c1fb2ab61@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190301125207.30973-1-jani.nikula@intel.com> <20190301122659.1776b678fadcc16c1fb2ab61@linux-foundation.org>
Date:   Mon, 04 Mar 2019 12:16:02 +0200
Message-ID: <875zszndwd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Mar 2019, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri,  1 Mar 2019 14:52:07 +0200 Jani Nikula <jani.nikula@intel.com> wrote:
>
>> While is_power_of_2() is an inline function and likely gets optimized
>> for compile time constant arguments, it still doesn't produce an integer
>> constant expression that could be used in, say, static data
>> initialization or case labels.
>
> hm, what code wants to do these things?
>
>> Make is_power_of_2() an integer constant expression when possible,
>> otherwise using the inline function to avoid multiple evaluation of the
>> parameter.
>
> Spose so.  But I fear that some gcc versions will get it right and
> others will mess it up.  While this patch is under test I think it
> would be best to also have at least one or two callsites which actually
> use the compile-time evaluation feature.  Possible?

I have some drm/i915 patches that have a local compile-time version of
IS_POWER_OF_2(). It'll take a while before they hit Linus' master. This
can wait.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
