Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DBB218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553185245;
	bh=IhPIrhq8W8Q87S/POuATveJFR7fESaBnfudF5pTg+A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tIIq/eDtfJ98QN7pQ3Qrg2SbVtzftsZ16RPOtTJa2eQXk3tqT2B7FGBs35zMyyh3U
	 pfov+h1l9qKYI2ThRyY1eIfd+VW3UKLZfBoAd0GDjRFaiJjWqIGGT3TR+uDTCYp8O/
	 hcjgj2F8T0vVqvCh0EzWYervImwP3D1sTIevoUe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfCUQUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:20:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:37556 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUQUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:20:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 09:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="144019210"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2019 09:20:41 -0700
Date:   Thu, 21 Mar 2019 10:21:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Harris, James R" <james.r.harris@intel.com>,
        Felipe Franciosi <felipe@nutanix.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>,
        John Ferlan <jferlan@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: 
Message-ID: <20190321162140.GA29342@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321161239.GH31434@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:12:39PM +0000, Stefan Hajnoczi wrote:
> mdev-nvme seems like a duplication of SPDK.  The performance is not
> better and the features are more limited, so why focus on this approach?
> 
> One argument might be that the kernel NVMe subsystem wants to offer this
> functionality and loading the kernel module is more convenient than
> managing SPDK to some users.
> 
> Thoughts?

Doesn't SPDK bind a controller to a single process? mdev binds to
namespaces (or their partitions), so you could have many mdev's assigned
to many VMs accessing a single controller.
