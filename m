Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2517E208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqAFJzbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHLHrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:47:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44615 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfHLHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so103689596wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SGHeIRh8ezlsLQH6K2/MyQvs0INV6sLDvESGidgbLNA=;
        b=pqAFJzboaNQrIeklrekkZiKxw+jGjcdDc81Zi2DIOPOB7s4RDj+w5XeH9BR+lCDxzk
         X3wtmUAQvQ8k4decEL7kjMhjZ3Ti+Rm8nbb67zn1IWEd5ov2lGadNc3afmy6koqw3Nou
         G2bxnaHYrOso9zfIeOkX/ZD1bnKyPdwOG+hKSNm1mmGSXuLL1Dy5mNl5NzYjYafCkX+U
         ADdL4ClJZrpjiSpQ8CByBQ/+1nYLc4y7rGD+2pP0XbTpyIipfbVKVC/SI1KhSGQICpDw
         VH+qIVAmAmENFb0NKwWkJKvYbO6nVIFYxqrwEGl6jbyzuJNEY2JUnK5PzNw0uFIz1bnA
         +GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SGHeIRh8ezlsLQH6K2/MyQvs0INV6sLDvESGidgbLNA=;
        b=gbjtoiiLYAKhdS+IXogukeXe+iaPfLlwShEfLBFjHzxkFzO5hn/H7f7Bqs1aAXJ2UB
         ZCvJ+taG4ffjeV51q7AZrR10aDkAvYlgpTsPoeSZL+3OMOO0UV3OzDhcjuYskYBGG1XY
         Bj6NiAuqKrqHOd++WOcSzpGNoAHeR4Km4QInBmxFfjO/x5YH1ydP1K8fgd/mRnXLLdGa
         X0Zdcdn+X3okJ/H1F7UoGZZF4D29kAI4FemzfKrwuFGXejz4q4jaWl9yWzW95kz/uIKm
         TS9LwgRY4uXmGLDAC11ny0SpoEzeHW07gZUQWaLEY7WVyVcV08zy4Yppy05XzvjH49pk
         CaKA==
X-Gm-Message-State: APjAAAVKUxSiinHpHCSbsdZ/gOhX7+p9ipLHyxWweSN+OapMz/6ZUzW7
        P+WgtQtookXT+iRkrzvcNaETMg==
X-Google-Smtp-Source: APXvYqwxws2yQGkwcZJCpMCTsxXEc5Cqq/NDdqYAvJ2yWFDngyGxVF6e7xKyff8yFiKGr/PlaEbLRA==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr38450486wru.246.1565596022635;
        Mon, 12 Aug 2019 00:47:02 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id b2sm10326265wrf.94.2019.08.12.00.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:02 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] mfd: bcm590xx: convert to i2c_new_dummy_device
Message-ID: <20190812074700.GV4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-5-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/bcm590xx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
