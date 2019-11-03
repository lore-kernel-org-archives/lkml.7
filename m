Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D52CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333A215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572756979;
	bh=LNDBIGrezfGTuxdh0E7VEudgND+qq4oiCQ1SZqWL0Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w6y6hOqR/GVLbsGeNCZouEIoIRcoe31R3qiaP6Zn/KlXJdGEzVj1FUH02TFbBZb4X
	 dJ2i4sZmj6phWIkXdW+Wy4/CxCBtmygUO0zli6q2R69JQiL1FmAAwdkSBVjJ6PJZZk
	 qX60d8ED766ckuOJADN2E4QjWaW36VxVYMhDhXUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKCE4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 00:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfKCE4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 00:56:17 -0400
Received: from localhost (unknown [106.206.115.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C7220848;
        Sun,  3 Nov 2019 04:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572756977;
        bh=LNDBIGrezfGTuxdh0E7VEudgND+qq4oiCQ1SZqWL0Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/I69N0+C9oVDKL7HN9+0fKDiBaDsDsasQC9P8sMi9jalbpYL7ZllA/HXhYQEdAvO
         0ZPXGRHtRXFtQwiI8I8JF3HBGupOzfho0vOE435xH/7PKZnc5LMJpDr0Z8JeGgFdPK
         +6K4W2ZUsZbnsyMgci6mMGOZ8nKizI7GbalGYUoc=
Date:   Sun, 3 Nov 2019 10:26:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/4] soundwire: sdw_slave: add new fields to track probe
 status
Message-ID: <20191103045604.GE2695@vkoul-mobl.Dlink>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
 <20191023210657.32440-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023210657.32440-2-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 16:06, Pierre-Louis Bossart wrote:
> Changes to the sdw_slave structure needed to solve race conditions on
> driver probe.

Can you please explain the race you have observed, it would be a very
useful to document it as well

> 
> The functionality is added in the next patch.

which one..?

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 688b40e65c89..a381a596212b 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -545,6 +545,10 @@ struct sdw_slave_ops {
>   * @node: node for bus list
>   * @port_ready: Port ready completion flag for each Slave port
>   * @dev_num: Device Number assigned by Bus
> + * @probed: boolean tracking driver state
> + * @probe_complete: completion utility to control potential races
> + * on startup between driver probe/initialization and SoundWire
> + * Slave state changes/imp-def interrupts
>   */
>  struct sdw_slave {
>  	struct sdw_slave_id id;
> @@ -559,6 +563,8 @@ struct sdw_slave {
>  	struct list_head node;
>  	struct completion *port_ready;
>  	u16 dev_num;
> +	bool probed;
> +	struct completion probe_complete;
>  };
>  
>  #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
> -- 
> 2.20.1

-- 
~Vinod
