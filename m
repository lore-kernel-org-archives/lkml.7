Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD243C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910F120675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556818764;
	bh=pi7lOUBAQB9xKDXZB87/kDUBWEnbEXpxofFy5jrI20w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BX7GHeTGZF/OkhP00SD3uQXs+UDozpV65YQ7OjXKv2whPIqIRgatCD3p4kHz3Ysvf
	 PvGpH/ZCwBotwEOwEtbxuIdGt9blS+qpktMaDCQf1EepswJc16WPdV83WwnYiY+YOp
	 MlrJZ+cKoV+pHOJNFf7/PtB/bndmXDU4XdRzdAfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBRjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEBRjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:39:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CB920652;
        Thu,  2 May 2019 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556818762;
        bh=pi7lOUBAQB9xKDXZB87/kDUBWEnbEXpxofFy5jrI20w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueM4ebg5htP06iOobY+ZZ0t0UuieLbUnWR8EYWcvbQKpNyfZqKWF9vEkTR9hWhp/T
         3+8942Z4lASCPoGQhcAwXyX5pwEYxuVPL/INObpIPYOBCmaE56l14QwSujXg1TRCBm
         DQbfmOPUPSo07xebi91eDK6h5GADsEtnNgpm5Y2Y=
Date:   Thu, 2 May 2019 19:39:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] staging: most: cdev: fix chrdev_region leak in mod_exit
Message-ID: <20190502173920.GA14304@kroah.com>
References: <20190424192343.15418-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424192343.15418-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:23:43PM +0200, Eugeniu Rosca wrote:
> From: Suresh Udipi <sudipi@jp.adit-jv.com>
> 
> It looks like v4.18-rc1 commit [0] which upstreams mld-1.8.0
> commit [1] missed to fix the memory leak in mod_exit function.
> 
> Do it now.
> 
> [0] aba258b7310167 ("staging: most: cdev: fix chrdev_region leak")
> [1] https://github.com/microchip-ais/linux/commit/a2d8f7ae7ea381
>     ("staging: most: cdev: fix leak for chrdev_region")
> 
> Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Acked-by: Christian Gromm <christian.gromm@microchip.com>

In the future, please use the "correct" way to mark a fixup patch.  For
this, it would be:
Fixes: aba258b73101 ("staging: most: cdev: fix chrdev_region leak")

I'll go add it, and the needed stable tag to the patch when applying it.

thanks,

greg k-h
