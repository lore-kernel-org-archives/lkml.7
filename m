Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA378C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8660E21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyNekJfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEHNFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:05:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46244 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEHNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:05:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so856184ljk.13;
        Wed, 08 May 2019 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yK6lZQ5RuzRcv+wOgC6XMr6FEm+7QRFs6HWH5BwlilM=;
        b=kyNekJflza5TUlzyOAXxMSkwrd6WWuXL2ns2+3SPo5XBwBbvnTpV054tobjLV8KnnH
         bEsRoCgfBrVQuozXHXkFUaWQt1cbSny1tWguOUffWMXWJDZA8qSRk/ZOLxqix/ywopHG
         zemGn0sWYukabpxnES0Sd9f/2nt+eKpAJ6KasU0MOhlJ6Uqd4VkCCqMhfc0vx2xcf4/x
         7t+3MTmqENbckdI27TSXyqSQJyzG0RP8CKKMGfVNPD5lHaD6V92AL7Os/juXG1rsNjJ8
         RNFCLnaX4LALeMcFetmhgtPI52ZbwL2ebl37BuUC14TqFLAPE23PY1J2Q62oV7Sztw2W
         DOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yK6lZQ5RuzRcv+wOgC6XMr6FEm+7QRFs6HWH5BwlilM=;
        b=qisQhNY/foRZ8TLpVQWrUqYphl3DD4tQc68juKe9wPkpqQKbrJokXHgDoJK/+YHGxT
         qG9Zi3EtcSOAp21YppUBmMtuzZO2H4Z3PizqUvzM9TiG4Fa7EjjczBd8guBVRiL32XUv
         /H91QPe6LOMGVGF+JRexOX05GaFkA4MSbgpdBy1JVktZHmNWd49PJyFlj/KZ39CIIXP9
         bZXnS6rbGU/oPsqf2ZK78hznRHuqb/RP05OnyGu3zemaTPaHmaq2e6vaCYNVxh1B/Zqr
         ZVEMkWD0OkxP9NBOGL9/cx3kojkcpDHRVWB34claoJkifrduMSDKrmyMUqAZIPkl7hW6
         ea+A==
X-Gm-Message-State: APjAAAXhW1JZP72nd90JId9Wc20f9ZdXY+v3KhT1dYUZ1J4EA5/wadIj
        h8hqgGCbH2AhFqII3nimRQJmKqkq
X-Google-Smtp-Source: APXvYqyCJTzduk6QZN8Is804Qd3hz5KKlfVCqF0AhMwjp8Brr415n5lDxSKVjz5EWJSuuZYw3rqCfQ==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr20897427ljj.192.1557320734442;
        Wed, 08 May 2019 06:05:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id n4sm4025793lfe.15.2019.05.08.06.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 06:05:33 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/6] regulator: core: Introduce API for
 machine-specific regulators coupling
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-2-digetx@gmail.com>
 <20190508075542.GV14916@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <674a93f6-0d35-c558-72ed-45a66f8c8c3e@gmail.com>
Date:   Wed, 8 May 2019 16:05:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508075542.GV14916@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.05.2019 10:55, Mark Brown пишет:
> On Sun, Apr 14, 2019 at 08:59:34PM +0300, Dmitry Osipenko wrote:
>> Right now regulator core supports only one type of regulators coupling,
>> the "voltage max-spread" which keeps voltages of coupled regulators in a
>> given range. A more sophisticated coupling may be required in practice,
>> one example is the NVIDIA Tegra SoC's which besides the max-spreading
>> have other restrictions that must be adhered. Introduce API that allow
>> platforms to provide their own custom coupling algorithms.
> 
> This is really concerning since it's jumping straight to open coding the
> algorithm in platform specific code which isn't great, especially since
> that platform specific code is now going to have to handle all possible
> board specific restrictions that might be found on that platform.  Why
> is it not possible to express the rules that exist in a more general
> fashion which can be encoded in drivers?  I'm not thrilled about later
> patches that export core functionality for platform specific use either.
> 

Indeed, it's absolutely not the part of the idea that platform specific
code will be handling board specifics as well. I just wanted to KISS for
the first draft and will change that for a more generic solution in the
next revision.
