Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE9C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6420859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4gJaN/ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbfFJPmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:42:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35292 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390454AbfFJPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:42:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFdYQh181982;
        Mon, 10 Jun 2019 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hwAMwagac6Yi0afPfWltWIF0pd2yRFxuWvj33N/Nr+0=;
 b=4gJaN/eiXIY+aw+Q6HR4ak8yWFhBOv3LOxXnlrJFHtAXJwuhBrSTOB56BPNaAI26NVbw
 VH/aaPrnJZXx+Ra6Qgm3tkQzYm3V9tFHKsxVMrKwkxnw0Sqmsyl0ZyQ2dI+yg1yaxV42
 ti+kNw5mGuWn2NgwHEGdDRTodebgb1ei22MVzAOTudlgNA8fnKYBufikKvK1StfBnRWG
 KLRNBLE7QdHY93P9MDwlX1UmTlnxS3JSbRSXUCwoxZ3hXkr7xQYB1ZS/+9Ebno3RHV/i
 fllnLHowwewnxfc+LBEVR0XbAc8xvehTEQAAf2pWvwpsZqpncQ0qOOFqhw2Rj+gLL0nN Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2t02hefv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:41:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFfEdN079190;
        Mon, 10 Jun 2019 15:41:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t024tw7ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:41:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5AFfIXg006946;
        Mon, 10 Jun 2019 15:41:19 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 08:41:18 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 80A556A00FC; Mon, 10 Jun 2019 11:42:41 -0400 (EDT)
Date:   Mon, 10 Jun 2019 11:42:41 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v4 0/9] iommu: Bounce page for untrusted devices
Message-ID: <20190610154241.GS28796@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=551
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=601 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:16:11AM +0800, Lu Baolu wrote:
> The Thunderbolt vulnerabilities are public and have a nice
> name as Thunderclap [1] [3] nowadays. This patch series aims
> to mitigate those concerns.
> 
> An external PCI device is a PCI peripheral device connected
> to the system through an external bus, such as Thunderbolt.
> What makes it different is that it can't be trusted to the
> same degree as the devices build into the system. Generally,
> a trusted PCIe device will DMA into the designated buffers
> and not overrun or otherwise write outside the specified
> bounds. But it's different for an external device.
> 
> The minimum IOMMU mapping granularity is one page (4k), so
> for DMA transfers smaller than that a malicious PCIe device
> can access the whole page of memory even if it does not
> belong to the driver in question. This opens a possibility
> for DMA attack. For more information about DMA attacks
> imposed by an untrusted PCI/PCIe device, please refer to [2].
> 
> This implements bounce buffer for the untrusted external
> devices. The transfers should be limited in isolated pages
> so the IOMMU window does not cover memory outside of what
> the driver expects. Previously (v3 and before), we proposed
> an optimisation to only copy the head and tail of the buffer
> if it spans multiple pages, and directly map the ones in the
> middle. Figure 1 gives a big picture about this solution.
> 
>                                 swiotlb             System
>                 IOVA          bounce page           Memory
>              .---------.      .---------.        .---------.
>              |         |      |         |        |         |
>              |         |      |         |        |         |
> buffer_start .---------.      .---------.        .---------.
>              |         |----->|         |*******>|         |
>              |         |      |         | swiotlb|         |
>              |         |      |         | mapping|         |
>  IOMMU Page  '---------'      '---------'        '---------'
>   Boundary   |         |                         |         |
>              |         |                         |         |
>              |         |                         |         |
>              |         |------------------------>|         |
>              |         |    IOMMU mapping        |         |
>              |         |                         |         |
>  IOMMU Page  .---------.                         .---------.
>   Boundary   |         |                         |         |
>              |         |                         |         |
>              |         |------------------------>|         |
>              |         |     IOMMU mapping       |         |
>              |         |                         |         |
>              |         |                         |         |
>  IOMMU Page  .---------.      .---------.        .---------.
>   Boundary   |         |      |         |        |         |
>              |         |      |         |        |         |
>              |         |----->|         |*******>|         |
>   buffer_end '---------'      '---------' swiotlb'---------'
>              |         |      |         | mapping|         |
>              |         |      |         |        |         |
>              '---------'      '---------'        '---------'
>           Figure 1: A big view of iommu bounce page 
> 
> As Robin Murphy pointed out, this ties us to using strict mode for
> TLB maintenance, which may not be an overall win depending on the
> balance between invalidation bandwidth vs. memcpy bandwidth. If we
> use standard SWIOTLB logic to always copy the whole thing, we should
> be able to release the bounce pages via the flush queue to allow
> 'safe' lazy unmaps. So since v4 we start to use the standard swiotlb
> logic.
> 
>                                 swiotlb             System
>                 IOVA          bounce page           Memory
> buffer_start .---------.      .---------.        .---------.
>              |         |      |         |        |         |
>              |         |      |         |        |         |
>              |         |      |         |        .---------.physical
>              |         |----->|         | ------>|         |_start  
>              |         |iommu |         | swiotlb|         |
>              |         | map  |         |   map  |         |
>  IOMMU Page  .---------.      .---------.        '---------'

The prior picture had 'buffer_start' at an offset in the page. I am
assuming you meant that here in as well?

Meaning it starts at the same offset as 'physical_start' in the right
side box?

>   Boundary   |         |      |         |        |         |
>              |         |      |         |        |         |
>              |         |----->|         |        |         |
>              |         |iommu |         |        |         |
>              |         | map  |         |        |         |
>              |         |      |         |        |         |
>  IOMMU Page  .---------.      .---------.        .---------.
>   Boundary   |         |      |         |        |         |
>              |         |----->|         |        |         |
>              |         |iommu |         |        |         |
>              |         | map  |         |        |         |
>              |         |      |         |        |         |
>  IOMMU Page  |         |      |         |        |         |
>   Boundary   .---------.      .---------.        .---------.
>              |         |      |         |------->|         |
>   buffer_end '---------'      '---------' swiotlb|         |
>              |         |----->|         |   map  |         |
>              |         |iommu |         |        |         |
>              |         | map  |         |        '---------' physical
>              |         |      |         |        |         | _end    
>              '---------'      '---------'        '---------'
>           Figure 2: A big view of simplified iommu bounce page 
> 
> The implementation of bounce buffers for untrusted devices
> will cause a little performance overhead, but we didn't see
> any user experience problems. The users could use the kernel

What kind of devices did you test it with?

Thank you for making this awesome cover letter btw!
