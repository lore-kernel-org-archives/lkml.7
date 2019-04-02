Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F271C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5E02075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z7c8RfEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfDBTCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:02:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43903 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfDBTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:02:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so12627177ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vnnMwtGlBE0Yvz+axzlkS6WeB8MVf14JlhwhvAZOtHQ=;
        b=Z7c8RfEAZYSyKXV43cMabVo3yW/U1akBHSg9xQDPDOGiFzE8pmsrbH5XE4YQ9cWtYQ
         yJqkj3R6jm0qo1Tz1q3ae9DPXBc+LxQT46v+tBblZr3r1ZGogKYD8ZMfzTjbkxtsAQ4W
         OqR61ocLErFA+S9Krkya0y9m2HBoGFoZ2dtdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vnnMwtGlBE0Yvz+axzlkS6WeB8MVf14JlhwhvAZOtHQ=;
        b=bffy14Aa+swmHQFsRrhnOPaFFhF47xhXSn66X4xmUYQbl63YKcVATnrT6u5Okb+KjD
         vfq9eUgf8eugIQrvufBRv1VO92XqjXVCWIoK6ZOP5qHJZgGyZKoPgYCRM/FbkGfBP2x1
         HN2udzbS40hAVcU+98Xin1bdudadk2Bn5kAfYrTe9Uq8MXjHra1hXIZSNLPErdJqmhpC
         M4HSXWWeQ7D8e7QQ1JLm64ZQ34YIEuj2qblKHcWRd+G+DME/0d4yGHZ7ULrx3TTMky0c
         iNBjM9fAfDNyTmN13hA0HH2Pd79oIaVJYsXZ7GHWNH5JL8AV0jG9s4m7qBnGjQQGvd13
         R1uw==
X-Gm-Message-State: APjAAAU8exiUflvhHm+ngATqqMWkg6fzXx5htIkmU5SYVer1rD8Da2Dr
        clFeCRYt14eACzBrm+q+IyDvBg==
X-Google-Smtp-Source: APXvYqxmFKba2USa8sutCHaQJHfi5k9VKPY1K2aZOeb8EfTIf6efFnH/Wf5sXWj3qTvMd9ifK1MAoA==
X-Received: by 2002:a50:b618:: with SMTP id b24mr49039482ede.9.1554231749062;
        Tue, 02 Apr 2019 12:02:29 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id x20sm4212588eda.40.2019.04.02.12.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:02:28 -0700 (PDT)
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190331214020.836098943@linutronix.de>
 <20190331215136.039902969@linutronix.de>
 <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
 <20190402154329.scp7i7uqevubgwrz@treble>
 <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4db4323f-3416-54a8-27e3-c491827a2fbd@rasmusvillemoes.dk>
Date:   Tue, 2 Apr 2019 21:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 17.48, Thomas Gleixner wrote:
> On Tue, 2 Apr 2019, Josh Poimboeuf wrote:
>> On Tue, Apr 02, 2019 at 12:19:46PM +0200, Thomas Gleixner wrote:
>>> +/*
>>> + * Array of exception stack page descriptors. If the stack is larger than
>>> + * PAGE_SIZE, all pages covering a particular stack will have the same
>>> + * info.
>>> + */
>>> +static const struct estack_pages estack_pages[ESTACK_PAGES] ____cacheline_aligned = {
>>> +	[CONDRANGE(DF)]		= ESTACK_PAGE(DOUBLEFAULT_IST, DF),
>>> +	[CONDRANGE(NMI)]	= ESTACK_PAGE(NMI_IST, NMI),
>>> +	[PAGERANGE(DB)]		= ESTACK_PAGE(DEBUG_IST, DB),
>>> +	[CONDRANGE(MCE)]	= ESTACK_PAGE(MCE_IST, MCE),
>>
>> It would be nice if the *_IST macro naming aligned with the struct
>> cea_exception_stacks field naming.  Then you could just do, e.g.
>> ESTACKPAGE(DF).
> 
> Yes, lemme fix that up.
> 
>> Also it's a bit unfortunate that some of the stack size knowledge is
>> hard-coded here, i.e #DB always being > 1 page and non-#DB being
>> sometimes 1 page.
> 
> The problem is that there is no way to make this macro maze conditional on
> sizeof(). But my macro foo is rusty.

Eh, but why do you need the CONDRANGE thing at all? [5 ... 5] is a
perfectly fine designator, equivalent to [5]. So you can just use
PAGERANGE in all cases, no?

Rasmus
