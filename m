Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D4ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E913C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfJNOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:44:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731121AbfJNOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:44:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9EEZUVm069450;
        Mon, 14 Oct 2019 10:44:12 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vmt312n7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 10:44:12 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9EEeLVF014283;
        Mon, 14 Oct 2019 14:44:11 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 2vk6f6u5jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 14:44:11 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9EEiAHr28443060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 14:44:10 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B8496A057;
        Mon, 14 Oct 2019 14:44:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E7F6A054;
        Mon, 14 Oct 2019 14:44:06 +0000 (GMT)
Received: from [9.199.41.79] (unknown [9.199.41.79])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Oct 2019 14:44:05 +0000 (GMT)
Subject: Re: [PATCH 2/2] mm/gup: fix a misnamed "write" argument: should be
 "flags"
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
References: <20191013221155.382378-3-jhubbard@nvidia.com>
 <201910141316.DHpeevy3%lkp@intel.com>
 <d431c2cf-22bf-13be-05e5-c93512ac9ae5@nvidia.com>
 <20191014135234.7ak32pfir6du3xae@box>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <acc39afa-ae6f-0eb9-fa31-1b63f8f86b2e@linux.ibm.com>
Date:   Mon, 14 Oct 2019 20:14:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014135234.7ak32pfir6du3xae@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 7:22 PM, Kirill A. Shutemov wrote:
> On Sun, Oct 13, 2019 at 11:43:10PM -0700, John Hubbard wrote:
>> On 10/13/19 11:12 PM, kbuild test robot wrote:
>>> Hi John,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on linus/master]
>>> [cannot apply to v5.4-rc3 next-20191011]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/John-Hubbard/gup-c-gup_benchmark-c-trivial-fixes-before-the-storm/20191014-114158
>>> config: powerpc-defconfig (attached as .config)
>>> compiler: powerpc64-linux-gcc (GCC) 7.4.0
>>> reproduce:
>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # save the attached .config to linux build tree
>>>           GCC_VERSION=7.4.0 make.cross ARCH=powerpc
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>      mm/gup.c: In function 'gup_hugepte':
>>>>> mm/gup.c:1990:33: error: 'write' undeclared (first use in this function); did you mean 'writeq'?
>>>        if (!pte_access_permitted(pte, write))
>>>                                       ^~~~~
>>>                                       writeq
>>>      mm/gup.c:1990:33: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>
>> OK, so this shows that my cross-compiler test scripts are faulty lately,
>> sorry I missed this.
>>
>> But more importantly, the above missed case is an example of when "write" really
>> means "write", as opposed to meaning flags.
>>
>> Please put this patch on hold or drop it, until we hear from the authors as to how
>> they would like to resolve this. I suspect it will end up as something like:
>>
>> 	bool write = (flags & FOLL_WRITE);
>>
>> ...perhaps?
> 
> Just use
> 
> 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
> 
> as we have in gup_pte_range().
> 
> And add:
> 
> Fixes: cbd34da7dc9a ("mm: move the powerpc hugepd code to mm/gup.c")
> 

b798bec4741bdd80224214fdd004c8e52698e42 isn't this the commit that need 
to be mentioned in the Fixes: tag?

-aneesh
