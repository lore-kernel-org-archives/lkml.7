Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D8C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0707D21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfJIJj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:39:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbfJIJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:39:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x999bYkw082427
        for <linux-kernel@vger.kernel.org>; Wed, 9 Oct 2019 05:39:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhbekukc7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:39:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <prudo@linux.ibm.com>;
        Wed, 9 Oct 2019 10:39:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 10:39:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x999dJ6K50135240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 09:39:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51B95AE051;
        Wed,  9 Oct 2019 09:39:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B9FAE056;
        Wed,  9 Oct 2019 09:39:19 +0000 (GMT)
Received: from laptop-ibm (unknown [9.152.212.222])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 09:39:18 +0000 (GMT)
Date:   Wed, 9 Oct 2019 11:39:17 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC v2 0/1] s390/purgatory: Make sure we fail the build if
 purgatory has missing symbols
In-Reply-To: <20191008085421.11011-1-hdegoede@redhat.com>
References: <20191008085421.11011-1-hdegoede@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100909-4275-0000-0000-0000037065B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100909-4276-0000-0000-000038836965
Message-Id: <20191009113917.47ef6eda@laptop-ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

also adding Ingo on Cc.

I tested you patch on s390 and it does what it's supposed to do. The build now
fails with 

  LD      arch/s390/purgatory/purgatory.chk
arch/s390/purgatory/purgatory: In function `sha256_update':
(.text+0x3bc2): undefined reference to `memzero_explicit'
/home/prudo/git/linux/linux/arch/s390/purgatory/Makefile:38: recipe for target 'arch/s390/purgatory/purgatory.chk' failed
make[3]: *** [arch/s390/purgatory/purgatory.chk] Error 1

After applying Arvid's memzero_explizit fix ("[PATCH] lib/string: make
memzero_explicit inline instead of external") as well the build works again.

My only problem is how to uptream your patch. Just adding it to our branch
would cause a (intentional) build breakage until Ingo's branch is merged.

@Vasliy & Ingo: Can you please find a solution for this.

Thanks
Philipp

On Tue,  8 Oct 2019 10:54:20 +0200[PATCH] lib/string: make memzero_explicit
inline instead of external Hans de Goede <hdegoede@redhat.com> wrote:

> Hi s390 maintainers,
> 
> Here is a second RFC version of my patch for $subject, mirroring the
> changes in v2 of the x86 patch.
> 
> As last time this patch is completely UNTESTED.
> 
> Changes in v2:
> - Using 2 if_changed lines under a single rule does not work, then
>   1 of the 2 will always execute each build.
>   Instead add a new (unused) purgatory.chk intermediate which gets
>   linked from purgatory.ro without -r to do the missing symbols check
> - This also fixes the check generating an a.out file (oops)
> 
> Relevant part of the cover letter from v1:
> 
> In 5.4-rc1 the 2 different sha256 implementations for the purgatory resp.
> for crypto/sha256_generic.c have been consolidated into 1 single shared
> implementation under lib/crypto/sha256.c .
> 
> At least on x86 this was causing silent corruption of the purgatory due
> to a missing memzero_explicit symbol in the purgatory string.c/.o file.
> 
> With the x86 equivalent of this patch applied a x86 build of 5.4-rc1 now
> correctly fails:
> 
>   CHK     arch/x86/purgatory/purgatory.ro
> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> make[2]: *** [arch/x86/purgatory/Makefile:72:
>     arch/x86/purgatory/kexec-purgatory.c] Error 1
> make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
> make: *** [Makefile:1650: arch/x86] Error 2
> 
> It would be great if the s390 maintainers can test this equivalent patch
> on s390.
> 
> As for fixing the missing memzero_explicit symbol, we are currently
> discussing making memzero_explicit a static inline wrapper of memset
> in string.h, so that we do not need to implement it in multiple places.
> 
> This discussion is Cc-ed to the generic linux-kernel@vger.kernel.org list,
> it is happening in the
> "[PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit" thread.
> 
> Regards,
> 
> Hans
> 
> 
> 

