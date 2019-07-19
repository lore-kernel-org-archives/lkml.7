Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A1C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23202173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfGSMNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:13:39 -0400
Received: from verein.lst.de ([213.95.11.211]:39599 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfGSMNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:13:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40CB568B02; Fri, 19 Jul 2019 14:13:37 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:13:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] [v2] blkdev: always export SECTOR_SHIFT
Message-ID: <20190719121336.GB28960@lst.de>
References: <20190719113139.4005262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719113139.4005262-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * The basic unit of block I/O is a sector. It is used in a number of contexts
> + * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
> + * bytes. Variables of type sector_t represent an offset or size that is a
> + * multiple of 512 bytes. Hence these two constants.
> + */
> +#ifndef SECTOR_SHIFT
> +#define SECTOR_SHIFT 9
> +#endif
> +#ifndef SECTOR_SIZE
> +#define SECTOR_SIZE (1 << SECTOR_SHIFT)
> +#endif

While we're at it we really should drop the ifndefs.

Otherwise looks good.

In fact given that sector_t is in linux/types.h I wonder if these
should just move there.
