Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C8FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4890220855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YzechEtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCHVcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:32:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46987 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCHVcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:32:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so17498372edy.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d0/oxdu7juoth+hF4+V/bziz4rbEjp/4uMVwzYwsE00=;
        b=YzechEtA0a8eWk5grjPceN5gmTcNrIKSIEBrzciVav/28fqEoFsSZygGSHuCzDrojX
         dnghIr8E19v1zNUuk4BI+6kuYArJpX6RAOQy0TOyd/l+pu9/DOXfQsXl2qYy3+v/c3I9
         LRMcsLE4BL4zD3WkR+yHYh7XepmoaOAt2qRs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d0/oxdu7juoth+hF4+V/bziz4rbEjp/4uMVwzYwsE00=;
        b=XxCCWsWbURqMswnqYr+GdWSzx9W/PTiQ3ZKu+Va8HZtrsAHDTH4YCFBMTl4fqUrSD2
         7hPwv+/Od9IXoaGw3GGnDKX/j90V/zJRf3yZX5trVmhdxWnpH99caL13EySwzO6Nbb0C
         17KRyyM7+BZSAbzEz5vcGpVJ170BF54pBKdg4kQbJVif0RSrExVFyOkFeDHEU0CeR4vG
         d8Lgc/rIi8IPOyfFClhEcy0FO8PXthKVbx/TGWjcFBNWL9/NQxl4uDVd6BUamcXgFC+8
         B7l4tbN34SaFH45scfggIskJ7czSKRVA6xn4nIgIGQyZcUOKxkvKtdK+59TpsPfc5/9q
         /itw==
X-Gm-Message-State: APjAAAXl+QdR+i1PZhy0YEZVjz7LYBsuLnBwBEZoD2qt8PPa4TYvOhvq
        nu4TaVse70kwr2Wxw8u8ypQbEw==
X-Google-Smtp-Source: APXvYqwRkKzEWMpK43xSZvo4VRech0UpAjCKRxbLtC1VfyKWwIyXO6luXNJa93qQfNzOV38WEda5oA==
X-Received: by 2002:a17:906:e107:: with SMTP id gj7mr13131134ejb.208.1552080763293;
        Fri, 08 Mar 2019 13:32:43 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-117-145.cgn.fibianet.dk. [5.186.117.145])
        by smtp.gmail.com with ESMTPSA id z23sm2502287edz.50.2019.03.08.13.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 13:32:42 -0800 (PST)
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
 <1552003703.45180.17.camel@acm.org>
 <20190308070107.GE32625@mtr-leonro.mtl.com>
 <ca0d8714-3258-3155-247c-af2d63c28273@rasmusvillemoes.dk>
 <20190308155318.GG32625@mtr-leonro.mtl.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d4980392-af18-34a3-8fce-a5760b637ebe@rasmusvillemoes.dk>
Date:   Fri, 8 Mar 2019 22:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190308155318.GG32625@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 16.53, Leon Romanovsky wrote:
> On Fri, Mar 08, 2019 at 09:09:46AM +0100, Rasmus Villemoes wrote:
>> On 08/03/2019 08.01, Leon Romanovsky wrote:
>>>
>>> Mathematical therm for discrete numbers greater or equal to zero is
>>> "normal numbers".
>>
>> Sorry, WHAT? "Normal" is used and abused for a lot of things in
>> mathematics, but I have never heard it used that way. When attached to
>> the word "number", it means a real number with certain properties
>> related to its digit expansion(s). And then of course there's the
>> isnormal() thing for floating point values in C/computing.
> 
> It is hard to argue with this type of arguments: "never heard -> doesn't
> exist". Luckily enough for me who can't find my fifth grade textbook
> from school, we have Wikipedia which has pointer to ISO standard with
> clear declaration of "normal numbers" as 0,1,2, ....

I'm not really sure how to respond. The word "natural" is not the same
as the word "normal". The wiki page you link to is titled "Natural
number". I'm not going to pay for a copy of that iso standard, but it's
easy enough to google a pdf, which shows a very clear declararation of
"the set of natural numbers" on page 6. Nowhere do any of those sources
talk about "normal numbers".

[As the second paragraph of the wiki page points out, there is not
universal agreement on whether 0 is considered a natural number - though
I'm happy to learn that what I believe to be the right convention is
sanctioned by an ISO standard.]

Rasmus
