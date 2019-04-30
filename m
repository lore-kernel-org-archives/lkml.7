Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E3A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfD3JQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:16:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfD3JQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:16:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3U98FGP046501
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 05:16:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s6hj3dejm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 05:16:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 30 Apr 2019 10:16:47 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Apr 2019 10:16:46 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3U9GjwS52429002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:16:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 815BDA4055;
        Tue, 30 Apr 2019 09:16:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56B8EA4051;
        Tue, 30 Apr 2019 09:16:45 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Apr 2019 09:16:45 +0000 (GMT)
Date:   Tue, 30 Apr 2019 11:16:44 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Reschedule while waiting for modules to
 finish loading
References: <20190429151751.15424-1-prarit@redhat.com>
 <20190430075108.GA21092@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430075108.GA21092@linux-8ccs>
X-TM-AS-GCONF: 00
x-cbid: 19043009-0012-0000-0000-00000316C720
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19043009-0013-0000-0000-0000214F2F36
Message-Id: <20190430091643.GB5487@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 09:51:08AM +0200, Jessica Yu wrote:
> +++ Prarit Bhargava [29/04/19 11:17 -0400]:
> >Heiko, do you want a Signed-off-by or a Reported-by?  Either one works
> >for me.
> >
> >P.
> 
> I think you forgot to CC Heiko :)

Indeed ;)

I'm fine with the Reported-by tag. Thank you!

> >----8<----
> >
> >On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
> >loading the s390_trng.ko module.
> >
> >Add a reschedule point to the loop that waits for modules to complete
> >loading.
> >
> >Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> >Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
> >Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> >Cc: Jessica Yu <jeyu@kernel.org>
> >---
> >kernel/module.c | 1 +
> >1 file changed, 1 insertion(+)
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index 410eeb7e4f1d..48748cfec991 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -3585,6 +3585,7 @@ static int add_unformed_module(struct module *mod)
> >					       finished_loading(mod->name));
> >			if (err)
> >				goto out_unlocked;
> >+			cond_resched();
> >			goto again;
> >		}
> >		err = -EEXIST;
> >-- 
> >2.18.1
> >

