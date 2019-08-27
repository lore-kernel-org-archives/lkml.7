Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88234C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651EF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfH0XhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:37:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36032 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH0XhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:37:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so332688pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kKp3RU3/nr6zAi1XcHUG1q7j4xoSv+zNUf1bXZ97gqs=;
        b=m2HRDTLD+IpaOMJWcU+CYd5/1RdMwZ7VxLNTHhIf6nXLUxm1q0Ce3mmaVijhWt6vH5
         Hio9MscsmQmJgYlffHBg9b6Phns4HKFsIumN+Lim6HlMHjhZOjRDCrbrQ5m2UUH9nDd9
         /t1oigFH0k4KPpR4vDkKd7N+BGp3lCF2L4mUiiRaEneYzCtfkIGUocN5C3m9GIncbxQo
         nUpw/jlvn9G/SAJKCJ5ZviETAgHBSUt99RZKV04lD7fEAJnEmtHDkqkupEgmIPZXP8s3
         SRpUcfT71FDSzjnLxtZLSaYOhwo2u5GS14jQSegHsd2PLHqpAe+7DDRjIZ3l/KFxAf8F
         tDzQ==
X-Gm-Message-State: APjAAAWLVe39OXaP+1aHCoygyvq2cAI84OFzNi9TWUUc3rGJ8m75CtFX
        8wykgQ1hURYhep+AI4k7NIg18ukLDg8=
X-Google-Smtp-Source: APXvYqzfMRjZVJP4TOJqKo6BCjPIPegk8eB6z/Qabnt77V7vseI+/uWcZ64QfSaRY16wYCaRm18eRA==
X-Received: by 2002:a65:6108:: with SMTP id z8mr872696pgu.289.1566949037744;
        Tue, 27 Aug 2019 16:37:17 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g19sm471856pfk.0.2019.08.27.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 16:37:16 -0700 (PDT)
Date:   Tue, 27 Aug 2019 16:37:16 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 16:36:41 PDT (-0700)
Subject:     Re: [PATCH 08/15] riscv: provide native clint access for M-mode
In-Reply-To: <20190819101648.GA29645@lst.de>
CC:     mark.rutland@arm.com, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-6c980844-cfea-4aaa-ac86-3c99ce6a6d14@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 03:16:48 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Aug 13, 2019 at 05:29:58PM +0100, Mark Rutland wrote:
>> > +	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
>>
>> Since the MMIO layout is that of the SiFive clint, the compatible string
>> should be specific to that. e.g. "sifive,clint". That way it will be
>> possible to distinguish it from other implementations.
>>
>> What exactly is the "0" suffix for? Is that a version number?
>>
>> If that's a CPU index, then I don't think that's the right way to encode
>> this unless the programming interface actually differs across CPUs. It
>> would be better to use an explicit phandle to express the affinity.
>
> It isn't a cpu index, I suspect a version number.  These show up
> in a lot of the early RISC-V DTs coming from the UCB/SiFive sphere.
> They've now spread everywhere unfortunately.

clint0 would be version 0 of the clint, with is the core-local interrupt 
controller in rocket chip.  It should be "sifive,clint-1.0.0", not 
"riscv,clint0", as it's a SiFive widget.  Unfortunately there are a lot of 
legacy device trees floating around, but I'm only considering what's been 
upstream to be actually part of the spec.

In this case the code should match on a "sifive,clint-1.0.0", and the device 
trees should be fixed up to match.  We match on "riscv,plic0" for legacy 
systems, and I guess it makes sense to do something similar here.
