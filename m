Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99721CA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF9020663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hy0//0hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJ2HYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:24:38 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:43461 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfJ2HYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:24:37 -0400
Received: by mail-lj1-f176.google.com with SMTP id s4so13183993ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SoFQNKQ4Qa81yrqKCpibxDMBO3sAN1LEi2FGE9F/8RA=;
        b=Hy0//0hOS03mKb68HU9qDOg02jeHGzftxkWxOIgCuOU7CKTJ+k6iUZX7gjKOSvGQPl
         4BICrmSElIBBlJfP3hi6Yo0Otz+bH5RNw0pVZLArmHAfxPetqDt+zD9HpnTKyeckCM+D
         g8xjzcLF853wbCU3oVitJzkWqZdiNvQxj+RoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SoFQNKQ4Qa81yrqKCpibxDMBO3sAN1LEi2FGE9F/8RA=;
        b=d6o0DrI7gJKLk5aWlJ2Zde4n+lxFFUHhrdtkpAhngcdVZOlrB/bRLsrwprH6eN/FSJ
         O4gHLrkFRoqrJhjU3bG8FBrwg8INjVMI7KrLT+u22/hYnexvw+CXV4WQltzVJWIeMbZV
         HyYD+FuBd1sYzWADvpsMJ9mnkWUarrmPygQvkC1l5R0jvbYGitPNpeH1zf92VGOEiF19
         O1yicS0Kyv/qd9Xq970pPy4dBAvOfwHyf9Rp1lraezeQQ8aLI5vu6Nx8H22bUnkzxRyF
         lXyhI8E00/YoKrKJkhQQnmVGy+SIVdyEIs49r/t1Cl1MPTsFSbVeZbfCtZ1fXTyBCEWU
         47jw==
X-Gm-Message-State: APjAAAU+rsGmxywjV/xuJ5RhAMoxxhBu6YfQrruTLyrlZGeiA0CkHcph
        gnmMGMA9ylCMe5CCico10HYYeqlyLGv9suE9
X-Google-Smtp-Source: APXvYqxZ8IhrFy/tgteftGXSXlOqZ4BXScz2I7670qyE6XtdMubwJllvBbNMdBuHGKwNyqbFNN3qLw==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr1293910ljl.95.1572333873850;
        Tue, 29 Oct 2019 00:24:33 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p88sm9377100ljp.13.2019.10.29.00.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 00:24:33 -0700 (PDT)
Subject: Re: detecting misuse of of_get_property
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191028224914.enpqjkcvbxyeexnl@desk.local>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2dcd6ac3-8a01-a11c-3532-5a8eb83ccdf5@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 08:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028224914.enpqjkcvbxyeexnl@desk.local>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2019 23.49, Luc Van Oostenryck wrote:
> On Mon, Oct 28, 2019 at 08:32:42PM +0100, Rasmus Villemoes wrote:
>> Hi,
>>
>> I just spent some time trying to convert some so far PPC-only drivers to
>> be more generic. One of the things I had to do was convert stuff like
>>
>>   u32 *val = of_get_property(np, "bla", NULL);
>>   do_stuff_with(*val);
>>
>> with
>>
>>   of_property_read_u32(np, "bla", &val);
>>   do_stuff_with(val);
>>
>> (error checking omitted for simplicity). The problem is that
>> of_get_property() just returns void*. When the property is just a
>> string, there's no problem interpreting that as a char*. But when the
>> property is a number of array of numbers, I'd like some way to flag
>> casting it to u32* as an error - if you cast it to a (pointer to integer
>> type wider than char), it must be to a __be32*. Is there some way
>> sparse/smatch could help find such cases?
> 
> If I understand you correctly, you would need a kind of 'soft'
> bitwise pointer?

Yes, that's a very good way of putting it.

> I guess it shouldn't be too hard to add a new flag which would
> allow cast of bitwise pointers to pointers to char/void (see
> at end of evaluate.c:evaluate_cast()).

Hm, yeah, but it should also allow casting to __be32* , but not u32* or
__le32* (though somebody must have gone out of their way to introduce a
bug in the latter case). Don't spend too much time on it, I was just
wondering if there was an easy (maybe already existing) way.

Thanks,
Rasmus
