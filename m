Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667BFC352AA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B01222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfIZMh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:37:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfIZMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:37:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8QCam5v103987
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:37:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8tjx94xy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:37:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 26 Sep 2019 13:37:51 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Sep 2019 13:37:48 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8QCblR030081378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 12:37:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB7C5204F;
        Thu, 26 Sep 2019 12:37:47 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B682D5204E;
        Thu, 26 Sep 2019 12:37:46 +0000 (GMT)
Date:   Thu, 26 Sep 2019 14:37:45 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch
 customizable
In-Reply-To: <20190923152117.GA2767@lst.de>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
        <20190923123418.22695-2-pasic@linux.ibm.com>
        <20190923152117.GA2767@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092612-0020-0000-0000-00000371F6A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092612-0021-0000-0000-000021C7C21D
Message-Id: <20190926143745.68bdd082.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 17:21:17 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Sep 23, 2019 at 02:34:16PM +0200, Halil Pasic wrote:
> > Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
> > common code") tweaking the client code supplied GFP_* flags used to be
> > an issue handled in the architecture specific code. The commit message
> > suggests, that fixing the client code would actually be a better way
> > of dealing with this.
> > 
> > On s390 common I/O devices are generally capable of using the full 64
> > bit address space for DMA I/O, but some chunks of the DMA memory need to
> > be 31 bit addressable (in physical address space) because the
> > instructions involved mandate it. Before switching to DMA API this used
> > to be a non-issue, we used to allocate those chunks from ZONE_DMA.
> > Currently our only option with the DMA API is to restrict the devices to
> > (via dma_mask and dma_mask_coherent) to 31 bit, which is sub-optimal.
> > 
> > Thus s390 we would benefit form having control over what flags are
> > dropped.
> 
> No way, sorry.  You need to express that using a dma mask instead of
> overloading the GFP flags.

Thanks for your feedback and sorry for the delay. Can you help me figure
out how can I express that using a dma mask? 

IMHO what you ask from me is frankly impossible.

What I need is the ability to ask for  (considering the physical
address) 31 bit addressable DMA memory if the chunk is supposed to host
control-type data that needs to be 31 bit addressable because that is
how the architecture is, without affecting the normal data-path. So
normally 64 bit mask is fine but occasionally (control) we would need
a 31 bit mask.

Regards,
Halil

