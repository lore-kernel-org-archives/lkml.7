Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC395C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B020869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfK2Mmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:42:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfK2Mmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:42:45 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATCg4CV104204
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 07:42:43 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wjtts0c9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 07:42:43 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Fri, 29 Nov 2019 12:42:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Nov 2019 12:42:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xATCgbCS66257032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Nov 2019 12:42:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFE9C11C058;
        Fri, 29 Nov 2019 12:42:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A79D011C04C;
        Fri, 29 Nov 2019 12:42:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Nov 2019 12:42:36 +0000 (GMT)
Received: from [9.81.207.37] (unknown [9.81.207.37])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9B025A01F3;
        Fri, 29 Nov 2019 23:42:32 +1100 (AEDT)
Subject: Re: [PATCH] relay: handle alloc_percpu returning NULL in relay_open
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     akash.goel@intel.com,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
References: <20191129013745.7168-1-dja@axtens.net>
 <87d0dbffbk.fsf@mpe.ellerman.id.au>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Fri, 29 Nov 2019 23:42:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87d0dbffbk.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112912-4275-0000-0000-00000388029D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112912-4276-0000-0000-0000389B97A2
Message-Id: <4415adee-5c12-3d65-d44a-34ee4eb00fed@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_03:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/19 3:59 pm, Michael Ellerman wrote:
>> diff --git a/kernel/relay.c b/kernel/relay.c
>> index ade14fb7ce2e..a376cc6b54ec 100644
>> --- a/kernel/relay.c
>> +++ b/kernel/relay.c
>> @@ -580,7 +580,13 @@ struct rchan *relay_open(const char *base_filename,
>>   	if (!chan)
>>   		return NULL;
>>   
>> -	chan->buf = alloc_percpu(struct rchan_buf *);
>> +	chan->buf = alloc_percpu_gfp(struct rchan_buf *,
>> +				     GFP_KERNEL | __GFP_NOWARN);
>> +	if (!chan->buf) {
>> +		kfree(chan);
>> +		return NULL;
>> +	}
>> +
>>   	chan->version = RELAYFS_CHANNEL_VERSION;
>>   	chan->n_subbufs = n_subbufs;
>>   	chan->subbuf_size = subbuf_size;
> 
> This looks right to me. The kfree + direct return is correct, there's
> nothing else that needs tear down in this function.
> 
> I think I'm 50/50 on the __GFP_NOWARN. We're only asking for 8 bytes per
> cpu, and if that fails the system is pretty sick, so a warning could be
> helpful. There's also logic in the percpu allocator to limit the number
> of warnings printed. But see what others think.

mpe was wondering why we didn't see a message printed from the percpu 
allocator - the answer appears to be that we hit this case when the 
process is killed while the percpu allocator is waiting for 
pcpu_alloc_mutex, in which case it bails out without printing a warning.

It looks to me like that case doesn't warrant a warning message, while a 
failing allocation for other reasons should probably get a warning.

But whatever, otherwise this patch looks good to me. I've told our 
powerpc syzbot to test it.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

