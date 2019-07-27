Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06851C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99262147A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564260889;
	bh=8KYB1Mna/qqU8VFRs889zst+w4SYhrS+6Rwy2vlNHcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nwkTQMgN8+Ojm7nR4DNh8I84U33wVLvQQpc260zRFdLUrkJpfLSUxqYOcrgM2pxjH
	 C63ClCkufmy6R5tx31LxWoZvYL8zm7iPmDeqkomirgj5XalMGAIg+bNRurqANdNcYO
	 rAbrTvahkaI5/i7Qrl1VQioWaMXt85qviS6ndpf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfG0Uys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 16:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387841AbfG0Uys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 16:54:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90903208E4;
        Sat, 27 Jul 2019 20:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564260887;
        bh=8KYB1Mna/qqU8VFRs889zst+w4SYhrS+6Rwy2vlNHcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L8f7yy48UvPCIcykDvMWdN2p3ukUh17Bi/GGBqyNYC1kCgkKlMBE8vwVrhuM3RLEG
         Lxt3s1Q7xlyIFuzGtf9VHgMOxlV3G2YaZWrHtPYCGajtFvbwR7rRjIhWbdkAEjBjcQ
         QdsS2cHEy4wieL/A4fPEOTj6ZqTbm2RhSRtBverw=
Date:   Sat, 27 Jul 2019 21:54:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com
Subject: Re: [PATCH v6 2/2] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Message-ID: <20190727215440.1e657e5b@archlinux>
In-Reply-To: <20190727124212.3da89d41@collabora.com>
References: <cover.1563542515.git.vitor.soares@synopsys.com>
        <77c709aca8607f31f141ee7c4dc28bf89266bd23.1563542515.git.vitor.soares@synopsys.com>
        <20190721181656.236faa63@archlinux>
        <20190727124212.3da89d41@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 12:42:12 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Sun, 21 Jul 2019 18:16:56 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 19 Jul 2019 15:30:55 +0200
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >   
> > > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only in
> > > spi and i2c mode.
> > > 
> > > The LSM6DSO and LSM6DSR are also i3c capable so let's give i3c support to
> > > them.
> > > 
> > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>    
> > Great. I'll pick this up once Boris has that immutable branch
> > available. Give me a poke if I seem to have lost it!  
> 
> Here it is:
> 
Great. Merged that into the togreg branch of iio and applied this patch.

Pushed out as testing to let the autobuilders have a poke at it all.

Thanks,

Jonathan

> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/export-i3c_device_match_id
> 
> for you to fetch changes up to 934d24a5e1508e73c0001afb54a3916e4270428f:
> 
>   i3c: move i3c_device_match_id to device.c and export it (2019-07-27 11:22:19 +0200)
> 
> ----------------------------------------------------------------
> Needed for the st_lsm6dsx_i3c.c driver
> 
> ----------------------------------------------------------------
> Vitor Soares (1):
>       i3c: move i3c_device_match_id to device.c and export it
> 
>  drivers/i3c/device.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/i3c/master.c       | 45 ---------------------------------------------
>  include/linux/i3c/device.h |  4 ++++
>  3 files changed, 57 insertions(+), 45 deletions(-)
> 
> 

