Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1341CC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB0D21881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6nGr7fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393924AbfIJPX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:23:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbfIJPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:23:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8AFItUK027960;
        Tue, 10 Sep 2019 15:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tOczzZS4JVmfczdE9mY887heuT2/utVYNO9vG7SJCcc=;
 b=G6nGr7fAvGgT+9NCwikhlTwHcRA7ww33aAgb+LexAHOEHnXH8h0HpfNoNEENo/jRPvqt
 tnKbN1EnMhQh7HLj51k5bjAfWtTCXau6gbwiLIPxfPwXFKrBpHgzcFFTD1mGrpjxe3pq
 ilX2FaHLtQMOBd4XAfkP+vQhXvvsllltPBMXHHGgLKmtFqz7AvHuJyuR1IXuAPSHq9v0
 9j+fHJ/iaoXJhaE7WoHUhaJHl0BzH7xA+svEuJdzlZjrdoZ4NvQQMAWbQIX0CAgevkbm
 8FdVE2RCgjaHH2SVQjKIfU0Joc1aw3E7ITG8swlkozjhUJzvbFSwEX8gM8C8cQngCbhB Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uw1jkc7gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 15:22:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8AFIiQQ191566;
        Tue, 10 Sep 2019 15:22:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2uwq9q5j9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 15:21:11 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8AFJwpG020463;
        Tue, 10 Sep 2019 15:19:58 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 08:19:58 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 18E256A010E; Tue, 10 Sep 2019 11:21:42 -0400 (EDT)
Date:   Tue, 10 Sep 2019 11:21:42 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/5] iommu: Bounce page for untrusted devices
Message-ID: <20190910152142.GC7585@char.us.oracle.com>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
 <20190910145322.GB24103@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910145322.GB24103@8bytes.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 04:53:23PM +0200, Joerg Roedel wrote:
> On Fri, Sep 06, 2019 at 02:14:47PM +0800, Lu Baolu wrote:
> > Lu Baolu (5):
> >   swiotlb: Split size parameter to map/unmap APIs
> >   iommu/vt-d: Check whether device requires bounce buffer
> >   iommu/vt-d: Don't switch off swiotlb if bounce page is used
> >   iommu/vt-d: Add trace events for device dma map/unmap
> >   iommu/vt-d: Use bounce buffer for untrusted devices
> > 
> >  .../admin-guide/kernel-parameters.txt         |   5 +
> >  drivers/iommu/Kconfig                         |   1 +
> >  drivers/iommu/Makefile                        |   1 +
> >  drivers/iommu/intel-iommu.c                   | 310 +++++++++++++++++-
> >  drivers/iommu/intel-trace.c                   |  14 +
> >  drivers/xen/swiotlb-xen.c                     |   8 +-
> >  include/linux/swiotlb.h                       |   8 +-
> >  include/trace/events/intel_iommu.h            | 106 ++++++
> >  kernel/dma/direct.c                           |   2 +-
> >  kernel/dma/swiotlb.c                          |  30 +-
> >  10 files changed, 449 insertions(+), 36 deletions(-)
> >  create mode 100644 drivers/iommu/intel-trace.c
> >  create mode 100644 include/trace/events/intel_iommu.h
> 
> Applied, thanks.

Please un-apply the swiotlb until the WARN_ON gets fixed. Or alternatively
squash the fix once that is done.

