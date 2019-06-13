Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD66C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C635A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="kLaRA7AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfFMPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:17:07 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33519 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbfFMNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:23:18 -0400
Received: by mail-yb1-f193.google.com with SMTP id h17so3034588ybm.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2bYrhwljlJiLsRXLwerBDD4QlmICRm9Vh/5gWlUBlk=;
        b=kLaRA7ADCVziNcQ5xyT8ZkcaFSjEOmx1+mMkQmrZmMrT7Yai8fpQswRzXPqg5aSlLM
         hP1Gvwr8s5PNeI67HGGSgfTyuYs1cHY3fRCOzzjCfWsy6qdzXb7T1YhiFI5ql0SACW0N
         ooQ1zDmRWhl3sCrKr5at+usUvQztNIQsEsp8owbn1subrhfw20uZdu+dDq3YijvzPn5r
         Fz67MTiqskYjLu9k3cxC8yElqPEDVdy4ZBMYODEoLQBXzZSLceoiQkis/gIIreuZj48u
         lyley80Es+2RAy79j4pn7j7v+EpBTtKYPkoj9emJLjidRY50WheQWrfRL0z4M7GQ8jlQ
         mDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2bYrhwljlJiLsRXLwerBDD4QlmICRm9Vh/5gWlUBlk=;
        b=L70k4/darQjCt9QuqkDISvHCdENRaHea3LLea5BVTdkfyLLrMF2ghB1C1ZpCP3EMmi
         BAAeLt06CiUw9/QDiQzXFrVP+AoFkjtiFdvNOazWZ2T98qc036xlT/W0Wk+Ru0LHdshL
         krAsr74u8edm7w+5a19AoOk8J05dhDDoRGkf2p8ijv6F4L4n55OJ1YIJfep+cIN5uF5G
         FdGPuuGYD4R64+HJFZRoNUonllRbosYT2A+XqNOTSE/vpTyzQ6Xxvym9o/0uGjnFDE+s
         e2m4W1yC4/ZWdh19Pe1nNU1isHRa/WXProtsA/mvwPK3V/bcVprV/Rp2L0UfzgXI0Fq9
         GZzA==
X-Gm-Message-State: APjAAAU0bposGS0+tdTP9D5jnrVU4cntLXWgNcsEv2rikm/zs+Oixp5M
        uepG2cF2TP6vz1+9NEu/so7LSg==
X-Google-Smtp-Source: APXvYqwhOV2mRTVPLlJz1R6yR2FsD0maV5DS23FuJSwdVAzARRErIxfg5PsbQfiQvE0AmFXxz3tW4g==
X-Received: by 2002:a25:94b:: with SMTP id u11mr44890805ybm.227.1560432197282;
        Thu, 13 Jun 2019 06:23:17 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id 193sm751896ywd.100.2019.06.13.06.23.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:23:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:23:15 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com, logang@deltatee.com
Subject: Re: [PATCH] NTB: correct ntb_dev_ops and ntb_dev comment typos
Message-ID: <20190613132314.GB1572@kudzu.us>
References: <1556618669-2434-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556618669-2434-1-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:04:29PM +0800, Wesley Sheng wrote:
> The comment for ntb_dev_ops and ntb_dev incorrectly referred to
> ntb_ctx_ops and ntb_device.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Sorry for the delay.  The series is now in the ntb branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request.

Thanks,
Jon

> ---
>  include/linux/ntb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 56a92e3..604abc8 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -205,7 +205,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>  }
>  
>  /**
> - * struct ntb_ctx_ops - ntb device operations
> + * struct ntb_dev_ops - ntb device operations
>   * @port_number:	See ntb_port_number().
>   * @peer_port_count:	See ntb_peer_port_count().
>   * @peer_port_number:	See ntb_peer_port_number().
> @@ -404,7 +404,7 @@ struct ntb_client {
>  #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
>  
>  /**
> - * struct ntb_device - ntb device
> + * struct ntb_dev - ntb device
>   * @dev:		Linux device object.
>   * @pdev:		PCI device entry of the ntb.
>   * @topo:		Detected topology of the ntb.
> -- 
> 2.7.4
> 
