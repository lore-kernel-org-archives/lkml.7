Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86644C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4993020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aimmYDKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfCJVTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:19:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45606 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfCJVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:19:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so2349805eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JKG5xdlN5NKxquHkjkAuYuyTauOUTcmnssUoglNZYPs=;
        b=aimmYDKRx0j4HNw4oE8ktvwvViTAS/3d2e4oR+DOP7hkuhiC45pigimGr2+qq6aYBn
         wDAYBMLFPe7ersE5FwQ6VaDWdGbZcS9zgNkl9aLVvsuswinA/71FlNf3Bljl5D2qxepF
         MXoPQB1qVC0tZjpiITH2ClR61gbURrEFbTSYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JKG5xdlN5NKxquHkjkAuYuyTauOUTcmnssUoglNZYPs=;
        b=n8osNrs5ieuQ8ZK2b8KmF4X4i8WhvcVooR0C2l7Hnh0dMcuQ1Y+r7mPCc5vl9snKwz
         mUadgXNshwsq/hqd7qd2YJV3u5a29jQMG8cAVHcE8WqvDjUKNDx74aO+Y9N2S1FcPT8J
         F9ekuNQOAkhh6Wig6koNgYk7DD4xaIRxG34B1ySmDjYLErNKVJjZxivgF/7hPzs1S8Vu
         19Df/FPuTiZBHmHNyeU/RR1N3Fff2FLStPuG9/8mNDtlGJZSl5/neGJi+sxBc7/wj+Vz
         Zzf497/wo55g8zSolUFMqugBqvLI/C7GhmXCR8jwp3cffdCb+LqYzv2RvbktqW0I8H/P
         +klA==
X-Gm-Message-State: APjAAAXCwA3PNSQVk6S06xOB+p27AUVAOy5/WkvcTB9Z0PcQi1q5OXG/
        /v8rzsvvBNL+cGEc0dtDC7+68rPC8Jl2IQ==
X-Google-Smtp-Source: APXvYqwe2fXd6j2H2Dr+bqjGl2sjVWEG8kX552HjIlPxmw8tZDXDFezbBYaJWD+3n2tGk4bhvhHvNQ==
X-Received: by 2002:a17:906:13c8:: with SMTP id g8mr1423550ejc.49.1552252778959;
        Sun, 10 Mar 2019 14:19:38 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id l15sm2608112ejn.77.2019.03.10.14.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 14:19:38 -0700 (PDT)
Subject: Re: [PATCH] static_assert: move before people start using it
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
References: <20190310105157.GA15039@avx2>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1d957ac2-3423-2471-6b7f-f6f25dd0273d@rasmusvillemoes.dk>
Date:   Sun, 10 Mar 2019 22:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190310105157.GA15039@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2019 11.51, Alexey Dobriyan wrote:
> Userspace places static_assert() macro at <assert.h>
> 

So? That seems a rather weak argument. We have lots of interfaces that
also exist in userspace which are not declared in similar-named headers
(e.g. we have no stdio.h, which is where snprintf lives). Not to mention
that memcpy and friends are in <linux/string.h>, not a bare <string.h>.
Your assert.h would be the first and only header to live directly in
include/.

If you can somehow convince Andrew to take it you can add a Meh'ed-by me.

Rasmus
