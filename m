Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB14BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839BA20644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQA/R7ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfIBJGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:06:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfIBJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:06:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id 30so2227040wrk.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jsEBeFFNvFaPm+UINQ8FKKE9kI76YVop7KZk/SgIN0w=;
        b=EQA/R7ER71h6q2L0q6RyD91BLLw2kzWILEICeJVIqMMoaPHkQfzCy4GrQ9R5sBh0A1
         BjOBfnt6KrqiZ0OutIgU+RMQ09MN5jKZtdJA0dsG3V8suQ8tVyr/dj1aiudZ+fxB/DDe
         vX87A/djueXnHzTheatGtTPNSbGoQvJoLH5PhcZeJ1U41Rmp1tfFywm65VbahANHD7q5
         u9aVEyX61rZgbeFkaNPvkmJTyfsJVCxn26LtnrUK2P559KiRyUFqVKQrj9bonn6XeO4x
         kDCfeE46xu39tfh4otV173ZC9Pg0stVfkSFPhpGkggefW/nSFj5ZKOaLEQFKq/U+sapt
         aOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jsEBeFFNvFaPm+UINQ8FKKE9kI76YVop7KZk/SgIN0w=;
        b=FNZnHTUK9hIYLhgBfGeh3KFmfR0YAwHEU/smG9ZQE7J7A8XbhYeEjbkTyE5Nx9Dwe4
         cft2EDbX061DmkeOUziYUyK9BE9+9nrzR9QoKoEvKyd6LoqmzxXktlOXtMQK7QBsh+ZS
         WrqpEzsfj9vVmFHe+QqvHLmPR6mQwp+BVINPq8X3v+GvwSlQJmW6s1ClGFYP6WD9vDbB
         /puhXgtZ/IbcZUTB8oe81krUnEclfY1I5Bs6v6CxEllcFyJvEJ5zB7wpTvu8Uo7SyNTn
         BA8cBPxXPquSvGczivq7qwvUunkPoMBYfGutKy+Ou/WUAe8IMTbhVeyLmYISSo2FZHYs
         QDiw==
X-Gm-Message-State: APjAAAV0a+RDCXrhjntBfXqqp4nn1crkaSRguQsF6hk1SJrgR59CQOOy
        JSwmEXCpMjb9cnAnbjoO8mzthA==
X-Google-Smtp-Source: APXvYqy3AlQzIqFirHwiqt0lgMFigNByRSNqVI0P1nO7V1nkPNQl8F2riQFP7gj6w0mv3ltiUhT2fA==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr9934885wru.145.1567415158006;
        Mon, 02 Sep 2019 02:05:58 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id h125sm32172794wmf.31.2019.09.02.02.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:05:57 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:05:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: Include the GPIO driver header
Message-ID: <20190902090556.GC32232@dell>
References: <20190820103715.7489-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820103715.7489-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019, Linus Walleij wrote:

> This driver creates a gpio chip so it needs to include the
> appropriate header <linux/gpio/driver.h> explicitly rather
> than implicitly.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/sm501.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
