Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DEF208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCHP3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:29:30 -0500
Received: from verein.lst.de ([213.95.11.211]:54586 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfCHP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:29:30 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 84E8E68D0D; Fri,  8 Mar 2019 16:29:24 +0100 (CET)
Date:   Fri, 8 Mar 2019 16:29:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: mark xfs_dir2_sf_entry_t as __packed again
Message-ID: <20190308152924.GB20294@lst.de>
References: <20190304193723.657089-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304193723.657089-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:36:47PM +0100, Arnd Bergmann wrote:
> For ARM OABI builds, we run into a compile time assertion:
> 
> inlined from 'init_xfs_fs' at /git/arm-soc/fs/xfs/xfs_super.c:1991:2:
> fs/xfs/xfs_ondisk.h:119:208: error: call to '__compiletime_assert_119' declared with attribute error: XFS: sizeof(xfs_dir2_sf_entry_t) is wrong, expected 3
> 
> While ARM OABI is pretty much dead and fails to build for typical
> configurations on modern architectures (ARMv6 or higher), and has
> been declared deprecated in user space since gcc-4.6, the kernel
> still allows it to used for building the kernel.
> 
> In commit 8353a649f577 ("xfs: kill xfs_dir2_sf_off_t"), Christoph
> removed the old __arch_pack annotation that made it possible to
> build xfs with oddball ABIs. However, OABI not only requrires
> padding around short structure but still adds padding after this
> change. There is no harm to unconditionally mark the structure as
> __packed now, and that will do the right thing here.
> 
> As of commit aa2dd0ad4d6d ("xfs: remove __arch_pack"), we need to
> use __packed here as well, instead of the old __arch_pack.

I don't think we want more __packed attributes than required.  Given
how dead OABI is can we just have XFS depend on !OABI?
