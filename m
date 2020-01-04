Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6FC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7A2222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578174936;
	bh=d8DC5PsHzB+CZJKJU3WrbaIjr67x6r0i/d5cJleFLMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rMHQdT7VuVYvz+V48jqOHnIeLZZeuZDItytG+/28DTbqhbWsCIX2JFrtvzl6Zi189
	 X+44l3cBQi7Gx6xg5ahJXaoNfmBm2wYMbasH3C/u0u9Jxz6Z1JoX0UJ/FMVsxWN3IC
	 w/pFzuo6wNS/GxwTJI5rZLjyJEzzRvAiHTTUdr7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgADVzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:55:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38797 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgADVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:55:34 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so44814185ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DpHIoc7R3nvhDkYlx8d7RkRksbRX6Kou1+9AvQFNTV8=;
        b=OZGk457TA7BL5zZ7Ix/szuTJRXrQKS91fSylfwkyP+N4k942RH1ABqFdW5CBYBVvJb
         tC2tJjsHt7c0JrSVMxEdrL6iVi6MNuJcq2at3S7drLiNEraafcjB7GnOFaBUKdJYustf
         AT7wDYnftcotol4bkr+bMzrzO22hcZu9AR9mq3PhaNV1w6mTutii/YTqzl56OljWscNe
         suRVzA1gUp9wm4G8Np+fcrtTkYfmGIVkhdT7E0PJIci5uVOJeTjs/FofDhBw2CLOcykX
         XGDbdwNgVgOYij5xS9ihTl6V4jbc6HQKLuXjZdFWrUnRrJg3e9ALcFis3EHzefgFZFTN
         FNfA==
X-Gm-Message-State: APjAAAWCNpY/XdNXsFBCNvfliGRiR2tCis5Ypr4xn7ol4iPsQT2+BaZR
        5Z9SjwkaOywwyPDhBztHUEBC5Nw=
X-Google-Smtp-Source: APXvYqzlbdn5re5VVz5+5pn71dYvNbD3KAFG5t3WWFXVWeivNvgJBOLst8UBX0HuJLgriHampu2A8Q==
X-Received: by 2002:a5e:8d14:: with SMTP id m20mr61044353ioj.282.1578174932988;
        Sat, 04 Jan 2020 13:55:32 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g4sm22538645iln.81.2020.01.04.13.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:55:32 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:55:31 -0700
Date:   Sat, 4 Jan 2020 14:55:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: clarify disable-wp text
Message-ID: <20200104215531.GA28533@bogus>
References: <20191219145843.3823-1-jbx6244@gmail.com>
 <20191228093059.2817-1-jbx6244@gmail.com>
 <20191228093059.2817-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228093059.2817-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019 10:30:59 +0100, Johan Jonker wrote:
> "disable-wp" has been removed from all Rockchip eMMC and SDIO dts nodes,
> but people still continue to submit new patches with "disable-wp" added
> to other nodes then for the SD card slot,
> what it was designed for in the first place.
> So clarify the "disable-wp" text by adding that this option should
> not be used in combination with eMMC or SDIO.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
