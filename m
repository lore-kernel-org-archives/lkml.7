Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F55C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9D206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhxMaYDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfEOLpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:45:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39751 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbfEOLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:45:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id f1so1747979lfl.6;
        Wed, 15 May 2019 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mUy1je0IIPUFedYE7Ug9F2Gjdt7jwZe0h7nDZjYmm7Y=;
        b=HhxMaYDABJSSM6XGK0JrZcAExbjVZpiZSBdB1aDNBn7mf9mePa71fOhDs1kTouAhes
         GQCoQ5NBEYKlqzmFstALTi4I5T0OqLnfBiZy4ZigcQRCsL33aXE9SE8+KlQDDmHq/GHY
         sMvzCIWUH3Zy56Xq/Qml98I0ugBvbgeRS6dxgPm/2DfkVdyeWwgK/7sVtT8VJxTKS5Cr
         9jPQeGegROpenRV+zWqCd5wo2MC+fotHkp0/fULj/c/tGhJCxT84TrohnjVXfGeknUQg
         XCeFF7bQ0BM4LJ5eKjOCA+WlDQ/EJMsG7IbSaYd+ReoSuKcDKpnXDWtDQ1VNQ8XyByIx
         6EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mUy1je0IIPUFedYE7Ug9F2Gjdt7jwZe0h7nDZjYmm7Y=;
        b=X6PHCI+k4/I7vmYFIkbfUfZ2kNdx3H1HxWBxJ1LxpJ0TfvJO8T5JHI0TNUz3KBkZay
         mGk1oVMzXi1gMgGVJAMKUkf+P0x0kw5BT9juyHHBP7PiaxOmqihV4Kwg2ZDqr55Vo9H7
         Suynz4eOtRu3csaXPSiVP8vyaP3jmgQHo/yK23zCde6pUwWUn6r+ERv4XOMd6S7jntl/
         K9a42Zh/e1XMw0JKQxhhqq2cYBrbNsvM1Y6jhleOFf8Y00cPX7p3qOQOCSfkHdR0lOiP
         ibtQBwhhI2gEDtXpbgqkEg74fkrLy2GlpgTSvWwzrTPpOOU7uEXJZnCRMa77fUFvPITQ
         L8Xw==
X-Gm-Message-State: APjAAAUkjYPs8YRoD4dw4qmnvO/TV/EMtCFps78v9DAObC8+O0g7OWw9
        qD+CWTDtSAHpwun+hJ7Dehg1OXxz
X-Google-Smtp-Source: APXvYqycCnOMw8rry0esZ+lXyPteNia2a59tl/Vtxt0BkGqym6pa0NfbDPGAAr6Y/Tm30kAbIC7rcw==
X-Received: by 2002:a19:4acf:: with SMTP id x198mr19797849lfa.7.1557920714019;
        Wed, 15 May 2019 04:45:14 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id y186sm343648lfa.14.2019.05.15.04.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:45:13 -0700 (PDT)
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
 <20190512090446.GN21483@sirena.org.uk>
 <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
 <20190513174000.GH5168@sirena.org.uk>
 <9e13bbd1-ff28-1570-b1a6-0cc6337b8f6c@gmail.com>
 <20190515090557.GB5613@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3be50306-d3e0-f931-9d6b-0ae0ad5c78ce@gmail.com>
Date:   Wed, 15 May 2019 14:44:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515090557.GB5613@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.05.2019 12:05, Mark Brown пишет:
> On Tue, May 14, 2019 at 09:30:05PM +0300, Dmitry Osipenko wrote:
>> 13.05.2019 20:40, Mark Brown пишет:
> 
>>> The thing with OPPs is that they specify a whole table of values that
>>> work together including regulator settings, the result being that you
>>> have many fewer options but don't need to think about constraints.
> 
>> I'm afraid this is just a way of abusing the OPP's. I actually already
> 
> There's nothing wrong with handling regulators in an OPP, that's a
> totally normal thing.
> 

Only if those regulators are directly related to the hardware unit,
which is not the case here. Regulators coupling is the right abstraction
that glues things together, there is absolutely no need in trying to
make workarounds using OPP.
