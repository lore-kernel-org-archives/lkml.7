Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D79C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F15B20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3Xv1j8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF0NqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:46:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33093 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0NqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:46:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so2686656wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xO/FZbl29nuBOdiCZY2u/8ffocQ/7vIi5f6s6E8O7gY=;
        b=A3Xv1j8uBRAIvTKd5ynFCw0IqmCkJEmN+w+ktLJH3XW10VDsu4bE+gMP1OflsVJpoU
         eiBFa6ip0eZCalQrmz5S0AYet76TcLMy3gabF3XZ4/CVd3s/BbHh8aaVlE0I1SamX+Lh
         c00sAC1Y/Vf2kss3inJ99nYM/yJcTQ5oAXPW6AiS7g2ImYYni74wJ8394YlH0BU6hptE
         edWKmDsDHM6XQMg5exIDgSIgaAEivEqrW0oEPVm4qq7kOTqkqRpUyHvGElg3xJHqFt1d
         WqoLjbC+xcXmgrtzYhAQS3QRE3ylp9Zf3tsfbi8gRQ8aA0esdYQZ9IuQQPp8LcK0UWxN
         DAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xO/FZbl29nuBOdiCZY2u/8ffocQ/7vIi5f6s6E8O7gY=;
        b=sFqjJkcX1y1bHr0nR9Ft7JXaMPbP4OJr5fKFTDSwIYiDkMCr4opjfYuLZ6/jWgzKth
         3ThI7+VCa20LMbdMc3nRE2onKLsuqKCxnPov9JqCcMnR8WFG3YmTq3JjV0tr6X2FG83q
         v7WN1XT/nisvkbBcGLkcAVX2KLH7LJ942a2BlxTLw8LTlFuGxWRMkUgDn13I7ZilhRHc
         vFhiVmPwoN+9DoVGlGkXyz0hMi050kRMT7xwbWcOgx5W5fsRvmRsw0Zx7bcHqxD/e8tx
         sKZCsw9Hy6UKa2vPdSQZ9zwc2YngZEiANqGcO8Vv49LhKqReCps29PrHefcXdzsDHjiN
         7xeg==
X-Gm-Message-State: APjAAAV9p/XkqXgOn3H5ATPfQe3CLT0tcYWisHwxEoHn7pRlGgtprAup
        BAHHhQsbTk9UKpbg9Nt2bf8IqUeUhb8=
X-Google-Smtp-Source: APXvYqzGM2t1mD3loma9emgLajloJkE9uD53bA5kqEvj7vO52R86XkI4gtwI4aIbGB1ijflhq8r8Bg==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr3135135wru.161.1561643162261;
        Thu, 27 Jun 2019 06:46:02 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id b2sm3161820wrp.72.2019.06.27.06.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:46:01 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:46:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] mfd: madera: Remove some unused registers and fix
 some defaults
Message-ID: <20190627134600.GE2000@dell>
References: <20190626133336.12466-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626133336.12466-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Charles Keepax wrote:

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/cs47l15-tables.c         |   2 -
>  drivers/mfd/cs47l35-tables.c         |  54 +---------------
>  drivers/mfd/cs47l85-tables.c         | 122 ++---------------------------------
>  drivers/mfd/cs47l90-tables.c         |  76 ----------------------
>  drivers/mfd/cs47l92-tables.c         |   1 -
>  include/linux/mfd/madera/registers.h |  80 -----------------------
>  6 files changed, 6 insertions(+), 329 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
