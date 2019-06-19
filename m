Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB3DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763E9208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6zaAPAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfFSF6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:58:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34026 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfFSF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:58:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so1929157wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v4Lzw69YqCGNT6d2yGg/IWB5HqmTYETWg/4G3e5GhcM=;
        b=E6zaAPAk1Z4K4tmdwrtkSOWC8nlnur95mxOoftmD56qCT5EXSvT6ycZbg/68lt02Db
         ANOwmUrYS8w8CEoIGQyyTc12+p7JBLChyKkAGMBvUm8921rg/86HOIoKnjA/G/R8389n
         OoRBu8SGvOjLJEhFA5uz6sPHwF/dhWNcH3R0aTlwJJfsHcOcmikrhYmCu1usEJe4lyTZ
         xN3ITGXrDBQodz+8qRz101FS4z+SouBbcBG9U+21yiSi6xIqsHcDAxzY3T1rlTCMg0y8
         ZGVDqtC6xipnmbNjTRJy0KVXGSMHUadcSXGoWZ7EkPIigPG06rZDh1hvsXAdJMmzfXJ2
         CxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v4Lzw69YqCGNT6d2yGg/IWB5HqmTYETWg/4G3e5GhcM=;
        b=n43kBWGS3u7TmWD7cCJBEY58bynrl7YB6Qeopswt8POjWS2FAfn7G32sLWUGvHk8Rr
         8jxY0nsdl2hN7WF86YH7mKHx0mQ1Qc8v2BJFIEMpHmY7DQI5oVLasoRF6XySHji5Dq5X
         tpm1jARqXo0gPYT3RhtixPGYAwbplGq+ImDxH3lQUYR3ZYDEs4kiCFhmWQQLaIpjYz4C
         tAKyMxOrOg/5aqr5dgsD1LO36TrCG4YMHtTDfndOg0v//0N/9BpQ/uDnUuJlkLb23f2o
         JCZ9ekh55femmUf/aNSnTPmEIMBebnJiaFDTE5EIdOnT0a6bDJbve9b1TRNbLtrAIglD
         a4pQ==
X-Gm-Message-State: APjAAAVtUnEj4rux2C+RtLgdvovjCtYg73H/rBEl6O9tXHg+mnHWu1XU
        178HKGs57OVEA9+WsDgvtNdvrA==
X-Google-Smtp-Source: APXvYqwCLJB9gv/cQEHgS6YpUkbFLxhQLp+LQAxMubEfU+V09+07SkfNFDSXxJ+QjUIfsER9MWzsng==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr39947594wrs.136.1560923898554;
        Tue, 18 Jun 2019 22:58:18 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id o126sm592028wmo.1.2019.06.18.22.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:58:18 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:58:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
Message-ID: <20190619055816.GF18371@dell>
References: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
 <20190617190605.GA21332@mwanda>
 <20190618081645.GM16364@dell>
 <CAHk-=wghW+AKvRGevUiVWwTqWObygSZSdq6Dz2ad81H73VeuRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wghW+AKvRGevUiVWwTqWObygSZSdq6Dz2ad81H73VeuRQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019, Linus Torvalds wrote:

> On Tue, Jun 18, 2019 at 1:16 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >
> > Ideally we can get a review too.
> 
> Looks fine to me, but obviously somebody should actually _test_ it too.

Amelie, would you be so kind?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
