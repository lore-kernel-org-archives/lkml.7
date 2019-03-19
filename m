Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC62C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F89D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553008881;
	bh=yIF+/JSX1jIjERjMQ3pXS/KvQfgg3HTeL1zS75H7t7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vroD3z/dRGoD2LCofCwOSt8iud4PRMawR65bRsUQgL2uemeE+Q3Sa4KDhSF/S/afJ
	 AHzH+8ZNo7i9Ly8GEqKs3I8/CLC6/s5kjFnDm84k079U+72VIx+FSUzr0K+5ddqxqb
	 P+ZSYbby+gSl3wB+zlNG9NxQ6Bfpe0Kt1kj3g0e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfCSPVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:21:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:5751 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:21:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 08:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="328664727"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 19 Mar 2019 08:21:17 -0700
Date:   Tue, 19 Mar 2019 09:22:13 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Subject: Re: your mail
Message-ID: <20190319152212.GC24176@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:
>   -> Share the NVMe device between host and guest. 
>      Even in fully virtualized configurations,
>      some partitions of nvme device could be used by guests as block devices 
>      while others passed through with nvme-mdev to achieve balance between
>      all features of full IO stack emulation and performance.
>   
>   -> NVME-MDEV is a bit faster due to the fact that in-kernel driver 
>      can send interrupts to the guest directly without a context 
>      switch that can be expensive due to meltdown mitigation.
> 
>   -> Is able to utilize interrupts to get reasonable performance. 
>      This is only implemented
>      as a proof of concept and not included in the patches, 
>      but interrupt driven mode shows reasonable performance
>      
>   -> This is a framework that later can be used to support NVMe devices 
>      with more of the IO virtualization built-in 
>      (IOMMU with PASID support coupled with device that supports it)

Would be very interested to see the PASID support. You wouldn't even
need to mediate the IO doorbells or translations if assigning entire
namespaces, and should be much faster than the shadow doorbells.

I think you should send 6/9 "nvme/pci: init shadow doorbell after each
reset" separately for immediate inclusion.

I like the idea in principle, but it will take me a little time to get
through reviewing your implementation. I would have guessed we could
have leveraged something from the existing nvme/target for the mediating
controller register access and admin commands. Maybe even start with
implementing an nvme passthrough namespace target type (we currently
have block and file).
