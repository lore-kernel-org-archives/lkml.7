Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B4FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A165215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuQm7M77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfIBJdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:33:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35829 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbfIBJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:33:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id n10so3150261wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0xz9pivsW1X+fkzwGjMbd/cLw8RxLJr78NFgGicHx+4=;
        b=PuQm7M77gK8TDYqSFSZJw0maTSHeRE5xrz2Aa9bPdCEdHGD9LsffOUe7gOgY2WOKnO
         pJmf4ac2qqXgwcYHOn5rS1idTHSiFp+TOizVesX0pCdgnjnTSvE9Vg6d29M2z0rhD6Wc
         rUtgDTUGNDnKsumVf5wh4wJfNNGJWszCvGOO4/iBoTI8hplEqtCJQklxK5FdIG//TZx6
         UAsBiUcoJ18897FkinJarrVjJqEzSDA7dD7i1D6hBl8KTZA+EXILsmEPJ8nB9VSW94F2
         7+YBs9gGPXpiXHaTtIb2puqeBfDi1KEc8saThL0xltfGjZv+hWQXcb7FUW7BAlS3MKpz
         BfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0xz9pivsW1X+fkzwGjMbd/cLw8RxLJr78NFgGicHx+4=;
        b=YhN9t1NZh5nlEyqM4BLdc6Rv6cwqXEzq+CNR2H58kDTAefkxH83G01vND0hR7Lfgaa
         0BUBptFr4d2O3Aikgu2qqWBNzws/gHH7MAiUNszNcZFZ+dwLEcbvHOAL6pGdZK1qlkkO
         P114HxmMpYyAncpslHX4aCRinBBg3dn3zOzK338nu/NpbfCk8LdDDkPpl5OAeEsbLVZZ
         SDZrOltHYYnH89/AO9brMbmxbRZAM86ETFh9wOqT25hoCAi0+OoFnQpAfs2GzzJ/WtuU
         5dXLa/mSBxk9wSs89bINABvLYriKq7qXXb0KHbYCcfdZjCGCKHjaPYYYJAq0QnKB2ezE
         oM2A==
X-Gm-Message-State: APjAAAWR25T0HA9esgB3ApEHNCIu6wQuUxNt3mdl8mSyyq7V+HQQ7v4p
        Zlds/Yil5XBULIiA9zB98asYSw==
X-Google-Smtp-Source: APXvYqxHpHyKHeVnNR8LoYA2/Xy4ZP6iMCFRlAgWlGkxTezTtxF6pj+ynxkTmffkjEOCPkaSSBfDzg==
X-Received: by 2002:a1c:a984:: with SMTP id s126mr34839595wme.26.1567416824468;
        Mon, 02 Sep 2019 02:33:44 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id f75sm20403518wmf.2.2019.09.02.02.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:33:43 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:33:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] mfd: db8500-prcmu: Support the higher DB8520 ARMSS
Message-ID: <20190902093342.GJ32232@dell>
References: <20190829112501.30185-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190829112501.30185-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019, Linus Walleij wrote:

> The DB8520 used in a lot of Samsung phones has a slightly higher
> maximum ARMSS frequency than the DB8500. In order to not confuse
> the OPP framework and cpufreq, make sure the PRCMU driver
> returns the correct frequency.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c | 40 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
