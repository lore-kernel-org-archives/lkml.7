Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77BD206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfHLU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:29:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726907AbfHLU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:29:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CKLwFx099237
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 16:29:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubcqvwju6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 16:29:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Mon, 12 Aug 2019 21:29:32 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 21:29:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7CKTQn254526030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Aug 2019 20:29:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1065A404D;
        Mon, 12 Aug 2019 20:29:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C6E1A4055;
        Mon, 12 Aug 2019 20:29:23 +0000 (GMT)
Received: from ram.ibm.com (unknown [9.85.191.17])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Aug 2019 20:29:22 +0000 (GMT)
Date:   Mon, 12 Aug 2019 13:29:20 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <20190810143038-mutt-send-email-mst@kernel.org>
 <20190810220702.GA5964@ram.ibm.com>
 <20190811055607.GA12488@lst.de>
 <20190811064621.GB5964@ram.ibm.com>
 <20190812121324.GA9405@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812121324.GA9405@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081220-0008-0000-0000-000003084E4A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081220-0009-0000-0000-00004A265E9B
Message-Id: <20190812202920.GC5964@ram.ibm.com>
Subject: RE: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=710 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:13:24PM +0200, Christoph Hellwig wrote:
> On Sat, Aug 10, 2019 at 11:46:21PM -0700, Ram Pai wrote:
> > If the hypervisor (hardware for hw virtio devices) does not mandate a
> > DMA API, why is it illegal for the driver to request, special handling
> > of its i/o buffers? Why are we associating this special handling to
> > always mean, some DMA address translation? Can't there be 
> > any other kind of special handling needs, that has nothing to do with
> > DMA address translation?
> 
> I don't think it is illegal per se.  It is however completely broken
> if we do that decision on a system weide scale rather than properly
> requesting it through a per-device flag in the normal virtio framework.

if the decision has to be system-wide; for reasons known locally only to the
kernel/driver, something that is independent of any device-flag,
what would be the mechanism?

RP

