Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2BFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170B1206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbfIMUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:47:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45102 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388865AbfIMUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:47:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id x3so13728307plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 13:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QGt5Azf3+0XZwNWPdJzqQycZhJFLYdeBQtKL97p4dH4=;
        b=Uw6ks0dbRm/Wtjd312NjhtsdFY5AjJaCb3YI8COev+jnnXSJ0j+3ZImzPI3YXs5nl7
         tQubdFLJc33RbI7kpLxtpTCvTD1awVV4+wqa+myc58F60h0CQv948RCvWNyUmmZAgMum
         1mk/6WjFb6NuOn4nxRWnsnM+Rwt0XlfqFEs2KutJdhyKJO7jds/dfrWLT4hioIb3Ebzt
         5auVzN6L5B/yIfwJvhKQGW0Goq+E7q4YpXb1qecBedpvGrWuaioS9J/d6ylo7KJ1KF0U
         Okax/HUDiWSymO7pisXFCqf6S6XtQ1ktiC8KZzX1hOOTvI4ulLG7XiBCb+3ASFqhZfV2
         wIzA==
X-Gm-Message-State: APjAAAXtzB3jacWFMoCLDjoDN8WoJWF0eHKJd4/6+b48xBs2AY9pxOCH
        dWl117gkfVuBRxp0xgBmUoXMUw==
X-Google-Smtp-Source: APXvYqxgHC7bnMvWebn0igw5sG0hxATfwRcf89UsRAG+/65idbIUiwRzPEAVH5DVpOOjajgR6iv/dA==
X-Received: by 2002:a17:902:6507:: with SMTP id b7mr51141019plk.37.1568407646516;
        Fri, 13 Sep 2019 13:47:26 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id 202sm58241328pfu.161.2019.09.13.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:47:25 -0700 (PDT)
Date:   Fri, 13 Sep 2019 13:47:25 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 13:46:05 PDT (-0700)
Subject:     Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
In-Reply-To: <20190910060010.GA6027@infradead.org>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, johan@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-300d37d6-c3a0-461c-b843-ca9b0e2b4714@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Sep 2019 23:00:10 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Sep 06, 2019 at 11:27:57PM +0000, Atish Patra wrote:
>> > Agreed. May be something like this ?
>> >
>> > Let's say f/d is enabled in kernel but cpu doesn't support it.
>> > "unsupported isa" will only appear if there are any unsupported isa.
>> >
>> > processor       : 3
>> > hart            : 4
>> > isa             : rv64imac
>> > unsupported isa	: fd
>> > mmu             : sv39
>> > uarch           : sifive,u54-mc
>> >
>> > May be I am just trying over optimize one corner case :) :).
>> > /proc/cpuinfo should just print all the isa string. That's it.
>> >
>>
>> Ping ?
>
> Yes, I agree with the "dumb" reporting of all capabilities.

I agree: it looks like other architectures are passing info (ie, x86 flags) 
that isn't supported by userspace.  We have the ELF hwcap stuff for those who 
want to tell which instructions they can run, so it's sane to just keep this 
simple.
