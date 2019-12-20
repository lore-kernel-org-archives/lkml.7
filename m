Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDEEC2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3C2206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576882491;
	bh=FhSIQVGkG/HvMbdRBsPKIYkm1u8+h8pRpTCxtPOOuEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EYvvQBEiovYyQNdHyLqMQesJn88QH43g9klzNV7k9hEN1/wyK4PfDWKjpSDnJCTDU
	 CruKxRblAnQu9ZPHHUMOwIORX89oasBYpjKYk4jbk0v2nFtJbPwCVvEpmsaox45RWN
	 SAI7bx6jpOraMAbTaonI5tc/jPWylA++RU9nimUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLTWyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:54:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40609 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:54:50 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so10974266iop.7;
        Fri, 20 Dec 2019 14:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6aXh/oY7lMy+cARmMvGPpZJvUooMcIfU6lzBw92zjc=;
        b=IYva/2omyTOYtBLWDNUwb3/8fJ9o4jDg1NiTwpX7uzPY+HiLhFsiSbKrQsfR3F44rv
         G3ffU3wr+iSh6aPLBv30dhXpAQTPeEIWqa0SnQ3ehKXjqOacFz5ZsXlF072zmar6A9Mz
         zBAs6/IcZyCFZKTytJ5Ih00xEX7L6uWtSaeUG12TBz2WoM9TsB0cbK6tFKYzoc8Du+gm
         asXwaccypTN0SFx5abyelLwhx1DFcvMO+NaI+LajNt1AMoEwG+PE2Hqn5/euwPvl1DVZ
         Nj2PsfkwCXk7iuM8VNl/1YHEnvuQi1nukrO2NzzIkEbKxoSt/+eYgKVcz6WlnVsAuBmw
         OtGA==
X-Gm-Message-State: APjAAAVWHw6ib6cwhh6Ju5wV9l5RgLpy3f8rxZ45B1Sc/fONM9HgG3b0
        LdoC8rzlGUK/yP9FK+L8pw==
X-Google-Smtp-Source: APXvYqxRHv3mavUCCTrXPMpUhFxucuGGurQ6Fm6MRXBtA0U0dF6vAMO9RsEqh8V50CJdUZic7aVDsg==
X-Received: by 2002:a02:8817:: with SMTP id r23mr14536778jai.120.1576882489464;
        Fri, 20 Dec 2019 14:54:49 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z15sm5471450ill.20.2019.12.20.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:54:48 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:54:48 -0700
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, fabrice.gasnier@st.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Convert STM32 ROMEM to
 json-schema
Message-ID: <20191220225448.GA5275@bogus>
References: <20191219144117.21527-1-benjamin.gaignard@st.com>
 <20191219144117.21527-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219144117.21527-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 15:41:15 +0100, Benjamin Gaignard wrote:
> Convert the STM32 ROMEM binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ---------------
>  .../devicetree/bindings/nvmem/st,stm32-romem.yaml  | 46 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> 

Applied, thanks.

Rob
