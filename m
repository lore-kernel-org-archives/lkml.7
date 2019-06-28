Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10938C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D096821726
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfF1Lt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:49:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726564AbfF1Lt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:49:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SBktql034395
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:49:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdgnvm2ye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:49:55 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anju@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 12:49:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 12:49:51 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SBnoRP55574710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 11:49:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64FEA52052;
        Fri, 28 Jun 2019 11:49:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.75.80])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4250B5204E;
        Fri, 28 Jun 2019 11:49:49 +0000 (GMT)
Subject: Re: power9 NUMA crash while reading debugfs imc_cmd
To:     Qian Cai <cai@lca.pw>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1561670472.5154.98.camel@lca.pw>
 <87lfxms8r3.fsf@concordia.ellerman.id.au>
 <715A934D-EE3A-478B-BA77-589C539FC52D@lca.pw>
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date:   Fri, 28 Jun 2019 17:19:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <715A934D-EE3A-478B-BA77-589C539FC52D@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19062811-0020-0000-0000-0000034E5C46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062811-0021-0000-0000-000021A1DC69
Message-Id: <9c87dc72-54f8-8510-c400-1e89779cc88b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/19 9:04 AM, Qian Cai wrote:
>
>> On Jun 27, 2019, at 11:12 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Qian Cai <cai@lca.pw> writes:
>>> Read of debugfs imc_cmd file for a memory-less node will trigger a crash below
>>> on this power9 machine which has the following NUMA layout.
>> What type of machine is it?
> description: PowerNV
> product: 8335-GTH (ibm,witherspoon)
> vendor: IBM
> width: 64 bits
> capabilities: smp powernv opal


Hi Qian Cai,

Could you please try with this patch: 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-June/192803.html

and see if the issue is resolved?


Thanks,

Anju


