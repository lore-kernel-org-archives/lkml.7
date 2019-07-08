Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F141C606CD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CFC20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M76wxX/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404846AbfGHUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:07:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34001 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfGHUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:07:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so8232796pgn.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Adk3Sp4omK3tII22cu91Argw+pw324+uMJZd/RcTnI=;
        b=M76wxX/tvbAll81joQN1cX2dmf5uHqy3K+qfYhgIyOCaR4E1iHoBNWO+dUwsFK3pR9
         MN17vaD7bQSjxErvFtUFSRAGjB7NX/srUvHyXUn19OeHdftt9niKFDRXQ9e8fIcBWwoR
         fRGSlrPPkJQQkIiUGTzpBgVNLLVc1NETwj1Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Adk3Sp4omK3tII22cu91Argw+pw324+uMJZd/RcTnI=;
        b=mBzGoln5QNxpgHgsN92SBLqQTN3fDSh/Oxrfwwhkz6j8mxUYXJ012MMHLAoXAigVcU
         y12DtHipSWBsb9f82J6GFRkTtj3ql0Udf92lHKJdmFEIHeti6IUiMeO8xWc1GOnJsiS3
         tCfPG+9Nh5rSY445wvU32fhliu4ka4C7uPi8rM01ZbhdmsStL1RxWdinrA+PbEniZQcn
         DFFiqL6nbc9tpRnMmWM0KFZDqn0zku8bT0h09/u3WGYa30sdzZ8dT/t0RlnrlParLAm/
         Tba/0LFFjD86BftpihMO+yZd7nPvt6LNql+B8sYO8MMyYOU+hWAgLPODrpsRlFJPUigt
         DYIg==
X-Gm-Message-State: APjAAAWUba6JlxVcVkOhMaLl60VWitJZ6aRrt+0wWu3vZ1JEFNz6ijMc
        wi9DD/ln3aHbwXGqtQ/fONSazQ==
X-Google-Smtp-Source: APXvYqzVaazt1DJiY1ZMsZNK9/WExCcA8j6aGSnlEsUYqdPT0vu+CbjMH5BCOUFNvjpOMCNDw6RSrw==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr26108786pgm.143.1562616427462;
        Mon, 08 Jul 2019 13:07:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 3sm17335443pfg.186.2019.07.08.13.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 13:07:06 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:07:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: net: realtek: Add property to
 configure LED mode
Message-ID: <20190708200705.GN250418@google.com>
References: <20190708192459.187984-1-mka@chromium.org>
 <20190708192459.187984-7-mka@chromium.org>
 <20190708194834.GI9027@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190708194834.GI9027@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Jul 08, 2019 at 09:48:34PM +0200, Andrew Lunn wrote:
> On Mon, Jul 08, 2019 at 12:24:58PM -0700, Matthias Kaehlcke wrote:
> > The LED behavior of some Realtek PHYs is configurable. Add the
> > property 'realtek,led-modes' to specify the configuration of the
> > LEDs.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Hi Matthias
> 
> Humm. I thought you were going to drop this and the next patch?

It wasn't clear to me whether not introducing a generic interface is a
definitive NACK and tought I could at least post a version with the
review comments addressed. If there is no way forward without a
generic interface I'll drop the two patches.
