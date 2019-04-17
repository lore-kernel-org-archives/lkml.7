Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F18C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A19620674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMU/Fv+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfDQSTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:19:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3qFLY8cDeOYehuBn5cRrDUkDX75dEgaFFdO5IYDJgUY=; b=GMU/Fv+kSMV4z0zGIpaoI09/rI
        lSrTPyF6uNB6dwNzOiOJWlp9lUlqh+v2MrGu7UmVFFy9SDX8SdIsFhHTS9BgJiXpEVqkM7rBWDzq5
        nKrhcD3XQanYDFntb/uoK7HsRxsql1bQd7Ak1Ijujg+3WZ9f+5salVpZTwubjEnvtnDL2pCTs5jjy
        cdsaEfSJ+HiYRdwBGq4gZvBVflTHtrtAVFKoGnkbpjungATbKOpkpc2wuE18fXxu9y9HLTgfb7tpu
        9qoCm+mr2oC2PPqDczB15GGsvGgRFtcUtke7N7me+QfkjrMMlJrLAj863AatHUqxhaWjGVn+EnJtP
        D1mtLy3g==;
Received: from [199.233.58.37] (helo=[10.83.93.157])
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGp9g-0007mL-E5; Wed, 17 Apr 2019 18:19:32 +0000
Subject: Re: [PATCH -next] ALSA: ps3: Remove set but not used variables
 'start_vaddr' and 'pcm_index'
To:     Yue Haibing <yuehaibing@huawei.com>, perex@perex.cz,
        tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org
References: <20190417145722.20448-1-yuehaibing@huawei.com>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <1078ccec-2cc9-f16d-caca-32ac9c3cce4d@infradead.org>
Date:   Wed, 17 Apr 2019 11:19:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417145722.20448-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 7:57 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warnings:
> 
> sound/ppc/snd_ps3.c: In function 'snd_ps3_program_dma':
> sound/ppc/snd_ps3.c:236:8: warning: variable 'start_vaddr' set but not used [-Wunused-but-set-variable]
> sound/ppc/snd_ps3.c: In function 'snd_ps3_pcm_open':
> sound/ppc/snd_ps3.c:529:6: warning: variable 'pcm_index' set but not used [-Wunused-but-set-variable]
> 
> They are never used and can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/ppc/snd_ps3.c | 4 ----
>  1 file changed, 4 deletions(-)

Seems OK.  Thanks for submitting.

Acked-by: Geoff Levand <geoff@infradead.org>
