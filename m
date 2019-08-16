Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD22C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775272089E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfHPAuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:50:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbfHPAuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:50:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G0lE2g060786;
        Thu, 15 Aug 2019 20:49:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udgdgufwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 20:49:38 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7G0l82C060567;
        Thu, 15 Aug 2019 20:49:38 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udgdgufwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 20:49:37 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7G0idd1008401;
        Fri, 16 Aug 2019 00:49:36 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 2udbc489w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 00:49:36 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7G0nZSx61276572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 00:49:35 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10C61BE05B;
        Fri, 16 Aug 2019 00:49:35 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39D37BE054;
        Fri, 16 Aug 2019 00:49:32 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.158.166])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 16 Aug 2019 00:49:31 +0000 (GMT)
References: <20190806052237.12525-1-bauerman@linux.ibm.com> <20190806052237.12525-12-bauerman@linux.ibm.com> <8736i6sfhn.fsf@concordia.ellerman.id.au> <87r25qgeb5.fsf@morokweng.localdomain> <87sgq36ivk.fsf@concordia.ellerman.id.au>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 11/16] powerpc/pseries/svm: Export guest SVM status to user space via sysfs
In-reply-to: <87sgq36ivk.fsf@concordia.ellerman.id.au>
Date:   Thu, 15 Aug 2019 21:49:26 -0300
Message-ID: <87imqyrl2h.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>>> From: Ryan Grimm <grimm@linux.vnet.ibm.com>
>>>> User space might want to know it's running in a secure VM.  It can't do
>>>> a mfmsr because mfmsr is a privileged instruction.
>>>>
>>>> The solution here is to create a cpu attribute:
>>>>
>>>> /sys/devices/system/cpu/svm
>>>>
>>>> which will read 0 or 1 based on the S bit of the guest's CPU 0.
>>>
>>> Why CPU 0?
>>>
>>> If we have different CPUs running with different MSR_S then something
>>> has gone badly wrong, no?
>>
>> Yes, that would be very bad.
>>
>>> So can't we just read the MSR on whatever CPU the sysfs code happens to
>>> run on.
>>
>> Good point. I made the change in the patch below.
>
> The patch looks good. Although, it raises the question of whether it
> should be an attribute of the CPU at all.
>
> I guess there's not obviously anywhere better for it.

Ok. TBH this patch is not as urgent as the others. It was added so that
tests have an easy way to tell if they're in an SVM. I can leave it out
for now to figure out if there's a better place for this information.

> Still you should document the attribute in Documentation/ABI/testing/sysfs-devices-system-cpu

Indedd, will do that.

--
Thiago Jung Bauermann
IBM Linux Technology Center
