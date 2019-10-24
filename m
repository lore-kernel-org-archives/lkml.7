Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35315CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E5A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571916602;
	bh=kQFBcxNmjHibeaxCaSYIXnvQiiyNhH2RsaW0IcDrCyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=obeWMVe5jQiC2vz69raiMgzPqT8dl90I+fgyomYHuyBW96PmMLfa5fAUTa4JA61GF
	 sH9lwrlTpZEAkw0Qi7mjWhCuSZTJmcr46PZQ9jg4AoZW8V/hvgaa+3elz3LZFZAFKy
	 I/Xe5lsKjec/JFgAHq3UdgzcU8cmpmOLM4bd0B2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439011AbfJXLaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439001AbfJXLaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:30:00 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D021620856;
        Thu, 24 Oct 2019 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571916599;
        bh=kQFBcxNmjHibeaxCaSYIXnvQiiyNhH2RsaW0IcDrCyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWARDvzBYDMGrGirwmA5/ugE7yPufb1g6YtyMnTGSO9xqY3IL4LqVWeT++Isa8T1q
         q6bNcCn2We5sUloFHsyL8wCHoyvC+EkUvTHt1TuOM3b6nVhtUsu1smBRvqsayBRUs4
         g5kBHMQshA1kJsY7cfkNZguhIAXNei3og/3I2nnQ=
Date:   Thu, 24 Oct 2019 16:59:55 +0530
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
Subject: Re: [PATCH 1/3] soundwire: remove bitfield for unique_id, use u8
Message-ID: <20191024112955.GC2620@vkoul-mobl>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
 <20191022234808.17432-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022234808.17432-2-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:48, Pierre-Louis Bossart wrote:
> There is no good reason why the unique_id needs to be stored as 4
> bits. The code will work without changes with a u8 since all values

Well this was due to the fact the slave id defined by MIPI has unique id
as 4 bits. In fact if you look closely there are other fields in
sdw_slave_id doing this

> are already filtered while parsing the ACPI tables and Slave devID
> registers.
> 
> Use u8 representation. This will allow us to encode a
> "IGNORE_UNIQUE_ID" value to account for firmware/BIOS creativity.

Why are we shoving firmware/BIOS issues into the core?

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 688b40e65c89..28745b9ba279 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -403,6 +403,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave);
>   * SDW Slave Structures and APIs
>   */
>  
> +#define SDW_IGNORED_UNIQUE_ID 0xFF
> +
>  /**
>   * struct sdw_slave_id - Slave ID
>   * @mfg_id: MIPI Manufacturer ID
> @@ -418,7 +420,7 @@ struct sdw_slave_id {
>  	__u16 mfg_id;
>  	__u16 part_id;
>  	__u8 class_id;
> -	__u8 unique_id:4;
> +	__u8 unique_id;
>  	__u8 sdw_version:4;
>  };
>  
> -- 
> 2.20.1

-- 
~Vinod
