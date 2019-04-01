Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CABB20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SHBJgINp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDAUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:10:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36509 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDAUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:10:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so9517394edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dS238LEb0PWUf/IiVkIbdKNy8B8/WKlXXPDLci+X7/E=;
        b=SHBJgINpv38taHdc8uR3o0P1RWhlC6rmsBB6rIYcoiF6nYyHdIhxbpIKQD1CqA4Sc+
         2axD1t0XAPzG/0k5ES8/5JX91JKj0qTHo40lMT+TCZSTRA2K6MQvdh8YStd7ut9O2HEw
         sUG05ir3v7sNgQWLEmiusePYV6T776SRbvJBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dS238LEb0PWUf/IiVkIbdKNy8B8/WKlXXPDLci+X7/E=;
        b=WxetK9/RSrbCblodt4660mB1fC9s7xU15kUSaE6s/6NSbBIAMbp2KZHgyhaNEYjkaX
         dUV0x90avWBwML7fujTCNvnKmLa7vWIweGyc1wMgi1MES94IUaiamGDTC75RNTITcC2g
         oec9FUnh8lYPQK7HqlD0MMrf5B4nP5q7EmAianBWzQdLx8zCd8L5JhtHxaMwmu8Nq2dg
         hfJFHPxNCIQiEcGpjDQGK2Bnc9RcBLjd/wexshd8kUYxV3co0no7L8KalqX6YLdVHcWG
         UWt7JL44dAkIxjzn8gl8SQ7OCq+x4d2RZ/Q8DtB8XqKFKNkvTHzB9YqaIrle9jr8R1Pe
         NcIA==
X-Gm-Message-State: APjAAAXwni9rOPLPXIfoBrm1M3H/ABmElDhF47KW4yY05w4agJLLvLqv
        raQccKgE02Yoa15hEpIP+VGcfg==
X-Google-Smtp-Source: APXvYqz6PV6WQJi1k9iRmORo+tbPbNP4H9M8cMeV6TqAEH2OfyyeVCkdz0LpKmjvIuTQcOWGoc7Zcw==
X-Received: by 2002:a17:906:c343:: with SMTP id ci3mr38108921ejb.194.1554149435023;
        Mon, 01 Apr 2019 13:10:35 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id g41sm3524952edb.23.2019.04.01.13.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:10:34 -0700 (PDT)
Subject: Re: PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by
 CONFIG_NUMA
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <ynorov@marvell.com>
References: <20190330185436.GA19813@yury-thinkpad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9ad8cb18-ba77-c659-4f44-4ab4f810f9f1@rasmusvillemoes.dk>
Date:   Mon, 1 Apr 2019 22:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330185436.GA19813@yury-thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2019 19.54, Yury Norov wrote:
> Hi Rasmus!
> 
>> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Sent: Saturday, March 30, 2019 12:53:51 AM
>> To: Rasmus Villemoes; Andrew Morton; Andy Shevchenko
>> Cc: Yury Norov; linux-kernel@vger.kernel.org
>> Subject: [PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by CONFIG_NUMA
>>
>> The bitmap_remap, _bitremap, _onto and _fold functions are only used,
>> via their node_ wrappers, in mm/mempolicy.c, which is only built for
>> CONFIG_NUMA. The helper bitmap_ord_to_pos used by these functions is
>> global, but its only external caller is node_random() in lib/nodemask.c,
>> which is also guarded by CONFIG_NUMA.
> 
> Nice catch. I think you should protect declaration of those functions
> in include/linux/bitmap.h as well.

Yeah, well, it's not that simple, because one would also need to wrap
the static inline __nodes_onto etc. in ifdefs. Normally, there'd be an
#else branch defining simple static inline replacements that always fail
or return 0, but we can't do that here. So I'd prefer a simple linker
error should any user outside NUMA ever appear. Which I very highly doubt.

> I'm concerned about pollution of such a generic portion of code with
> subsystem-related #ifdefs. Would it make more sense to move numa-specific
> stuff to lib/bitmap_numa.c and include/linux/bitmap_numa.h (or *_nodemask.h,
> or whatever)?

Well, yes, that might be better, but a lot bigger patch. One could also
argue that bitmap.c is _already_ polluted with subsystem specific code
(though not in the form of preprocessor directives).

Dunno, I'll defer to Andrew's judgment.

Rasmus
