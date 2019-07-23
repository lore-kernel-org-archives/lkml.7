Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F2AC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3319821738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsRYSx9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfGWN4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:56:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39551 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGWN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:56:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so15199871pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gE4NALig95p0/WtOi5ycjghPPj+LxlT/SSElGke6cvM=;
        b=PsRYSx9yrGJt9bFEC3QXGBjOzj0rYhgWDaiTDc4dqwGikP+cVtCHAoXjV8u+lya6Hf
         lDZpjrGUc645L0QKrP3c4QLXHXMWENAxIsGaF3d+KQPxAbTS+ytOrwWP0lKS6y0rBq4z
         +eyfTFD25HVtBng+QgKdM+ty2wl+mXCwa0Dl/4pH//dWi3vlqg984gtNY0fj+lZK377W
         M3y5qMBJu4ipDv0UrMwHre9Grb7xJ4q+CFlIscj+++Cg9DMBLOXAQ8tsiQXB1ps12mgo
         +ZS0HbTsRybnfWXT3cJCA7ia3pJUbZWdp51FS4MRl63ObudHuEZlQKohLQPHhW/f9Dcn
         QqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gE4NALig95p0/WtOi5ycjghPPj+LxlT/SSElGke6cvM=;
        b=Ih4eF7xCPhltbNVaMmoBusvr4TVQzDXvRGcRwd553G6UTP+stXFKLEzL6eZg/SG04V
         r0c47n1G59AzQoN1XPCI26wSslQeoO20XqtDFh8IOH0gCBJ+wae3/Slx7aqeEVNeQuvJ
         hKXgn36cqCl3MtIbtVzD98zeFEZzDD0IHtpwIOy3qTdY3bDPAmcpgrY8YR1obqlAaA6t
         L+RjClEDFcLxsKCXOmVEjF2KBCtrDu44s0kpXuvvsfzuIYxslS+473TYx84IQ07PXn2r
         +QCOvtO0xS5M/4fLlJSUJqWhyZ5uPbVAN/oLu5enS8oTlSOaaDVdHYPP/SAIIHw8qqpS
         XXpQ==
X-Gm-Message-State: APjAAAWKUBWeNusmKYqbFrTHNDFYVXF48cv4FY/O/tkztjez8sM9Q6Jp
        9TT1U1BAlzcsNw6Dj6fKaNE2RpDl
X-Google-Smtp-Source: APXvYqwl51DnyqWqvQJhBLyVbR7YWYNoDgCHojwQ3l0t0W6pyRkPgwhLB0hGemy0Ul6RAQgXmg014Q==
X-Received: by 2002:a65:44cc:: with SMTP id g12mr64191426pgs.409.1563890193683;
        Tue, 23 Jul 2019 06:56:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm41108394pfr.113.2019.07.23.06.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:56:32 -0700 (PDT)
Subject: Re: Linux 5.3-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net> <20190723054841.GA17148@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6f528c6a-7257-d0fa-01ed-cb4dab0f77ce@roeck-us.net>
Date:   Tue, 23 Jul 2019 06:56:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723054841.GA17148@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 10:48 PM, Christoph Hellwig wrote:
> The fix was sent last morning my time:
> 
> https://marc.info/?l=linux-scsi&m=156378725427719&w=2
> 

That patch does not fix the problem observed with sata-sii3112.
It does, however, fix the problem observed with riscv64, suggesting
some interaction between the scsi-fixes merge and the dma-mapping
merge.

I am still bisecting the sata-sii3112 failure using the method
suggested by James. I'll report results when available.

Guenter
