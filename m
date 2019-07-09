Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07013C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F7216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGICw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:52:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbfGICw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:52:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x692pPF5045355;
        Mon, 8 Jul 2019 22:52:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tmf1fdu7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 22:52:00 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x692pxhj046997;
        Mon, 8 Jul 2019 22:51:59 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tmf1fdu6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 22:51:59 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x692oQTk000936;
        Tue, 9 Jul 2019 02:51:59 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2tjk96a903-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 02:51:59 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x692pwIQ43385274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 02:51:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 323B028059;
        Tue,  9 Jul 2019 02:51:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE5FC28058;
        Tue,  9 Jul 2019 02:51:55 +0000 (GMT)
Received: from [9.102.0.209] (unknown [9.102.0.209])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 02:51:55 +0000 (GMT)
Subject: Re: [PATCH 4/4] powerpc/64: reuse PPC32 static inline
 flush_dcache_range()
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
 <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
 <87y318d2th.fsf@linux.ibm.com>
 <CAOSf1CG-oxpSDsAPw8xHV5367MrMn2Ty_yDpPY9TvA6wMrMZHA@mail.gmail.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <c0461069-8ef8-cb56-6807-71cc79793ac4@linux.ibm.com>
Date:   Tue, 9 Jul 2019 08:21:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOSf1CG-oxpSDsAPw8xHV5367MrMn2Ty_yDpPY9TvA6wMrMZHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 7:50 AM, Oliver O'Halloran wrote:
> On Tue, Jul 9, 2019 at 12:22 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> *snip*
>>> +     if (IS_ENABLED(CONFIG_PPC64))
>>> +             isync();
>>>   }
>>
>>
>> Was checking with Michael about why we need that extra isync. Michael
>> pointed this came via
>>
>> https://github.com/mpe/linux-fullhistory/commit/faa5ee3743ff9b6df9f9a03600e34fdae596cfb2#diff-67c7ffa8e420c7d4206cae4a9e888e14
>>
>> for 970 which doesn't have coherent icache. So possibly isync there is
>> to flush the prefetch instructions? But even so we would need an icbi
>> there before that isync.
> 
> I don't think it's that, there's some magic in flush_icache_range() to
> handle dropping prefetched instructions on 970.
> 
>> So overall wondering why we need that extra barriers there.
> 
> I think the isync is needed there because the architecture only
> requires sync to provide ordering. A sync alone doesn't guarantee the
> dcbfs have actually completed so the isync is necessary to ensure the
> flushed cache lines are back in memory. That said, as far as I know
> all the IBM book3s chips from power4 onwards will wait for pending
> dcbfs when they hit a sync, but that might change in the future.
> 

ISA doesn't list that as the sequence. Only place where isync was 
mentioned was w.r.t  icbi where want to discards the prefetch.



> If it's a problem we could add a cpu-feature section around the isync
> to no-op it in the common case. However, when I had a look with perf
> it always showed that the sync was the hotspot so I don't think it'll
> help much.
> 

What about the preceding barriers (sync; isync;) before dcbf? Why are 
they needed?

-aneesh
