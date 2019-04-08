Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14E020857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDHN3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:29:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbfDHN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:29:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38DQfqP063576
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 09:28:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rr619v5eb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:28:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 8 Apr 2019 14:28:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 14:28:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x38DSrPg49479694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 13:28:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D755F52054;
        Mon,  8 Apr 2019 13:28:53 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8BB4552050;
        Mon,  8 Apr 2019 13:28:53 +0000 (GMT)
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        mark.rutland@arm.com, jolsa@redhat.com
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404130300.GF14281@hirez.programming.kicks-ass.net>
 <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
 <20190408082229.GI4038@hirez.programming.kicks-ass.net>
 <20190408095031.GG14281@hirez.programming.kicks-ass.net>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 8 Apr 2019 15:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190408095031.GG14281@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040813-0008-0000-0000-000002D78844
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040813-0009-0000-0000-00002243A423
Message-Id: <7e3244ff-b373-7ecf-73bd-e7b686eceb90@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 11:50 AM, Peter Zijlstra wrote:
> On Mon, Apr 08, 2019 at 10:22:29AM +0200, Peter Zijlstra wrote:
>> On Mon, Apr 08, 2019 at 09:12:28AM +0200, Thomas-Mich Richter wrote:
> 
>>> very good news, your fix ran over the weekend without any hit!!!
>>>
>>> Thanks very much for your help. Do you submit this patch to the kernel mailing list?
>>
>> Most excellent, let me go write a Changelog.
> 
> Hi Thomas, find below.
> 
> Sadly, while writing the Changelog I ended up with a 'completely'
> differet patch again, could I bother you to test this one too?
> 


Hi Peter, no problem, test is now running overnight.
Let you know the outcome tomorrow...

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

