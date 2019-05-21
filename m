Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AFCC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2063B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZQdLOQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfEUAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:23:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41399 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfEUAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:23:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so7576975pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPu70Acl0dDSmwm46W0owNu3b5RSfGh3FzFKNjihb00=;
        b=MZQdLOQw3W9V15ULJxTQ96AipAiJ1kcuFGGW2c9VkUElP4pINsXi9UyEKmOKHIxKVz
         wbH2J3shvQbhbLV4ZTggOKN/KSP2TzN+miO9Q/uJDdjiIDVdhHg0R3n3qQh0fpFnEFvB
         jAif5optmrvx3phb9f3Hy8Am1MI4LkPVP+DZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPu70Acl0dDSmwm46W0owNu3b5RSfGh3FzFKNjihb00=;
        b=uJIHgbZ20LH++Iu1c4CUQrem2Fr+oH+rW//SEw58LNZFUF7frHxOKjxfTkx8SLM2Y2
         NNV8XOaVaTcYfqmv37dUzVPB+GbukiAYSd4TrAPVN06b+7Zo7E3qTpuPJZEEP3mBUE+l
         Mcq5i19sSGZrGDq+rgLfie6UJXSvjowFnWG3e0yvsgebar/SUN6h87+T8HDyuX2mVlOF
         DrI0jkUUdpkLDpc9D2b/3NGWtzGPgxk2KTXyV1mUdkwtSWgn1BUiqU2shshrGiuuqsgi
         dyaPvGgg8RHADEGSQTb/f5TfqRxVG8vh09MVSNfvj5cGl4BxyLnZ0786wjnqXmeAwtKZ
         Jb5g==
X-Gm-Message-State: APjAAAVb4eLDxnXCANg7ZAlqALSK82vMNuBhA29YAsGrpQoAaSdX3ZQL
        fe8d6y5EAoMZSug2WDcXvQ5flw==
X-Google-Smtp-Source: APXvYqyHRvjDKJM7g5pNBmpglQaLaCNbnuq/wX0yAuGrBgJFe6RRW2bXvYhCXJl4QWmy07O1Y2HwHA==
X-Received: by 2002:aa7:9e51:: with SMTP id z17mr83145568pfq.212.1558398198034;
        Mon, 20 May 2019 17:23:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id j184sm19177690pge.83.2019.05.20.17.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 17:23:16 -0700 (PDT)
Date:   Mon, 20 May 2019 17:23:14 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        "mka@chromium.org" <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Martin Hicks <mort@bork.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>
Subject: Re: [PATCH 0/3] brcmfmac: sdio: Deal better w/ transmission errors
 waking from sleep
Message-ID: <20190521002312.GA89786@google.com>
References: <20190517225420.176893-1-dianders@chromium.org>
 <SN6PR04MB49258D4FBE0B4D739E8BAF7EFC040@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB49258D4FBE0B4D739E8BAF7EFC040@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 03:09:44PM +0000, Avri Altman wrote:
> > 
> > This series attempts to deal better with the expected transmission
> > errors that we get when waking up the SDIO-based WiFi on
> > rk3288-veyron-minnie, rk3288-veyron-speedy, and rk3288-veyron-mickey.
> > 
> > Some details about those errors can be found in
> > <https://crbug.com/960222>, but to summarize it here: if we try to
> > send the wakeup command to the WiFi card at the same time it has
> > decided to wake up itself then it will behave badly on the SDIO bus.
> > This can cause timeouts or CRC errors.
> Wake-up itself: as part of a WoWlan, or d0i3?

Neither, IIUC. (It's definitely not WoWLAN, and D0i3 sounds like an
Intel thing.)

I believe it's a Broadcom-specific mode. See also Arend's response to
this thread:

http://lkml.kernel.org/linux-wireless/8c3fa57a-3843-947c-ec6b-a6144ccde1e9@broadcom.com

> Looks like this calls for a wifi driver fix, and not WA in the mmc driver.

Basically asked and answered in patch 2's thread:

https://lkml.kernel.org/lkml/20190520085201.GA1021@kunai/
