Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7FA218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfDXNpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:45:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbfDXNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:45:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ODeI2g004520
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:45:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2rmch35w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:45:38 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nathanl@linux.ibm.com>;
        Wed, 24 Apr 2019 14:45:37 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 14:45:33 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3ODjWZS14352610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 13:45:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7454E7805F;
        Wed, 24 Apr 2019 13:45:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA1178068;
        Wed, 24 Apr 2019 13:45:32 +0000 (GMT)
Received: from localhost (unknown [9.80.195.59])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 13:45:32 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
In-Reply-To: <CAK8P3a3At0Znn7BRxVxFdxcCa2=uJ9fAJYazKe3E9688axPj2g@mail.gmail.com>
References: <20181210223133.22667-1-ndesaulniers@google.com> <CAK8P3a3At0Znn7BRxVxFdxcCa2=uJ9fAJYazKe3E9688axPj2g@mail.gmail.com>
Date:   Wed, 24 Apr 2019 08:45:31 -0500
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042413-0036-0000-0000-00000AAE4D29
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010987; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193717; UDB=6.00625795; IPR=6.00974540;
 MB=3.00026575; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 13:45:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042413-0037-0000-0000-00004B84232B
Message-Id: <87a7gfseis.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Mon, Dec 10, 2018 at 11:32 PM <ndesaulniers@google.com> wrote:
>>
>> GNU linker's -z common-page-size's default value is based on the target
>> architecture. arch/arm/vdso/Makefile sets it to the architecture
>> default, which is implicit and redundant. Drop it.
>>
>> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> ---
>
> The patch looks good to me,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Adding Nathan Lynch to Cc though for further comments, he originally
> added the Makefile flags here and might still remember why he did it.
>
> Unless Nathan objects, please add the patch to Russell's patch
> tracker.

Thanks for cc'ing me -- no objection.

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

