Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128CAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00320673
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20150623.gappssmtp.com header.i=@bluespec-com.20150623.gappssmtp.com header.b="jltM4Ar/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfHLTtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:49:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36979 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfHLTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:49:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so104103424qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UV8CKdboAmk/VxMPvqRcAfLPhy32LDZ4SxfI8+jq9eA=;
        b=jltM4Ar/lpuGu7lyFR8pJwgeA74SyhzojO+40mYneDCJsl94QUPrx70p61RHEz6xmu
         vxkRFSG8yB7Urm7pDINv5eITQYdhi20v2JKnVgLly8r+4TngIEXqgfyJWjjSMtT9mBQt
         gUCHl9Xmv24ePdraDYLmy1ht3MgFF7ACGEWY0cz6IJuxACbJ6YYWtRlW1EWgEI7xjhTQ
         YdjyYRXfgrXbypaFlvxwk/W2pesE3Uc5mymbJ0gXtvHWJZwSGwFXuIwJa6uYu+k9fRYM
         4wacfQuGkmQNOA5D6T6KTCi+hPh1pS6fcmEI0l8+cpFJNfBoCux0WwPHe0DCajgkek9P
         Zrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UV8CKdboAmk/VxMPvqRcAfLPhy32LDZ4SxfI8+jq9eA=;
        b=fNE43CCqJO3kJtAdyslyFUV+6gTnORtLWYanx++VgsuC4pqgYK1rHzDXE28PWxodKc
         R6SYkDWnyOt2l6nFmsCefr/1O9dRcoN+GSHe8IGWglh56ihe5meQl+l7U/cHzkOOsBMx
         CpAYaS5cGMkZa8X92GUuUMAB4MRQo7jlTIlSZ0q4b50B+13GRRJBuUuKq18diGcDYnbG
         Hsxb/IebLpBdE76OsSORP8bjIh94zxCgxU9ogq52nPg9QzmBdBejt287pr089W5e3pzk
         aiepEKo3BMWiuW0RhP/XAF/w0OhDZaGBlUo1rn7ggR6HtrENPqEMBLAcJaItp/AnazUS
         dRKA==
X-Gm-Message-State: APjAAAUgmPhym7pJj57mWNswfORbq+QRlHmmQwtApMSF2+f/ogRQGI3d
        /vXWx1p+5xn1MUMPABNzwW6A
X-Google-Smtp-Source: APXvYqwt1wY0kFXUf2SJJ0SNo1VLt4PBkuZhW7TlkhaF569W0Da1qsUMXXhslmo12N/U1uTW9SVUGg==
X-Received: by 2002:ac8:30f3:: with SMTP id w48mr29811591qta.216.1565639348315;
        Mon, 12 Aug 2019 12:49:08 -0700 (PDT)
Received: from [10.7.11.6] ([194.59.251.156])
        by smtp.gmail.com with ESMTPSA id k21sm7850588qki.50.2019.08.12.12.49.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 12:49:07 -0700 (PDT)
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
To:     Christoph Hellwig <hch@infradead.org>,
        Charles Papon <charles.papon.90@gmail.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
 <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com>
 <CAMabmMJ3beMcs38Boe11qcsQvqY+9u=2OqA0vCSKdL=n-cK9GQ@mail.gmail.com>
 <20190812150348.GH26897@infradead.org>
From:   Darius Rad <darius@bluespec.com>
Message-ID: <5a931461-c6a8-6d2d-4f73-103a10b26f0e@bluespec.com>
Date:   Mon, 12 Aug 2019 15:49:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812150348.GH26897@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 11:03 AM, Christoph Hellwig wrote:
> On Thu, Aug 08, 2019 at 02:18:53PM +0200, Charles Papon wrote:
>> Please do not drop it.
>>
>> Compressed instruction extension has some specific overhead in small
>> RISC-V FPGA softcore, especialy in the ones which can't implement the
>> register file read in a asynchronous manner because of the FPGA
>> technology.
>> What are reasons to enforce RVC ?
> 
> Because it it the unix platform baseline as stated in the patch.
> 

The same argument could be made for an FPU or MMU, yet there are options 
to disable those.
