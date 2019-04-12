Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABC12171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555052434;
	bh=dLpqsExVOfcCgCa9FgryrPELAZ3mhDKxU3lmCXnH9Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rxm4jnVV4xw7YjGw5usLhblSTNdt7678Yu2aQONQ7iK5zTMWVIlExaap6MnepTKva
	 NUUgfgcXmVOjB38rSdnXPWTIRzPVpCYxlprHQhIsU3ogOy9aIQp9H+QqA9psFlGaP0
	 B2GyqEruwRdq6aSv3K0CkRPqub05fAE1BqRFwLuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDLHAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:00:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLHAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:00:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so9605336wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Bbk35aBCZESEHG5RuZnD1QaHFZgpzC3BQiZIJk+H7A=;
        b=PmlG1wATxN+yYRJGI5HrsADPBKacqPwGDNzYciIeJunLtv8rqYm9e0A2E0B7k4CcvF
         /h62GzJFu2wVaZmnPrE3zt7Zg4OW+CqUJC9Xdqxj2HAzq44uOCq/vsWYaMN7GMIU2rG3
         HzGHDnmDnQcbhp3VJHLHOqst6veeJ39jtWd3aMiSPEAy8HSfwuHrA2I9rQc76i8vuTrz
         jBt0NuXlXe5gtFJUlsdV5ll6sCDHqFbG0wmPrFWdxnpz+yt6Miebxo17xWBArl7JJMKR
         X6kfUmjGaPivonV/ItIuu0tKBP0Gf/pt0ODYWDGIoEHbSodZ6HL+t9K9Aivy9k6gEFke
         Uy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Bbk35aBCZESEHG5RuZnD1QaHFZgpzC3BQiZIJk+H7A=;
        b=jKA4X1+DBN41e7pqA5pdGHZbUVLW4728IVyDu2DJP6rNdmWXHwTSPnp8prVA+YH/Lj
         jE//lD3qGHOtD8oW9u8f6+pNK77V3qBJ1OZCye3m75AgKTcESn3QVSrCX2XPqLtvn2jP
         wj0cuvsCgAmYUSySpCSFJnZHQO8VKtesTEswHm1LMeSmUK1roGks/USwpldEPabkuTjD
         UCUvcVk3vCtl6+bVbWCjXLpb0XRk82RXoDQR2IETZUkbmpJtvqKiSj8EGkNYYidpIsRp
         An1kOBJXevm5MIxI03kFrOWPwijItHzZZ/V9GjnAu9ppiKYKE+PmDYdKoS8wgAa0dZCU
         8vjA==
X-Gm-Message-State: APjAAAWyQj3XnF5R4009rY7hB+DG7cucOJ7VgvnT/yI0zqIaWjp373IG
        y1Aa0y7OLJQwEXCv4MQkym0=
X-Google-Smtp-Source: APXvYqy7AAcYtxGhSgkFdnH8n+8rnMF9kvqttL6gxc+5XUNk3J1ebSQNRdh0sL1NtXBy6UNzvVdpvw==
X-Received: by 2002:a1c:cb0f:: with SMTP id b15mr9176981wmg.88.1555052430515;
        Fri, 12 Apr 2019 00:00:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q24sm6481754wmj.26.2019.04.12.00.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 00:00:29 -0700 (PDT)
Date:   Fri, 12 Apr 2019 09:00:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     wangkefeng.wang@huawei.com, horms@verge.net.au,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-mm@kvack.org, takahiro.akashi@linaro.org,
        mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com,
        kexec@lists.infradead.org, tglx@linutronix.de,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
Message-ID: <20190412070027.GB129493@gmail.com>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-2-chenzhou10@huawei.com>
 <20190410070914.GA10935@gmail.com>
 <31b41dcc-0d16-d1d0-bff9-dec3e77515c1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b41dcc-0d16-d1d0-bff9-dec3e77515c1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen Zhou <chenzhou10@huawei.com> wrote:

> Hi Ingo,
> 
> On 2019/4/10 15:09, Ingo Molnar wrote:
> > 
> > * Chen Zhou <chenzhou10@huawei.com> wrote:
> > 
> >> In preparation for supporting more than one crash kernel regions
> >> in arm64 as x86_64 does, move reserve_crashkernel_low() into
> >> kexec/kexec_core.c.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/x86/include/asm/kexec.h |  3 ++
> >>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
> >>  include/linux/kexec.h        |  1 +
> >>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++
> >>  4 files changed, 64 insertions(+), 59 deletions(-)
> > 
> > No objections for this to be merged via the ARM tree, as long as x86 
> > functionality is kept intact.
> 
> This patch has no affect on x86.

In *principle*.

In practice the series does change x86 code:

> >>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
> >>  include/linux/kexec.h        |  1 +
> >>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++

which is, *hopefully*, an identity transformation. :-)

I.e. Ack, but only if it doesn't break anything. :-)

Thanks,

	Ingo
