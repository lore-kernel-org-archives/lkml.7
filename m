Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB97C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 07:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89B72184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 07:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nW9xKDUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFOHkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 03:40:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34537 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfFOHky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 03:40:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so864465wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HE16ahbAWAMVnpAglb6juluSX3qYrFAbnx3CahCk6VQ=;
        b=nW9xKDUf27Z5vqCprp67406EaM9VuIbn/g7Bb0n6hJp2DtnP2VdyeW/CykjoiUIXnp
         IaEJHKml9i7LhW8fU0EFeXDouMSO1GaBCz+F/TZpeMMow+IJ0kSI4fU2YXhwTkv+ywzu
         l6RIrSR/hQUdrsavgtpv6Vkfiob3ZDu+FTIis7gdxRgu0eo4bPazm8rsMlJRU0YfHSkA
         qn2gcjZQ5aEihmYxgFewuvc1IVEe2bfjIVtNJjefVYiqH/ZirIkrOcDMLKcVlPdrOSCk
         zVAIftuueYAkkkvJXWiuvzXIdRWKfO9NIXBgXw1XAmW7H2dL4633QncpIMFYSgsakzXj
         24YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HE16ahbAWAMVnpAglb6juluSX3qYrFAbnx3CahCk6VQ=;
        b=Cwak4VzcblDbXI0wPyHYqewfF1RH0G71QWy1KEYlTJ2d39MruC6/sP2NkGVUXe7Xxm
         t8xPbcYcEbXBj9DZHWq9turLav20n/yTTUnqHAW4RdAXSVkQO+jPWSBEOOyrWXRqXbhb
         SVx5gRh9bah/2+T32+Dgs9ONkZPG5+ZRCSOz9i5fNO3LBWLZvB9Kv/E2RUAqEYD2SkDZ
         itAM7e1sQZ0X7BsWw+RpPOHdC3aDLYGboFaba/vAQ/LCwckva0mLoVsY7HSkwV5xGaih
         FoD8JVIOtt1bEaFKRKY3ho1/NLVqGv9LYBPlCOvz6YsdvpdEjS4DMkkKSImorO8zl/6A
         FENw==
X-Gm-Message-State: APjAAAWYX+kD1qjSJzSzoKGUxTRiRXtse7NOtTGNBaRPuxBYZptMi1zz
        YF64mdMmkT3T05K2/D6gjko+sQ==
X-Google-Smtp-Source: APXvYqyGiEnRu/Q0XKZ13ZQa8cfXFCVeF4aYToCxoekgDTAhRDKtoIpUvGLTOKf0OMMtddfCOc0tDA==
X-Received: by 2002:a1c:c14b:: with SMTP id r72mr10707604wmf.166.1560584452580;
        Sat, 15 Jun 2019 00:40:52 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id l17sm8877075wrq.37.2019.06.15.00.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 00:40:51 -0700 (PDT)
Subject: Re: [PATCHSET block/for-linus] Assorted blkcg fixes
To:     Tejun Heo <tj@kernel.org>, jbacik@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, dennis@kernel.org, jack@suse.cz
References: <20190613223041.606735-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d5835d3-d0e4-f4cc-19b1-841b4ad46a9a@kernel.dk>
Date:   Sat, 15 Jun 2019 01:40:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613223041.606735-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 4:30 PM, Tejun Heo wrote:
> Hello,
> 
> This patchset contains the following blkcg fixes.
> 
>   0001-blk-iolatency-clear-use_delay-when-io.latency-is-set.patch
>   0002-blkcg-update-blkcg_print_stat-to-handle-larger-outpu.patch
>   0003-blkcg-perpcu_ref-init-exit-should-be-done-from-blkg_.patch
>   0004-blkcg-blkcg_activate_policy-should-initialize-ancest.patch
>   0005-blkcg-writeback-dead-memcgs-shouldn-t-contribute-to-.patch
> 
> Please refer to each patch's description for details.  Patchset is
> also available in the following git branch.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-fixes
> 
> Thanks.  diffstat follows.

Are you fine with these hitting 5.3?

-- 
Jens Axboe

