Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D52C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F82229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563903351;
	bh=noiU6lM13BMn93GA7u05D8lHjwROo/10pxVPsqKRAkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RPb288IWhfgUQ9rLJx4fTwojky4nqgH1MMGtkhTVdqHlWaaqiSuZsy1WwTcyvhlPB
	 G/LTM071VX/BzYxgNr6jjB/d72ixOssUuTHc08l+GytCOeR7DUUUngE2LInVM0/8zx
	 Y82OnwMuM1Rvk+HbdrLwQd812hDlPCMhfyTA1Rz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbfGWRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:35:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40175 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGWRfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:35:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so44065819wrl.7;
        Tue, 23 Jul 2019 10:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/qtNInPFRXJcLW+6umq8SHhA21s/sA6yHGFTcHNFQo=;
        b=X4YthXn/lTgcWXBoeeOSlddiDqGppTe7scCSZopD37KfDZdv2efIvpQb6YLyui00vH
         LE8EZpYw56ee+w/9CYis0vKsDFHdh1bGg/KuhRRRnW3XBsQiw4l3LFAfkRFXCvw4yZbZ
         ar5tkDY8RmgGkrBPGMhwPwuelLY5pPagwWZ2sD8U+Yvzy5iCaqqPf0tYSdfoWLLXvpXA
         NOlN/eiS/aMKZZynt2SeGAa3coWQPFSfKH4zXgFNV7d/ZR3dGpX/n6SGG6Hy3Hi3R+MY
         bgXKQXijTm3lpjrW6VKPAGhntEuCnT1fzmYFSmHgp/w68+UqA0Ye1xbNqOff9XJM3ZpV
         Lxmg==
X-Gm-Message-State: APjAAAVmEKZkTYs2Sr5BpQYX2u0eDi9/o6jBSpF6/BDBZPfoTdarKncC
        TDiQTwdmR6fPy0mgwADtN70=
X-Google-Smtp-Source: APXvYqzOeRQwpwUPyc0B1ttNjWB9N0I5o/Kf0fCyMHdbnJo/wb/mQLG1PQaGDs2nwWSrUbt8xYhZYg==
X-Received: by 2002:adf:f544:: with SMTP id j4mr83027145wrp.150.1563903348044;
        Tue, 23 Jul 2019 10:35:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id c30sm75496676wrb.15.2019.07.23.10.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 10:35:47 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:35:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] mfd: max77693: convert to i2c_new_dummy_device
Message-ID: <20190723173545.GB6317@kozik-lap>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-8-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722172623.4166-8-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 07:26:14PM +0200, Wolfram Sang wrote:
> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/max77693.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

