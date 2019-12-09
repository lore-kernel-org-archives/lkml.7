Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FE0C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE1520663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTlJj55q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLINOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:14:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:14:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so16086495wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bUge0ixzIJRgOEK4iKWBzjpSBLc6dnY7S7okAx0uGz8=;
        b=eTlJj55q92MdmXGG5b5fw8Yo2s9Q3sY+dgu3HtIdFiBgV2x85n/fFmfTbIf6/KZCnu
         HrMTtNfuZUWYwEyPkuojxYzefEKYC30RBLsCcSFdRRHKso1OV3K2AEXDNfgvrCke8hzZ
         GklsGKd84+URKyQZuIEDN8Nm2r/j15FkaRKZ2p5bVosl3pg176UUQH89Of67BxNMb0fS
         p0DyQnyTdpjUR2VF1vTJOh+q9wJ6v8m31DLluno4YFJKmq6Kp4Npd13h3cRk9ds2ofJR
         8qoPf4PnjT1jWj/me+W0jgPhzK/ZKu3w/v+pPhTMS4Uvli79Dxd0nyGNJi157BL55XcJ
         LhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bUge0ixzIJRgOEK4iKWBzjpSBLc6dnY7S7okAx0uGz8=;
        b=Z7LpoGse7cLpHkOv7mBx4oYL5YC9doJHEfM6hok7NKvBdkHZu8E59mKaHVWXdqP8cX
         naM7dJp7mAhUQancpIPwaUFDzr1xaHexZ6aCcmk24rmPvNXiV1wdKF6peGurgOXGSbGe
         x8oWdcxSWEt/+WsYSSFk1OLI3wVbGEMAFKZKxFp9hucQtRU3j1K+Q7UHcN2LuM0cmH0b
         CoAd7qboXgLUadn9Td0I2rJ0Jif667e57xIqg3A3+DrQObZJ796I2anbpHS8NQafPbEh
         C2/K1CMD9eUow99U3UfQTsYJHzXAUhsPw/7SN9rDXl83kdLcJLyBip2YbNXrjssth5m3
         2SYA==
X-Gm-Message-State: APjAAAVOVGOEkSxODpoPRgEvt5knfnDuUzf0ox2l72mbuTFTL/tnhryr
        RZyQ91Jo9ypd2WqBFpaER38HKA==
X-Google-Smtp-Source: APXvYqyuDQs/8PwKHv6lyJB2pmU9NT7G6Fd4i2uvdeIPsNairHTdyAoKSaIMKujxKJRMXsz5a2NrTg==
X-Received: by 2002:a5d:5487:: with SMTP id h7mr2112222wrv.18.1575897238325;
        Mon, 09 Dec 2019 05:13:58 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id w17sm27593924wrt.89.2019.12.09.05.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:13:57 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:13:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: fix mismatches of request_mem_region
Message-ID: <20191209131352.GK3468@dell>
References: <20191116151308.17817-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191116151308.17817-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2019, Chuhong Yuan wrote:

> This driver misuses release_resource + kfree to match request_mem_region,
> which is incorrect.
> The right way is to use release_mem_region.
> Replace the mismatched calls with the right ones to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mfd/sm501.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
