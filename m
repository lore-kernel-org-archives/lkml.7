Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F5C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC3F2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/POo8hM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfIBIiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:38:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfIBIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:38:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so13554885wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=piVC8lY47V4zd0qmJtmvx1ZiVDDDWKtmdiyonD3TF+Q=;
        b=n/POo8hMG3mQicU7+ByrLjlYsC97v0YrUFoP3JHijWfcpq4vMwVB3wWGfgPoFMdHww
         NE6bBd+YtLGrQx6m1WkizQrNtqvBTGoveH1A9A4NvxKke3W/0BU8Uo6jrYT4c2qfDok1
         iIoXNreDXNu8sHgng2vWjW5m8OCdvoCLVzU9fLxUJkAjdbFcQ2fYuVSjRYR4zdRyOEkn
         wH1mo8eGWcXUro7RAdESUDvzPQnCcu7T7Hr+bQShEltk17zsrBCHbjKpAhCDod4kUi8N
         4nkKdLTZzjctwhI1Rdz4FTx65stl+bfjit8oxwud7eje22AeKM9KtJ4g5bTxzE54637V
         FSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=piVC8lY47V4zd0qmJtmvx1ZiVDDDWKtmdiyonD3TF+Q=;
        b=AWJ5UN4CMWjm6JjvzIj9VdQdbQdDAnw/0O2cqoB5h43+7QrlxcRISHWU0i0rSbjZ7L
         gyMmrJYDWgXvDRl+pDrDlkmG8aR+dGD15Vxk9sk7xMSYByIo+MOYSduQhQODJZiCTrWM
         GyO49X2ts8LN4eFfUte1kHSUE3uxXf9AAvpKDHFKS/jgfG0aWVVAKZ7TaZvcqLWOwIrz
         l/JjcfUZa7PUeMh3IfFkR7UwJpeE1t87RxiKlD3O11RaUFk78Me/OjDwroPMkxcwFu/E
         ekw/7SEEOTZmc9r5YI/I0ZKKYF9s1ZxlIAkEz3KMEL5gLfcd7qGu7kU/UqCvBnuxJ7oT
         1xOw==
X-Gm-Message-State: APjAAAUGnLhrPGAoWavccTGFXnrJAgNabMzFg2bVghCr4ToGIUD4Fy7T
        I4UIBVgHZSxhjXVxOQN0X3DIpg==
X-Google-Smtp-Source: APXvYqzd+oaKCa9BjDVPLj3eFkkr6EXBnTjgGlGYosAAou3KodJM+uIFV8+hDwPS23hA06IffnQ5zA==
X-Received: by 2002:a1c:c5c3:: with SMTP id v186mr20535829wmf.66.1567413487754;
        Mon, 02 Sep 2019 01:38:07 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id o193sm12550070wme.39.2019.09.02.01.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 01:38:07 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:38:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ezx-pcap: replace mutex_lock with spin_lock
Message-ID: <20190902083805.GP4804@dell>
References: <20190813103133.8354-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813103133.8354-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Fuqian Huang wrote:

> As mutex_lock might sleep.
> Function pcap_adc_irq is an interrupt handler.
> The use of mutex_lock in pcap_adc_irq may cause sleep
> in IRQ context.
> Replace mutex_lock with spin_lock to avoid this.

No one has complained explaining why this might be a bad idea and the
premise is sound enough.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
