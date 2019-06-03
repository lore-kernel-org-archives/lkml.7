Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8BC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D3F24CD4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGDr+SaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFCIMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:12:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55719 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:12:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 16so5684790wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rA1VCD3GAb0PD3btTSc5UgdukJM3iIv+UYfmDc9ijRY=;
        b=HGDr+SaPaEwwAm5phsdsWmtpxmne/TyhXv5ImfuOj5Gdkuffhte9CgCwbYvRoDlMGW
         cZe1B3eJ6guyNqvjTTos4JKJ0TZtV7wTXJdtoL28/uBddgf9sTiCHJSdgOpLl8/VQKl5
         6eS5cwBV47ZjOAXI3mPTXUF9k67RJEO44bMyXgZ0gq/lakJg9LeGdKiY0v2OHO2wrial
         nW6bjAV1pfhovdKC8wax7NwTLOArUb4g664DhmxNdX1OCjpYA8pU/UCUPGPtzEZa2g/G
         IPVzQy/MrRWfbHKXecWu7c0/BNRP8WBhgTUYJOPMmyAcJSMWFhN3DAsuYiiRfBgD8GBs
         O7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rA1VCD3GAb0PD3btTSc5UgdukJM3iIv+UYfmDc9ijRY=;
        b=a7qrSj1cyB3lZf2GJKPwA/vCTGBD0uYXl+WCVLHLCJ5uUid0rsygLHaVmVJC3hW4IV
         QrZRLLMs9LA3AkkI0klfgxY4GgLCDxk6bJgMU0J5sj0rNQy2WGWL90o4QxCD8jClAKhb
         2SLKkJgNs3YAYPWNhgJhzKc2tQL3bo6/p7Xe68uGRjy4Jm0uXfdEC/s19cKRB5pUyK59
         kzRO0NfwIewQQVSvCXHKN4ExgDIj2QgY67mcEt00HtG6A2bUFxSzeE9r+dMjpD34mHYH
         qQVYfsOJ6tTlxlYgBojpNZFoDYIJy3e1+Xo71tVhWaig+6zRskcgtXgw1Lt6otjWhyKD
         A7SQ==
X-Gm-Message-State: APjAAAXrx4TCM4AI8yjGhHgZvwv1auekqAD+BrxgsYmzDTJvGgM7tnrk
        iabt4TOsHTd0SNVEyoX7uI2kIg==
X-Google-Smtp-Source: APXvYqzs9kYOpuv0Oqi4vkNcyrdkKxl7+hada0n0FgsvyjwLdnHbT2Pjc30QWl9yRlT4LRH3YpsV6Q==
X-Received: by 2002:a1c:e356:: with SMTP id a83mr1365844wmh.38.1559549526778;
        Mon, 03 Jun 2019 01:12:06 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id x83sm12809175wmb.42.2019.06.03.01.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 01:12:06 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:12:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: stmfx: Uninitialized variable in stmfx_irq_handler()
Message-ID: <20190603081204.GG4797@dell>
References: <20190515093141.GA3409@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515093141.GA3409@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019, Dan Carpenter wrote:

> The problem is that on 64bit systems then we don't clear the higher
> bits of the "pending" variable.  So when we do:
> 
> 	ack = pending & ~BIT(STMFX_REG_IRQ_SRC_EN_GPIO);
> 	if (ack) {
> 
> the if (ack) condition relies on uninitialized data.  The fix it that
> I've changed "pending" from an unsigned long to a u32.  I changed "n" as
> well, because that's a number in the 0-10 range and it fits easily
> inside an int.  We do need to add a cast to "pending" when we use it in
> the for_each_set_bit() loop, but that doesn't cause a proble, it's
> fine.
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mfd/stmfx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Could do with an author's Ack here.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
