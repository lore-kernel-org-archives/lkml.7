Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216C821655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8kJxphP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEHLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:11:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39564 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfEHLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:11:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2719389wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NVYGOZcqjk78nflqXOFona2LfzGNJNT4gdq4AY8AIEw=;
        b=K8kJxphPZjrzRcD2kCbNStQL12MyFr4laIHIBXmGtmvmN258PuBxH/FJNcYbFMtrmP
         FeV0S7uUVLg02wK0UetEetYIweB43aAQKVZeSAaQmRF927HZUaajugaHChRjZuVFn/ef
         PUPuC/+GDuUDPgRCnPoyOVezIVNSNKDbXJ8iWBgMiMB713ZW10Dnk7j02m/S2WK0aJCk
         QS/ZrrwnbpjLazij1KtO/KTDmsBEgexPdIb1pqqXd+7sFcslFJDlY8aVgwZzn9ITsQeI
         6IzrzfkSTCB6/5F/QHWood4P5k/0d1s1qHNGm0mAOePeGioKocrZqReKqUujVOKLF73a
         8vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NVYGOZcqjk78nflqXOFona2LfzGNJNT4gdq4AY8AIEw=;
        b=PXd40jNo64eyjWHbSGBUcWkiMj7AYfUd4rN37YpUIiLCnBocLNUHzqsU9DoV2l1nwI
         qGMHIA7V8XyXrDyGR+Q0Ac+Xqs7dg9Ft4nnoDYN2qGR820vWtkxhIidyrj+e52aRil9d
         Te5AVRuPd9MKwtNhufK88700dunHbO1mPfNlmFTn7OfqKS2u9yNH1EIo/y95hdTPxqvq
         6UujGBWhfH1a1kvdsTCtNqgvxljS476JUt/WvcdOwinL68hW6f5VZxeePAloJwP0OOlE
         sEWVVKAh4zQvy30jnPJCQ+bmbovtJzVFiQfLs2bBR5C5eVIzF16SWw5wZRUDo1Vlc1OV
         jeeQ==
X-Gm-Message-State: APjAAAWi3u6HY2EoHK/0x+Sy89AoZelitV4pltGcFtL2anUlN4GVaqRW
        /+3ysFmmeJgNSN0x4Cw/LLy8yIM9IJY=
X-Google-Smtp-Source: APXvYqwcU01G6ndTzQz1Y4MJtFrGZO15pRBrIU8F1lFAZGr6QxxEeMP9xnO/lLu31doNjDITWUsOPg==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr2623521wmc.12.1557313912890;
        Wed, 08 May 2019 04:11:52 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id c10sm35550508wrd.69.2019.05.08.04.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:11:52 -0700 (PDT)
Date:   Wed, 8 May 2019 12:11:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: ab8500-debugfs: Fix a typo ("deubgfs")
Message-ID: <20190508111150.GS3995@dell>
References: <20190430151726.7032-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190430151726.7032-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, Jonathan Neuschäfer wrote:

> "debugfs" was misspelled.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/mfd/ab8500-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
