Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC90217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711323;
	bh=jf5FBSIfuopYRz4BJUbyXjwdIVrEyxaUf4nAFx7faUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sFqrwJ0CXFnKdfXK3EzKoYdR0jtIn2ILBcy4WwF8EsmxrraDyHiSnd83Rkmryhype
	 1jeQ4L8RoaDMxuWeLewCMGUlzuPtX2vsx0Ol6lfIIwfA4vfnJED4IjzVc4sT2vtra7
	 w63V1Spx+/mDErtJ1Nk1OK5JTEtNrbgVZ58Fc5XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391916AbfC0S2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391905AbfC0S2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:36 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD34620651;
        Wed, 27 Mar 2019 18:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711316;
        bh=jf5FBSIfuopYRz4BJUbyXjwdIVrEyxaUf4nAFx7faUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyBr1le/GpjmQFlDE3wHm9TP2Aci6ODydOuK101Zwkq5R5ztdLo161lLL5bO9zlzH
         EIXgslKl0upwfqosSmofRGI4hqAUbObIZDNqy1WQkvMntPXLQCHx/EYe0EdWpMUmco
         Q+23BBwEyhLemfeZYHVrtx2NfwRszG5rYfJuPV1A=
Date:   Thu, 28 Mar 2019 01:45:42 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Venture <venture@google.com>
Cc:     arnd@arndb.de, joel@jms.id.au, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
Message-ID: <20190327164542.GC11712@kroah.com>
References: <20190312163101.155910-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312163101.155910-1-venture@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> +	phys_addr_t mem_base;

Is this really a 32bit value?

Your ioctl thinks it is:

> +struct aspeed_p2a_ctrl_mapping {
> +	__u32 addr;

Does this driver not work on a 64bit kernel?

> +	__u32 length;
> +	__u32 flags;
> +};

addr really should be __u32 here so you don't have to mess with 32/64
bit user/kernel issues, right?

thanks,

greg k-h
