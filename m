Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC849C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82192085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfIKU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:58:37 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:46610 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730545AbfIKU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:58:36 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BKuTwo030715;
        Wed, 11 Sep 2019 20:58:17 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uxpwjgd84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 20:58:17 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 080C19A;
        Wed, 11 Sep 2019 20:58:17 +0000 (UTC)
Received: from [16.116.129.27] (unknown [16.116.129.27])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id C296A46;
        Wed, 11 Sep 2019 20:58:15 +0000 (UTC)
Subject: Re: [PATCH 4/8] x86/platform/uv: Setup UV functions for Hubless UV
 Systems
From:   Mike Travis <mike.travis@hpe.com>
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
 <20190910145839.975787119@stormcage.eag.rdlabs.hpecorp.net>
 <20190911060702.GD104115@gmail.com>
 <e3a3d64d-87ff-d6de-c550-9a3249b687dd@hpe.com>
Message-ID: <e10cd5c2-c0b0-60f6-ee49-12ff62a483ef@hpe.com>
Date:   Wed, 11 Sep 2019 13:58:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e3a3d64d-87ff-d6de-c550-9a3249b687dd@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_10:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=971 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909110187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2019 1:44 PM, Mike Travis wrote:
> 
> 
> On 9/10/2019 11:07 PM, Ingo Molnar wrote:
>>
>> * Mike Travis <mike.travis@hpe.com> wrote:
>>
>>> +/* Initialize UV hubless systems */
>>> +static __init int uv_system_init_hubless(void)
>>> +{
>>> +    int rc;
>>> +
>>> +    /* Setup PCH NMI handler */
>>> +    uv_nmi_setup_hubless();
>>> +
>>> +    /* Init kernel/BIOS interface */
>>> +    rc = uv_bios_init();
>>> +
>>> +    return rc;
>>> +}
> 
> This looks like an excessive cleanup error by me.  The original was:
> 
>> +static __init int uv_system_init_hubless(void)
>> +{
>> +       int rc;
>> +
>> +       /* Setup PCH NMI handler */
>> +       uv_nmi_setup_hubless();
>> +
>> +       /* Init kernel/BIOS interface */
>> +       rc = uv_bios_init();
>> +
>> +       /* Create user access node if UVsystab available */
>> +       if (rc >= 0)
>> +               uv_setup_proc_files(1);
>> +
>> +       return rc;
>> +}
>> +
> 
> Hubbed UV's do not have a non-UV BIOS, but hubless systems in theory 
> can.   So uv_bios_init can fail on hubless systems if it has some other 
> BIOS (unlikely but possible).  So I removed too much in this cleanup. 
> I'll send another patch set that puts this back.

I discovered the problem... In a rearrangement of the patches this 
change does happen but in a later patch [5/8]:

  /* Initialize UV hubless systems */
  static __init int uv_system_init_hubless(void)
  {
@@ -1468,6 +1555,10 @@ static __init int uv_system_init_hubless
         /* Init kernel/BIOS interface */
         rc = uv_bios_init();

+       /* Create user access node if UVsystab available */
+       if (rc >= 0)
+               uv_setup_proc_files(1);
+
         return rc;
  }

The mistake you saw [in patch 3/8] is very short lived... Hopefully no 
need for another patch set?

> 
> Thanks,
> Mike
> 
>>
>> Am I the only one who immediately sees the trivial C transformation
>> through which this function could lose a local variable and become 4
>> lines shorter?
>>
>> And this function got two Reviewed-by tags...
>>
>> Thanks,
>>
>>     Ingo
>>
