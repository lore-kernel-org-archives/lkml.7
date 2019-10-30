Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78392CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4601C2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UeZxmXcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJ3Mwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:52:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJ3Mwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:52:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id v2so2551283lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5erIfBzA/jd7EXBaSVGi4HXOCmx41ZkwEb2QQHCHgvk=;
        b=UeZxmXcP45HajlZCYTH/fPyfVK7l1VzXklUgS+JvhBfli6XupBaZ6oybuR4B0/An4o
         YkfSu1jEro5BttaiBUCjD3BKKyuvn3uZaxqZvJrbOX821We5YHsTMZVt1W/Tg2CnC0N3
         Ilvs/BDd2vCMKXhzz00VdbdI1YVn0PGO0dv04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5erIfBzA/jd7EXBaSVGi4HXOCmx41ZkwEb2QQHCHgvk=;
        b=mDl6PXWJ1Bkvl1icfNw7VA19/MkAWgxbWnGXuo5EUO1SJiScraBKiQ9KrofsBoM/SR
         cI5s/bfaD4vgV3fPkM5eVc6+s/QSKS13fJ5E8kb/qmpPqakESlBEaYf04xiVTqyxAofE
         5WDrNMJDfbDSg32gzUTm+N0g+Iz+lJGgVhXViL3E5PXfxYZqCaRACiPaoQweCmPTnV9V
         WeqBVQybmlww1UJWUaxO1gdO9Jrxrna8Qtb8LRx7AI20xrqovpAWel7cm9gAS+34Wout
         ZinXZaRESpmNiw3KaOVTN6Zb71YZmfB9XxF0HVb/mIUomCnWVLpMoj505oVF14aR/sZC
         fKaA==
X-Gm-Message-State: APjAAAWB9klAPXVMcRQ4fUuLjEOL2iSn5gT9W8V64B4p1gXcUQH1/vjF
        NikQ9AcFoztE4XZyQBDwOjiYFQ==
X-Google-Smtp-Source: APXvYqwUzQtilkzjwaBLHyLTKEW/yG9aPJtXBPBUOwPOr4CS6DkX1KalmlTNN88bUG4+HgjaXpR6Eg==
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr475136ljo.124.1572439956073;
        Wed, 30 Oct 2019 05:52:36 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d9sm1426980lfj.81.2019.10.30.05.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 05:52:34 -0700 (PDT)
Subject: Re: [PATCH v2 17/23] soc: fsl: qe: make qe_ic_cascade_* static
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-18-linux@rasmusvillemoes.dk>
 <1d12e0d1-a873-d841-6e73-22ec1d09c268@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bb00fda2-7d20-b1a1-e2e8-22702842548e@rasmusvillemoes.dk>
Date:   Wed, 30 Oct 2019 13:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1d12e0d1-a873-d841-6e73-22ec1d09c268@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 11.50, Christophe Leroy wrote:
> 
> 
> Le 25/10/2019 à 14:40, Rasmus Villemoes a écrit :
>> Now that the references from arch/powerpc/ are gone, these are only
>> referenced from inside qe_ic.c, so make them static.
> 
> Why do that in two steps ?
> I think patch 9 could remain until here, and then you could squash patch
> 9 and patch 17 together here.

Agreed, I should rearrange stuff to avoid touching the same lines again
and again.

Thanks,
Rasmus
