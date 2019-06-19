Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E17C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A5E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfFSHsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbfFSHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:48:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J7lW4B149786
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:48:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t7dbuh7n4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:48:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 19 Jun 2019 08:48:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 08:48:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5J7m0eH53674124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 07:48:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED6D1A4057;
        Wed, 19 Jun 2019 07:47:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A778A4040;
        Wed, 19 Jun 2019 07:47:58 +0000 (GMT)
Received: from [9.124.31.60] (unknown [9.124.31.60])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 07:47:58 +0000 (GMT)
Subject: Re: [PATCH 0/5] Powerpc/hw-breakpoint: Fixes plus Code refactor
To:     Michael Neuling <mikey@neuling.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
 <2344165b-b55b-d1b9-fd96-e057500e8c74@c-s.fr>
 <85d5494d2a5d4a887e739c379105436e498217a8.camel@neuling.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 19 Jun 2019 13:17:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <85d5494d2a5d4a887e739c379105436e498217a8.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061907-0016-0000-0000-0000028A6128
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061907-0017-0000-0000-000032E7B628
Message-Id: <44c41c74-66a5-fa34-00b8-6de6e9b264bb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/19 11:47 AM, Michael Neuling wrote:
> On Tue, 2019-06-18 at 08:01 +0200, Christophe Leroy wrote:
>>
>> Le 18/06/2019 à 06:27, Ravi Bangoria a écrit :
>>> patch 1-3: Code refactor
>>> patch 4: Speedup disabling breakpoint
>>> patch 5: Fix length calculation for unaligned targets
>>
>> While you are playing with hw breakpoints, did you have a look at 
>> https://github.com/linuxppc/issues/issues/38 ?
> 
> Agreed and also: 
> 
> https://github.com/linuxppc/issues/issues/170
> 
> https://github.com/linuxppc/issues/issues/128 
> 

Yes, I'm aware of those. Will have a look at them.

