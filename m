Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211C8C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AFE208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxDpUxb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgAGOVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:21:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37237 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:21:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so41545918wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=azgP9PCCbsROjZ/Zv0Cietnsuop473LJEmV+uxcq2/Q=;
        b=NxDpUxb8VwIteetS34QYQv+7Ifm+Vgr/QSMt8l1vjZGmQHeyjDs0Im3CvXbP173MX9
         XCrDRyrfU6D1XY5Jm5Mju0iCP0LeFS74KyXXBpXBOspr8hxS9tCCAIGrnFKhk4y+jPqj
         lC2Bkt9HWBZEXiKSgTPtw8WPVQwS1VmCbmtKItgUsIsJSGesCjrKAG67F24pczDSIB4V
         88rS3U6NK7OwYSBH8vcxJ+PgMCiWjChWIKdvSySGU1n4H6aWakK7DLO8CQnA69kYX9sd
         Hvp68g5tkuUVY3IJBX2o/stx9jTlnp9zgIQUSiKLrOs5CjMnUBBvyfmImZuWhXAGMDBo
         epaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=azgP9PCCbsROjZ/Zv0Cietnsuop473LJEmV+uxcq2/Q=;
        b=ud+gEYeiNgI/Z0SGDytjqbGzLECupeIPupgjyJcLx9p1Lc7/Eh4jKbv3vqJPREGJim
         F2Zab/caBNBzwRmJBpsasZfuIQLZ8BrSoRtOJlKesjOiQIhph7nahxM+QT/zcbwagFgA
         Nn5bDVXbc6DkRBKHX2dPaE9MIgE7JHqJ2U30aJqRrDk0zfQih+k2CwX6/AzbGPdWA55+
         zsS1npbR8tC1krdB7BGeKFdp2wqFHE47REJm0/3Sq5HA3Gw5mP4C0XFxCMNoWWiRfzmt
         x9R5AgdV5hTB7UiEHjzfQdrCe0/psCsr4huxfrULrp8TLK6WuwuFSRH8lWLtIVN1pe7O
         SoFg==
X-Gm-Message-State: APjAAAUmnOWFY17JTa1tN3DiyEGbNSyUk4GT7J56SRmyTQ4OaVQM/2+l
        QMSmsD2P1H7kC1Gex/FcpHkVP21vfCA=
X-Google-Smtp-Source: APXvYqzNo1kOfNgyBHgzFUZVdegqI1QcWuFJbzR0+8/g+AShalBaRufT2SoZy1pZBCofT16eBQid4g==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr104817988wrw.255.1578406881664;
        Tue, 07 Jan 2020 06:21:21 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id a1sm27110377wmj.40.2020.01.07.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:21:21 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:21:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhengbin13@huawei.com
Subject: Re: [PATCH] mfd: tqmx86: remove set but not used variable 'i2c_ien'
Message-ID: <20200107142135.GL14821@dell>
References: <20200103120925.460-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103120925.460-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jan 2020, yu kuai wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/mfd/tqmx86.c: In function ‘tqmx86_probe’:
> drivers/mfd/tqmx86.c:161:29: warning: variable ‘i2c_ien’
> set but not used I[-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/mfd/tqmx86.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
