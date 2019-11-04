Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E91CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBA620659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572879719;
	bh=Wja1Nou+3B9RfyoLJ0X5VblrpMRkzLjZwzBxYEC726g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WuTu4SxYkbH+wKDWdMgZKf5P1QGTANb0jBkU/5L9Hj9bwzXavPBVkwgvsT9zL3Dvc
	 z3XwuEjRVAUBz1ZaH2vGgCyUJkNmLE1GtFZs6wi32HBvge72/fT6gI2fDV7x7xXTMF
	 6AZxas0VMO8sGxvYB9SrndhA551Y0SQtw84L2Fd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfKDPB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfKDPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:01:57 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D34F20656;
        Mon,  4 Nov 2019 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572879717;
        bh=Wja1Nou+3B9RfyoLJ0X5VblrpMRkzLjZwzBxYEC726g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVUOo6v87yZZRNciSy1W9aO3L4qjP6141S7FwkM9ySR5eaddnDq6yN5nz/Vf6mtdh
         rLv71dWhzUp6lTR7Z0cozX9yvtaZap/fyBCVSAbwXuisIxwZHrYVvwY6V2pDBx52mo
         gZuIAxz+qsYGeuWg75E20qOeOSTNEaW6BUhRkgfg=
Date:   Tue, 5 Nov 2019 00:01:51 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Charles Machalow <csm10495@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Message-ID: <20191104150151.GA26808@redsun51.ssa.fujisawa.hgst.com>
References: <20191031050338.12700-1-csm10495@gmail.com>
 <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
 <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
 <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:56:57PM +0100, Marta Rybczynska wrote:
> ----- On 4 Nov, 2019, at 15:51, Charles Machalow csm10495@gmail.com wrote:
> 
> > For this one yes, UAPI size changes. Though I believe this IOCTL
> > hasn't been in a released Kernel yet (just RC). Technically it may be
> > changeable as a fix until the next Kernel is released. I do think its
> > a useful enough
> > change to warrant a late fix.
> 
> The old one is in UAPI for years. The new one is not yet, right. I'm OK
> to change the new structure. To have compatibility you would have to use
> the new structure (at least its size) in the user space code. This is
> what you'd liek to do?

Charles is proposing only to modify the recently introduced 64-bit ioctl
struct without touching the existing 32 bit version. He just wanted the
lower 32-bits of the 64-bit result to occupy the same space as the 32-bit
ioctl's result. That space in the 64-bit version is currently occupied
by an implicit struct padding.
