Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4437AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2288C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfE0UOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:14:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbfE0UOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:14:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RKBr8T036884
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 16:14:49 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2srkvx64ua-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 16:14:49 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 27 May 2019 21:14:48 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 May 2019 21:14:46 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4RKEj7P22806886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 20:14:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8620F78067;
        Mon, 27 May 2019 20:14:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16EE87805E;
        Mon, 27 May 2019 20:14:33 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.238.201])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 27 May 2019 20:14:28 +0000 (GMT)
References: <20190522220158.18479-1-bauerman@linux.ibm.com> <459lBd53mCz9sBr@ozlabs.org>
User-agent: mu4e 1.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] powerpc: Fix loading of kernel + initramfs with kexec_file_load()
In-reply-to: <459lBd53mCz9sBr@ozlabs.org>
Date:   Mon, 27 May 2019 17:14:17 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052720-0036-0000-0000-00000AC37FD2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011173; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209460; UDB=6.00635357; IPR=6.00990487;
 MB=3.00027077; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-27 20:14:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052720-0037-0000-0000-00004BF7F30A
Message-Id: <87pno3psdi.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905270142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Ellerman <patch-notifications@ellerman.id.au> writes:

> On Wed, 2019-05-22 at 22:01:58 UTC, Thiago Jung Bauermann wrote:
>> Commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
>> changed kexec_add_buffer() to skip searching for a memory location if
>> kexec_buf.mem is already set, and use the address that is there.
>> 
>> In powerpc code we reuse a kexec_buf variable for loading both the kernel
>> and the initramfs by resetting some of the fields between those uses, but
>> not mem. This causes kexec_add_buffer() to try to load the kernel at the
>> same address where initramfs will be loaded, which is naturally rejected:
>> 
>>   # kexec -s -l --initrd initramfs vmlinuz
>>   kexec_file_load failed: Invalid argument
>> 
>> Setting the mem field before every call to kexec_add_buffer() fixes this
>> regression.
>> 
>> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Reviewed-by: Dave Young <dyoung@redhat.com>
>
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/8b909e3548706cbebc0a676067b81aad

Thanks!!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

