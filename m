Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259FDC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C1C24093
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZnI7pdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfE3Lue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:50:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36440 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfE3Lud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:50:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so2476996plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zmwy2eCtUUPpDmMBQ6rFl9JiUjPHoljW8LGh3yuYhmY=;
        b=ZZnI7pduCOEyDrTOKbUkeeWSaSWpo4AGBgyk6uXATZ6TCGZu1F34Uaokh4K7EdUwOm
         pSJlGykrnmzd5NlhQMWUFiP/TV0OJoimXtJqJvo0DKFQuKBW+g2pTA/tmDOdccCIB0U3
         59kZNt9/5019Wfhqf3W9Q49sdMYk6Mc3Ow5Hw6yI6+z/Jh3szcYixvPB0NPMR0SY+AN9
         Udb4OZfhGhPvbkGRBVm/V5AyzLSgSBnGIZemwWBEv+8MDjrIUe5SlN3fpLz9RmCApkKx
         6yPOW6PkNUSe6SgepP1H7APphWpsrtXzSAH4FIr1WBeQqRTP6ryBNmn+QjbAs/vV7PrA
         qzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zmwy2eCtUUPpDmMBQ6rFl9JiUjPHoljW8LGh3yuYhmY=;
        b=G7fToYvPcTMYZsH+DJp1yCMhqV9aZKY4uYkNMWTm82sbdIxSXVLAXRRjeJ8+yUri4G
         rjuix4SnryEGavIAukfsKgAOBEFXP2BkhUmOSNDa199yaDWqao6d7e07ITa1EX4mQ7vq
         N0ESgmQMBYCG08z0U+8PF/nmbVBqdib4jiepqKuDvKjfK3z6TaachYfOL7DcnkntSYro
         aIdAlCXx/LUJQR+DIfJ9igNfT2vA0L9bDznPo5t8qu96Cgqy37qGz5h6xTJUECmrh7bC
         UDWAJzgni1MwstQ/ajxVWZQoBCZjGoVs7xxHEiZM+8rXboJqAuyzkGdby+kzTSBYcgwb
         3tmg==
X-Gm-Message-State: APjAAAVpqkm8uOqBV6bvvgSsDYFkoAWI9bD/BJ/+Y34DdSvHLa6rGu9u
        OFyN1dKb0CqajpWmERihkJ3I5I5s
X-Google-Smtp-Source: APXvYqxPMquWu/rMiDxK6n5moKWUfjKKkSgX86nM154Y5TovzJ11jElNqOzLhaVEYdXaQdhmiseoyw==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr3327256plf.246.1559217033011;
        Thu, 30 May 2019 04:50:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q125sm6264967pfq.62.2019.05.30.04.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:50:32 -0700 (PDT)
Subject: Re: [PATCH] samples: pidfd: Fix compile error seen if
 __NR_pidfd_send_signal is undefined
To:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <1559216447-28355-1-git-send-email-linux@roeck-us.net>
 <CAB50BEC-4816-4D92-AC46-921C62B1D344@brauner.io>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b4e3a71d-9892-f71c-3df5-4c721ff0ed75@roeck-us.net>
Date:   Thu, 30 May 2019 04:50:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAB50BEC-4816-4D92-AC46-921C62B1D344@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 4:43 AM, Christian Brauner wrote:
> On May 30, 2019 1:40:47 PM GMT+02:00, Guenter Roeck <linux@roeck-us.net> wrote:
>> To make pidfd-metadata compile on all arches, irrespective of whether
>> or not syscall numbers are assigned, define the syscall number to -1
>> if it isn't to cause the kernel to return -ENOSYS.
>>
>> Fixes: 43c6afee48d4 ("samples: show race-free pidfd metadata access")
>> Cc: Christian Brauner <christian@brauner.io>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> samples/pidfd/pidfd-metadata.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/samples/pidfd/pidfd-metadata.c
>> b/samples/pidfd/pidfd-metadata.c
>> index 640f5f757c57..1e125ddde268 100644
>> --- a/samples/pidfd/pidfd-metadata.c
>> +++ b/samples/pidfd/pidfd-metadata.c
>> @@ -21,6 +21,10 @@
>> #define CLONE_PIDFD 0x00001000
>> #endif
>>
>> +#ifndef __NR_pidfd_send_signal
>> +#define __NR_pidfd_send_signal	-1
>> +#endif
>> +
>> static int do_child(void *args)
>> {
>> 	printf("%d\n", getpid());
> 
> Couldn't you just use the actual syscall number?
> That should still fail if the kernel is to old
> and still work on kernels that support it
> but for whatever reason the unistd.h h
> header doesn't have it defined.
> 

syscall numbers can differ from architecture to architecture, and the
provided solution is used in other test code. Please feel free to submit
a different patch, though - I am only interested in a fix, which doesn't
have to be mine.

Note that this fails in mips builds.

Thanks,
Guenter
