Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DDC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpDUMh43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIMjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:39:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46295 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfJIMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:39:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so1537158pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFsvEPN4hiHMlDYyUwsnor18aPb0yDPMcBpGrLSQCi4=;
        b=VpDUMh43gYy18DlDXwaI0fdCcjDxFbwRCbZ699C+HMhCH3mmjb90A7d7FYgRfkhLxP
         svU7gIRD8ZtUGry4LonkwC3oUkAN3obM1CDkN8djdMBA1Do2wCkpFriR4UXUP1ek0rr1
         bvVzEEYqDtUAESKugVOGD3FcfB472NbwE8hC5TOv+M72z0Gz+YUWxLz/R77z1E04hhMi
         EVO3UvRBhFmlBfpKDks28mS12bPazC1fQTx7F/MvMsKtlGxd+B+x9NOes8zVNBpGBLjW
         UcTIwhx5/hh/njLIU8GCGgzgx+m/xRl0YZebcRMvsHmRW/1z6iARgXnTWSFCVuZRLXEs
         3Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wFsvEPN4hiHMlDYyUwsnor18aPb0yDPMcBpGrLSQCi4=;
        b=D4PCKfiidUUf9R4cfo73mUe2V5/x/G78v92gJvjLn7NnvSzNZ7biysj/fsgFvaDfkh
         iC0aCDIRTTnzvYBMVUjGWRHLyGJh5YVog5fEa+iMXFu46nIl66dyWlj8jMPMrB6Ee8cE
         EQCmphBgX8Y8krBQQvzGLmlBQOg61i8lDcokUb3+HKOLZqnvOcvfQqWlKavZXx5RlIUl
         wwNuFKtITBN0s4B3i8BxT6YYkmsStnBkyLn1s240OiTpCn2eKrVvWLtc9Vsd2+3PShGS
         Fh77oRBS7tAW3edssnO5V6lWDoedO2/D6zsFSqQVSiM06lZptDZMfQsJySI6ibLa+vbU
         8JWw==
X-Gm-Message-State: APjAAAUdYPsE5gsjA2+S8foQzxQq9AHS4NpIgYtSiumN3+d2YVhQCOi+
        6vIXggllEPKU36nJgHUgvIg=
X-Google-Smtp-Source: APXvYqzE1Y6pQ9aLhmsuA7JioJhkfDo6/AAqH/MW7E8npnCx6z6gUVu56q8LUFvRo7r7ebq0n5dVxA==
X-Received: by 2002:a63:c445:: with SMTP id m5mr4073422pgg.211.1570624757250;
        Wed, 09 Oct 2019 05:39:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s3sm2169915pjq.32.2019.10.09.05.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 05:39:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] sched/topology: Improve load balancing on AMD EPYC
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com, Borislav Petkov <bp@alien8.de>,
        Thomas.Lendacky@amd.com, Mel Gorman <mgorman@techsingularity.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190808195301.13222-1-matt@codeblueprint.co.uk>
 <20190808195301.13222-3-matt@codeblueprint.co.uk>
 <20191007152816.GA10940@roeck-us.net>
 <20191009120412.GA4065@codeblueprint.co.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <846c01c4-f388-0634-9b98-618b82f74ca4@roeck-us.net>
Date:   Wed, 9 Oct 2019 05:39:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009120412.GA4065@codeblueprint.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 5:04 AM, Matt Fleming wrote:
> On Mon, 07 Oct, at 08:28:16AM, Guenter Roeck wrote:
>>
>> This patch causes build errors on systems where NUMA does not depend on SMP,
>> for example MIPS and PPC. For example, building mips:ip27_defconfig with SMP
>> disabled results in
>>
>> mips-linux-ld: mm/page_alloc.o: in function `get_page_from_freelist':
>> page_alloc.c:(.text+0x5018): undefined reference to `node_reclaim_distance'
>> mips-linux-ld: page_alloc.c:(.text+0x5020): undefined reference to `node_reclaim_distance'
>> mips-linux-ld: page_alloc.c:(.text+0x5028): undefined reference to `node_reclaim_distance'
>> mips-linux-ld: page_alloc.c:(.text+0x5040): undefined reference to `node_reclaim_distance'
>> Makefile:1074: recipe for target 'vmlinux' failed
>> make: *** [vmlinux] Error 1
>>
>> I have seen a similar problem with one of my PPC test builds.
>>
>> powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x18): undefined reference to `node_reclaim_distance'
> 
> Thanks for this Guenter.
> 
> So, the way I've fixed this same issue for ia64 was to make NUMA
> depend on SMP. Does that seem like a suitable solution for both PPC
> and MIPS?
> 

You would still have to cover all other architectures where SMP and NUMA are independent
of each other. Fortunately, it looks like this is only sh4.

sh4-linux-ld: mm/page_alloc.o: in function `get_page_from_freelist':
page_alloc.c:(.text+0x3ce0): undefined reference to `node_reclaim_distance'
Makefile:1074: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

arm64 and s390 happen to work because they mandate SMP support, even though NUMA
is nominally independent.

Wondering - why not declare node_reclaim_distance outside SMP dependency ?

Thanks,
Guenter
