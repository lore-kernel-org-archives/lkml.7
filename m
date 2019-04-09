Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C09C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08482070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfDINn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:43:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbfDINn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:43:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39DeXq6043845
        for <linux-kernel@vger.kernel.org>; Tue, 9 Apr 2019 09:43:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rruwfj9sj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:43:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 9 Apr 2019 14:43:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 14:43:18 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x39DhHix57737368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 13:43:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD57EAE05F;
        Tue,  9 Apr 2019 13:43:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81321AE04D;
        Tue,  9 Apr 2019 13:43:17 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Apr 2019 13:43:17 +0000 (GMT)
Date:   Tue, 9 Apr 2019 15:43:16 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] ubsan: Avoid unnecessary 128-bit shifts
References: <201904050158.x351wr9f016512@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904050158.x351wr9f016512@sdf.org>
X-TM-AS-GCONF: 00
x-cbid: 19040913-0016-0000-0000-0000026CF29F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040913-0017-0000-0000-000032C91C40
Message-Id: <20190409134316.GC4227@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:58:53AM +0000, George Spelvin wrote:
> If CONFIG_ARCH_SUPPORTS_INT128, s_max is 128 bits, and variable
> sign-extending shifts of such a double-word data type are a non-trivial
> amount of code and complexity.  Do a single-word sign-extension *before*
> the cast to (s_max), greatly simplifying the object code.
> 
> Rasmus Villemoes suggested using sign_extend* from <linux/bitops.h>.
> 
> On s390 (and perhaps some other arches), gcc implements variable
> 128-bit shifts using an __ashrti3 helper function which the kernel
> doesn't provide, causing a link error.  In that case, this patch is
> a prerequisite for enabling INT128 support.  Andrey Ryabinin has gven
> permission for any arch that needs it to cherry-pick it so they don't
> have to wait for ubsan to be merged into Linus' tree.

Still, this should go upstream via Andrew Morton.

As soon as this gets merged I'd like to select ARCH_SUPPORTS_INT128 on
s390 unconditionally.

However... ;)

> +static inline long sign_extend_long(unsigned long value, int index)
> +{
> +	if (sizeof(value) == 4)
> +		return sign_extend32(value);
> +	return sign_extend64(value);
> +}
> +

This doesn't compile:

In file included from ./include/linux/kernel.h:12,
                 from ./arch/s390/include/asm/bug.h:5,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
./include/linux/bitops.h: In function 'sign_extend_long':
./include/linux/bitops.h:163:10: error: too few arguments to function 'sign_extend32'
   return sign_extend32(value);
          ^~~~~~~~~~~~~
./include/linux/bitops.h:143:21: note: declared here
 static inline __s32 sign_extend32(__u32 value, int index)
                     ^~~~~~~~~~~~~
./include/linux/bitops.h:164:9: error: too few arguments to function 'sign_extend64'
  return sign_extend64(value);
         ^~~~~~~~~~~~~
./include/linux/bitops.h:154:21: note: declared here
 static inline __s64 sign_extend64(__u64 value, int index)
                     ^~~~~~~~~~~~~

