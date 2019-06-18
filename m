Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3EB2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdJUUnfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfFRQ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:29:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33945 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:29:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so218842ljg.1;
        Tue, 18 Jun 2019 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4q8d4fxsPgs4M6ir/dEft8nMebwBlWc7Y3opWmNrzjI=;
        b=YdJUUnfNMd8dDECZZx5+DNhyMvGb0M/7lEUSAPomERL7HHxJvdYleQg0i30f8EPyai
         NTLbp7aEYRXHqlWRyOFKlJHek7o0MBolxxDpH+dEjl6q358SJHEUgzE9XnRbV+nw/KF3
         CVV/FwGPnDVYxx3Ej5dFJIcGeflJTVS1yM7pxayaF69dh2j1IftSLLqdlkqWVJFumzZQ
         F1Tt6UCqZ9ix42G6Ry1TThKB3QcpIX6Zk/L0VrcQ373cln1IxdFZc7PTaGmSgqL5VI09
         kiDE4NVneGTtLJ9WCJGpixHsZSTCplTAVnbY52K0aLQGZbSl2cCkKgUitHmRqLvime3a
         WG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4q8d4fxsPgs4M6ir/dEft8nMebwBlWc7Y3opWmNrzjI=;
        b=Ldw4sq21UyV0fSMGmjGV9IrEk6VdMq5DXnAZxh/qcsrsj6g74NRbIg5WfZPMRPKdDQ
         EYJaL+6uy1GFKZXhZrpuCtt69kX659YMyvfLmvdl9vbAIPTReLQtLXFwoy9yIx/Nhoqt
         +M/IaHx1TwzbyYVLZ3SQ9+6ooWcnfsENNqp5L0nWXbhrtxjCBWifrUUrddP3vCBC1g8D
         m7SDgGz9Tp4gGRkJQC7KemFZgt6J49yinHjqRR7w4YGdseH9WWvOqBp2ClZnQ6w5EOlN
         apoApslTvGLKMZlSqMvNDR6ChNNy0/gwBpLZWLqO5mpLkJ0tCnZyRc+5BnE0g/UkiPPt
         Yu5g==
X-Gm-Message-State: APjAAAVwqDlSwFqgofWd2R3IxnYcj7uTowq4hJrZbyAI4urBybPO6acf
        Wk7f63N/jwyKb3Xb0i75kbKVhVRS
X-Google-Smtp-Source: APXvYqwzIqCd8H8wtmTUJkqjeNuP8mbxR7gJbEsgeOORwRQ/iw/WrwE0SCSwHLRZyjsR7gZlKgUj6A==
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr3235615ljc.38.1560875387542;
        Tue, 18 Jun 2019 09:29:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id v7sm2723693ljj.3.2019.06.18.09.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:29:46 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] regulator: core: Expose some of core functions
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-4-digetx@gmail.com>
 <20190617153259.GZ5316@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f0a83ad0-a6a6-52ae-6184-4908e8dd19fd@gmail.com>
Date:   Tue, 18 Jun 2019 19:29:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617153259.GZ5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 18:32, Mark Brown пишет:
> On Tue, Jun 04, 2019 at 02:58:59AM +0300, Dmitry Osipenko wrote:
>> Expose some of internal functions that are required for implementation of
>> customized regulator couplers.
> 
>>  include/linux/regulator/driver.h | 11 ++++++
> 
> I'm a bit dubious about exposing any of this but there's no way we
> should be exposing it directly to random drivers, this needs a new
> header so it's more obvious that normal code shouldn't be using these
> interfaces.
> 

That's a good call! Will address it in the v3.
