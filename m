Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63039C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfK2OJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:09:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbfK2OJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:09:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATE2aHC101988
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 09:09:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wjtq039wg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 09:09:50 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 29 Nov 2019 14:09:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Nov 2019 14:09:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xATE9h6h50200654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Nov 2019 14:09:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAAF011C05E;
        Fri, 29 Nov 2019 14:09:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7816511C050;
        Fri, 29 Nov 2019 14:09:42 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.151])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Nov 2019 14:09:42 +0000 (GMT)
Date:   Fri, 29 Nov 2019 15:09:41 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <Ashish.Kalra@amd.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
In-Reply-To: <20191126184527.GA10481@lst.de>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
        <20191119121022.03aed69a.pasic@linux.ibm.com>
        <20191119080420-mutt-send-email-mst@kernel.org>
        <20191122140827.0ead345c.pasic@linux.ibm.com>
        <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
        <20191126184527.GA10481@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112914-4275-0000-0000-000003880D13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112914-4276-0000-0000-0000389BA270
Message-Id: <20191129150941.34cab07a.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 19:45:27 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Sat, Nov 23, 2019 at 09:39:08AM -0600, Tom Lendacky wrote:
> > Ideally, having a pool of shared pages for DMA, outside of standard
> > SWIOTLB, might be a good thing.  On x86, SWIOTLB really seems geared
> > towards devices that don't support 64-bit DMA. If a device supports 64-bit
> > DMA then it can use shared pages that reside anywhere to perform the DMA
> > and bounce buffering. I wonder if the SWIOTLB support can be enhanced to
> > support something like this, using today's low SWIOTLB buffers if the DMA
> > mask necessitates it, otherwise using a dynamically sized pool of shared
> > pages that can live anywhere.
> 
> I think that can be done relatively easily.  I've actually been thinking
> of multiple pool support for a whіle to replace the bounce buffering
> in the block layer for ISA devices (24-bit addressing).
> 
> I've also been looking into a dma_alloc_pages interface to help people
> just allocate pages that are always dma addressable, but don't need
> a coherent allocation.  My last version I shared is here:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages
> 
> But it turns out this still doesn't work with SEV as we'll always
> bounce.  And I've been kinda lost on figuring out a way how to
> allocate unencrypted pages that we we can feed into the normal
> dma_map_page & co interfaces due to the magic encryption bit in
> the address.  I guess we could have a fallback path in the mapping
> path and just unconditionally clear that bit in the dma_to_phys
> path.

Thanks Christoph! Thanks Tom! I will do some looking and thinking and
report back.

Regards,
Halil

