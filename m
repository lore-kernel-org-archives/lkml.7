Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D84C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96621848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzVcanTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405556AbfHVXEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:04:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35174 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbfHVXEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:04:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so4565085pgv.2;
        Thu, 22 Aug 2019 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JVU95exBjHdfvipHaUyTwOy4gZGJDfMsi14XdjAuNbg=;
        b=jzVcanTp063Y2pjOkhp6QojnEWYXMe2bLQaZLhm+XsCG2f4XVz4LeR32w+ERnzVTbU
         xTnvQn9cRD2gFTiNhrR/QYbE/3KiOJGCBqvcoV8RSgGpOAk8HGyX/dbHtnE7XtbgXuK9
         D8Q9StwXXPFKT30KVYBpo4f7Mm2MF6zN6dku9Eo+0qRCzKtiRKvNPp/3Ec+CDhM5bXk2
         FuQiy5JXm6P2aTaW4r0jYdLkbE5R/CI8F1z5IACo1idikMy5WLh4k1l1SifUnM6k6fqk
         nzxouaOqsJ9dPt/2yBPYNakJUBN/kiO1hyA47bkWVJ7fCcc57u7d+70b0Rv+0DVQEAD1
         K8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JVU95exBjHdfvipHaUyTwOy4gZGJDfMsi14XdjAuNbg=;
        b=EG/ntjVtmXY6hXxsFG/41yE2CuxFlLGIRtHr7jFoZ+OHu1VB3XEa4onxwhVWn83x2I
         OO0o/IY4/Bd6Tqcq7J9rKdXuUZbcwegvVoeiV6BKyp5ygW+0ikqO/4fuWOEOJ1F2KcSt
         X4nhPNjQ0TcWNbDL1wFeFwsgnuNpoLF45Rmhg7zI6dR9yId0yWVrNHo070VstU6VZhrO
         8NHhtJN8jLZRN8uj8S5zFzbGRhbmOOXxs6UpDAL6mKrX+c1Qz6lQoZN+HfV9K273LvCD
         xEwt7ctlcrwIYa8PVm2//YR733qPl2sJ+NxAuIl6DLt2FKapykc80QzKJbVq+FmqG0N2
         0+Dw==
X-Gm-Message-State: APjAAAVLd8ZEPa6VN66fT3iReQk/4Sz4C8bEEXEhYUdVkBcN/ai1fkv9
        Px3BfPTOwVFwlG/Ko0uR5OBMpLgy
X-Google-Smtp-Source: APXvYqy1QkRfISBkrDhUil9TiACVJ0jo7TgmINTiREK7hKH3la8l5Khvc4Ol4XOwd57wC37essGcBw==
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr2119603pjs.88.1566515081458;
        Thu, 22 Aug 2019 16:04:41 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k6sm456363pfi.12.2019.08.22.16.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 16:04:40 -0700 (PDT)
Subject: Re: [PATCH] parisc: fix compilation errrors
To:     Helge Deller <deller@gmx.de>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, James.Bottomley@HansenPartnership.com,
        kirill.shutemov@linux.intel.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190815205305.1382-1-cai@lca.pw>
 <20190815210208.GA9868@roeck-us.net>
 <0f27b102-471a-e472-3e69-d9883a36efeb@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f6be421-5304-3d2c-1e6e-d9f464bdff88@roeck-us.net>
Date:   Thu, 22 Aug 2019 16:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0f27b102-471a-e472-3e69-d9883a36efeb@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 1:53 PM, Helge Deller wrote:
> On 15.08.19 23:02, Guenter Roeck wrote:
>> On Thu, Aug 15, 2019 at 04:53:05PM -0400, Qian Cai wrote:
>>> The commit 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix
>>> variable 'p4d' set but not used") converted a few functions from macros
>>> to static inline, which causes parisc to complain,
>>>
>>> In file included from ./include/asm-generic/4level-fixup.h:38:0,
>>>                   from ./arch/parisc/include/asm/pgtable.h:5,
>>>                   from ./arch/parisc/include/asm/io.h:6,
>>>                   from ./include/linux/io.h:13,
>>>                   from sound/core/memory.c:9:
>>> ./include/asm-generic/5level-fixup.h:14:18: error: unknown type name
>>> 'pgd_t'; did you mean 'pid_t'?
>>>   #define p4d_t    pgd_t
>>>                    ^
>>> ./include/asm-generic/5level-fixup.h:24:28: note: in expansion of macro
>>> 'p4d_t'
>>>   static inline int p4d_none(p4d_t p4d)
>>>                              ^~~~~
>>>
>>> It is because "4level-fixup.h" is included before "asm/page.h" where
>>> "pgd_t" is defined.
>>>
>>> Fixes: 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used")
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Helge Deller <deller@gmx.de>
> 
> Helge
> 

Any chance to push this patch into mainline anytime soon ? It has been applied
to -next, but all parisc builds in mainline are still broken.

Thanks,
Guenter
