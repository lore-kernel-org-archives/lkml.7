Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA275C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7D21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530748;
	bh=635nTB3JGNyeTsNhAP/UwHGSpw+mQhgz3JjN7DOqrZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aOdVDm3B2/dwuTIdjLBRLcBLf7tPhENp3i2D+hl4RRF6nETrnCtzuWuxxO+6O4QwX
	 7BHfrkwGEfVUG1W71ToP48NyjXzV2RtV/5d4WfOd3+4bIQqDu/nfJtNrPmQBRKshOY
	 nzooiZ4sIIElJj6aMkX8zbzOxBmhi0EFIj5SHVa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDFGFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:05:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38781 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:05:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so4174133plb.5;
        Fri, 05 Apr 2019 23:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhcz0Kw5HmPfyuSB9aMh96hh2s+Rqxh9TAlPXiFmBrw=;
        b=rOI2MA3Negx5mmOcBNx/lRWKE6ZqfC6PNxZqt+lGfqkk4qmbR1rP9X7+g6QV+HAgbe
         wOFB3S34/GSr14/WWuBXpcn5wBr3cU2Q6Qx5IcE0ZA7u/P9hOBBjgu/LZ319lpfQBua1
         BLrWKpIyFtTqnQFe/K42Llpcs8+9pmQ6qj7T/FTuAA5vhIxDTXl69y0HWIwEV+y762Tk
         xkOwcB+CyXSc76WM9/VIZEhJUBoQMNuR0ffKR082lW7Nt5vcLilBytjyrwIcnJwJTBbd
         fcvELhUY+ELhdTD+aruqQblyto/8lirwKUH9H/62Go+zPwt1/MPyTo3WH5gelX7ZW0A9
         Mrrg==
X-Gm-Message-State: APjAAAUBgbMTLq23znmqjBLDv6yQ1uQAbbOXH2Zy3Yt58LRznm3y1Slx
        vK/Hm3ewGsYWpRBPricd+w==
X-Google-Smtp-Source: APXvYqxm3HUgLnYeNzzDkQcMXvIUtGAgtNeOC7wFAhNKncXRtaaBWte8HT9Eq2yDsBpoRPv5w9CZKQ==
X-Received: by 2002:a17:902:87:: with SMTP id a7mr17187252pla.295.1554530746137;
        Fri, 05 Apr 2019 23:05:46 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id q77sm1761564pfi.45.2019.04.05.23.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:05:44 -0700 (PDT)
Message-ID: <5ca841b8.1c69fb81.48fee.6697@mx.google.com>
Date:   Sat, 06 Apr 2019 01:05:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Shih <pihsun@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/7] dt-bindings: Add binding for cros-ec-rpmsg.
References: <20190327051450.16222-1-pihsun@chromium.org>
 <20190327051450.16222-6-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327051450.16222-6-pihsun@chromium.org>
X-Mutt-References: <20190327051450.16222-6-pihsun@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 01:14:47PM +0800, Peter Shih wrote:
> From: Pi-Hsun Shih <pihsun@chromium.org>
> 
> Add a DT binding documentation for ChromeOS EC driver over rpmsg.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v6:
>  - No change.
> 
> Changes from v5:
>  - New patch.
> ---
>  Documentation/devicetree/bindings/mfd/cros-ec.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

