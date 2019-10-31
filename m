Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AEDCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDE520862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfJaNjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:39:25 -0400
Received: from verein.lst.de ([213.95.11.211]:51051 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfJaNjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:39:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9831E68BE1; Thu, 31 Oct 2019 14:39:21 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:39:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     linux-nvme@lists.infradead.org, marta.rybczynska@kalray.eu,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191031133921.GA4763@lst.de>
References: <20191031050338.12700-1-csm10495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031050338.12700-1-csm10495@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:03:38PM -0700, Charles Machalow wrote:
> Changing nvme_passthru_cmd64's result field to be backwards compatible
> with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
> field. With this change the first 32 bits of result in either case
> point to CQE DW0. This allows userspace tools to use the new structure
> when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.

All that casting is a pretty bad idea.  please just add an explicit
reserved field before the result, and check that it always is zero
in the ioctl handler.
