Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E1C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D5420640
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407889AbfJQHGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:06:24 -0400
Received: from thoth.sbs.de ([192.35.17.2]:54696 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390955AbfJQHGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:06:23 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x9H75TrX028281
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 09:05:29 +0200
Received: from [167.87.38.115] ([167.87.38.115])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x9H75SUB010204;
        Thu, 17 Oct 2019 09:05:29 +0200
Subject: Re: [PATCH] scripts/gdb: fix debugging modules on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191015105313.12663-1-iii@linux.ibm.com>
 <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
 <EC1E8F36-C374-4130-9841-CC35F557B7CE@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d50b9ad-3e70-27d4-e73a-f67a33b39e7f@siemens.com>
Date:   Thu, 17 Oct 2019 09:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <EC1E8F36-C374-4130-9841-CC35F557B7CE@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.19 17:43, Ilya Leoshkevich wrote:
>> Am 15.10.2019 um 17:21 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>>> @@ -113,6 +113,12 @@ lx-symbols command."""
>>>         if module_file:
>>>             gdb.write("loading @{addr}: {filename}\n".format(
>>>                 addr=module_addr, filename=module_file))
>>> +            if utils.is_target_arch('s390'):
>>> +                # Module text is preceded by PLT stubs on s390.
>>> +                module_arch = module['arch']
>>> +                plt_offset = int(module_arch['plt_offset'])
>>> +                plt_size = int(module_arch['plt_size'])
>>> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
>>
>> Shouldn't we report the actual address above, ie. reorder this tuning
>> with the gdb.write?
> 
> That's a tough question. I thought about this, and the argument for
> showing the fixed up address is that if someone does the math with
> symbol offsets from e.g. objdump, the result will be consistent with
> what gdb shows.
> 
> On the other hand side, why would anyone do this? that's exactly what
> this gdb script is for. So showing the actual address at which the
> memory was allocated gives the user some additional information, and is
> also consistent with what cat /proc/modules would show.
> 
> At the end of the day, I don't have a strong opinion on this, so if you
> think it's better to show the fixed up address, I'll send a v2.

One of the original ideas of the printout was to provide the information
needed to reproduce potential issues manually. From that perspective,
the fixed-up address would the the thing to print.

If you think the vanilla address has some value as well, we could make
an s390-specifi printout of both values.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
