Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83518C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEF8216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHUTM1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:12:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727685AbfHUTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:12:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LJCQ8a027579
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:12:26 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhb5y1q1h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:12:25 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 21 Aug 2019 20:12:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 20:12:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LJCE5f48169192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 19:12:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D7D64C044;
        Wed, 21 Aug 2019 19:12:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3280F4C040;
        Wed, 21 Aug 2019 19:12:14 +0000 (GMT)
Received: from localhost (unknown [9.85.72.179])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 19:12:13 +0000 (GMT)
Date:   Thu, 22 Aug 2019 00:42:12 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: Regression fix for bpf in v5.3 (was Re: [RFC PATCH] bpf: handle
 32-bit zext during constant blinding)
To:     Jiong Wang <jiong.wang@netronome.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
References: <20190813171018.28221-1-naveen.n.rao@linux.vnet.ibm.com>
        <87d0gy6cj6.fsf@concordia.ellerman.id.au> <87k1b6yeh1.fsf@netronome.com>
In-Reply-To: <87k1b6yeh1.fsf@netronome.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19082119-0028-0000-0000-0000039234C0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082119-0029-0000-0000-000024545D62
Message-Id: <1566414605.l9kcxxdjo7.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiong Wang wrote:
> 
> Michael Ellerman writes:
> 
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>> Since BPF constant blinding is performed after the verifier pass, there
>>> are certain ALU32 instructions inserted which don't have a corresponding
>>> zext instruction inserted after. This is causing a kernel oops on
>>> powerpc and can be reproduced by running 'test_cgroup_storage' with
>>> bpf_jit_harden=2.
>>>
>>> Fix this by emitting BPF_ZEXT during constant blinding if
>>> prog->aux->verifier_zext is set.
>>>
>>> Fixes: a4b1d3c1ddf6cb ("bpf: verifier: insert zero extension according to analysis result")
>>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>> ---
>>> This approach (the location where zext is being introduced below, in 
>>> particular) works for powerpc, but I am not entirely sure if this is 
>>> sufficient for other architectures as well. This is broken on v5.3-rc4.
>>
>> Any comment on this?
> 
> Have commented on https://marc.info/?l=linux-netdev&m=156637836024743&w=2
> 
> The fix looks correct to me on "BPF_LD | BPF_IMM | BPF_DW", but looks
> unnecessary on two other places. It would be great if you or Naveen could
> confirm it.

Jiong,
Thanks for the review. I can now see why the other two changes are not 
necessary. I will post a follow-on patch.

Thanks!
- Naveen

