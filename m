Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F03DC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E558206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f5ixLevq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfGKUg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:36:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38610 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:36:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so3484774pgz.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U05ONlBbPINFuimdTBUsOatUpH+2O9AcUBX+vMez/GE=;
        b=f5ixLevqIWQvivZ74pOXO929BcoCqmvzjZt0NEzOGVs7/8VfCjVUseMFq28qP41b27
         cOSPs1pq8IYk6wGAz1bRA9/AXypLdgaVcgTIp7BbjCQ+m6OqNUXyptfSqS8hQVvBU/O9
         NwzkTnyiPV5ItHlSsN30DKTmsB1znkoXR0lL7kRLhI+fl/KziS4Wjbk2WC9OA3bPIYtO
         RpwywCQ/EA/W+6Z9xHcZvxrIe5QOCoBPuvDSHWo89ggxEQrm54Hgxc+O89Si9YaZnJ4q
         f3DUt0VLnz4vss2+iw94D7wOidx2m/b3XiYE2TngB/aTZHyGN+TXGlBpw5eEpAvSrqdP
         RNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U05ONlBbPINFuimdTBUsOatUpH+2O9AcUBX+vMez/GE=;
        b=EPx/OPrUd1l0SAuV7QHR/yHHmoJVxMRfk5zXnKnHCP3P73+rvQn01WzWBkbMXYuJN6
         3cS5K/cZfDVt1TEmN8QE7EDD1RVDh8+QaiKuMrPmWP74VeA6W+m9nuhRonnJcP9c38+o
         wz8vS53V+4LiNCcVnzgVQxjoDp9cdgPvpDBuIW1fvkZemn+aEtaIGtpfEmXzLokyVKyM
         8ZA/nMtUSAnXqcN1w+gsE2LmQrk502ZenPSFQLDD40Nn5L+bPbCsVJWnOW+R2I/vCF0J
         pbKl81xwtwz44MM0Z7T0fW7ttNm8ARAwA/g8A/4hFUSLz9gGJefIh6OvAzEbc+rxSnvq
         MbTg==
X-Gm-Message-State: APjAAAU2qbvoULLq3CHoyCwK5oxIwOWjswXefRed+pl6Krrse0SlNn2P
        ADxg+bUCKACbmmoA3FaBHQFKLOFx8PQ=
X-Google-Smtp-Source: APXvYqwt6420DCq/8aOZYasWpu+xq8Gcs291fC8EGXWmzL2/e3Wyu/TIHN36Mskj2KVBn2eC9v6zxg==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr7310376pjx.15.1562877417701;
        Thu, 11 Jul 2019 13:36:57 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q126sm6651473pfq.123.2019.07.11.13.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 13:36:56 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>
References: <20190711151507.7ec1fd18@canb.auug.org.au>
 <20190711201736.GQ657710@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c18d276-d8e9-148e-ba05-604e7a4d9dec@kernel.dk>
Date:   Thu, 11 Jul 2019 14:36:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711201736.GQ657710@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/19 2:17 PM, Tejun Heo wrote:
> Hello,
> 
> Yeah, my patche series raced with 8648de2c581e ("f2fs: add bio cache
> for IPU").  Jens, can you please apply this one too?

I can't really, as that commit isn't in Linus's tree yet. I'll
keep an eye out for what hits mainline, I'll probably ship what
I have on Monday.

-- 
Jens Axboe

