Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34FA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fXL4Bw5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfFMPyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:54:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36302 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfFMI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:57:07 -0400
Received: by mail-yb1-f194.google.com with SMTP id b22so5982166yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5rpwm+WXYqpS5Yt4a3EFiaLIxY1PzE0lEAcH6B/6h0A=;
        b=fXL4Bw5Kwl/mMKIWGa1cdKDK4KAo0XR2yGRH64ZJ/I1MVExg0wWUUDX3vBHTYZkjOF
         vYFKvyecLJNLSA/E7m7sTD8zh55AOz/agx/OfhCByMjAe9qffdMIJXqrpeOoxi+v3NkU
         sXmf687D6xOZ2qyVaV0Av3gvkn68lJwqr/d2PEpnz/YSD7pg1u3UtvyzLDx4Mi3w75OR
         HJJI+g/bVt6L2m1CG0hBdOwJes2EebjVxjs/giB7QyWUieZGe5ei2HyxPmHI0pV+dWgb
         1hEim2OLo6wzfu6Jcv47M0Q4ZvWL5BNXddHdsTUs3Eu/hfMQJY2po5LVVP9PbG0vjMfb
         rW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rpwm+WXYqpS5Yt4a3EFiaLIxY1PzE0lEAcH6B/6h0A=;
        b=YLqQydzPztMzYlVTAx9Nnq5kxAgv+i4myIXMxUz9a0moZufVG/BySNzrlYis7pL5L0
         1Aq2zgvoVy5jkjVCPrKABOucEhX3fDOoHq1zknroIxzxmHOrScbIWgcCgVdr7ZX6os9n
         1MZjer9tlIte63wDbmxKdn+N0jVgoa5aG2sqLBtdKl3bNUnFuKd/gfPtl88NMah8L7JB
         5rTj+E2h0XHOkrr1goY8e3rewE+8FRRGvqFSJZ/M6YQbgw7PTqKkDaaehfJ/nm6Ybjpk
         xV5sdR3S7auPrHG7EF0Gl7J3pvrQhimT6GBDMoOz9BdBtRwnq6bm2EgEY0MoIOpHk4zJ
         zHQg==
X-Gm-Message-State: APjAAAUmAz08tez9AKtGX46zaGu57NELvetlIC0IGJqax/Cg2OsOJ6In
        l1zg4JfZmMACrtnY9Iu1rGVoyQ==
X-Google-Smtp-Source: APXvYqw1zJomCCuCV1QnOnfqSwphH8qY2fZ84XDZGajBAG2kedoKa5gZ+d1vm3seCvUptjeuiel9rQ==
X-Received: by 2002:a5b:b8b:: with SMTP id l11mr40277348ybq.165.1560416227034;
        Thu, 13 Jun 2019 01:57:07 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id i199sm607899ywe.89.2019.06.13.01.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:57:06 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
To:     Stephen Bates <sbates@raithlin.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
 <20190612092403.GA38578@lakrids.cambridge.arm.com>
 <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3c9138e-bf3b-0851-a63e-f52f926d5ed8@kernel.dk>
Date:   Thu, 13 Jun 2019 02:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 3:47 AM, Stephen  Bates wrote:
>> Aargh. My original patch [1] handled that correctly, and this case was
>> explicitly called out in the commit message, which was retained even
>> when the patch was "simplified". That's rather disappointing. :/
>    
> It looks like Jens did a fix for this (44a9bd18a0f06bba
> " io_uring: fix failure to verify SQ_AFF cpu") which is in the 5.2-rc series
> but which hasn’t been applied to the stable series yet. I am not sure how
> I missed that but it makes my patch redundant.
> 
> Jens, will 44a9bd18a0f06bba be applied to stable kernels?

Yes, we can get it flagged for stable. Greg, can you pull in the above
commit for 5.1 stable?


-- 
Jens Axboe

