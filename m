Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC54BC73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC67F214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562691935;
	bh=zmH7Tla7rLJF/r5JnrAvdV887swl754fWwQFg7dwqmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=grHhZzwDYdJxlehHcJghB57oj8VpdoANfitweWuDpOuEqx2V1MWXSYpsZfcb4yYPK
	 zRiu/NfRqMf/CIkPI26dSzDIsFQsPQ/xIjUQnfii0M4Ydari+UdXHPyNO2b+rfx00w
	 WpIhuEVMSCHnBVkzZ4DNORWoHmLhsJMAoKb4WMLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGIRFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:05:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39973 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:05:34 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so36502634iom.7;
        Tue, 09 Jul 2019 10:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZVSdIReA1dub8lT+/BNLKNf7FMnmnulMnUfS3UgQmc=;
        b=lIfPNS77oh6GZKTG8EW0DdN7iALgEHwzL89uHZYjO9TNjeVYtWTw3RXwvPGkQykOWD
         bkcFa6UMXSOir8F2Egs7a83pgFrZXh9luUaKKGX0NHrjT8WPWAVQiQTZ1asixhuYCjMU
         qfv/XWVZ+HtdE+jrHZs2rqi8A6xPSIJ5iX4HaZquBC8nq6jtFfKckNWe0PHhqAfUggRs
         sfUxDQxENJN8guZ8F9zuUEV8XCdGwt5Xj+kD8SFfoxXNbirTAVuVXEXKyJsRKJnTwJhj
         8xgHsr1BsJieTCqoxxDHfY9c77EEzZ0ukNGMoRds3N/524H0voPESCkSc6lGVa20wLy9
         jarw==
X-Gm-Message-State: APjAAAUMQxADasf2bNU4OOZrw9lnY6KU1cgYi5vYQ4DjdzamJ42LetXG
        DfitaDmRY0efwF/s3ny8tw==
X-Google-Smtp-Source: APXvYqy82rUB+PxD0GvIta+96cabnu3QalLm/IpoEAom3xpXM1tw/t9dcYtTv9yOKDIievsmVKm/tg==
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr24563041ior.123.1562691933479;
        Tue, 09 Jul 2019 10:05:33 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f20sm19481160ioh.17.2019.07.09.10.05.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 10:05:32 -0700 (PDT)
Date:   Tue, 9 Jul 2019 11:05:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, maxime.ripard@bootlin.com, olof@lixom.net,
        horms+renesas@verge.net.au, jagan@amarulasolutions.com,
        leonard.crestez@nxp.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        aisheng.dong@nxp.com, ping.bai@nxp.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, peng.fan@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V5 1/5] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Message-ID: <20190709170531.GA19236@bogus>
References: <20190619055247.35771-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619055247.35771-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 13:52:43 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add the clock binding doc for i.MX8MN.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
> No changes.
> ---
>  .../devicetree/bindings/clock/imx8mn-clock.yaml    | 112 +++++++++++
>  include/dt-bindings/clock/imx8mn-clock.h           | 215 +++++++++++++++++++++
>  2 files changed, 327 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
>  create mode 100644 include/dt-bindings/clock/imx8mn-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
