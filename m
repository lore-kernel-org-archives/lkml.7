Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C648C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36290218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551337796;
	bh=82AbP/WT2T2DEYB4UNWVVP6ujm7PE1Sd5wU5UmPvySA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=goigGmQm1ISnUXfX4hrv4WrwTFinF2PBMrI2EXeYZQ+Nl2MGh0ZuN/DbvBQ9ZW81Y
	 5gEukdRzIdl2Jt9/B53As03D/RxqmAjr/KoxqJjElFxAV8x+oHaF4P/7seQ0D6tNtd
	 iPvNgM984RWOmPk/41MGTKhbVQ4PhQjDRcRYsx0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfB1HJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfB1HJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:09:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2557B21850;
        Thu, 28 Feb 2019 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551337793;
        bh=82AbP/WT2T2DEYB4UNWVVP6ujm7PE1Sd5wU5UmPvySA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICeILLvwOF5RG8pzl86enJEV2O4MrG5uHjIFf9rZA27699ijtWbKXMO6LFEgDecQR
         4k3KNRGbeXpHRtcMKupyvUDSMcbRrplefCVMoqK8dYBCDOCuoa2XvcPwQWwRxEQbpk
         7L7p6fe4mElu6Q/HE3ZO0VVPF8fw4IK5pIKep2Ro=
Date:   Thu, 28 Feb 2019 08:09:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     rrangel@chromium.org, Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci: use iopoll for xhci_handshake
Message-ID: <20190228070950.GB27446@kroah.com>
References: <20190227221917.62567-1-djkurtz@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227221917.62567-1-djkurtz@chromium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 03:19:17PM -0700, Daniel Kurtz wrote:
> In cases such as xhci_abort_cmd_ring(), xhci_handshake() is called with
> a spin lock held (and local interrupts disabled) with a huge 5 second
> timeout.  This can translates to 5 million calls to udelay(1).  By its
> very nature, udelay() is not meant to be precise, it only guarantees to
> delay a minimum of 1 microsecond. Therefore the actual delay of
> xhci_handshake() can be significantly longer.  If the average udelay(1)
> is greater than 2.2 us, the total time in xhci_handshake() - with
> interrupts disabled can be > 11 seconds triggering the kernel's soft lockup
> detector.
> 
> To avoid this, let's replace the open coded io polling loop with one from
> iopoll.h that uses a loop timed with the more presumably reliable ktime
> infrastructure.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Looks sane to me, nice fixup.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Is this causing problems on older kernels/devices today such that we
should backport this?

thanks,

greg k-h
