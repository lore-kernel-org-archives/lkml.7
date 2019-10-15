Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58341ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A04220650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571160112;
	bh=+ozPeN8DnBYyFtW5HSwjxEcst7ITBd5zSwAogU+rtZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j8uCQB6VgWEcfAgPtAyjQqwvUQkGMMIKvUCtXuipr0ihiwe+fhroTU9FqVuK7RgBo
	 WjCLr6MgY9ReqCXh1kL4nFwscJ0f2IRyMh9Xs87Ab7yjVL2OZgx3DfxWI12ke4nVyX
	 AxVcSYqtBGhNRcgusB99HFUe81FY4wZlkA62OOaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfJORVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:21:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40141 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfJORVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:21:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so17524556oib.7;
        Tue, 15 Oct 2019 10:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wMQYKbyhFA0J53uXBrOY3g9qc7SUK0PL+5SCKX00VUU=;
        b=D878rz1Z4ez2g0ZBvon/wKCoB/esDCrO7mYh1Pmp07UXFfUxNDZEykjhGdMb7JI+9F
         NRrtthiQGe40+6ZEwPcY+o7Svf4vrzRRF0Dm2IhX6gTRbWL71v7H9pQqF9edW7Ccf6QV
         0QAnxan7QqmquGj35OuWLV8yBAaDxIHOqDgZVnM/Da40+AoSB3eyjfBfudQme5OMOQY2
         qMyUuTXzflFXfxKaBV1krKb5t1yoo5vrYST7tkAk+WMC5BRW+nZoC0Azve6Y3waR/hdl
         9yQ/P7AWVBZyq863rjFDgajd1tPGWRLXDyKvYsN/dA56uXKqoOoP0ARuRtOjsq+B2Qhw
         9UKg==
X-Gm-Message-State: APjAAAVhVat7Ol9EEAYE46QPphyesI2IWJ0poQYFAZ06MTmBNJ2GGE6E
        NJn1/rTze4qkJfNcMp4ZRw==
X-Google-Smtp-Source: APXvYqzqnTfEgidDenSlUfa7aOPOWYsLH7H0GHitbZ8rXyoGFRnAK2iUj2pxxTyIJqKthdjAV1LKQQ==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr30817920oig.46.1571160108888;
        Tue, 15 Oct 2019 10:21:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d95sm7245526otb.25.2019.10.15.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:21:47 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:21:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: stm32: Add missing STM32 boards
Message-ID: <20191015172147.GA29624@bogus>
References: <20191007134410.10337-1-alexandre.torgue@st.com>
 <20191007134410.10337-2-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007134410.10337-2-alexandre.torgue@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 15:44:08 +0200, Alexandre Torgue wrote:
> This commit documents missing STM32 boards:
> 
> -STM32MCU: F429 disco/eval, F469-disco, F746 disco/eval, F769 disco,
> H743 disco/eval.
> 
> -STM32MPU: MP157 dk1/dk2/ed1/ev1.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 

Applied, thanks.

Rob
