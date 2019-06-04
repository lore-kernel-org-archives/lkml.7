Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D06C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7F024C49
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sW4SdT2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfFDIzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:55:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41778 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfFDIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:55:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so3137004pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kx5q7zCTFKw0j3QN1oqE8pZnZTP9To8Le7W99DKm2LU=;
        b=sW4SdT2R95XIX+vXafemro3dM2V7gCnY1WEO1ChuJw8577FfF4rpJTWX3J2hPWsmiw
         b15JXnIO87kszDkbXvD9vAIkC9jcBM/+CZdeQeK64Dili6fANlVoIrxtnTODhCmQaosz
         ZrjP9hAEmTn5YbHldzcM7oZW+ufKWM2emARh/YhJkOag4U+xO/+uS0WFmSLd9i8MNg/e
         WWUyHYR2R9bUxhOGAymLg4gqZMSc01/zfU9c5fUJQoQhTJXQPpwh2ABhYsBOrDJ67hEX
         YxLddJ/KMmCzeJO8Wd67wtIPVoFogIEfgAWggKTgK12LnKB7X7XfxzQdPQxjlpFB7N4p
         UEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kx5q7zCTFKw0j3QN1oqE8pZnZTP9To8Le7W99DKm2LU=;
        b=b3rYm75O8t0TFazPAmrjAVcEAAU1KlTqnN8dhA6GrDULYm1XijeJ1rAeH7zYCX8O++
         /UqIjfZ+K1Dl0+vCu9CdZjH9gCAKisLCvUYTVLN/NiFWi63ustBgJNvhNjfzmFXbZNva
         W4gpvAVrQeKT9zw3D5J4WDGMcj5/yUOX9bPjOeiWfT91NTaZOpMgwtncyiHisggSkJwl
         eO68x5a169LuN7oiYlYk83B9BvCt0AI7BOdyRc1RWRBf5L+BkkcIMAZemBHHxUEC4i/5
         Ra4IDBpc2ONhcSubRa9xV9h/jVq9J3cqZkiSiJy22qrmcii6jlBAkVCwhPLN8/+7B0xn
         SX0w==
X-Gm-Message-State: APjAAAUxHbexVQ0j5A9cXVYARVm+z2kE1KyEIimsClMP2RSSjj18sq1V
        XgFF98e6R2/Z5W/x+r76JgbWbwtKeW0=
X-Google-Smtp-Source: APXvYqxAVFtSOCZX5AfZ+92Sy7EAVfXddvBIiq0QZdyyoPKzviGrJnwpdWBBPBjPOpg361VTnR4AkA==
X-Received: by 2002:a17:90a:bf84:: with SMTP id d4mr34814181pjs.124.1559638549661;
        Tue, 04 Jun 2019 01:55:49 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id l23sm18420974pgh.68.2019.06.04.01.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 01:55:47 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:25:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190604085545.hsmxfqkpt2cbrhtw@vireshk-i7>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <20190604084349.prnnvjvjaeuhsmgs@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604084349.prnnvjvjaeuhsmgs@mbp>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 09:43, Catalin Marinas wrote:
> On Tue, Jun 04, 2019 at 10:13:19AM +0530, Viresh Kumar wrote:
> > We currently get following compilation warning:
> > 
> > arch/arm64/kvm/guest.c: In function 'set_sve_vls':
> > arch/arm64/kvm/guest.c:262:18: warning: passing argument 1 of 'vq_present' from incompatible pointer type
> > arch/arm64/kvm/guest.c:212:13: note: expected 'const u64 (* const)[8]' but argument is of type 'u64 (*)[8]'
> 
> Since the vq_present() function does not modify the vqs array, I don't
> understand why this warning. Compiler bug?

Probably yes. Also marking array argument to functions as const is a
right thing to do, to declare that the function wouldn't change the
array values.

I tried a recent toolchain and this doesn't happen anymore.

Sorry for the noise.

-- 
viresh
