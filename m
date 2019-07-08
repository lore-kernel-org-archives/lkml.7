Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9081C606A1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C026920659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfGHJjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:39:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfGHJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:39:39 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mgf4k-1iRSYw42Zw-00h3XH; Mon, 08 Jul 2019 11:38:59 +0200
Subject: Re: [PATCH] sched/topology: One function call less in
 build_group_from_child_sched_domain()
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ad2e7dfb-3323-b214-716e-a6cae41b8bcc@web.de>
 <20190706172223.GA12680@linux.vnet.ibm.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <65dedcbc-aefb-eb30-39e1-194248214369@metux.net>
Date:   Mon, 8 Jul 2019 11:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190706172223.GA12680@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8wBrfagyDqUmyHZdI4/YvRiTnAGqE1b8phfN4j+zhAitnHbT9bw
 Qb2gZ9dRKuuuJMvhAJscZssN4vmGOSOjrhkrWyNCTvkD7km2ZS7GXLy+FE5NBNRkwxqz94o
 sC0JIOP9qD6l3qNeuDdwuucVLFiqrQiIKh9almdJJv2Bu7SgvSfToZex9NxNBHrA5ZtzFkB
 U85l2pQ+2jXAPSPPQo8pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fyZEtlCBsVQ=:7W6MaUzLMjiPoZuwU0Fe+s
 u6I0SmwNIxdIJKhng/yDzARH4260uXjI8HJvvkx3GeCt64p7F9jsEHbbp4Kbgl8SdD5+Dkc2I
 MpY36hOxdo5++DOO9bP4krXwvq3iT7e2LTz+w9ylSeITN/sihaQqNSq2ne9pLygNznyOW+B6u
 s0YWreAvKixY/7j6CZ7/qDOJLbx4qHL1PY+SKPU9py6OZ3g4E9bdF7Fl2a+MPpsIdvT8SxZuC
 zZCBCVRO4PniFTBE1NSgYlKcL/EszYT6YE0CDZROsY9PSNSP5qb2O7Y9dKw1iRmS7cRBB392U
 UPKaWeX9IkFYbEnMZnep/5lIdfGw/EKQbmAgU2XnHMkTO6VD/Rx/8PSwJwTPNS5l5rHtIkJre
 9o5h4euOQkEXdv5m5NVAMLkcMSqSjemp8/ThUWARIoF8YbjDQiuNoE7EyCIRKgs5maVGQZDt0
 lZPbe5t/hZtHt3LBUbHO4u9BwwXYnxiEto7frZyGiSN3HXlzJnB5JHBAX17f3LD3WamUO33/J
 n93RBkWFdCPFOFA6roVy6X2YdSeFC1dhl6nHbeUQBHaQ+bolbAZBqFWkwNyk0iH6UKODI5dC9
 ry9DH91dKJqv+OCtdwlBU9UnANYlehiRJjBUd174qmh0fMX/L5JLSICE8JUZR7UXyPMTIuOQy
 8x4assWGaHLtX2o7WROwyNWorbr48xg/N+ZOcCEJIZTkGKvePJ2KOl2Rtrl8tcwyk0Ch2sYz0
 UKtpC7guwNDKp+KZdX7dRfrb1Dq69427eN/di7Ep+Cn2E7zFaWgI9TsSULI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.19 19:22, Srikar Dronamraju wrote:
> * Markus Elfring <Markus.Elfring@web.de> [2019-07-06 16:05:17]:
> 
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 6 Jul 2019 16:00:13 +0200
>>
>> Avoid an extra function call by using a ternary operator instead of
>> a conditional statement.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  kernel/sched/topology.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index f751ce0b783e..6190eb52c30a 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -886,11 +886,7 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
>>  		return NULL;
>>
>>  	sg_span = sched_group_span(sg);
>> -	if (sd->child)
>> -		cpumask_copy(sg_span, sched_domain_span(sd->child));
>> -	else
>> -		cpumask_copy(sg_span, sched_domain_span(sd));
>> -
>> +	cpumask_copy(sg_span, sched_domain_span(sd->child ? sd->child : sd));
> 
> At runtime, Are we avoiding a function call?
> However I think we are avoiding a branch instead of a conditional, which may
> be beneficial.

If you're assuming the compiler doesn't already optimize that (no idea
whether gcc really does that).

@Markus: could you check what gcc is actually generating out of both the
old and your new version ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
