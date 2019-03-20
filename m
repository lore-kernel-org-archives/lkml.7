Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D8D218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553101351;
	bh=7G48HZIX95PNFoIqOqiO7qLUtbaJCPXyyEJCx2MPR+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nkMYvfaEY1/dMHoWfnLcvwkx7lmu51tZfh58J3eXEfIvwctj7Z+4H2XIxmG+7D7rw
	 IE3RgdZGhtvYOK6YL5zFtEApWGm+zZcUSm4PI1B3qH+9TN8mHGyT6hZ+oOHa1OvWoC
	 lr4IX4/0ITCGnVha7ML/7fY5T7/ZEIuf1Wf5hjtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCTRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:02:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:34755 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfCTRC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:02:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 10:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="135726514"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2019 10:02:24 -0700
Date:   Wed, 20 Mar 2019 11:03:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        John Ferlan <jferlan@redhat.com>
Subject: Re: your mail
Message-ID: <20190320170321.GA27462@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
 <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:30:29PM +0200, Maxim Levitsky wrote:
> Or instead I can use the block backend, 
> (but note that currently the block back-end doesn't support polling which is
> critical for the performance).

Oh, I think you can do polling through there. For reference, fs/io_uring.c
has a pretty good implementation that aligns with how you could use it.
