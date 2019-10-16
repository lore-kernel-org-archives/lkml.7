Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A02C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403F82082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571207284;
	bh=R3LJ895N9E9pE0cFFt4AtsD2smGUhoFnt5YlJuFUZrU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=pokqHH2Ets/oiPo5VlHKtPy8JIJTaQJg/9C70pNspTTgqnZxDi10kpcN2Zwr/WKfJ
	 pqqEWQh1J1iSBI3BJn8Bl0YIr2neopLQ/qfnpCJD6a2p7dzfmFQ1/P46P/rCQF/JPk
	 sDwDCwWjoxFZYu5kXEQiOBu6qE7Fs5Gvutgv2KYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfJPG2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfJPG2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:28:02 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3436F2082C;
        Wed, 16 Oct 2019 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571207282;
        bh=R3LJ895N9E9pE0cFFt4AtsD2smGUhoFnt5YlJuFUZrU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KLqvnONhSNhIfnY0+xnxfId7f03QWuyYJxNHiIYuqJaJRuQIBKd1l8Alfl3WgLc4B
         GYx1qbowvDDsLeGAdrikTqHtV7/QqfSYdSxfs9a6zhG193QF1QNsyrMWql1Mtx4Vsu
         bmF7RqRaxksaDAHyAKPyhhhbpJRgsgvUY7UHXY6c=
Date:   Wed, 16 Oct 2019 08:27:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Zhang Lixu <lixu.zhang@intel.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com
Subject: Re: [PATCH] hid: intel-ish-hid: fix wrong error handling in
 ishtp_cl_alloc_tx_ring()
In-Reply-To: <20191016001559.27947-1-lixu.zhang@intel.com>
Message-ID: <nycvar.YFH.7.76.1910160827460.13160@cbobk.fhfr.pm>
References: <20191016001559.27947-1-lixu.zhang@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Zhang Lixu wrote:

> When allocating tx ring buffers failed, should free tx buffers, not rx buffers.
> 
> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp/client-buffers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> index 1b0a0cc605e7..513d7a4a1b8a 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> @@ -84,7 +84,7 @@ int ishtp_cl_alloc_tx_ring(struct ishtp_cl *cl)
>  	return	0;
>  out:
>  	dev_err(&cl->device->dev, "error in allocating Tx pool\n");
> -	ishtp_cl_free_rx_ring(cl);
> +	ishtp_cl_free_tx_ring(cl);

Applied to for-5.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

