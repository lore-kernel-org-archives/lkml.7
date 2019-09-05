Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB8B2168B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIEEEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:04:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbfIEEEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:04:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8542YLA025101
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 00:04:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utn8puy1m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:04:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <michaele@au1.ibm.com>;
        Thu, 5 Sep 2019 05:04:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 05:03:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8543uBQ11665444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 04:03:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C124204C;
        Thu,  5 Sep 2019 04:03:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7279242045;
        Thu,  5 Sep 2019 04:03:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 04:03:56 +0000 (GMT)
Received: from localhost (unknown [9.81.222.227])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CF2DFA0231;
        Thu,  5 Sep 2019 14:03:54 +1000 (AEST)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 02/16] powerpc/pseries: Introduce option to build secure virtual machines
In-Reply-To: <87lfv5ky8j.fsf@morokweng.localdomain>
References: <20190820021326.6884-3-bauerman@linux.ibm.com> <46MFv23NDjz9sNF@ozlabs.org> <87lfv5ky8j.fsf@morokweng.localdomain>
Date:   Thu, 05 Sep 2019 14:03:54 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19090504-0008-0000-0000-00000311436B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090504-0009-0000-0000-00004A2F9AF2
Message-Id: <878sr3pexh.fsf@mpe.ellerman.id.au>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=943 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> Michael Ellerman <patch-notifications@ellerman.id.au> writes:
>> On Tue, 2019-08-20 at 02:13:12 UTC, Thiago Jung Bauermann wrote:
>>> Introduce CONFIG_PPC_SVM to control support for secure guests and include
>>> Ultravisor-related helpers when it is selected
>>> 
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>
>> Patch 2-14 & 16 applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/136bc0397ae21dbf63ca02e5775ad353a479cd2f
>
> Thank you very much!

No worries. I meant to say, there were some minor differences between
your patch 15 adding the documentation and Claudio's version. If you
want those differences applied please send me an incremental patch.

cheers

