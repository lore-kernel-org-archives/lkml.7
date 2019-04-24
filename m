Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59552C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A336206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdtWjBrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfDXS2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:28:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48762 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbfDXS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:27:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OINpqI077256;
        Wed, 24 Apr 2019 18:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KBSDR6RWqPya7xUYiX+Qhe6fX2wumsafyUnxOMhrzC8=;
 b=ZdtWjBrWW1T1ii/DKxZ92QlWm+mSqiTHgpxDBM91XdHa4rPjH1vesiMI2s20vAhnWHO+
 m7ke8mXaBE2sczCRIpO0/782RMjEJOSIi0OP6G+iBBYITlVDk0Vtfic0hxP401bdEC3Z
 0FQ8l50cgDTSn4ZcG7DowoBAHz+eC95ATgyn+zjBBun5ZNw2WGnrHb5wfp8aYlSaTqhC
 9+V3nBQnRg19wODlXpxUBFsk5UMCwIAYv2pMMoSu9j6CG2Fzhj73Vc/yvysGM1X/M+93
 3ZLjXPTwOPnk4qIay1opZDaFRVt4PE8NaxUZlzoncnMwcSqZKnLPUcViy7n5Nu/r3yUQ tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rytut44ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 18:27:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OIQTAf076377;
        Wed, 24 Apr 2019 18:27:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2s0fv3qjgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 18:27:29 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3OIRRcv004972;
        Wed, 24 Apr 2019 18:27:27 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 11:27:27 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C0D466A00FB; Wed, 24 Apr 2019 14:27:30 -0400 (EDT)
Date:   Wed, 24 Apr 2019 14:27:30 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 08/10] iommu/vt-d: Check whether device requires
 bounce buffer
Message-ID: <20190424182730.GA17505@char.us.oracle.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-9-baolu.lu@linux.intel.com>
 <20190422164755.GC31181@lst.de>
 <76e35340-32c3-ee0d-5232-bd8800248402@linux.intel.com>
 <20190423060858.GA12762@lst.de>
 <e11489cf-87cc-a956-7c6c-ffdd26a4e3ec@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11489cf-87cc-a956-7c6c-ffdd26a4e3ec@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240133
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:35:51PM +0800, Lu Baolu wrote:
> Hi,
> 
> On 4/23/19 2:08 PM, Christoph Hellwig wrote:
> > > > Again, this and the option should not be in a specific iommu driver.
> > > > 
> > > 
> > > The option of whether bounce is ignored should be in the specific iommu
> > > driver.
> > 
> > Why?  As a user I could not care less which IOMMU driver my particular
> > system uses.
> > 
> 
> Looks reasonable to me. Let's listen to more opinions.

I agree with Christoph here.
> 
> Best regards,
> Lu Baolu
