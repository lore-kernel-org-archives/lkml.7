Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833FD208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqBfxw97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfG3KFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:05:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51865 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732336AbfG3KFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:05:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so56564840wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKHPgt351A2QI/YnAoBew430R/eEud4lktf6EqpjGpg=;
        b=RqBfxw97A4nmG8mtwYF0ixTRO1L2KitydpEs0s7A9mThwfv3W3lssL9LdVrwBCNSTL
         6aTa3QikOhqtxE8YBtXu8RFvVtc0749oRJnZzvfR2Jf1aXTQ1KGUb60z4+d7aqpxpuFt
         Yimlk5DPLJT8+c3Gvq8/wpNlwQDJoT4InUI8dySJ+VfY9eE2glqRn98uvt9rstvIlgkb
         ujoyIDTr3IF+RcBEuw60GT1gGg+/z6IFD/bcphdQG9oFzRNxt7d2bV96UeLvKqZPqa1G
         57xWhKorvU+Mz7lw8uXpGHPgX4epyPFoX+aBQbvdKc287NFLi0I40AcA5VkoBBcGPrrB
         cI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKHPgt351A2QI/YnAoBew430R/eEud4lktf6EqpjGpg=;
        b=et3Gd+pg3CNL7ignxuufq4EwJ8JX1xfM1CT57X3lGGID8MxU6Hs5ueRS3xyR0WqfMY
         KFCMWBUztDvTmXasenYFOlIBebtcOrIJ86Lio5iMnbI5IdmzwZJjJN95v2HL5l4t+3LZ
         ymLXZ4efjTpi1f+FGJjtGNeuFTrzjV3YU52OdswUmXGoHH/kMpW4KDpDDBrDjfY0T/1t
         i/RPi5SDOlhZgV4v0M91+dNRLNJxjocTCc7kcPf5r4ZhbUATUTdxcVqLi3MyMpsASeux
         7M447YM+Vu/moetnYdgKg1Vh8H8l+9GNfIpuLuZdPUP3HjeJXxYoR/o1V49GNMD1C1/I
         A8/g==
X-Gm-Message-State: APjAAAUHXP1m8ACGgxt18Jd4c8s0oGHBUtVp8+03EN8SDO80lQCPXDc0
        fZOqmCktKUDJiZPJ9f04Qg3ahw==
X-Google-Smtp-Source: APXvYqzMcRBOGS9JyQwlv9X1JATjMYuUOHXer2CbHw/UNsXtIbzYshroVuyxhY0awf3K6l7Q+DIEDA==
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr101927560wmf.137.1564481137788;
        Tue, 30 Jul 2019 03:05:37 -0700 (PDT)
Received: from holly.lan (cpc152527-shef18-2-0-cust115.17-1.cable.virginm.net. [77.99.252.116])
        by smtp.gmail.com with ESMTPSA id s12sm59321417wmh.34.2019.07.30.03.05.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 03:05:37 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:05:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] kdb: Replace strncmp with str_has_prefix
Message-ID: <20190730100535.iv7blrsktbenjfwv@holly.lan>
References: <20190729151359.9334-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729151359.9334-1-hslester96@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:13:59PM +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  kernel/debug/kdb/kdb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 9ecfa37c7fbf..4567fe998c30 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -830,7 +830,7 @@ static void parse_grep(const char *str)
>  	cp++;
>  	while (isspace(*cp))
>  		cp++;
> -	if (strncmp(cp, "grep ", 5)) {
> +	if (!str_has_prefix(cp, "grep ")) {
>  		kdb_printf("invalid 'pipe', see grephelp\n");
>  		return;
>  	}
> -- 
> 2.20.1
> 
