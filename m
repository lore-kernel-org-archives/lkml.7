Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95937C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfI0Ui4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:38:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfI0Ui4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:38:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RKasNA040269;
        Fri, 27 Sep 2019 16:38:44 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9rd7j4u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 16:38:43 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RKUd4c029263;
        Fri, 27 Sep 2019 20:38:43 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2v5bg7u5k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 20:38:43 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RKcfPX38142260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 20:38:42 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4DD2112063;
        Fri, 27 Sep 2019 20:38:41 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 659D6112062;
        Fri, 27 Sep 2019 20:38:40 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.194.136])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 27 Sep 2019 20:38:40 +0000 (GMT)
References: <20190911163433.12822-1-bauerman@linux.ibm.com> <875zly1jbo.fsf@morokweng.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom_init: Undo relocation before entering secure mode
In-reply-to: <875zly1jbo.fsf@morokweng.localdomain>
Date:   Fri, 27 Sep 2019 17:38:38 -0300
Message-ID: <87v9td5vap.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>
>> The ultravisor will do an integrity check of the kernel image but we
>> relocated it so the check will fail. Restore the original image by
>> relocating it back to the kernel virtual base address.
>>
>> This works because during build vmlinux is linked with an expected virtual
>> runtime address of KERNELBASE.
>>
>> Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> I meant to put a Suggested-by: Paul Mackerras <paulus@samba.org>
>
> Sorry. Will add it if there's a v2.

Ping?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
