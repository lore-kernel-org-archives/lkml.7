Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1104EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF8521473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4ldITgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDCFOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:14:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35305 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDCFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:14:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so13650380ljc.2;
        Tue, 02 Apr 2019 22:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h45M3N+al39KQVnHd20i2OCw5fAE+ZOWCaq99/cObhE=;
        b=R4ldITgjX9QltSmjZg0B2/tgsbhBjIJzZeN3mA6q0yhTivEhKNwFqRUl5ddLVHvQ4I
         8JpYTrlFUHnJ6aYkC0mTJKw8tBC5k7hpI1B8faeGjVYvlq7nOTu01J6ZXCtqWK8xeQ6f
         dkQrmsp+yiTG9kJmbzsMcblU/d9J44WUt2UHs+FSMsY0sUm1cNL4R5zqYRVlE1o7+qW0
         p2WyZ9d6pF/0B8Nv8mOz2h1KSNeTSyr5A+IH3OKCbemsT/xxaUN0INFsqFrnH/hlHws+
         OKnUTml+XGgP9pKZFNY53cwFNx17bUyYkWtKQktRSv7ZqbVb6Njczr32AEjokL7Qs1mP
         NnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h45M3N+al39KQVnHd20i2OCw5fAE+ZOWCaq99/cObhE=;
        b=eo7/n8HhiFnLBf4NA+0e3YpXElbjxSLKXa38OAhk/uepfbsFJ9ZwEuED+fdiZoLS/8
         liBSwjWD0J45sTktRCKS5SQuhLk0TOUBktNkszc83JQwVT4ZrodYOboK+DK1bRPtknl9
         35PmpDG9mDfVDyILxCdI+wYt/X1wO8xb4JkzZ6N7ITb0FpG9yhA4BG/ijCuKvC1Wt41i
         1wwEeaD78ueFhenynjWvfjRReJErO4YbzUvep3XEUd1TqrqLD5IVkWbQ9guaf/FQWYNU
         fkTDQWXYbsNI8dq+6EXDmp4FqsyxhOWIfuooLxYi+rhvlf5EyjWethLLKn76l7eDIXja
         eldg==
X-Gm-Message-State: APjAAAVVm74mLc6icgSwh5kfgb45i+6grh0363dV7Eq0CbQdSqgC57Xt
        OlYGMe/HPnBBFmJDB+sMJj0yipll
X-Google-Smtp-Source: APXvYqzndg4j7srX3QvMkkvjvz89XksfdqzMcbzZVTqBpaDyB2SooBU+H3v89EMKXHH8rPYedNhEPQ==
X-Received: by 2002:a2e:9ac3:: with SMTP id p3mr43961397ljj.109.1554268460476;
        Tue, 02 Apr 2019 22:14:20 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id r3sm3029281ljr.7.2019.04.02.22.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 22:14:19 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] IOMMU: Tegra SMMU fixes
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190306225009.3391-1-digetx@gmail.com>
Message-ID: <99d4f594-f9a0-1cf6-8031-a3faa8e091e3@gmail.com>
Date:   Wed, 3 Apr 2019 08:14:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.03.2019 1:50, Dmitry Osipenko пишет:
> Hello,
> 
> This small series primarily fixes a bug that affects Terga30 and
> Terga114 platforms, it also carries two patches that improve SMMU
> functionality and clean up code a tad.
> 
> Dmitry Osipenko (3):
>   iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
>   iommu/tegra-smmu: Properly release domain resources
>   iommu/tegra-smmu: Respect IOMMU API read-write protections
> 
>  drivers/iommu/tegra-smmu.c | 41 ++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 

Joerg, could you please apply this series?
