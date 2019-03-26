Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FBDC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646AE20651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="n5Ofe8zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfCZWwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:52:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42601 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCZWwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:52:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so16678187qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2K7y5i3c/bIxXtCts/FFPzx4K3yumcOwK4/9lIY7Rk=;
        b=n5Ofe8zLAm9EvPjLhVdPsZ3yG+NXRr4zT84bTkHrv5sbGyhMdamxp8kmuZCee4HzOn
         vJkAbTon7PDVvYe3EFK7GVlOoVTOnjLB1CViUgGTK5uuYPXOw4ZLWKTOTm0NPo7Zx3Sf
         iyFHDIRg7FTnJ32MLxyOMtoh7uSbxAG16X3FZ3kd/muS5nMET3h4yolATvnTiHym2shp
         y8j4LbsQp7pv7TmRMcGCPehHXc2+FTM7JwFAubRsShJIAyU1frlyf/6DG3+h1adfDJ+y
         sr61X8iIfSJWKhqqF4WxmKwMvQD6uJSXvByvuPeB7NLgjwqjc3xGfKuBUVZMsO7kWFFT
         ywLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2K7y5i3c/bIxXtCts/FFPzx4K3yumcOwK4/9lIY7Rk=;
        b=PAZDmuzwneCHSW4ExZicuwjMvLXUfxAk7RlHVi4iZHyZc6dFIYDJ1SUICp4+zdY9l/
         ZaiHhjFQh1Seppn2JY9IBprFarwqQykOuOSo4n26mAK5sqMOZclBhMGnrViyvmDfbEp9
         GqbgVpx8HXIuGfT4wn7pYqugJjp6lK47ESqejbC5orSMTxKCmyaBhFzhBiCXZIBHhWd3
         DREfZ/71QZg7m4uNGdkp/YkoQ6tqkMZv852UNAsh9ge+iOQuZTtzSmazzzLEarXUgWzj
         iT78jDBD7BTqM4HZgrXuShbI16pL9HjeguQpevcByUdyta4/qJdIzYa2H1fiGNv58s57
         8cIA==
X-Gm-Message-State: APjAAAVVG3hrS48Q4+0IAwrYvmEsWTxYdZAydtMP8jIxypGBmeJKHhGm
        c1tVisIW/i3Wmuh7eYengv/YTFiTYsY=
X-Google-Smtp-Source: APXvYqyACKSYRBpxrbdIiKwu+la2okmi8IV5CX3I+DKq1kFHmH4WfTErGqK9QvxozjxIFy+SFYyQww==
X-Received: by 2002:ac8:17ee:: with SMTP id r43mr27012056qtk.169.1553640726411;
        Tue, 26 Mar 2019 15:52:06 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p64sm12128427qkc.62.2019.03.26.15.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:52:05 -0700 (PDT)
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190326154338.20594-1-cai@lca.pw>
 <20190326160617.GG33308@arrakis.emea.arm.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <2193546d-e525-b8d0-a643-53fea7391c86@lca.pw>
Date:   Tue, 26 Mar 2019 18:52:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190326160617.GG33308@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 12:06 PM, Catalin Marinas wrote:
> I wonder whether we'd be better off to replace the metadata allocator
> with gen_pool. This way we'd also get rid of early logging/replaying of
> the memory allocations since we can populate the gen_pool early with a
> static buffer.

I suppose this is not going to work well, as DMA_API_DEBUG use a similar
approach [1] but I still saw it is struggling in a low-memory situation and
disable itself occasionally.

[1] https://lkml.org/lkml/2018/12/10/383

