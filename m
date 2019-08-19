Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B530214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241194;
	bh=Wxa6xg07vvb4+S3puGVqgQafgQXeiE6wj03+QbDhvTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gF21kSfNI4MOeaX8pBTRHV1FCMOV+BrjnSJDLKyqFyximEjSdSD84VRQCrCfk6PRj
	 b9zsL63Dm1n9NB6xwlGPvR+nvlCS3V80m5O6GE55ljwc7uglF+OVkmCZHk1hoCSpxE
	 oQ1W/EslHEZ+gQGXKOOaOgrOHZdtBz8Fiv7S3qrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfHSS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:59:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:29694 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHSS7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:59:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 11:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="195595817"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 11:59:52 -0700
Date:   Mon, 19 Aug 2019 12:57:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Christoph Hellwig <hch@lst.de>, axboe <axboe@fb.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190819185749.GA11202@localhost.localdomain>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190816131606.GA26191@lst.de>
 <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
 <20190819144922.GC6883@localhost.localdomain>
 <1d7819a9-9504-2dc6-fca4-fbde4f99d92c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7819a9-9504-2dc6-fca4-fbde4f99d92c@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:56:28AM -0700, Sagi Grimberg wrote:
> 
> >> ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
> >>> Sorry for not replying to the earlier version, and thanks for doing
> >>> this work.
> >>>
> >>> I wonder if instead of using our own structure we'd just use
> >>> a full nvme SQE for the input and CQE for that output.  Even if we
> >>> reserve a few fields that means we are ready for any newly used
> >>> field (at least until the SQE/CQE sizes are expanded..).
> >>
> >> We could do that, nvme_command and nvme_completion are already UAPI.
> >> On the other hand that would mean not filling out certain fields like
> >> command_id. Can do an approach like this.
> > 
> > Well, we need to pass user space addresses and lengths, which isn't
> > captured in struct nvme_command.
> 
> Isn't simply having a 64 variant simpler?

Could you provide more details on what you mean by this?
