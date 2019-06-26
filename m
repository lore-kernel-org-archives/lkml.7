Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CDBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561551850;
	bh=641EHDpmvZqgAGg8LqnSOkw87ehZLVxWtrc67udnISM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PvKuAVBxjglU4VLu27PYKDf4blXK39oUlz7/TfCjU1VjvsRq2ELwf16G4wKuFUfpS
	 UfOWbFRSO9JKrWtViJ16+/Wigl28CWHFJBuuIDgwfL8V7Id9xY8IOaj1XFj/SIOyDA
	 6/OZxd3Y6CkZGGt0jnHInRQDTAlB/cRQpr3VgkF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFZMYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZMYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:24:08 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A86204FD;
        Wed, 26 Jun 2019 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561551847;
        bh=641EHDpmvZqgAGg8LqnSOkw87ehZLVxWtrc67udnISM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMal2AgtgxKFwMuFlSKUJqywFq4FoohLkt6ztb4Inwva82zP417XBn+4FEtldquLz
         oIC1/KeBCNQ3+JzA2f3x4QdbZG/p7mtmQr3fHp0xqPnpmAPuiTtiKBa01qvYY8KtBs
         U/Rynxi6djAk/SMtgbbTBQdPj2bUpggApoFBl19A=
Date:   Wed, 26 Jun 2019 20:23:17 +0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sjoerd.simons@collabora.co.uk" <sjoerd.simons@collabora.co.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH] Adjust analogix chip driver location
Message-ID: <20190626122317.GC30972@kroah.com>
References: <20190626104430.GA11770@xin-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626104430.GA11770@xin-VirtualBox>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:44:38AM +0000, Xin Ji wrote:
> Move analogix chip ANX78XX bridge driver into "analogix" directory.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                     |   10 -
>  drivers/gpu/drm/bridge/Makefile                    |    3 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.c          | 1485 --------------------
>  drivers/gpu/drm/bridge/analogix-anx78xx.h          |  710 ----------
>  drivers/gpu/drm/bridge/analogix/Kconfig            |   10 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |    2 +
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 1485 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h |  710 ++++++++++
>  8 files changed, 2208 insertions(+), 2207 deletions(-)
>  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.c
>  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h

'git format-patch -M' is usually a lot better to use when moving files
around, as it shows you only any changes in the files, not a huge
delete/add cycle.

thanks,

greg k-h
