Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98943C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E320874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uL0P0jZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437184AbfFLIcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:32:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54979 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437172AbfFLIcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:32:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so5598894wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SCbAKtZetnO5Z22X20EZ6GG20W2TItgwn42uTS6LP74=;
        b=uL0P0jZV6KYM9+gGGt/TmrJ477DVL0qT+1CFzUMhiAsCmdorZUxLXfvQ+mFtC1d5KA
         eyZtozvyTTC/uCymmI27/Zb/2POkSSFm/z8Tirs0QyqNiGEGmj+Rr56SqX7gGwtVJ3tK
         /cwsuhDmpOMJdN6vW7nriByORclvUP8aSllBTF+mM5q61eyl+kAhlkbzCghxuhkOGq+R
         d97VvfyJE/CDDDZUvuGDRHtk7rF1ohbXl7x15SY5dHrURaHQJaPUc5+xFewCjJZLSLMp
         bmXLnUn6jpGMK3p4FhvgowaT4sHe7CLHSwSfqOCCXRaXvOgX0OyALE+OtukOSCgBnkjn
         l7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SCbAKtZetnO5Z22X20EZ6GG20W2TItgwn42uTS6LP74=;
        b=qsvLqasJ8ZbgqJDfQyAHqVuFCAbV1Yehloml5tWK6cmqTBfUef9lVNTF1PwSX57il2
         Ss2mzya/dbnjR1CGivjxpvMGY1tCLX9ugxL+kCWd10GGHdMahTPiWfapeqV20F3XibaS
         4x/llzhazuFXBeYLVFJSeCJB0zDSbyNGEDj1Qs1DY4BxV0euSJCl7GVKYNX+rZxpnYej
         qCD+GW+QWjMcpb4KCHGrnlZYpF6Ecivxc/qNhCrDZSYCEtJIo3GyT6X6iGlqx8K2xjNP
         e9iqGVNC0RURkssEevr94JtlRS+oNQfkYTjvU5paVtZv4jMuNHohraPR8H5FWj1+/E4O
         16cA==
X-Gm-Message-State: APjAAAW5clydJ1u/U3louoXnmjmsaxMEPmwN+s0Y9kpLcqvGGETf09rQ
        W8c3j3FY4MT0R4lHEBOsH0ti1g==
X-Google-Smtp-Source: APXvYqyCyBRn8P3jhZrt9QzMD5iHTN6JSPV29E5itdR4GZdzttcCYVL1p8p8Bvcf7ZdV7xlXu1ytGA==
X-Received: by 2002:a1c:1bc1:: with SMTP id b184mr22631453wmb.42.1560328322104;
        Wed, 12 Jun 2019 01:32:02 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id x6sm22052044wru.0.2019.06.12.01.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:32:01 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:31:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     arnd@arndb.de, natechancellor@gmail.com, ottosabart@seberm.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 3/4] mfd: madera: Fix potential uninitialised use of
 variable
Message-ID: <20190612083159.GV4797@dell>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
 <20190520090628.29061-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520090628.29061-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019, Charles Keepax wrote:

> From: Stuart Henderson <stuarth@opensource.cirrus.com>
> 
> regmap_read won't set val to anything if an ACKed bus fails.
> 
> Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
