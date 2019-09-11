Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA97FC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AB22075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfIKQFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:05:31 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:11590 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728818AbfIKQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:05:30 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BG1xOc026275;
        Wed, 11 Sep 2019 16:05:01 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uxxgjdyry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 16:05:01 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id A8B01A1;
        Wed, 11 Sep 2019 16:05:00 +0000 (UTC)
Received: from [16.116.129.27] (unknown [16.116.129.27])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A08DD47;
        Wed, 11 Sep 2019 16:04:58 +0000 (UTC)
Subject: Re: [PATCH V2 5/8] x86/platform/uv: Add UV Hubbed/Hubless Proc FS
 Files
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
 <20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net>
 <20190911060456.GC104115@gmail.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <1d7a8b2f-80e0-33bf-85f4-2de719747eeb@hpe.com>
Date:   Wed, 11 Sep 2019 09:05:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911060456.GC104115@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_08:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909110146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2019 11:04 PM, Ingo Molnar wrote:
> 
> * Mike Travis <mike.travis@hpe.com> wrote:
> 
>> @@ -1596,7 +1687,7 @@ static void __init uv_system_init_hub(vo
>>   	uv_nmi_setup();
>>   	uv_cpu_init();
>>   	uv_scir_register_cpu_notifier();
>> -	proc_mkdir("sgi_uv", NULL);
>> +	uv_setup_proc_files(0);
> 
> This slipped through previously: platform drivers have absolutely no
> business mucking in /proc.
> 
> Please describe the hardware via sysfs as pretty much everyone else does.
> 
> Thanks,
> 
> 	Ingo
> 

If I was doing it now I definitely would put it in the sysfs realm.  The 
problem is Jack did it back in (I think) 2007.  The earliest commit I 
could find:

commit a3d732f93785da17e0137210deadb4616f5536fc
Author: Cliff Wickman <cpw@sgi.com>
Date:   Mon Nov 10 16:16:31 2008 -0600

     x86, UV: fix redundant creation of sgi_uv

     Impact: fix double entry creation in /proc

And in the past 12 years probably a hundred user programs are now keying 
of the presence of /proc/sgi_uv to signal this is indeed a UV system. 
Changing the location of this node also affects all the UV utilities 
including those not written by us.
