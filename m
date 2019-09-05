Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FF620825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfIEQHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:07:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731190AbfIEQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:07:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85G6mFj049654;
        Thu, 5 Sep 2019 12:06:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uu3q0de09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 12:06:49 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x85G6nEG049715;
        Thu, 5 Sep 2019 12:06:49 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uu3q0ddx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 12:06:49 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x85G5NWD016118;
        Thu, 5 Sep 2019 16:06:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2uqgh7k5bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 16:06:44 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x85G6gHd16908604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 16:06:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7E8EAE060;
        Thu,  5 Sep 2019 16:06:42 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A11A9AE05F;
        Thu,  5 Sep 2019 16:06:40 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.152.73])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Sep 2019 16:06:40 +0000 (GMT)
References: <20190820021326.6884-3-bauerman@linux.ibm.com> <46MFv23NDjz9sNF@ozlabs.org> <87lfv5ky8j.fsf@morokweng.localdomain> <878sr3pexh.fsf@mpe.ellerman.id.au>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Michael Ellerman <michaele@au1.ibm.com>
Cc:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 02/16] powerpc/pseries: Introduce option to build secure virtual machines
In-reply-to: <878sr3pexh.fsf@mpe.ellerman.id.au>
Date:   Thu, 05 Sep 2019 13:06:36 -0300
Message-ID: <87h85qzq0j.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Michael,

Michael Ellerman <michaele@au1.ibm.com> writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>> Michael Ellerman <patch-notifications@ellerman.id.au> writes:
>>> On Tue, 2019-08-20 at 02:13:12 UTC, Thiago Jung Bauermann wrote:
>>>> Introduce CONFIG_PPC_SVM to control support for secure guests and include
>>>> Ultravisor-related helpers when it is selected
>>>>
>>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>>
>>> Patch 2-14 & 16 applied to powerpc next, thanks.
>>>
>>> https://git.kernel.org/powerpc/c/136bc0397ae21dbf63ca02e5775ad353a479cd2f
>>
>> Thank you very much!
>
> No worries. I meant to say, there were some minor differences between
> your patch 15 adding the documentation and Claudio's version. If you
> want those differences applied please send me an incremental patch.

Thanks for pointing it out. There's no need. Claudio's version is the
canonical one. The differences are because I had a slightly older
version at the time I posted my patches.

--
Thiago Jung Bauermann
IBM Linux Technology Center
