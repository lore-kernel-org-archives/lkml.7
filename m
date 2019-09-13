Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5864DC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320722084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568385404;
	bh=qIPIMaMx6a3oV8mqJN3WAWXM3lpAozlNJSV+l0kdcLA=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=yhMju65hUEGD6NK5nQ/TRo7i0twJ6Ag1TgnNnZBUzFE2WO0gyUnIKZbCuOHo/gJPG
	 UVNPfjJ/7soAJZb6Dt6ckX0IrMAKnG1sDLYHMP/NyjEFeBT/PfXShUmVypqEWPItQM
	 WKYGJjAznrL55AhAvfNs4vKA/EAhIEKtNNwzR9M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbfIMOgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:36:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34196 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbfIMOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:36:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id 12so2841360oiq.1;
        Fri, 13 Sep 2019 07:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=XF/J+3ctjtlo/NlmrKY+nZTXf6q7nI9Vp8O8/m5fFYw=;
        b=lATtZpyTgHW9vJJIgRJKKYuYaUF/cGZL0AXvgbcj2UEuk79AA+E37QltdsGMncCbqq
         jpJSuL2Mrs3aErgxCDs+2EvkPgHALvC8wdjp+vwlocrbNZRvXArELJQOssiWBckpbpII
         sndU4rVZvRtpbUAkMmhuWi3gC8ayurrZ/ZQYTs3rfaRClHnKtF/Uk2RMJMMgTHcL/hxN
         z/FjuFK66WWdKrSzMBrlqOaMbgptDbXaTlNvhVpTvKcvdcXqVC7aYrDlS8CNhmmYiEOx
         ElV1FtinV84PRJuRGE6o2ULL6EUGa9qe2IqRR2kLR2UHkYFkUaYfC+sLOcpmoZ5OiMUO
         q0aQ==
X-Gm-Message-State: APjAAAWiqRWLxnkU0bDtD1YHweGQLo4t/FWUG1gJ2DX7RkKIDqUz+40w
        Y1NqVzdwIDIB+QT+J9WRUiiQvSg=
X-Google-Smtp-Source: APXvYqwebrpt6cNCRPnAVBk2egSEUvhDKhy/qsYCKODmPuxqc7VBU23iwhJZOOIBx5hQpU+pizh/yg==
X-Received: by 2002:aca:53cf:: with SMTP id h198mr3477800oib.160.1568385386903;
        Fri, 13 Sep 2019 07:36:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l47sm9612669ota.56.2019.09.13.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:26 -0700 (PDT)
Message-ID: <5d7ba96a.1c69fb81.b5d1e.fd85@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:25 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] reset: uniphier-glue: Add Pro5 USB3 support
References: <1568080527-1767-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1568080527-1767-1-git-send-email-hayashi.kunihiko@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 10:55:27 +0900, Kunihiko Hayashi wrote:
> Pro5 SoC has same scheme of USB3 reset as Pro4, so the data for Pro5 is
> equivalent to Pro4.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 5 +++--
>  drivers/reset/reset-uniphier-glue.c                        | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

