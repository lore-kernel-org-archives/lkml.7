Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674FBC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFC720650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571861505;
	bh=H9eFVhBOqGvUencmVa9iOo15cwZTwTUCUaSj5ffXdXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FpHkHlV+srC3mXz6Evfq2mQ4q1EVK1lpXs4oA+KU4F4h5eaV9Y4tGgpi70buN/Cux
	 tYQs3UzQ43ujf0MVP1Hzyg9Thz5AMvMoxvbMoJegWx1asjHtEpZpP8uwS7QrWRkl3Q
	 1xac+nMp6esuWofcUMMelviHnknCFwxPAEPVXvbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbfJWULo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:11:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39036 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJWULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:11:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so18557170oia.6;
        Wed, 23 Oct 2019 13:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ssgTw4r4WsQxJaQ0k03EQpF6DWzjNZA4/vVMy3/jAcM=;
        b=V0sdBl4weOMtEjEq6E+NxyfRgZMUyMjW1WVOwonRqCWpME8iVs0y55/PinN8P1G+8D
         bVSisEY/7YGJX00TyRHc8Hse4xvxkJNALMxTYHaRDGszsNdwE2ywcHM5rl6FCra5rKtW
         9ZqiHvfjyNcLw49p9dDR2MJwx7uOC7GRBF6JxkJFeNc0EIkN8FetvuuKGXzAPObzIl6L
         2dqDVrV8ejq/3hC66ATdH36xqQESgQKreVOUfq3WP+LrimfgAGWFExD73t1XvRuepBWu
         Y6jWQ5UXqu+788BER6AI+40I7DpwGRE4j1FeJMvgYesm1VjzYVFUxPG8DHLJKWYABXBk
         dKIA==
X-Gm-Message-State: APjAAAXM/ZVwUCJQjMiItMrWZgXGP5u9R1ktkqH8Lhm3Ljf2ErOXo80C
        HYx6UlwstCu6f46GkpkwRQ==
X-Google-Smtp-Source: APXvYqwwKmIXhOF7O4GFPIsSTdhEVmGYoVwlyXr/mkWIGXxrFLlArngzjnMcD7Lh9nvgON2DEJ3P2w==
X-Received: by 2002:aca:cf92:: with SMTP id f140mr1557736oig.57.1571861502798;
        Wed, 23 Oct 2019 13:11:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a69sm5985960oib.14.2019.10.23.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:11:42 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:11:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
Message-ID: <20191023201141.GA21235@bogus>
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014141718.22603-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> This patch updates the documentation with the information related
> to the quirks that needs to be added for disabling all SuperSpeed XHCi
> instances in park mode.
> 
> CC: Dongjin Kim <tobetter@gmail.com>
> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> Reported-by: Tim <elatllat@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
>  1 file changed, 2 insertions(+)

Sigh, what's one more to the never ending list of quirks...

Acked-by: Rob Herring <robh@kernel.org>
