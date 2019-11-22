Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56957C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAF920714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKVNIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:08:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfKVNIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:08:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMD7WZe027686
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:08:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wd5s2xb4n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:08:37 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 22 Nov 2019 13:08:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Nov 2019 13:08:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAMD8T9J28114958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 13:08:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 700134C044;
        Fri, 22 Nov 2019 13:08:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22A24C052;
        Fri, 22 Nov 2019 13:08:28 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.110])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Nov 2019 13:08:28 +0000 (GMT)
Date:   Fri, 22 Nov 2019 14:08:27 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
In-Reply-To: <20191119080420-mutt-send-email-mst@kernel.org>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112213-0008-0000-0000-000003362449
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112213-0009-0000-0000-00004A5551E7
Message-Id: <20191122140827.0ead345c.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michael!

Actually I also hoped to start a discussion on virtio with encrypted
memory.

I assume the AMD folks have the most experience with this, and I very
much like to understand how do they master the challenges we are all
facing.

My understanding of IO in the context of AMD SEV is that the user
is responsible for choosing the swiotlb command line parameter of the
guest kernel so, that the guest never runs out of swiotlb. And that
not doing so may have fatal consequences with regards to the guest. [1]

The swiotlb being a guest global resource, to choose such a size, one
would fist need to know the maximal swiotlb footprint of each device,
and then apply some heuristics regarding fragmentation.

Honestly, if somebody asked me how to calculate the max swiotlb
footprint of the most common virtio devices, I would feel very
uncomfortable.

But maybe I got it all wrong. @Tom can you help me understand how this
works?

In any case, we s390 protected virtualization folks are concerned about
the things laid out above. The goal of this patch is to make the swiotlb
full condition less grave, but it is by no means a full solution.

I would like to work on improving on this situation. Obviously we have
done some thinking about what can be done, but I would very much like to
collect the opinions, of the people in the community that AFAICT face
same problem. One of the ideas is to try to prevent it from happening by
making swiotlb sizing dynamic. Another idea is to make the system deal
with the failures gracefully. Both ideas come with a bag of problems of
their own (AFAICT).

According to my research the people I need to talk to are Tom (AMD), and
Ram and Thiago (Power) and of course the respective maintainers. Have I
missed anybody?

Regards,
Halil

--

[1] https://github.com/AMDESE/AMDSEV#faq-4

On Tue, 19 Nov 2019 08:04:29 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Will be in the next pull request.
> 
> On Tue, Nov 19, 2019 at 12:10:22PM +0100, Halil Pasic wrote:
> > ping
> > 
> > On Thu, 14 Nov 2019 13:46:46 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> > > Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
> > > virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
> > > a very realistic scenario for guests with encrypted memory, as swiotlb
> > > may run out of space, depending on it's size and the I/O load.
> > > 
> > > The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
> > > error, despite the fact that swiotlb full is in absence of bugs a
> > > recoverable condition.
> > > 
> > > Let us change the return code to -ENOMEM, and make the block layer
> > > recover form these failures when virtio-blk encounters the condition
> > > described above.
> > > 
> > > Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > > ---
> > > 
[..]

