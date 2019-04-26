Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49163C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192872077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfDZKKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:10:04 -0400
Received: from foss.arm.com ([217.140.101.70]:37878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDZKKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:10:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1CCA78;
        Fri, 26 Apr 2019 03:10:03 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BFF03F5AF;
        Fri, 26 Apr 2019 03:10:03 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 9FE37682411; Fri, 26 Apr 2019 11:10:01 +0100 (BST)
Date:   Fri, 26 Apr 2019 11:10:01 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Brian Starkey <brian.starkey@arm.com>, malidp@foss.arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/komeda: Use memset to initialize config_id
Message-ID: <20190426101001.GK15144@e110455-lin.cambridge.arm.com>
References: <20190425062720.26695-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425062720.26695-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:27:20PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:76:38: warning: suggest
> braces around initialization of subobject [-Wmissing-braces]
>         union komeda_config_id config_id = {0,};
>                                             ^
>                                             {}
> 1 warning generated.
> 
> One way to fix these warnings is to add additional braces like Clang
> suggests; however, there has been a bit of push back from some
> maintainers, who just prefer memset as it is unambiguous, doesn't
> depend on a particular compiler version, and properly initializes all
> subobjects [1][2]. Do that here so there are no more warnings.
> 
> [1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
> [2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
> 
> Fixes: 4cc734cb79a8 ("drm/komeda: Add sysfs attribute: core_id and config_id")
> Link: https://github.com/ClangBuiltLinux/linux/issues/457
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I'll pull the patch into my tree today.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 9d6c31cca875..e605a518f59a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -73,9 +73,10 @@ config_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct komeda_dev *mdev = dev_to_mdev(dev);
>  	struct komeda_pipeline *pipe = mdev->pipelines[0];
> -	union komeda_config_id config_id = {0,};
> +	union komeda_config_id config_id;
>  	int i;
>  
> +	memset(&config_id, 0, sizeof(config_id));
>  	config_id.max_line_sz = pipe->layers[0]->hsize_in.end;
>  	config_id.n_pipelines = mdev->n_pipelines;
>  	config_id.n_scalers = pipe->n_scalers;
> -- 
> 2.21.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
