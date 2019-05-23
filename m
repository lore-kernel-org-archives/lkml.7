Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F396521019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nihb+m35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfEWQ1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:27:46 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33902 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:27:45 -0400
Received: by mail-io1-f48.google.com with SMTP id g84so5380812ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bzIoUuSyukV9aK18ip6xd/3be561dSQGY3qTAn+FJTM=;
        b=nihb+m35AEW3FRA9RuVLTeKjWVgDq4XTuSOQVx982l7cWGL62yG9ol00goGmpKTkaC
         sBezyqLrCG0ZfuVDRABCHTILA3jzBxuvGGJHMVKsTBOCKPqOfCn1UocfV3kxjBqykLsN
         x+rlf2w1Ka+I/l9HdDrl6NPQgE8XGf98/bpsKABCwJixqiVb4Q+5mub0TbiLVFSnwAZt
         qLp1mRUpK/RrHT7ksRRhkUczrUVaGf7H80aJmderQEU6GCK8negmts0xBTIMLxKZ7gzd
         Tuxs7htOC0WB7MifdJiCQVvvyBReQBcSN2NXMrHoSPc4Aoxe8S64434ho7J7ZT1vVWez
         easA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bzIoUuSyukV9aK18ip6xd/3be561dSQGY3qTAn+FJTM=;
        b=JC57IyZ1TLB0MjRBXPklg4snzjakRGbuth541jLPFSHGn2mYvQ/xI25vmMQKX76HKb
         dz0+A5Wq5RYY/x8JcDp1r1iFWVd08UWwocXfhum9jsvaBI2dVnBJowzuWBK4Rp8ZF1mW
         6+UwRR7DfrOCdJq7YhZva0P6PBwJbWnQ8wihP5jf0RwhUmV2F3y4lDVpXxnUsU7yiX74
         qohsEw7iMihiIllicJBlsRHPtb34QFjw03p/z63K69ddkpD417DL2AkoFgJWO1y87d+w
         tIr3S354lSQYPvq8U2N0+I1cd/xVAbpeXDaohXlWQV1aPa2PCnerfo5desohGjKDVrvj
         r6Gw==
X-Gm-Message-State: APjAAAX/faRnVy61lwtudVVbVOfbEegCNZXj2hEpsxwh7lr7tisbbgCr
        oOcuQ1WD2Jv9ewMJ3E23ztdYsckkplPkuQ==
X-Google-Smtp-Source: APXvYqzUSeXDDboiy4cpGVw54ApsN0FAT1S2aFWE8OVLkl/Az3OqyqurRlEopzzvN1xXrs5ePkOSFA==
X-Received: by 2002:a6b:5914:: with SMTP id n20mr27992852iob.239.1558628864360;
        Thu, 23 May 2019 09:27:44 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z198sm2735018itb.11.2019.05.23.09.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:27:43 -0700 (PDT)
Subject: Re: [PATCH] aoe: list new maintainer for aoe driver
To:     Ed Cashin <ed.cashin@acm.org>
Cc:     Justin Sanders <justin@coraid.com>, linux-kernel@vger.kernel.org
References: <1558125894.9571@cat.he.net>
 <856ae195-ceb8-5657-5ce7-9743f96845a5@kernel.dk>
 <2f5aa01b-86bc-ce12-deb6-98a0d68d3760@kernel.dk>
 <CADvA-d=f2+Wm2qwJPBAkuTqih41K5xwQoUpxPcLuv+uQL5b5Rg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e287684a-804e-7605-f5bc-1faa05700566@kernel.dk>
Date:   Thu, 23 May 2019 10:27:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CADvA-d=f2+Wm2qwJPBAkuTqih41K5xwQoUpxPcLuv+uQL5b5Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 10:24 AM, Ed Cashin wrote:
> Yes, please.  Sorry for the omission!

Done, thanks.

-- 
Jens Axboe

