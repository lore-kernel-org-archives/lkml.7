Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29886C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B2A206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5eQX4hfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391464AbfFJQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:08:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35394 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389392AbfFJQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:08:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFwsBg002715;
        Mon, 10 Jun 2019 16:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yJSUkUfJlNJAw+L9mkymSs4Y+eCe6BeX8bK8q/f5wUs=;
 b=5eQX4hfMyqiisp6GNaLZr5IPvrE+m1NcEoQ7xFlIXRI2Xc+qRPkcDRAYar3l87aWWaZp
 DvnfQnDrCRwT7gwkGF41dkqeAv7M3sCJeyPjY/tH3ayZMxi9w5y+EndLFh7YbvPCne11
 AiXgpyk1y1ieHWTu9n3QqGXycz7FmPOQ4AV+uqkKdfhXvrZYITTkzr1wSNSMg+v41ihE
 +yN/NdMIQZELR28IdGegWGR/4xLQaxf5xudNDc0/tIKVi7l44AWRyfNF7biHuVcFbfzD
 YLRT5AO9Gs/TafTQACmJYnpVvu5aIC1z4p/qS1gpJmHErc8kxCqTaW3qIua8tmu/1nuI /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02heg106-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 16:07:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AG6mex023934;
        Mon, 10 Jun 2019 16:07:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jpgxxat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 16:07:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5AG7FxX009151;
        Mon, 10 Jun 2019 16:07:16 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 09:07:15 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id D3A6C6A00FC; Mon, 10 Jun 2019 12:08:38 -0400 (EDT)
Date:   Mon, 10 Jun 2019 12:08:38 -0400
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 7/9] iommu/vt-d: Add trace events for domain map/unmap
Message-ID: <20190610160838.GY28796@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603011620.31999-8-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=892
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=940 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:16:18AM +0800, Lu Baolu wrote:
> This adds trace support for the Intel IOMMU driver. It
> also declares some events which could be used to trace
> the events when an IOVA is being mapped or unmapped in
> a domain.

Is that even needed considering SWIOTLB also has tracing events?
