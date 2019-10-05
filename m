Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66AC32792
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1552D222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZL7XnJSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfJEEBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 00:01:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJEEBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:01:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so4067232pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5hylgRMeRU8L9fHC/1Fb4E//rkwEdbksV9F9/mIRbA=;
        b=ZL7XnJSQG3L3uQDFU4czS6QDWOm9UGODjWe8twIXjS5XOj1lqsERlLXOaoDIskWGHy
         6z/Yzl09u40RoGg6/DCOkTTjF7lInbF2TxUcC+T5yOmiAEj5FKYFD/o/Qv9gQwrXS58k
         JQgHmXH4W8zDjaGy8RSBw6Qc3w/bz/QINI7yzHkQJQ9loIb6Bhq7nWT77w/93ft2RKAf
         2XeffjCIgE4yaQLDp3/l/RR/3gpii0MEEisdFjwkwaxU3g1fVr82cbaA+jZan2I57qNm
         sMjR/wxk592/TM9Gkp4YJbWYbTizqQBa0gkDJKniwRn+wal86zZFwUemuzGKQ88QRnPC
         dXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5hylgRMeRU8L9fHC/1Fb4E//rkwEdbksV9F9/mIRbA=;
        b=kj6aXXVR+fSgm6O+Yd0ONTL+cKUuZOqtSS+j9P5UkjOgNfi2OaeCBSuLzNOy6OpQDm
         F+PgTu3arKjVstebhYDrb5CodZ19v898RLVqQPkblXrEJ8o03Ym6y9zyIXOXKGnHsDRH
         A6SUm1ANRml8LYIhyNgbxRcHQgt3fIz+MteliyUwYiK0TfwLVzLXT82q91NS8oawVdz0
         QbvUhPBcVex1kGhwRsipg9yZfieh0PEtkmFIcHw+RgDdLU8ndqsP37ZOaqrCea7EeLZO
         mOSggyAqxQpPiSnNCNj7/Am9RUsUqOQSt+ovwgg4tq3MirQU6OrEamN5ZXjKB2qO+p/c
         riUQ==
X-Gm-Message-State: APjAAAWeZb02llVMdZDltmAZWt1Kmh9F3dgU7xS/hLyQ6QRI+EEmvk5O
        LcBynQOSQwx+rXIJ/TOdue75mw==
X-Google-Smtp-Source: APXvYqwtVfC9awsCX31ooNBVQ9ZPETZdMu5K40YYblKAeEdWHBXOtuqnI4Fa/lwyS5uv0R5M4KJ3+A==
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr18180654pls.315.1570248102165;
        Fri, 04 Oct 2019 21:01:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f12sm6064016pgo.85.2019.10.04.21.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 21:01:41 -0700 (PDT)
Date:   Fri, 4 Oct 2019 21:01:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     linus.walleij@linaro.org, ohad@wizery.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Optimize the u8500_hsem hwlock driver
Message-ID: <20191005040139.GA5189@tuxbook-pro>
References: <cover.1569572448.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Sep 01:27 PDT 2019, Baolin Wang wrote:

> This patch set did some Optimization with changing to use devm_xxx()
> APIs to simplify the code and make code more readable.
> 

Applied, with Linus' r-b

Thanks,
Bjorn

> Baolin Wang (3):
>   hwspinlock: u8500_hsem: Change to use
>     devm_platform_ioremap_resource()
>   hwspinlock: u8500_hsem: Use devm_kzalloc() to allocate memory
>   hwspinlock: u8500_hsem: Use devm_hwspin_lock_register() to register
>     hwlock controller
> 
>  drivers/hwspinlock/u8500_hsem.c |   46 +++++++++++----------------------------
>  1 file changed, 13 insertions(+), 33 deletions(-)
> 
> -- 
> 1.7.9.5
> 
