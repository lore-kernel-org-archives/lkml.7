Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5222C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855112082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566226288;
	bh=CnOPR/e44FYPZO3KrGvvAvxky60l5hPQKnrovTsunc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PpX2usKGnDGPUWaMw65CY0evZ2j25m/BGwTQrwAHTxkJEx5ZlhHKgnRT9+/u9dzAg
	 UAegjNKXSo79x+tmRFP3+cdrIdnoktw8oC2bWsY/Q80WRlFJ0KxZDA37xNGkt3IRka
	 7b4d7N5bQbvsvQXEwX0v9hZ3JJBCljPL3dRTZUWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHSOv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:51:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:34266 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSOv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:51:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 07:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="195551635"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 07:51:26 -0700
Date:   Mon, 19 Aug 2019 08:49:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Christoph Hellwig <hch@lst.de>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190819144922.GC6883@localhost.localdomain>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190816131606.GA26191@lst.de>
 <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:06:23AM -0700, Marta Rybczynska wrote:
> ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
> > Sorry for not replying to the earlier version, and thanks for doing
> > this work.
> > 
> > I wonder if instead of using our own structure we'd just use
> > a full nvme SQE for the input and CQE for that output.  Even if we
> > reserve a few fields that means we are ready for any newly used
> > field (at least until the SQE/CQE sizes are expanded..).
> 
> We could do that, nvme_command and nvme_completion are already UAPI.
> On the other hand that would mean not filling out certain fields like
> command_id. Can do an approach like this.

Well, we need to pass user space addresses and lengths, which isn't
captured in struct nvme_command.
