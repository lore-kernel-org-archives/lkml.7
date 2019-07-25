Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C2B22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564066159;
	bh=w2m48S5hBD6xMNgWFaIjnAEL4n6W/YAcLr/Tg/RrQBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZpawaVdhafvcta8V9jyP1zMhBT2NbcYMyXLEYwcTyDyNkP8gQslmktNxBNDgVZtV
	 wwvKC9E5PWphVQOrKbZ8TdQZiWE6twtpU11ZBQBv//BO2qp6NFH6sdF8o6fFJ1MprL
	 egaotmociCtSHb0F3TQEMdcW5AcBUpHNBTUKlv7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfGYOtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfGYOtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:49:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14462229F9;
        Thu, 25 Jul 2019 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564066156;
        bh=w2m48S5hBD6xMNgWFaIjnAEL4n6W/YAcLr/Tg/RrQBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FS8YW7aAsciXRty67KBaUlHnGuFwkgHhA5ojo57vz4fDy2cMTKVn4PZrg4EjtPIuG
         rlCAZrpvqsB6mFSORv9pg1XxuKHlRA76nriRktFLnpyTSXEMORpvGIqLceW15oD6zj
         F6DQqWrpoeGqmXP3amThU978Ja3e1S4R5Ryuseok=
Date:   Thu, 25 Jul 2019 16:49:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     eric@anholt.net, wahrenst@gmx.net, inf.braun@fau.de,
        nishkadg.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] staging: vc04_services: fix used-but-set-variable
 warning
Message-ID: <20190725144913.GC29688@kroah.com>
References: <20190725142716.49276-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725142716.49276-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:27:16PM +0800, YueHaibing wrote:
> use variables 'local_entity_uc' and 'local_uc',
> mute gcc used-but-set-variable warning:
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_release_internal:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:16: warning:
>  variable local_entity_uc set but not used [-Wunused-but-set-variable]
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:6: warning:
>  variable local_uc set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index cc4383d..04e6427 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -2861,15 +2861,13 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
>  		} else {
>  			vchiq_log_info(vchiq_susp_log_level,
>  				"%s %s count %d, state count %d - suspending",
> -				__func__, entity, *entity_uc,
> -				arm_state->videocore_use_count);
> +				__func__, entity, local_entity_uc, local_uc);
>  			vchiq_arm_vcsuspend(state);
>  		}
>  	} else
>  		vchiq_log_trace(vchiq_susp_log_level,
>  			"%s %s count %d, state count %d",
> -			__func__, entity, *entity_uc,
> -			arm_state->videocore_use_count);
> +			__func__, entity, local_entity_uc, local_uc);

Are you sure this is the correct way to solve this?

Why not just remove the local variables instead, as obviously they are
not being used.

thanks,

greg k-h
