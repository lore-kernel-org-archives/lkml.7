Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77431C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435FA2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5u4dNhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCTJ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:59:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52230 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:59:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so5857561wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NHxzUBD5WbtN8rV3XpofLZKwOM97I5NkDo0qq5NT9Xw=;
        b=f5u4dNhFvFEHCIeUIdeVcYflxSs/oXA77Nr67GscEinq5T8pPO3McRjyroISxMbgRD
         GNsinldFJQ4S9bhm8jlYIlHkN2IhK48k10R3uMDC0/AC1QKMywOgfz40TzA3ULqqjBbD
         7nBBANNH7b/MxKzhORYliEat3ID0WupgGnBtyptvEWh0hamezA1yvIKewyCzdNyCW0Zd
         8hcWEqcsrLGSVkukdPiD0oEDLyIZxR7VxVrQjfGO2kaNupReyctc/yrwEZlxue1aGIh2
         Of+TsP7SU2itVfpMjGBWtQXMJT4mPxnx4tx16/+OEjBkIdq4FsiuCSLhHg8Nv0FVSvcm
         +1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NHxzUBD5WbtN8rV3XpofLZKwOM97I5NkDo0qq5NT9Xw=;
        b=kiFij6MoaHz0SK2+CgCnQqPR0h6pMY0/G2yFCN4SGbGKtobDxbQyYHjmNoBLeTBtyi
         vOneLEIkTWVJoyQ8o/AIkDTzS/Vd8aObfs3+m0vDrIrgGh+p3Q0DRO/Ecd7cok1tC6JK
         ntnd7kMaQdlkOaMcJe0jLwfbBjXCrf5SlmHnUFBv1sNG18uisgZYzj7wwKMmVj9qHVj9
         aB87xOKRlokd45QrNiCIT7culSoFk0yIrQMNjwoETws0Ybav2WwkjuvXW3hRic86DmoF
         vIEy3eGvoTXttsd9+jD9OANZGWGCSUYov7CnrkEnWsmPN9B95Vlzzq9GjbwVKlPSo7ma
         dZHw==
X-Gm-Message-State: APjAAAWc4ekP+/9v/y80ZENq8EZtpci7vVApgO4zEP1SO/NjKysJ2qQb
        PNzlmS0KZN7mLoudMw6YAtUq8A==
X-Google-Smtp-Source: APXvYqyK0gIkE5IeWA83yhRNf5jZz0xuMNIyqfnMZfoas6sI0qOJDnhTpbXj3iO71ZFboiac7uIF/Q==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr6073261wma.99.1553075941718;
        Wed, 20 Mar 2019 02:59:01 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id w24sm1642832wmi.40.2019.03.20.02.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 02:59:01 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:58:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mfd: sec: Put one element structure
 initialisation on one line
Message-ID: <20190320095859.GK4731@dell>
References: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
 <20190213222402.20541-2-stuart.menefy@mathembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213222402.20541-2-stuart.menefy@mathembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Stuart Menefy wrote:

> Change the layout of the initialisation of structures with one
> element to a single line of code. This keeps the coding style
> consistent.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/mfd/sec-core.c | 58 +++++++++++++++++---------------------------------
>  1 file changed, 19 insertions(+), 39 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
