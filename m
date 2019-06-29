Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECDC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D11920828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XT1vSftJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfF2PnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:43:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45216 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfF2PnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:43:19 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so18984937ioc.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sOx1hbPyZTSyxrijx5gkB9/AvD6BlWJPkD8kP2n7Rk0=;
        b=XT1vSftJh4vXYeGUSNXOGJS41ySgB3A+ls+Rp911xHb4NxVBSvKmGuhSmBSP2OBJ/+
         f8EgWwh3K3tNK4exbSH9vNdpE6rUChyANqP9Nk3Rftjym++2fJ/t1js6xZjPlVfrvJp3
         UlGemSUY2rGTJJuFjZqL5EaBRKrSDiHUAemQdQw5uNZW58iVq/TN517DaCje/7ZthOjm
         AqSUchTpVbnELVcYA2wFPXu8peiqvhL+vh2SqbBctYo2W1zdxlJzEAMQa2uzrcvm/XSe
         A8RSGiwKkgGLmQsIqeBPrRc8glqVQQZLFhUUz6s1BSRYV31CcYPK4YvqOrPVJYZL8gsH
         xi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sOx1hbPyZTSyxrijx5gkB9/AvD6BlWJPkD8kP2n7Rk0=;
        b=mijVGASg+E3YO8RtvO6GfZ6m2FfMOkhyKwF7qSIJbvLOwX5M2SNMOLCTlPGa9J5Y9E
         9T+HP2qoI4vLgUddzrFFwwf8c6Kae1F+nKyAq8XO3wegLD8bJaYIbM7Bomecm0sE5Q6/
         nL1z1JsOlyCw8UPb0ggM5LjOUeG+FNFOL9u9iKq5fi9LMGycGc/4mGA6VEgNfk80uMDX
         0aWM24QxU9XE60AmkvRbF6OkAbddERYkIcMM0rfZw/rUJhxMasqFuSnxrPzLMDbGnZG9
         CfBWKjvtAvAiIMtG8b1acqMTgQZUQvNewZ/wiSsqIo4ezoKT4K5CZNrSgQlpIB0P60al
         mZkQ==
X-Gm-Message-State: APjAAAUv6CtOb7sff1PlBpIDOdrG0d0DHmj54t20jP2+TcDgLMEE/uzc
        LQEStB76UqAczuI/kjQ3PeajXNt4/+yfRQ==
X-Google-Smtp-Source: APXvYqx0Smu0Bzy2x6EEOU+5J+Uk5t6GL4NayykldjvS1X8mFcaLskdcqJvUiQmSysEF3OgCKPmOQQ==
X-Received: by 2002:a6b:f711:: with SMTP id k17mr3362605iog.273.1561822998325;
        Sat, 29 Jun 2019 08:43:18 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p10sm6715393iob.54.2019.06.29.08.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:43:17 -0700 (PDT)
Subject: Re: [PATCH 02/87] ata: acard-ahci: Remove call to memset after
 dmam_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190627173346.1933-1-huangfq.daxian@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8de5399c-aaeb-5c51-6d78-63292db2fbaa@kernel.dk>
Date:   Sat, 29 Jun 2019 09:43:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627173346.1933-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 11:33 AM, Fuqian Huang wrote:
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dmam_alloc_coherent has already zeroed the memory.
> So memset is not needed.

Applied this, and the rest of the ATA related patches, for 5.3. Thanks.

-- 
Jens Axboe

