Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC473C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9C20578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFTppKxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfEHKxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:53:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45740 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfEHKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:53:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so26550293wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JKIh0OlhwogoLb2gFyisL8SYZblJ6QPDpG/wRuDQA24=;
        b=mFTppKxWA4GeHfy4yFj5epQB5aB96Y+vW6eCsgWlUQuqcLEh+9LwYIFeZA2ImEO0jk
         DhlXwKXhcqQQOEcbfLvglZtWb1CHB/CVlKNID+KGJkfKLZjvwuufkyAhCOs2CElWSqhc
         DH0w5P+Ka+ee9+xjmx/uy2aVvjd0YGli9fHjM4TwIzLS/d3HO44zy4JgrxOmHB02hEV4
         OfdZl4PfvUpZKTMHCapmyD6XHsbWfnFO5a3Bo9yCPQNEuEm3kfMjo7dsC8OryU6e+/JM
         pgXpDOmguZrm4X83TulKDQzPmxdVGGZQGz+07HfTdXm5whns+Mgr7EyE5TVWy5arX/Gu
         e6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JKIh0OlhwogoLb2gFyisL8SYZblJ6QPDpG/wRuDQA24=;
        b=XBKFuOGzPHzgv6lBJBpHjfinDAIgYGJ70iXQ5PtagQG/3cA9Vw9V1I4prNHdixVX1T
         S5cnm1Sp0l5MiAH14O+WxxbVmSS1DFJrYeDSKnhA9xkaqNLBylpdRhBv7lQy9YyF2oAp
         5jtPOOBceh1NhYiJxAls6HoAhMtK/IE9OtxWYIOwWc59gGdowLOq/6fJ/BSwnwEKI0lN
         eVM6mvYSfEq3178Xwdq8fO8zleRH+vr+uLr0VUEYrY6xD5sfou0QcdkXG5EEGVxRaBnI
         8/EZTsNRcV6Pyc9EtVkNQGeev/7Cy6YV68M6T9c9nkoQhPBGCFK2ZaDyZZ+NoecEfQ/S
         jyAQ==
X-Gm-Message-State: APjAAAWhvo6dtJ531f1FjudsiW6TFETcjmzZrkkTx0yTDSCBiDeeaGcX
        YQumiZ3nS+PwdpF4w3jvLSmt1w==
X-Google-Smtp-Source: APXvYqwlZiLdXlAEfznjHpk8nEAvN3fWmgxnXEvPPeJPbdOBuNx4TYP/ubkjdyqBdKeqCDOr/OLFRA==
X-Received: by 2002:adf:c6c3:: with SMTP id c3mr27422586wrh.267.1557312821690;
        Wed, 08 May 2019 03:53:41 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id j46sm5210579wre.54.2019.05.08.03.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:53:40 -0700 (PDT)
Date:   Wed, 8 May 2019 11:53:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: LMU: Fix lm3632 dt binding example
Message-ID: <20190508105339.GP3995@dell>
References: <20190405141907.3348-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405141907.3348-1-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2019, Dan Murphy wrote:

> Fix the lm3632 dt binding examples as the LCM enable GPIOs
> are defined as enable GPIOs per the regulator/lm363x-regulator.txt
> bindings document.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/ti-lmu.txt | 4 ++--

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
