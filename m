Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A030C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72B820840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVSx05dF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfDBGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:23:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43136 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBGXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:23:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id m10so5716208plt.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ETMI+bqjvfHa1XN/b4poUyYIe+EA3e513VzIGmNFEic=;
        b=FVSx05dF3ffq9G3aD4jOphSBEgig24TtkgFEVy121HzN2S/mQ7T726xU4Limglc5cu
         OtNGlx+Hcf0lN6Ns0yDqwX4qDUYLNcJSt7l/s5ZI8Li7ZTetOwd57lyV5Bhq8RXKUj1K
         bmPrn2+nhZ3Gpj/qqyaafMv3FXA4+Vm5cgmmQKYzfB0egY7mxFrviT0qlQWxa+PT80rK
         TjRC/Oz0eOq2stDcZ9my77+vpeF7SAO8VI1dJwgWhmvBTOgSUrBqs+GRirHay+g/6RRm
         DT76aumZtCVBvcGZLcca0f8PDpXyjIPbq2C/1cyS0xI3IugwoMC+iEksrMw4y+t+MNc+
         95vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ETMI+bqjvfHa1XN/b4poUyYIe+EA3e513VzIGmNFEic=;
        b=Z3AzaIPse40jHqdhTjYFWN+egDK+/tKfHYkBL4vHfr+MqR0JLBoED1i1aGIORQwVR/
         ytju1A2oij9tZyQ00KU5EZ+XMufnoaIE0AJ9lrQ4m5iBynjimuI9NV38zlZtsbARgDGU
         vEOQ5R5xm6guGbnwvj8yBpjL8hBl+DR2c/OWwBCKqzD3NIfqyebcNjvQufcCftUvFjsL
         e+y+X1zYekgdFAHOhfXzMoy/HSvX8GefvdZr3JhHIXtBw9JIOb1wbaKzZYtzcQ5Ilcbs
         Z7A6foTLalvvnM8guUFEiP9CrHfpxmveX7q4YbCK7xgVsse5whOT++zzEr+2GSXZkVON
         Xgvg==
X-Gm-Message-State: APjAAAX9KRz54aSOIaPyvvdzpjr1t4ogwY0tcq2Wlzi8ldmTr0q/e7Go
        VxeJ3eMif8gL5t3O2utqaTrN4Q==
X-Google-Smtp-Source: APXvYqxxC6pusNaTG6hbk5s2Ojpu9mZOqNpuK/GmsBNJG0EziJqId+Aq4QvYweMZD0xHylapjBPjnw==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr19430771plr.288.1554186209535;
        Mon, 01 Apr 2019 23:23:29 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id c18sm36806407pfc.0.2019.04.01.23.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:23:28 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:23:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
Subject: Re: [PATCH 3/4] Add support for SUNIX Multi-I/O board
Message-ID: <20190402062323.GW4187@dell>
References: <20190319120818.3791-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319120818.3791-1-saumah@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019, Morris Ku wrote:

> This patch add header files and Makefile. 

Makefiles and header files should be added to the same patch as they
are first used.

> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  mfd/sunix/Makefile      |    9 +
>  mfd/sunix/driver_extd.h |   90 ++++
>  mfd/sunix/snx_common.h  | 1031 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1130 insertions(+)
>  create mode 100644 mfd/sunix/Makefile
>  create mode 100644 mfd/sunix/driver_extd.h
>  create mode 100644 mfd/sunix/snx_common.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
