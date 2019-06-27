Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80197C48BDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5793F214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF0RLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:11:22 -0400
Received: from foss.arm.com ([217.140.110.172]:59128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0RLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:11:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6CC360;
        Thu, 27 Jun 2019 10:11:21 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0733F718;
        Thu, 27 Jun 2019 10:11:20 -0700 (PDT)
Subject: Re: [PATCH] EDAC: Fix global-out-of-bounds write when setting
 edac_mc_poll_msec
To:     Eiichi Tsukata <devel@etsukata.com>
References: <20190626054011.30044-1-devel@etsukata.com>
From:   James Morse <james.morse@arm.com>
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Message-ID: <ee91dd9d-e9ac-4fee-d7f2-152195995ecb@arm.com>
Date:   Thu, 27 Jun 2019 18:11:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626054011.30044-1-devel@etsukata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(CC: +Tony Luck.
 Original Patch: lore.kernel.org/r/20190626054011.30044-1-devel@etsukata.com )

On 26/06/2019 06:40, Eiichi Tsukata wrote:
> Commit 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2") assumes
> edac_mc_poll_msec to be unsigned long, but the type of the variable still
> remained as int. Setting edac_mc_poll_msec can trigger out-of-bounds
> write.

Thanks for catching this!


> Fix it by changing the type of edac_mc_poll_msec to unsigned int.

This means reverting more of 9da21b1509d8, but it also fixes signed/unsigned issues:
| root@debian-guest:/sys/module/edac_core/parameters# echo 4294967295 >  edac_mc_poll_msec
| root@debian-guest:/sys/module/edac_core/parameters# cat edac_mc_poll_msec
| -1
| root@debian-guest:/sys/module/edac_core/parameters# echo -1 > edac_mc_poll_msec
| -bash: echo: write error: Invalid argument


> The reason why this patch adopts unsigned int rather than unsigned long
> is msecs_to_jiffies() assumes arg to be unsigned int.

Ah, so the range is limited anyway.

It looks like it was switched to long to be consistent with edac_mc_workq_setup(), which
has since been removed in preference to msecs_to_jiffies().


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
