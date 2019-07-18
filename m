Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E8AC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8D62077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfGRDjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:39:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732313AbfGRDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:39:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I3cLjd100710
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:39:30 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttf28bk77-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:39:30 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 18 Jul 2019 04:39:29 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 04:39:26 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6I3dPPR39518630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 03:39:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D56AE063;
        Thu, 18 Jul 2019 03:39:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC3DDAE062;
        Thu, 18 Jul 2019 03:39:22 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.129.123])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 03:39:22 +0000 (GMT)
References: <20190204144048-mutt-send-email-mst@kernel.org> <87ef71seve.fsf@morokweng.localdomain> <20190320171027-mutt-send-email-mst@kernel.org> <87tvfvbwpb.fsf@morokweng.localdomain> <20190323165456-mutt-send-email-mst@kernel.org> <87a7go71hz.fsf@morokweng.localdomain> <20190520090939-mutt-send-email-mst@kernel.org> <877ea26tk8.fsf@morokweng.localdomain> <20190603211528-mutt-send-email-mst@kernel.org> <877e96qxm7.fsf@morokweng.localdomain> <20190701092212-mutt-send-email-mst@kernel.org> <87d0id9nah.fsf@morokweng.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mike Anderson <andmike@linux.ibm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <87d0id9nah.fsf@morokweng.localdomain>
Date:   Thu, 18 Jul 2019 00:39:18 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071803-0064-0000-0000-000004009593
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011449; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233740; UDB=6.00650108; IPR=6.01015068;
 MB=3.00027771; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 03:39:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071803-0065-0000-0000-00003E521224
Message-Id: <87y30wj9jt.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=947 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Just going back to this question which I wasn't able to answer.

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Michael S. Tsirkin <mst@redhat.com> writes:
>
>> So far so good, but now a question:
>>
>> how are we handling guest address width limitations?
>> Is VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS subject to
>> guest address width limitations?
>> I am guessing we can make them so ...
>> This needs to be documented.
>
> I'm not sure. I will get back to you on this.

We don't have address width limitations between host and guest.

--
Thiago Jung Bauermann
IBM Linux Technology Center

