Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EDC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B21821897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dHJuIjqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfIQJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:18:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfIQJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:18:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so2298769wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZmyRTH11FKZjg3p5bM7cG4+5udISP5256aWYiASckV4=;
        b=dHJuIjqRrMgYB6fmsR6dYurmuJBGEplDO2KM8mJBxvGK3M53S8DAFRSK5dQwECdgo0
         Gg2XAY0BNCAkaT/SxqegMe6rlZNrz9i6rFpfy2td6EfNmHUON7rzQkU/XovsjYJ90y+t
         K33DN9idOuOz2XnClLuxfxO38v7z8Im6sfNbjjKsVwPAwR1fnS5LVeIko7SxjXHIq7To
         4RWuwxLjux3xOfSZedVplKgwccufxiplMB1/w6XOwgDZtXsKOxNtYDoOn4L7uAF/gH38
         uXjC4ywXmgWtO77ZW45qC+KW/pWaepiGGlKxyoPYKN8gmJFbmPUmaBNo/nuwn2WUNtKr
         Ccug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZmyRTH11FKZjg3p5bM7cG4+5udISP5256aWYiASckV4=;
        b=tyCt2g5wedsKCRKcXs8spVsf4G4X6srX5/JIRy2IEptZabxkSkzcr0HCmUt6T9azCR
         BUNp8f+qVyEsy4og9SruAtVozw6gTCGBR9vGCaXLjhiyfnSHOqlryiBfvaI5cTHa7qtk
         IOwoLhuLboUz85DulSoipYdnNceESiGrZCbRNhVtdTLnQ1eU8YqSXbTC9Pumm4lWUR6q
         Z1Kn3DTreSmZzURx/8Vnk4eJLGcdjirkLXHmc3BVU+oXVAx9l5irD8AmT900i8EN1L0J
         dpdAGKfLXAOzd6/pn55rsPsmu/Vox4mKlgfO/LhANqOimpxzgjCH6mzERl6rzEUo5uGl
         t6VA==
X-Gm-Message-State: APjAAAX01fEWvZXWmps0bcs9l43jHdc2B7j3bjlemeKRW6NFLXk+LlOb
        /DA1YUWHcJSAUtlRlJcCkLEZJw==
X-Google-Smtp-Source: APXvYqzMcsMkF+IzOhVUpVJstLoCK/jTQlsQSur1FiOv4mcOYSPoHSHQehqpCbl+eHk03Y8y2kTFOA==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr2177174wrt.59.1568711894210;
        Tue, 17 Sep 2019 02:18:14 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id 26sm1849272wmf.20.2019.09.17.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 02:18:13 -0700 (PDT)
Date:   Tue, 17 Sep 2019 02:18:12 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     broonie@kernel.org, palmer@sifive.com, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <20190917085627.4562-1-mail@aurabindo.in>
Message-ID: <alpine.DEB.2.21.9999.1909170216200.4260@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Aurabindo Jayamohanan wrote:

> platform_get_resource() may return NULL. If it is so, return -ENXIO
> 
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
