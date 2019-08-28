Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F0120679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukBoEAhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfH1Huu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:50:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1Huu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:50:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so1110135wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IbA/cfJmEgj2/uah+03wQlbIw/RMKKPtS7QXkq4AsO0=;
        b=ukBoEAhXjR5VGvNcxa2/RYqZbueOgkhitDp4eiseaig2Blmwk+E45yJuZcm5gFGZvH
         HktQvDSxBG5HtjDrzV2DT13s2fINftzz65jlIKrLSLtRdE8O5x/AtkeJlQR/T3k0NafD
         MUgcPzKPzzUAudbTsYksWYQ7JVUSLTkleAK41OnoTCQ73+gM9Qq4sZVpNDqoEULAZiGg
         u52/oWoEzhHtreqGfEqQvnjbdcI3UnVYj0Ho07IpX3Cud0d7EHdoS8/Cq9/rV75zHFHN
         KmUBp8KmL/dUsIklVjOfUff14sh/O3HGAY7k5MYUHvVWtKPWUlqMz2T/bTOy5Z9KsaWD
         c/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IbA/cfJmEgj2/uah+03wQlbIw/RMKKPtS7QXkq4AsO0=;
        b=oX71XGL6XvTxB4Go3JQGpMxo3rZUPCHmfGHgz1EtCNbi8gy1uR59d3dBz/lt+Q8t3t
         zwfTHsc4biWB6nkXk4DuO8AoqQ1vRfnal61ekfnStKPzuX+NZ3qIfs5c647km7fPqLsF
         PMUCgk/zUa6vC/UICeuZqM2Ujhchvigo3OM6w2Tno9J4nkA/tvStClrBn4U5y1c9SVdS
         8RcV29LHpkOH9kORkxMnrJd9SCl2g8scqEPXDwDr88mdviLyBm8mzIRJCbOTB7AunY8R
         LHDrJD/shtizMSITAC31s+D4Px6P3ZtOzeyBTSO8eE45RLVNBkFdSWv1GCTXCwdt7ocW
         sN0A==
X-Gm-Message-State: APjAAAWo1n/P3I4a1rxxZ5USmutlbLApxql3YJ3+Zb2usMZxXNV/DEXy
        fnyQxH1urXnJlkyuWrAf5/PTAtcrmbM=
X-Google-Smtp-Source: APXvYqxw1FOrrReE3+bimLAchc1d6Ug6sZ1fv4g8qSz0yeu4BSPCdkouXIu3hPkNZihqgVauVEIP1w==
X-Received: by 2002:a7b:c632:: with SMTP id p18mr3163278wmk.114.1566978648329;
        Wed, 28 Aug 2019 00:50:48 -0700 (PDT)
Received: from [192.168.1.6] (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id d207sm1695375wmd.0.2019.08.28.00.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 00:50:47 -0700 (PDT)
Subject: Re: [PATCH 4/5] misc: fastrpc: fix double refcounting on dmabuf
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
 <20190823100622.3892-5-srinivas.kandagatla@linaro.org>
 <CAC8LzUAnz+RZYh+bBbJbXJYP3QDq4H1847W8rJxj-aF1B1J9QQ@mail.gmail.com>
 <cb003c11-d331-a2c7-1eb4-a89ba025f4c6@linaro.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <d545f7fc-fc97-c250-b9d2-ebfbc9709780@linaro.org>
Date:   Wed, 28 Aug 2019 09:50:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cb003c11-d331-a2c7-1eb4-a89ba025f4c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 23:45, Srinivas Kandagatla wrote:
> 
> On 23/08/2019 16:23, Jorge Ramirez-Ortiz wrote:
>> can you add me as a co-author to this patch please?
> 
> No problem I can do that if you feel so!

yes please. thanks!

> 
>> since I spent about a day doing the analysis, sent you  a fix that
>> maintained the API used by the library and explained you how to
>> reproduce the issue I think it is just fair. > the  fact that the api
>> could be be modified and the fix be done a bit
>> differently- free dma buf ioctl removed- seems just a minor
>> implementation detail to me.
> 
> No, that's not true, this is a clear fastrpc design issue.

IMO the ioctls defines the contract with userspace and the contract
establishes that userspace must call deallocate. the kernel wrongly
implemented to that contract since it doesn't handle the cases where
userspace can't send the release calls which leads to memory leaks. this
is what I meant by and implementation issue.

if we had many fastrpc users, rolling out the design change that you
propose - removing an ioctl- would definitively have an impact. But
since that is not yet the case, there is not doubt that your patch makes
more sense.

but my point was that there is not a huge gap in efforts between doing
one or the other.

> 
> Userspace is already doing a refcount via mmap/unmap on that dmabuf fd,
> having an additional api adds another level of refcount which is totally
> redundant and is the root cause for this leak.

yes it is redundant but is not the root cause for this leak. the root
cause is that the driver doesnt handle the case where userspace didnt or
was not able to call release (and that is no more than adding allocated
buffers to a list and clean on exit)

> 
> 
> --srini

