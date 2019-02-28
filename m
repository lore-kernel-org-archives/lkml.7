Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71DEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFF720854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551380635;
	bh=Kv25OWi+4WhLFP/V0aE78wrgVvDQdEmz+UVIc4Ba5LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sBHVZ78khNDWLSljKxO1jb42uAxV7t2X4FxFN7KtXhhGEawTGeid6GxCChQhBfgz4
	 Os+nvw+TOWWFCqeOcxKT7I3E2DJz4YVYnEYu1Gp1bMN8a42AnXA22dyd3kjxMUKD45
	 djcoJqYoU4tYUgaHLJS9nN5oCoBZU+0MnGmzXqYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfB1TDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:03:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43973 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfB1TDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:03:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so17380532oib.10;
        Thu, 28 Feb 2019 11:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nncXU8MRTUbQGjl38s597Vx3RAfDTyhiOX13TTwf4Yk=;
        b=Ie7pM3Cudxa1zAHEwGlD1jqfADDjBBwKTyMCdVv2qhIELAhvCMeyFkxsgvTO4Tn+7L
         Ts50h2qBUAfv0F/1EAwJYhiF8AR29ry873ppXNhWjkn7vpnAN7is+fI9UZr2YKdQ3WPh
         8lM8tUkvqBSf8/uiAYA41GOaSyZTUHnosq6JUDW3Lg/Ds1S9XC0ggqrM+pBKCuySHC+I
         dpwRztWMdT9KfR1X886z/TUxYJ2hpthxNNI9f4OvZ+ENQjDTi4iwdL4UCXNH8ZVuoi3X
         vmSr4BJQoYJ7YRRh2k0xQF0cBN8NHAcNdgFhbNrbOKM3yber1zSLghWVlzQPEaik66Nj
         /XPQ==
X-Gm-Message-State: AHQUAubM0DYqE5lmOzgSx5haR8rVgGSaMP60+N5/qi6isICIWq5RroHi
        ihAiu61nPlhVxkYJcJHxfQ==
X-Google-Smtp-Source: AHgI3Ia//2XmLvVkLu74CgR//hIsn9GYAM7rZ3GbDsudzIYqDcFojkBHNTPSRxltNerl8a9D0uWI6w==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr835281oia.18.1551380632638;
        Thu, 28 Feb 2019 11:03:52 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id t12sm7691514otk.16.2019.02.28.11.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:03:52 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:03:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 3/5] nvmem: sunxi-sid: add binding for H6's SID controller
Message-ID: <20190228190351.GA11970@bogus>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-4-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217162316.14111-4-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 11:23:14 -0500, Yangtao Li wrote:
> Add a binding for H6's SID controller.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
