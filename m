Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9474C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 23:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834992075B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 23:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfIKX6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 19:58:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbfIKX6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 19:58:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8BNvo4E069648;
        Wed, 11 Sep 2019 19:57:50 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uy7u7myy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 19:57:50 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8BNnwUF024757;
        Wed, 11 Sep 2019 23:53:24 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 2uv467gra0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 23:53:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8BNrNlL59310362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 23:53:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BDB17805C;
        Wed, 11 Sep 2019 23:53:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D5D7805E;
        Wed, 11 Sep 2019 23:53:21 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.169.8])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Sep 2019 23:53:21 +0000 (GMT)
References: <20190911163433.12822-1-bauerman@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/prom_init: Undo relocation before entering secure mode
In-reply-to: <20190911163433.12822-1-bauerman@linux.ibm.com>
Date:   Wed, 11 Sep 2019 20:53:15 -0300
Message-ID: <875zly1jbo.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> The ultravisor will do an integrity check of the kernel image but we
> relocated it so the check will fail. Restore the original image by
> relocating it back to the kernel virtual base address.
>
> This works because during build vmlinux is linked with an expected virtual
> runtime address of KERNELBASE.
>
> Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

I meant to put a Suggested-by: Paul Mackerras <paulus@samba.org>

Sorry. Will add it if there's a v2.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
