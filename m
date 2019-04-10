Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19D3C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA552083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554880160;
	bh=pkTJZOLCSEMchIAjbeOuILZdc65IPdDOvGddsKwhvtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+KkhZ4YTzhEYTzfVRHJGPe9jzfuaDjov4RgyLaj6JQS9OEkGwInaAgLpzSaEhdvA
	 zZjwOxkaPd5zaJFJW6SOZnirBrBFmMeNbDrgK5nng/BZCczXazKfmBA9MBfDzqzBJi
	 iwpry6yDtKgt/T7mjF10f+yz785zjzWkXvpaA1H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfDJHJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:09:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38176 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfDJHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:09:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so1302703wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmMDhL7r3scJSdYXt4VYgbOoqXnNnP5oEXQavWWJBJg=;
        b=eKWMXOQZ19nAjBnGVrqRsm3NI7CyC60pLIl+iZm5ImplTuNblxkkoRZTsBzj92VKNi
         bVYnWYYHYlMkTKfQQXaQB5beQmLamUVSmqR+soSNCsAklnUZzMmY1j+YIWYurlg9KuFe
         lVJuFjkflfsHNizmSmZQy0n2ClMtKWByRYGMUOverKT8BXHBEOYmQG4G7fcIYUL0JGtf
         EpqncWMb37xf10yx358iUt5Fgvan10uZE4lSHlBFJ8KL2zqEGuOei/fnQLmplHmM5eNt
         YY4H9usBNPYrCL1soealdiyFDq3bBjGn6+kSIVQP10uKfbKKZKh3C3FAWLFNW5/J0JWe
         1tQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmMDhL7r3scJSdYXt4VYgbOoqXnNnP5oEXQavWWJBJg=;
        b=aNod8j180p+hH0xTIp9Q7/GZOwkhPlk+D1cRjMd0krGnxz/4tuhszJFitoe5OmBaDr
         ZNuGlggwl2QhQ+CNrKelb8tj3f5L3shFZkiGRh6WWIt0ManjTEtCOXcIXfnjiSPRzV/w
         Fa+V9ihv3XR01wV+PQFqc4jT5qp39XB2lhEsuZystIMQGIg+dL15K2BzkNRd+4rAOSxo
         LzMiAUKlqNOWiwoptb81yKxwMd7llX/+HscXelenAI1JVXZ7BAdVUf6ikLn7V/fa8RpT
         PoJVng++yJ4NjOwI3gr9PRmwd8Kul54avkrMTrTeGUlTPNsG0dyM9DzbyH03nf0cURmh
         xpLQ==
X-Gm-Message-State: APjAAAUkVJge4aTRMTGgsKzzmd1VrNioUmAPDCNb5KU+ftTkB441xuXW
        sa8tmth5HjsEZuPy6fZ0/jo=
X-Google-Smtp-Source: APXvYqzMXxCIca1Iui6iiU/slOIXjvkFFL+Ohx11GWbcd2WQAF/Mp32cTqA2HHUhaVYYcY+1O3MZTw==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr1665337wmk.18.1554880157596;
        Wed, 10 Apr 2019 00:09:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b3sm36823698wrx.57.2019.04.10.00.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 00:09:16 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:09:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        ebiederm@xmission.com, rppt@linux.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
Message-ID: <20190410070914.GA10935@gmail.com>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409102819.121335-2-chenzhou10@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen Zhou <chenzhou10@huawei.com> wrote:

> In preparation for supporting more than one crash kernel regions
> in arm64 as x86_64 does, move reserve_crashkernel_low() into
> kexec/kexec_core.c.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/x86/include/asm/kexec.h |  3 ++
>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
>  include/linux/kexec.h        |  1 +
>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 59 deletions(-)

No objections for this to be merged via the ARM tree, as long as x86 
functionality is kept intact.

Thanks,

	Ingo
