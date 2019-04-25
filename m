Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F48C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D7D206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kVSg2qPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfDYUFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:05:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50888 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYUFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:05:30 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so2228551itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8L0f48fUS21JxG0GfcGCO3YzTk7ZYhjXtaqnFDvT3PQ=;
        b=kVSg2qPMzGqrTzxq5OWY0i/vaKNpNdf1ZYi7DFYMiXkus8wt91uNv5KgAh4TmUS/eW
         P06+1qqe8YxdITKnn9aEJaMLwjpfnwvd+mGi8moAz9TlisVbIrecAfLScTfiUDiqhH0f
         By2GMD/aayDidwK1mjPjELgxLl3giY/gs8Xepa15Ipyu/SoVuyOYLVSjm8rTPPA5IP74
         ckVX9KBysbfkMVMnFSuXQeNPyK9EXYWNxcQJYB031M2yLBOu3dDd6d4SyuEKgu0i0Oi7
         JOUlkiurMPRhgXe3kIbmM4qsyfxpiXmo4170hvA5Qlh9M2rfN0ywdCKtAus2GakbRxCs
         /G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8L0f48fUS21JxG0GfcGCO3YzTk7ZYhjXtaqnFDvT3PQ=;
        b=kLQ6sI6P495qAtiMS8yB09s2Vuqg/kkZAAW2ROAzPCGwL0yakANYdbbAfh/0qg/xTE
         emF4V7r5Xh14rEXVbYzW/M7pSRxX6W61qAY6Byt3zukozw5PakcrC6ZGk8pPqwRZGab8
         m+A742mdVMV2e1j21rW0ZubQ+FjZYE8kI1hRnDANm8GpiKIbxocbpGe49hMpd5aAj6am
         tHHqwaFleQKZySK3faLZkJ8wtOv9UOR5BPtNXzDc4FWgmJDM21z2lwTvgS91rmJUTmZA
         Qjk357GUOyveQQrmS/9Qs9fAY7DS0CBDPGNVHAtQCTG1sNbBGMg5FLp8LsptryLx8wr0
         iKVw==
X-Gm-Message-State: APjAAAV0dX7694+hsGIr0vhZHpM46LIjq3OW5vzEIzP8eVSJg4rx5owv
        GLnO88R42zv9QwTQkLp8a9quCg==
X-Google-Smtp-Source: APXvYqzQbh+4Lv/3KkBwcb/rXsLgSl03p0iFu83tcoKpIOFf466TG5F4vtxoQEV5qQZw7+SC4ljxSA==
X-Received: by 2002:a24:6b4e:: with SMTP id v75mr5257630itc.74.1556222729564;
        Thu, 25 Apr 2019 13:05:29 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id b1sm10573522itd.12.2019.04.25.13.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 13:05:28 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:05:28 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] riscv: remove duplicate macros from ptrace.h
In-Reply-To: <20190425195447.GA22587@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1904251304330.17442@viisi.sifive.com>
References: <20190411115623.5749-1-hch@lst.de> <20190411115623.5749-8-hch@lst.de> <alpine.DEB.2.21.9999.1904251208140.17442@viisi.sifive.com> <20190425195447.GA22587@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Apr 2019, Christoph Hellwig wrote:

> On Thu, Apr 25, 2019 at 12:13:18PM -0700, Paul Walmsley wrote:
> > 
> > 
> > On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> > 
> > > No need to have two names for the same thing.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > This is probably worth cleaning up across the entire tree.  
> > 
> > asm-{generic,x86,arm64,powerpc}/ptrace.h all define similar GET_IP/SET_IP
> > macros - although it seems that arch/riscv is the only architecture that 
> > uses them.
> 
> Yes, we had that discussion before.  I've started on a series for that,
> but it is unlikely to touch riscv.

OK, if you're planning to post a separate series for that across the tree, 
then:

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

for this RISC-V patch.


- Paul
