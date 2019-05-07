Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC49C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620CA206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEGB6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:58:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:7351 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEGB6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:58:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 18:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,440,1549958400"; 
   d="scan'208";a="149039980"
Received: from speesari-mobl.amr.corp.intel.com (HELO [10.251.22.59]) ([10.251.22.59])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2019 18:58:21 -0700
Subject: Re: [PATCH 2/8] soundwire: mipi_disco: fix master/link error
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-3-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <42f30108-6870-d97b-7766-ce7a7f17ccf8@linux.intel.com>
Date:   Mon, 6 May 2019 20:58:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504002926.28815-3-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/19 7:29 PM, Pierre-Louis Bossart wrote:
> The MIPI DisCo specification for SoundWire defines the
> "mipi-sdw-link-N-subproperties", not the master-N properties. Fix to
> parse firmware information.

Please ignore this patch for now, there is a confusion in the spec 
itself that needs to be addressed by MIPI... Either there will be an 
errata issued, or we'll have to try both master- and link-N-properties 
to reconcile spec and actual implementations.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/mipi_disco.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index c1f51d6a23d2..6df68584c963 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -40,7 +40,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
>   
>   	/* Find master handle */
>   	snprintf(name, sizeof(name),
> -		 "mipi-sdw-master-%d-subproperties", bus->link_id);
> +		 "mipi-sdw-link-%d-subproperties", bus->link_id);
>   
>   	link = device_get_named_child_node(bus->dev, name);
>   	if (!link) {
> 
