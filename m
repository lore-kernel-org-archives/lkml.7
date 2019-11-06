Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC9BC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55E21882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfKFTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:30:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:12634 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfKFTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:30:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="205931904"
Received: from rbidasar-mobl.amr.corp.intel.com (HELO [10.251.0.251]) ([10.251.0.251])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2019 11:30:27 -0800
Subject: Re: [alsa-devel] [PATCH 0/3] soundwire: use UniqueID only when
 relevant
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <caa9b0cb-ea85-e7de-6ada-35ad906dec28@linux.intel.com>
Date:   Wed, 6 Nov 2019 13:30:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/19 6:48 PM, Pierre-Louis Bossart wrote:
> The hardware UniqueID, typically enabled with pin-strapping, is
> required during enumeration to avoid conflicts between devices of the
> same type.
> 
> When there are no devices of the same type, using the UniqueID is
> overkill and results in a lot of probe errors due to mismatches
> between ACPI tables and hardware capabilities. For example it's not
> uncommon for BIOS vendors to copy/paste the same settings between
> platforms but the hardware pin-strapping is different. This is
> perfectly legit and permitted by MIPI specs.
> 
> With this patchset, the UniqueID is only used when multiple devices of
> the same type are detected. The loop to detect multiple identical
> devices is not super efficient but with typically fewer than 4 devices
> per link there's no real incentive to be smarter.
> 
> This change is only implemented for ACPI platforms, for DeviceTree
> there is no change.

Vinod, this series has been submitted for review on October 22 and I 
answered to your questions. There's been no feedback since October 24, 
so is there any sustained objection here?

ACPI platforms are completely unmanageable without this patchset.

> 
> Pierre-Louis Bossart (3):
>    soundwire: remove bitfield for unique_id, use u8
>    soundwire: slave: add helper to extract slave ID
>    soundwire: ignore uniqueID when irrelevant
> 
>   drivers/soundwire/bus.c       |  7 +--
>   drivers/soundwire/slave.c     | 98 +++++++++++++++++++++++++++--------
>   include/linux/soundwire/sdw.h |  4 +-
>   3 files changed, 84 insertions(+), 25 deletions(-)
> 
