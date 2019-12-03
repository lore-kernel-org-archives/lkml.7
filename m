Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBAAC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27520803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575402215;
	bh=SM0rYSykbk7tf2FAMkHp85Q+Xwfmlf1KnW/8RwZfe5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2tOfmCCEVATaczweY9Lju2p2woXbXW3O1fFNomQIlUcuw2VFXiaQ2DOEg172Em+bi
	 wR6mEKaE8djSc4Y0Azyv2Q7hFwfgWsOIgxLfJHjCub5ZsFM+f4KYK+JTL8jaBXUqHj
	 5EW3Z0cZHKJymtp0eJWyVQeqaPomy/TlaZUEaX2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLCTne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfLCTnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:43:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969AC206EC;
        Tue,  3 Dec 2019 19:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575402213;
        bh=SM0rYSykbk7tf2FAMkHp85Q+Xwfmlf1KnW/8RwZfe5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lA3ApHnaIe4TfRVp1tYFqtZxuNftBqD6Ls3dtM2j3Hf3vCKnnDuiLAUT15EGJV551
         GJ1iJzz7CW0GF2Qm+z3ZjCuwHPLn/1rW+c1Uh1G3PxsrKM0tDWogSG3nGeSJElfia2
         Z2728TFQbUxqcqxvmZXmm+4fpxdPWqa/K4RImHx0=
Date:   Tue, 3 Dec 2019 20:43:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [stable 4.19][PATCH 06/17] remoteproc: fix rproc_da_to_va in
 case of unallocated carveout
Message-ID: <20191203194330.GA2847072@kroah.com>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
 <20191128165002.6234-7-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128165002.6234-7-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:49:51AM -0700, Mathieu Poirier wrote:
> From: Loic Pallardy <loic.pallardy@st.com>
> 
> commit 74457c40f97a98142bb13153395d304ad3c85cdd upstream
> 
> With introduction of rproc_alloc_registered_carveouts() which
> delays carveout allocation just before the start of the remote
> processor, rproc_da_to_va() could be called before all carveouts
> are allocated.
> This patch adds a check in rproc_da_to_va() to return NULL if
> carveout is not allocated.
> 
> Fixes: d7c51706d095 ("remoteproc: add alloc ops in rproc_mem_entry struct")

This commit only shows up in 4.20, not 4.19, so why is this patch
relevant for 4.19?

thanks,

greg k-h
