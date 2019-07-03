Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D759C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1D218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGdp+1HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCM7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:59:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35981 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:59:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so1223846pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ouWnXLxg4ztxXDt/TZujciYyAwrslehJzaThxzlNGEc=;
        b=HGdp+1HCA6NLpYs1SV4MGO79EIiZsu2RxQpweguODv+FXyPE610/hIXbBrjYbhUpaa
         x8cSkuvCPLc5FMRap0UqSVSd8QTlrYvuAmYmNHFzazFt830f1bztjpvxWMa9lCV+SiLB
         FouMvabY6r1nYWSSJ8LDrv9/uZcWZk1Go0iSwjOCTZSo+nyPw3dsgakWDt+UDPDn+lDt
         tIszfU/UB97eOYB+s2UqZjvRHvjnvlCiWz+N6+rxuyY+5cmIz4H5l0l3JNTC4pL8M0Hw
         f7PfxA6BoLuhaVUoS6/ZUCVvTY6F2IdFjzGyEnViDCrfXplSlEy0US/iHuv8zHQhYJBd
         VnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouWnXLxg4ztxXDt/TZujciYyAwrslehJzaThxzlNGEc=;
        b=VuECFFV3ZFVozWcoOf2joJ7mmYrLKrOgXntmyXaIleKe6Yrp219LRTUs32FkE4TGiA
         ONR/KdVKK1Tiy1e6NY6tGaF8tWCERQq/Ec1z8epqJur2bK2rZ4dV+cg+oKYGgY9x01Ye
         3fIYtyZvra+758IGfkNQxom1bbE10ZsOWOMeNuzDYR3QBTDA+TUpzqY6XVS+o0onWHhT
         bB8EJQ6NUOs/jZW6RbFvrQ/DI1tdgGT+zEm/hpYG3ShrOtpl0PxNUiti1ke/5lO2G+Nt
         ZPtsqG6Cno1IaOfMNtrgpkr4W0KhJorRlxmmTZQWIoE3OcY4mzFWOk/VooaziqAzovej
         um8Q==
X-Gm-Message-State: APjAAAWSJSgY1qqtS8c3WsgmRdfIQ5wXoKauzGmptL0GSHwev73QsGF3
        RQqjdZJf+xtOG0VAvBqXKCE=
X-Google-Smtp-Source: APXvYqxFTji1JG+3QVruvwDkAscN+e2dBfknvjPHa8Ff9O+QoFcmuk4Wi3S9TrXVvQpsIpUNdM8ZKg==
X-Received: by 2002:a17:90a:3463:: with SMTP id o90mr12935683pjb.15.1562158744663;
        Wed, 03 Jul 2019 05:59:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u65sm9916014pjb.1.2019.07.03.05.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:59:03 -0700 (PDT)
Subject: Re: [DRAFT] mm/kprobes: Add generic kprobe_fault_handler() fallback
 definition
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
References: <78863cd0-8cb5-c4fd-ed06-b1136bdbb6ef@arm.com>
 <1561973757-5445-1-git-send-email-anshuman.khandual@arm.com>
 <8c6b9525-5dc5-7d17-cee1-b75d5a5121d6@roeck-us.net>
 <fc68afaa-32e1-a265-aae2-e4a9440f4c95@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a5eb5d5-32f0-01cd-b2fe-890ebb98395b@roeck-us.net>
Date:   Wed, 3 Jul 2019 05:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <fc68afaa-32e1-a265-aae2-e4a9440f4c95@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 10:35 PM, Anshuman Khandual wrote:
> 
> 
> On 07/01/2019 06:58 PM, Guenter Roeck wrote:
>> On 7/1/19 2:35 AM, Anshuman Khandual wrote:
>>> Architectures like parisc enable CONFIG_KROBES without having a definition
>>> for kprobe_fault_handler() which results in a build failure. Arch needs to
>>> provide kprobe_fault_handler() as it is platform specific and cannot have
>>> a generic working alternative. But in the event when platform lacks such a
>>> definition there needs to be a fallback.
>>>
>>> This adds a stub kprobe_fault_handler() definition which not only prevents
>>> a build failure but also makes sure that kprobe_page_fault() if called will
>>> always return negative in absence of a sane platform specific alternative.
>>>
>>> While here wrap kprobe_page_fault() in CONFIG_KPROBES. This enables stud
>>> definitions for generic kporbe_fault_handler() and kprobes_built_in() can
>>> just be dropped. Only on x86 it needs to be added back locally as it gets
>>> used in a !CONFIG_KPROBES function do_general_protection().
>>>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> I am planning to go with approach unless we just want to implement a stub
>>> definition for parisc to get around the build problem for now.
>>>
>>> Hello Guenter,
>>>
>>> Could you please test this in your parisc setup. Thank you.
>>>
>>
>> With this patch applied on top of next-20190628, parisc:allmodconfig builds
>> correctly. I scheduled a full build for tonight for all architectures.
> 
> How did that come along ? Did this pass all build tests ?
> 

Let's say it didn't find any failures related to this patch. I built on top of
next-20190701 which was quite badly broken for other reasons. Unfortunately,
next-20190702 is much worse, so retesting would not add any value at this time.
I'd say go for it.

Guenter
