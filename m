Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A800BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A712146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCmkoVuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCTNFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:05:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55863 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCTNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:05:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so20422124wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pcAe7xKXSA+JqdtmP9jJoY+vIqRWtxM3ko7Hz0Mu9XM=;
        b=CCmkoVujw80180LAp2VjhdD6MYlzX3KrXHBgwNSIJxTh0F/jcpj6UcpTTuyp9z5yIf
         qr50lpPN6lpDWTfXADhRHsZmEbFjGcAIcbWVk/AFi2kcGi8aTP9MXioupSLPjh10TEdb
         KO8j6OmSqVhLOhUpuqtA85p3PORv7bSAybvfc61SnMGzs/VHTKtSbazJqqnu2vsWVTcX
         Kgx/8CagVY6UHpVib6uF8PqhA5sbRzePveYy27wgDAKb3h0BTXniqA4+oNc++xY3O7S8
         s6kk8eYiCuUowy73E7WOWHBHtvAvxFWeLpcjlSUarTLdmkdjJaphu7ONO430bREIzFd/
         38jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pcAe7xKXSA+JqdtmP9jJoY+vIqRWtxM3ko7Hz0Mu9XM=;
        b=qzHbSMCmj3Axrov02TkHG1V3VAbpHjCMtZTd36JeEMOdbpRUivjhU7YFliYFGO2xCg
         KrkHrQea+WG5ZVlk59d/kFjMgTAXScVRQPNtHa+oJGVCBk44QXMTdiO9xNHJILQrUZDc
         x0Pdj2AsCbvZoeR9LCcNLv3B2kqRdV+DragCeSZnL8bZ9nXuvmIUemzl2Q4TExYysN6M
         a5OrS+O/fi6ZInTBT7J6CFN4KycKurYpuaCMsDWJdglnYV21SCDkdnCGRrhYgOf1Uh9r
         v9GkIKnqPwSUV9uxe/Ymw/BqiKYoUjrD7StR1IssuOrAEZKIlmCyfMWyErjvQqlizt75
         cheQ==
X-Gm-Message-State: APjAAAUn0Gznrk4S1dOMHGd6FnZovy/Dqt3irYp++6Pr2BZ2g7x6aw2C
        aE9JSHBW0z11uCZG8jyIIjSzhA==
X-Google-Smtp-Source: APXvYqz8mfe/6jxjJCwNqRWPRNhurjfeIqqq8Yrt6IxDdoOAtXo4tvUaa4T3bSXZSwxfUPfBBw9T9w==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr7857218wml.17.1553087136963;
        Wed, 20 Mar 2019 06:05:36 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id y63sm2300306wmb.31.2019.03.20.06.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:05:36 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:05:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, arnd@arndb.de, mark.rutland@arm.com,
        gabriel.fernandez@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
Message-ID: <20190320130534.GP4731@dell>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Fabrice Gasnier wrote:

> Some system control registers need to be clocked, so the registers can
> be accessed. Add an optional clock and attach it to regmap.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/mfd/syscon.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
