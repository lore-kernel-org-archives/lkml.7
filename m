Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54292075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfD2Fz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:55:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbfD2Fz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:55:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3T5rWnt070566
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:55:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s5tjwht0b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:55:27 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 29 Apr 2019 06:55:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Apr 2019 06:55:23 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3T5tM5N63176736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 05:55:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161B44C046;
        Mon, 29 Apr 2019 05:55:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C33C24C044;
        Mon, 29 Apr 2019 05:55:21 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Apr 2019 05:55:21 +0000 (GMT)
Date:   Mon, 29 Apr 2019 07:55:20 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Cathy Avery <cavery@redhat.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris>
 <20190426160956.GA3827@linux-8ccs>
 <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
 <52c293e9-ddfa-426a-a8f1-2106e250e78d@redhat.com>
 <f74996cb-3e0a-ab23-00b9-85ac782583d1@redhat.com>
 <20190427102440.GA28889@osiris>
 <6a69074a-e913-3b67-feef-9b62a7400f8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a69074a-e913-3b67-feef-9b62a7400f8a@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19042905-0008-0000-0000-000002E15202
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042905-0009-0000-0000-0000224DB46F
Message-Id: <20190429055520.GA3665@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=911 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904290045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 06:42:51AM -0400, Prarit Bhargava wrote:
> On 4/27/19 6:24 AM, Heiko Carstens wrote:
> 
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 410eeb7e4f1d..48748cfec991 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3585,6 +3585,7 @@ again:
> >  					       finished_loading(mod->name));
> >  			if (err)
> >  				goto out_unlocked;
> > +			cond_resched();
> Heiko, I'm testing on 2-cpu systems which appear to show the problem ~10% of the
> time.  On another system I backed out my original patch to set a baseline, and
> noticed that occasionally the time to boot the system doubles from ~4 seconds to
> 9 seconds.  Is this something you're also concerned with?

This _could_ be an issue, since I see the problem much more likely to
happen on systems with many devices (where many means only something
like 10 block devices). As far as I can tell it looks like
systemd/udevd tries to modprobe at the s390-trng module for each(!)
device.
I have no idea why it is doing that... however given that (failed)
module handling now sometimes takes more time, this might become a
real issue on system with several 1000s of block devices, which is a
realistic scenario at least on s390.

