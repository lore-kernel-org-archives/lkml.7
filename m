Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B30C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0920665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfEWIM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:12:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbfEWIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:12:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N8CroE071291
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:12:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2snmye6uda-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:12:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 23 May 2019 09:12:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 09:12:46 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4N8CjvH57278560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 08:12:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92C74204B;
        Thu, 23 May 2019 08:12:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9027542042;
        Thu, 23 May 2019 08:12:45 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.165])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 08:12:45 +0000 (GMT)
Subject: Re: [PATCH 1/3] perf report: Fix OOM error in TUI mode on s390
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
 <20190522144601.50763-2-tmricht@linux.ibm.com>
 <20190522180812.GI30271@kernel.org>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Thu, 23 May 2019 10:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522180812.GI30271@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052308-0020-0000-0000-0000033F97FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052308-0021-0000-0000-0000219280B2
Message-Id: <872a9844-2464-d92d-21b9-311174c0bae4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 8:08 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 22, 2019 at 04:45:59PM +0200, Thomas Richter escreveu:
>


.....

>>
>> This size kills the TUI interface when executing the following
>> code:
>>
>>   process_sample_event()
>>     hist_entry_iter__add()
>>       hist_iter__report_callback()
>>         hist_entry__inc_addr_samples()
>>           symbol__inc_addr_samples(symbol = __bss_stop)
>>             symbol__cycles_hist()
>>                annotated_source__alloc_histograms(...,
>> 				                symbol__size(sym),
>> 		                                ...)
>>
>> This function allocates memory to save sample histograms.
>> The symbol_size() marco is defined as sym->end - sym->start, which
>> results in above value of 0x3fe6e64a850 bytes and
>> the call to calloc() in annotated_source__alloc_histograms() fails.
> 
> Humm, why are we getting samples in that area? Is it some JITted thing
> like BPF? What is it?
> 
> Why not just not consider the calloc failure as fatal, and when/if the
> user asks for annotation on such symbol, tell the user that it wasn't
> possible to allocate N bytes for it?
> 
> - Arnaldo


I have not debugged why this sample address was recorded. BPF code was not
running.

I have no problem with making calloc() failure no fatal, however we might
still allocate large memory...

I will send a new patch.

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

