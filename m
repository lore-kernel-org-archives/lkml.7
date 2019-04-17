Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C972FC10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F352073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhX89wge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfDQAZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:25:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34394 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQAZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:25:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id k21so19250401otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GxR3SmFS2DcVKS+hsstqZ3ZTAvI5HeM5sdfZJFbMgY4=;
        b=xhX89wgeYbIU2PdBdm9sk7KpGcvCHL/B7aeauFFnbarVk5wmLIysny6Xp7i2UqD4En
         Utm85VzBmifQFCS8KYwTeqvRzaWnacdfg9EYr/pW3rug06xTfpNKrHOnhHZTQeqimbTI
         dX4XmY1XswjCDqaqMYrjC4EmwY/ztTGJwKYUFbnbdBeGglWIegEQPYq+MjpH/B6LgV6e
         JZnOm4/bLRC9LMVHDs3Mf0j97vXEBbF8vdoC0kS9FVTo2jyOGY01IBcpcgGftTzKaZxm
         hykKmFLbjtjRdPjzD2Kek4TT5PjYpht1/DNKuwG5cbea0BNyAwCp5URIP7BpxaC6Cnjq
         /VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxR3SmFS2DcVKS+hsstqZ3ZTAvI5HeM5sdfZJFbMgY4=;
        b=UoZSiTwtxvLAO+/6HzSIQ8ErGyFtJwMJOKIcaXmPTXzbCiw3WPckY63tAYqpOch1On
         YM5saJ76rVylmiV6BJUfWCPBIbjZJE8RsduFkYfltSXr3kK/Xbb4roPCFNat2crg8M3b
         IYVqvAPwmuPRjx2nwN8dbmLIcx9L/GAPwF5aUq54EnIwdnoFMnReAgSY5aWJLB3oVjMa
         X1GMYnYtag0qvJWbUprVynPdEh1xmIZGXTNa54TLhz8nksrRYoJd7N3XxioHQPB1utya
         K5pUhHHn+NJhKiDgENEy882fd/yzKgJbRuK2CwdFd+0IeNGqgLk09hv9ycpSprG08B4N
         JmnA==
X-Gm-Message-State: APjAAAX8aXFQv3cI7kvyNtNOAJiyoPz83cdA//hO4ERyzklNUp/yjRA+
        Tg1oim81r5rWySt2sOYXm+8rvtwMuuQYhg==
X-Google-Smtp-Source: APXvYqxqOCoacPNOuNGR1WYwHCtlfQDPF5qg0R0wz4E58SbEYKmEpu7s4dJvU7p8YDq/bdoh31xZgw==
X-Received: by 2002:a9d:3d03:: with SMTP id a3mr52367720otc.72.1555460753050;
        Tue, 16 Apr 2019 17:25:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id n16sm19944570oic.7.2019.04.16.17.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 17:25:51 -0700 (PDT)
Date:   Wed, 17 Apr 2019 08:25:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        olof@lixom.net, marc.w.gonzalez@free.fr, john.stultz@linaro.org,
        liwei213@huawei.com
Subject: Re: [PATCH] arm64: defconfig: Update UFSHCD for Hi3660 soc
Message-ID: <20190417002546.GC6202@leoy-ThinkPad-X240s>
References: <20190416170221.13764-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416170221.13764-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:02:21PM +0100, Valentin Schneider wrote:
> Commit 7ee7ef24d02d ("scsi: arm64: defconfig: enable configs for Hisilicon ufs")
> set 'CONFIG_SCSI_UFS_HISI=y', but the configs it depends
> on
> 
>   (CONFIG_SCSI_HFSHCD_PLATFORM && CONFIG_SCSI_UFSHCD)
> 
> were left to being built as modules.
> 
> Commit 1f4fa50dd48f ("arm64: defconfig: Regenerate for v4.20") "fixed"
> that by reverting to 'CONFIG_SCSI_UFS_HISI=m'.
> 
> Thing is, if the rootfs is stored in the on-board flash (which
> is the "canonical" way of doing things), we either need these drivers
> to be built-in, or we need to fiddle with an initramfs to access that
> flash and eventually load the modules installed over there.
> 
> The former is the easiest, do that.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2d9c39033c1a..32fb03503b0b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -222,10 +222,10 @@ CONFIG_BLK_DEV_SD=y
>  CONFIG_SCSI_SAS_ATA=y
>  CONFIG_SCSI_HISI_SAS=y
>  CONFIG_SCSI_HISI_SAS_PCI=y
> -CONFIG_SCSI_UFSHCD=m
> -CONFIG_SCSI_UFSHCD_PLATFORM=m
> +CONFIG_SCSI_UFSHCD=y
> +CONFIG_SCSI_UFSHCD_PLATFORM=y
>  CONFIG_SCSI_UFS_QCOM=m
> -CONFIG_SCSI_UFS_HISI=m
> +CONFIG_SCSI_UFS_HISI=y
>  CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_AHCI_PLATFORM=y
> --
> 2.20.1
> 
