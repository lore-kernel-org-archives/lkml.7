Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E43EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D621206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QKySukuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfLEDDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:03:22 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35358 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfLEDDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:03:21 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so1658847ild.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 19:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DDaxXfCxsiOyqMSO9KYcmqVtM/PNL1XNRneVF7PtEEk=;
        b=QKySukuX+whyDlwTei1UZnZksz7c546kdE1Q+t6mhe/INeqiwSx/Pk/RJiJZbOtRd6
         giQJPsRdGlSjiHECuRruZEWSBvWnNW3YZlCwVezmQA4x9AlwZrO9YCUgsY/TV2VXEOgx
         JTqrpo8Yfz6IpPoASBfaTkbgkdymob1DtfD0OkGjk3yTa+AYbeMPbk3dZrtH7gwXiQP6
         2ucQMO3dMfiWQWK18vtoPyMjp2Tf3PEg5jXBOcvCbUdFQCKwYnu4yilSU5bcW5bM3esk
         pP7BWROiTfbyMWcefykLoXmV2DQOybkonJhJCb9BuhJmdJPjSIDaIk1TsdfjtplayCTZ
         WiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DDaxXfCxsiOyqMSO9KYcmqVtM/PNL1XNRneVF7PtEEk=;
        b=tVp5xbwObrpquBuax08ebMnIHTpA23FHdh0CRnAZs3K4gHNpSIsec6ZnM1ifDtshQv
         NQicdKdrisELOUG9ZV7hACEdr4D9Eflq8jIKV2VbfaJCRHQIpapcRtTvd5SACECiGHWu
         0iULsuUad+FG0sq11VEcP6MwsEwbAaj4LPKsyJQAIcO7LmiOWz+xS69xDa6QI4lAkbVH
         2lOkgwfYx7aKaD2FPmdlFfYdpan3Zr7i8IAK14tM0hqRMQ5KfBolWxWjfsz/0OdRrOf5
         TTRrKJfTjEyxgT5cTeoirxZ2K+dwP5E4SZQW1t6RBrvs3cEDb4rBdjrLeJdszyYnrBvg
         U09w==
X-Gm-Message-State: APjAAAWWMyS7c+0BEZ6fVGHcf+gLnkXAcJrJoGiBJbkz0J1xdi9ds6D9
        8SDwLH81ZKPYMoqmUknBm+pcJQ==
X-Google-Smtp-Source: APXvYqyNnDI4WPiQUe9ac+q6KSTTvsCXeGX7VU41qKjhR8914xo5CQA56RjP81NH34TxvX8az+BIKw==
X-Received: by 2002:a92:1b89:: with SMTP id f9mr6567185ill.122.1575515001113;
        Wed, 04 Dec 2019 19:03:21 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id e1sm2365633ill.47.2019.12.04.19.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 19:03:20 -0800 (PST)
Date:   Wed, 4 Dec 2019 19:03:19 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
In-Reply-To: <20191205005601.1559-1-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
References: <20191205005601.1559-1-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019, Anup Patel wrote:

> Various Linux kernel DEBUG options have big performance impact
> so these should not be enabled in RISC-V normal defconfigs.
> 
> Instead we should have separate RISC-V debug defconfigs having
> these DEBUG options enabled. This way Linux RISC-V can build both
> non-debug and debug kernels separately.

I respect your point of view, but until the RISC-V kernel port is more 
mature, I personally am not planning to merge this patch, for reasons 
discussed in the defconfig patch descriptions and the subsequent pull 
request threads.

I'm sure we'll revisit this in the future to realign with the defconfig 
debug settings for more mature architecture ports - but my guess is that 
we'll probably avoid creating debug_defconfigs, since only S390 does that.


- Paul
