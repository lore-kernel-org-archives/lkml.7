Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E33C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC92075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556885701;
	bh=7CaRcobSQnr8AgSwtp9Rk5pifRZI5NRB81+BJPOTdB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tt6wnu0rGnai/BbjDpYz22d+fNKYnKxqyN+TPP9kW0K9LkI12zT2nfLFtTVpCYmUX
	 tsqqwxboQDztQvbKzquxxnNKu06BXDc9A+pPi4iPnTbP81PE6TSFdTqSphnGWvAOKi
	 I+MPgh7yJdyYGbrkEG4H6QP1gk4t50dLiy5DIK0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfECMO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:14:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:41891 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfECMO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:14:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="343043907"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 05:14:58 -0700
Date:   Fri, 3 May 2019 06:09:15 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "Heitke, Kenneth" <kenneth.heitke@intel.com>,
        linux-nvme@lists.infradead.org, Fam Zheng <fam@euphon.net>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 08/10] nvme/pci: implement the mdev external queue
 allocation interface
Message-ID: <20190503120915.GA30013@localhost.localdomain>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-9-mlevitsk@redhat.com>
 <63a499c3-25be-5c5b-5822-124854945279@intel.com>
 <f1f471e0b734413e6c0f7a8bb1a03041b1d12d6d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f471e0b734413e6c0f7a8bb1a03041b1d12d6d.camel@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:20:17AM +0300, Maxim Levitsky wrote:
> On Thu, 2019-05-02 at 15:12 -0600, Heitke, Kenneth wrote:
> > On 5/2/2019 5:47 AM, Maxim Levitsky wrote:
> > > +static void nvme_ext_queue_free(struct nvme_ctrl *ctrl, u16 qid)
> > > +{
> > > +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> > > +	struct nvme_queue *nvmeq;
> > > +
> > > +	mutex_lock(&dev->ext_dev_lock);
> > > +	nvmeq = &dev->queues[qid];
> > > +
> > > +	if (WARN_ON(!test_bit(NVMEQ_EXTERNAL, &nvmeq->flags)))
> > > +		return;
> > 
> > This condition is probably not expected to happen (since its a warning)
> > but do you need to unlock the ext_dev_lock before returning?
> 
> This is true, I will fix this. This used to be BUG_ON, but due to checkpatch.pl
> complains I turned them all to WARN_ON, and missed this.

Gentle reminder to trim your replies to the relevant context. It's
much easier to read when we don't need to scroll through hundreds of
unnecessary lines.
