Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE19ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7504021848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571336396;
	bh=9IeQx8knH1tFMmB9rxGcz4mGfurbSPnHhX8jXh08iWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WT70ln6BwIziYTcVr7VqV6jwVVMZmNZKgmwdTKsxnXTNwvH1cddK4tna5YQA8oLJ
	 M+aOkG3c7H32RGLpZqIc0TFwy7NjFlgqK0GShLD9HO3gcvRA6YCd3/xzj3vugBdFrc
	 9oEQv3r2gNKpaBexMZ5o7dKj7EJxUWFdyL1TMoUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503144AbfJQSTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:19:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44397 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441309AbfJQSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:19:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so2964890oie.11;
        Thu, 17 Oct 2019 11:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zNcXSWPABIjDXrH4hrGPpnuCzAwqGYL95ldA2v+tK9k=;
        b=ZgF2GXLk6FD8HXb9UOIJLZl3MguzoN3lNaCeONVIgYd0jfZCidHgDOiHhRrfXbKR+O
         4Ko78NDISmHMIw0JM1sQulbVbArK7uocWAY4VadPma11zneiurzum/Ambe9I0iylYohE
         LxwgsmZD/GbWdk0uulQN8CukCcNKhKeYtM5R44g15LDeaLhT77h+9Q7aD5COBVCmT4Gy
         Cr7Q+SbXV2d0NKiFOBKPQbLrBLgqs6dWwclDunL9XjwSW4lBT2aAbrOHBjjTTbusqWwV
         0rDKRs3sQYQo2e+92u9HGnyhWh34nymfNQo4lZmP0ygZaNMSdWYkpcGDhOHcM7ZAN3aH
         O3gA==
X-Gm-Message-State: APjAAAWEwkXnX3HOEwmUiMzeUL66o8uHgjbmUHdcgKi4c0rmekQuq1mW
        u6ppssmB1eh7vNKrk1dpiQ==
X-Google-Smtp-Source: APXvYqydJLeSRq37GvjaH17XR/hx71gYtkOaY+q7KmhiTJg1o1MDriVXA4tVPzT17sIi/ahclXwxeg==
X-Received: by 2002:aca:dcd6:: with SMTP id t205mr4447363oig.128.1571336392417;
        Thu, 17 Oct 2019 11:19:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e18sm694901oib.57.2019.10.17.11.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:19:51 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:19:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v3 2/8] dt-bindings: mmc: arasan: Update Documentation
 for the input clock
Message-ID: <20191017181951.GA6853@bogus>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
 <1571293310-92563-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571293310-92563-3-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 11:51:44 +0530, Manish Narani wrote:
> Add documentation for an optional input clock which is essentially used
> in sampling the input data coming from the card.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
