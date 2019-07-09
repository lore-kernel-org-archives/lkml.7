Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49168C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BF72080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562702698;
	bh=vmfDMgSjA2Ct2/SDoO3o69CTZrVH7x38ea+ipsdK6/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZULJ40+PKvvhIZeTww2C7ClqWSdPBb/ulSuBp5VTvEIF3sMoeMxU/DjE55TM8QOYK
	 7daphSMJRkjCRpGawrtGODxs+AmvZsoXDkcrqqZ+PpO7TsTSAmag354CfqMwrQAiFv
	 nerEUfD97vG6FMu3sDEOw8oVEjInIYM9TWIyeGC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfGIUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:04:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35219 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfGIUE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:04:56 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so36411854ioo.2;
        Tue, 09 Jul 2019 13:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMWvhTwdTx4eCPgZpMKqdo6YtJFGRY4W4k7r7rWwQq0=;
        b=ELtTPWPEVPwZi++LX1X4cM/ucm2s7++TXaB9AwJpODI684916GSvLMZp17K1aYcLsl
         ofBNB374cStYqdPdOz9ZzN7mwrlRdEes8C/Or8XBG1nSMPfT99fZq/zu/PKkp/kPGxXT
         bZtIlv6mI+1/oKo1cfq6TJmEhBxv1+64qU8E53XV/Fm5/5fxbeIVVCfFFpVWAEyhqFCA
         Bh0qDo0t8WI6YWMoUyRXhUbTDi93MBRNZyowx94ghrBGLVYghv1bJT++VF5uC9Yn923v
         VIj305t2QL7V11rd+LWZfVpdLTFKa8Bvgc55FAj9vavei5WSRkusifXYcOoQjO8XEwuc
         jlTQ==
X-Gm-Message-State: APjAAAXy7py62PUr3PmarzgiTTEDv5wH4OjT1lXXeNGhO3ZL03TsMuGY
        sL0Bv6MMgoIjXrjXV1G26A==
X-Google-Smtp-Source: APXvYqym6yoyImjtZ4uA33nv3VEFPdV5kZxtSC8ErJEyWJqeGfIzXNMCldgpv1NB9zrEilSNLO/USg==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr2513338ioc.223.1562702695542;
        Tue, 09 Jul 2019 13:04:55 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h19sm15504351iol.65.2019.07.09.13.04.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:04:55 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:04:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        fabrice.gasnier@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, benjamin.gaignard@st.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/5] dt-bindings: pwm-stm32: add #pwm-cells
Message-ID: <20190709200454.GA328@bogus>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
 <1560937925-8990-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560937925-8990-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 11:52:01 +0200, Fabrice Gasnier wrote:
> STM32 Timers support generic 3 cells PWM bindings to encode PWM number,
> period and polarity as defined in pwm.txt.
> 
> Fixes: cd9a99c2f8e8 ("dt-bindings: pwm: Add STM32 bindings")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
