Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E54EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CEF206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564573008;
	bh=powFP0Y+wRgOqRhiTZYGxknj+gsGo6bx5N1D9mQEdZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IzL3/yIoLTX2sYYyPkAoi/3jpFjXfAidYBeJ9BEc3NkSXDlSEVvKL9kxxZPpnwsfV
	 du3l/+GkFbMuDFgkpu0Ek35n9qKWJYym9ZU3c6LqEqtwBk2S1A+u+osSzXJZAvbHeH
	 BFVyFBTg9YKPPH3WMPJH+AJNa4wQl+TZIBMU3Qx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGaLgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfGaLgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:36:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD01A206A3;
        Wed, 31 Jul 2019 11:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564573005;
        bh=powFP0Y+wRgOqRhiTZYGxknj+gsGo6bx5N1D9mQEdZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qni2KL8gJpXgOEAI11IFCUVPHZPu3+5p2EKkK+i3+Gom4zN3MQiUL+zR5R9kJ4S9p
         fOgKGwG3ZXmpyLHZICIZFA8CBFnNcHmsbWl7s3tydockLs3UH4vwSUgpSdLmDd9RcY
         Dc59k58tGsTXVRLc6KY4ydBoriMWOJpDM8jCE56k=
Date:   Wed, 31 Jul 2019 13:36:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     devel@driverdev.osuosl.org, b.zolnierkie@samsung.com, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, emamd001@umn.edu,
        Nishka Dasgupta <nishkadg.linux@gmail.com>, smccaman@umn.edu,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v3] staging: rtl8192u: null check the kzalloc
Message-ID: <20190731113642.GA3983@kroah.com>
References: <20190730164304.GA10640@kroah.com>
 <20190730220141.6608-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730220141.6608-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 05:01:39PM -0500, Navid Emamdoost wrote:
> In rtl8192_init_priv_variable allocation for priv->pFirmware may fail,
> so a null check is necessary.priv->pFirmware is accessed later in
> rtl8192_adapter_start. I added the check and made appropriate changes
> to propagate the errno to the caller.
> 
> ---
> Update v2: fixed style errors
> Update V3: fixed prefix
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

So close, the signed-off-by goes above the --- line.

thanks,

greg k-h
