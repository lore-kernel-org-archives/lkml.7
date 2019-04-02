Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA774C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938FA2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJL5w8n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDBEK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:10:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42484 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBEK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:10:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so5838120pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pIp4s/uZcJpfXdEIyppuCcmzflVMJ51Cq2s5rU3+TOA=;
        b=zJL5w8n31kIpGsJs+2RjKhMhF9rAUKht2R91mDcIx5V7vae1cVcjhobNT/otrwoDeP
         YAn+c44ylm63zl35lIIveVSpAPFqzAxYJJPR639DOp5tS9T0hB+glC8y/zTNV6y9bUQK
         /v907poFH4Hb26GP5Lluij8CNuxJSB1NHXL5EwtPV2gVQ0sX8p3fHSnRa1wPymGSLQYi
         vV/9lY1CAvZCTdf2VnV5U10MkN/zj2uYxHYadb19O1YlQ6w01Wqblw3safCucP7r8BFF
         hfLdSQwze7Oo9+Uf7kjjcORWyW84vZBzJNPzbEuOrYqSOToB6ocKHBlblAAxbGqRmYex
         tIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pIp4s/uZcJpfXdEIyppuCcmzflVMJ51Cq2s5rU3+TOA=;
        b=AtAamZZe2CZ2h/9B2CxO7ROwewMy6hlEQhkYVcpvbeqb5eTS+zrHMYPNTOOMdk5lHN
         Lq0M3+ugXjFN4Nc1XZEYrZmLZmL9Ssnh3VbRUwA3Gr9mC8UUukyyTtqfelV5SK+4h0hE
         KNTuTCRH88/BuDkMzTWr1+LZXgAAeLYKBJIz8xxj/4ADkrkxZKlLU3IjoIXX6sYj6rUw
         4MO0x60KpnDfBM5vYhO/9sfT3wqehUfeB9XHNRoQjBT7Qxk6DzxyDL8vvyRnhNMx1n4l
         9TxvJ29yxR6n7bfb4tcW1weDgh2lf9q+SYrXPecBYFtkmcrV/qot56+4axC6k30HXtjj
         ZJpw==
X-Gm-Message-State: APjAAAVNlHxudth+boPn2yuEZyKLTfFSGWwQvLw2IgTwV3mlXh+wIuxB
        ZKF1iCScIYDP2mB+vhzjlBHa5I1jg62suw==
X-Google-Smtp-Source: APXvYqxpCd/9TWbZY2zy/yhfZFD0a7SPohkD2IJ8e6Ff4ZQVpAIvqikzZ1HmWlsXTHpVabCiXbiQnQ==
X-Received: by 2002:a65:51c9:: with SMTP id i9mr8820022pgq.187.1554178256812;
        Mon, 01 Apr 2019 21:10:56 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id j28sm26352131pgb.46.2019.04.01.21.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:10:55 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:10:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 068/114] drivers: mfd: Kconfig: pedantic formatting
Message-ID: <20190402041051.GN4187@dell>
References: <1552310346-7629-1-git-send-email-info@metux.net>
 <1552310346-7629-69-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552310346-7629-69-git-send-email-info@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Enrico Weigelt, metux IT consult wrote:

> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/mfd/Kconfig | 62 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
