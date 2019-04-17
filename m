Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC3DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8521850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfDQVnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:43:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387653AbfDQVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:42:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HLY94S119623
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:42:58 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rxabtw870-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:42:58 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Wed, 17 Apr 2019 22:42:57 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Apr 2019 22:42:53 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3HLgq0f21037280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 21:42:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29C84112066;
        Wed, 17 Apr 2019 21:42:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C971112064;
        Wed, 17 Apr 2019 21:42:48 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.230.182])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Apr 2019 21:42:48 +0000 (GMT)
References: <87zhrj8kcp.fsf@morokweng.localdomain> <87womn8inf.fsf@morokweng.localdomain> <20190129134750-mutt-send-email-mst@kernel.org> <877eefxvyb.fsf@morokweng.localdomain> <20190204144048-mutt-send-email-mst@kernel.org> <87ef71seve.fsf@morokweng.localdomain> <20190320171027-mutt-send-email-mst@kernel.org> <87tvfvbwpb.fsf@morokweng.localdomain> <20190323165456-mutt-send-email-mst@kernel.org> <20190325005710.GC29295@umbus>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <20190325005710.GC29295@umbus>
Date:   Wed, 17 Apr 2019 18:42:44 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19041721-0068-0000-0000-000003B6AC2C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010946; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190544; UDB=6.00623874; IPR=6.00971342;
 MB=3.00026490; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 21:42:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041721-0069-0000-0000-00004832D539
Message-Id: <878sw871gr.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Gibson <david@gibson.dropbear.id.au> writes:

> On Sat, Mar 23, 2019 at 05:01:35PM -0400, Michael S. Tsirkin wrote:
>> On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
>> > Michael S. Tsirkin <mst@redhat.com> writes:
> [snip]
>> > >> > Is there any justification to doing that beyond someone putting
>> > >> > out slow code in the past?
>> > >>
>> > >> The definition of the ACCESS_PLATFORM flag is generic and captures the
>> > >> notion of memory access restrictions for the device. Unfortunately, on
>> > >> powerpc pSeries guests it also implies that the IOMMU is turned on
>> > >
>> > > IIUC that's really because on pSeries IOMMU is *always* turned on.
>> > > Platform has no way to say what you want it to say
>> > > which is bypass the iommu for the specific device.
>> >
>> > Yes, that's correct. pSeries guests running on KVM are in a gray area
>> > where theoretically they use an IOMMU but in practice KVM ignores it.
>> > It's unfortunate but it's the reality on the ground today. :-/
>
> Um.. I'm not sure what you mean by this.  As far as I'm concerned
> there is always a guest-visible (paravirtualized) IOMMU, and that will
> be backed onto the host IOMMU when necessary.

There is, but vhost will ignore it and directly map the guest memory
when ACCESS_PLATFORM (the flag previously known as IOMMU_PLATFORM) isn't
set. From QEMU's hw/virtio/vhost.c:

static int vhost_dev_has_iommu(struct vhost_dev *dev)
{
    VirtIODevice *vdev = dev->vdev;

    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
}

static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                              hwaddr *plen, int is_write)
{
    if (!vhost_dev_has_iommu(dev)) {
        return cpu_physical_memory_map(addr, plen, is_write);
    } else {
        return (void *)(uintptr_t)addr;
    }
}

--
Thiago Jung Bauermann
IBM Linux Technology Center

