Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A533C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4C521939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268567;
	bh=8ggC59kStR5I5LrA2NgjS3Hgh5jZM4DOIk1n8jiusIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zyBgw0GPTKKW6sfy0XmflFLHLUjVibi8CvZGNJFbo5nJsx3nIzx8AbnVTcOJkbzvL
	 HgdRoFUccyzPx381kbyegcSN2EtqamCCY1lz+m8kg387fSeE9/1teDEb0rvQvQBGdH
	 wP6fxGwzy+LjKjnQ83Iio0vKiGJ5mNF5kkfV7arA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCVP30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:29:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:7722 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCVP30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:29:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 08:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154833755"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2019 08:29:24 -0700
Date:   Fri, 22 Mar 2019 09:30:25 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Fam Zheng <fam@euphon.net>,
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
Message-ID: <20190322153025.GA31194@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
 <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
 <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
 <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 07:54:50AM +0000, Felipe Franciosi wrote:
> > 
> > Note though that SPDK doesn't support sharing the device between host and the
> > guests, it takes over the nvme device, thus it makes the kernel nvme driver
> > unbind from it.
> 
> That is absolutely true. However, I find it not to be a problem in practice.
> 
> Hypervisor products, specially those caring about performance, efficiency and fairness, will dedicate NVMe devices for a particular purpose (eg. vDisk storage, cache, metadata) and will not share these devices for other use cases. That's because these products want to deterministically control the performance aspects of the device, which you just cannot do if you are sharing the device with a subsystem you do not control.

I don't know, it sounds like you've traded kernel syscalls for IPC,
and I don't think one performs better than the other.

> For scenarios where the device must be shared and such fine grained control is not required, it looks like using the kernel driver with io_uring offers very good performance with flexibility.

NVMe's IO Determinism features provide fine grained control for shared
devices. It's still uncommon to find hardware supporting that, though.
