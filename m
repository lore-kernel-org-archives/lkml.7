Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F77C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10532206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKOaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30309 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDKOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DE7E3065416;
        Thu, 11 Apr 2019 14:30:49 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C50095D9CD;
        Thu, 11 Apr 2019 14:30:45 +0000 (UTC)
Subject: Re: [PATCH v3 1/9] livepatch: Create and include UAPI headers
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-2-joe.lawrence@redhat.com>
 <CAK7LNAQ_=bp0VTOze7ckfXSwFy0m_g6OYPxS5K-ac7jjoutB+A@mail.gmail.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <141bbc68-95a7-3444-08a5-3794b6dc84ce@redhat.com>
Date:   Thu, 11 Apr 2019 10:30:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ_=bp0VTOze7ckfXSwFy0m_g6OYPxS5K-ac7jjoutB+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 11 Apr 2019 14:30:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 8:32 PM, Masahiro Yamada wrote:
> On Thu, Apr 11, 2019 at 12:52 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>>
>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>>
>> Define klp prefixes in include/uapi/linux/livepatch.h, and use them for
>> replacing hard-coded values in kernel/livepatch/core.c.
>>
>> [ ... snip ... ]
 >>
>> diff --git a/include/uapi/linux/livepatch.h b/include/uapi/linux/livepatch.h
>> new file mode 100644
>> index 000000000000..bb86243de805
>> --- /dev/null
>> +++ b/include/uapi/linux/livepatch.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> 
> In my understanding, UAPI headers should be licensed under:
> 
> /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> 

Good eye, that is an interesting licensing detail.  Easy enough to 
update assuming Josh (original author) is fine with adding the modifier.

>> +
>> +/*
>> + * livepatch.h - Kernel Live Patching Core
>> + *
>> + * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
>> + */
>> +
>> +#ifndef _UAPI_LIVEPATCH_H
>> +#define _UAPI_LIVEPATCH_H
>> +
>> +#include <linux/types.h>
> 
> 
> Why is this include needed?
> 
>> +#define KLP_RELA_PREFIX                ".klp.rela."
>> +#define KLP_SYM_PREFIX         ".klp.sym."
> 
> These do not depend on <linux/types.h>
> 

Hmmm, types.h has been included since v1, but I just verified that 
removing it results in a clean build, so you are correct that it is 
(now) unnecessary.

Thanks,

-- Joe
