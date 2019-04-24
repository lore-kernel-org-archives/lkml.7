Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95C9218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556139020;
	bh=cwKb2Q4aYEHUb1HddaC9+HyWLX71sRpMMritCJuPOqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BKpelkhBVvc4EUmVEbwRM2TrpGQo362r/PsUX4Uzi/PAvWCEug+AsumM7RsyMu5fr
	 1s4FlLWqAaI1/Lc3cX5lmQyQGWzvU7qVPaKveSZP1CnYSc45jNU8TkNTms4fGYRAjE
	 DaZChypZmZfUtZzI7TctCDyVX3nxDa7Ni4XpdCMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfDXUuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:50:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:39221 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbfDXUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:50:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 13:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="164547980"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2019 13:50:18 -0700
Date:   Wed, 24 Apr 2019 14:44:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Amit Shah <aams@amazon.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] Adding per-controller timeout support to nvme
Message-ID: <20190424204417.GC15412@localhost.localdomain>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
 <20190424200706.GB15412@localhost.localdomain>
 <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:30:08PM +0200, David Woodhouse wrote:
> It isn't that the media is slow; the max timeout is based on the SLA
> for certain classes of "fabric" outages. Linux copes *really* badly
> with I/O errors, and if we can make the timeout last long enough to
> cover the switch restart worst case, then users are a lot happier.

Gotchya. So the default timeout is sufficient under normal operation,
but temporary intermittent outages may exceed it. It'd be a real
dissappointment if the command times out with an error anyway after
waiting for the extended time, but we ought to cover the worst case
time for a successful completion.
