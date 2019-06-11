Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF06C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B3206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XIxL3van"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfFKO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:29:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43692 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbfFKO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:29:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so20393571edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EcfTiCsffQkaI+Cy4Vw69CL5IwRZfczcRgXiPSVSIEU=;
        b=XIxL3vanV/BoGlCosN7UlsPccmg8Ri4Z8jWnddxaVhRqyTSA97xSsXt4jxSXSMip0O
         HpFjrqn/vPjrVZMT+GeJYFnV9HKUuOHcxOOmIXtwvxxVEptP5nNbKMHcw25Zwbpt5xDk
         O298v3Df7onxgjfwyNZNwkBvKJi1f4y7FYoa0hEYG65ZtOyDeMsOfaKSZO+JsanpC834
         S2zaSeOhqvsaAfk0Jujd0TFA+Xl9+PKsQ7dWYUFQtH6acylZeup5URZAeMT6WhYZ3HwX
         kiZI3rRCQsNnIm8DqX7+/EL9zhGJPvTFhsGeDF07K2fy8wWla6yffNDEYa6lSQQxTU92
         5DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EcfTiCsffQkaI+Cy4Vw69CL5IwRZfczcRgXiPSVSIEU=;
        b=DHzHn4NA7tQEgeIvCQuhtjlcxDnvDYSQ2j9SrP5Ophvb6ZsGwjJzwpt3tL4nz2U6EO
         yGVBXTJBMz4m9gZ3Qc7DlLCGRSQxigCxQhSyQQ3sJB0zkGD7+G3+kwj8rnhq0av7tIYC
         sKYVmY91gjPK81K2aVcfZ4dKDx+lPOUmREYcU3qofUNRxMWhO2IlvmekE78wH/N3kAQO
         npbr0OPe1P05TYCiqdSBzEkwc4KcXKJWLRB4p8XcruGcHgR4gmwXO7gBa0/MwwkDNV7D
         kUYSZrKWBRHRh4hfaNBynLTU6z2JVfzcfHtlTRU/6Hc+xzGMsUwOKTKN+O23zRfGi3rR
         cQnA==
X-Gm-Message-State: APjAAAVSDb9Akho0AmpChQ9bBwpLvdArJ/TJAV7UZAFixbGKdEHwB8kC
        F6whECUPvSSwMXISd2ZyaU5LiA==
X-Google-Smtp-Source: APXvYqxbHgB3hqxZayzzwYf//1JUbrAUHjHKk5IFJ5cxpjXezsvGZFi9XeOdup4uWumqb5EpI3IoQA==
X-Received: by 2002:a17:906:e203:: with SMTP id gf3mr45163746ejb.210.1560263352423;
        Tue, 11 Jun 2019 07:29:12 -0700 (PDT)
Received: from localhost (mpp-cp1-natpool-1-037.ethz.ch. [82.130.71.37])
        by smtp.gmail.com with ESMTPSA id s11sm1250132ejo.51.2019.06.11.07.29.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 07:29:11 -0700 (PDT)
Date:   Tue, 11 Jun 2019 07:29:10 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Nick Hu <nickhu@andestech.com>
cc:     greentime@andestech.com, palmer@sifive.com, albert@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, green.hu@gmail.com
Subject: Re: [PATCH v3] riscv: Fix udelay in RV32.
In-Reply-To: <67bfbb11e64273427b125528a4e2bc83b5efe70b.1559199430.git.nickhu@andestech.com>
Message-ID: <alpine.DEB.2.21.9999.1906110729030.16050@viisi.sifive.com>
References: <67bfbb11e64273427b125528a4e2bc83b5efe70b.1559199430.git.nickhu@andestech.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Nick Hu wrote:

> In RV32, udelay would delay the wrong cycle. When it shifts right
> "UDELAY_SHITFT" bits, it either delays 0 cycle or 1 cycle. It only works
> correctly in RV64. Because the 'ucycles' always needs to be 64 bits
> variable.
> 
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks, queued for v5.2-rc.


- Paul
