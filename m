Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC321ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E7F215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569955532;
	bh=tSA0eH9++rEulu7t4v7lBqNfCOSP45VX2fYHTJajmIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fnvKl+rW+mVWvCyIx1ZXhUio/N/CeyhqwS2JigOxOiVpuWAO2sjszMmh6Po4iaPrX
	 riEsZewmnKoR/zzs8AQr2r6L+Xr+vxTYrjq5B7jGWDNPCIn9a+vcijiVwKkqM2p/hd
	 g50kx4ct4/9Vbr6JUZX0NFasARYvKCPKt/Ado9Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfJASpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfJASp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:45:28 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD95215EA;
        Tue,  1 Oct 2019 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955527;
        bh=tSA0eH9++rEulu7t4v7lBqNfCOSP45VX2fYHTJajmIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGwXl5KenUFK6V19PoWZFBUaizhy7wGsLSmuwo71F64a03cLn+s42VVQQxB3oM4VA
         xvWwn8ePcDfEv9LhI3Aghg+dlRq8CXruUwcqoTicuXQtSBTVo5AVacMZkg9tDQWCM2
         91TZgYTkyx2usfmibcp0aptevWtTjOCNyUA2LN48=
Date:   Tue, 1 Oct 2019 14:45:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "info@metux.net" <info@metux.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Message-ID: <20191001184526.GE8171@sasha-vm>
References: <20190913060209.3604-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190913060209.3604-1-weh@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 06:02:55AM +0000, Wei Hu wrote:
>Without deferred IO support, hyperv_fb driver informs the host to refresh
>the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
>is screen update or not. This patch supports deferred IO for screens in
>graphics mode and also enables the frame buffer on-demand refresh. The
>highest refresh rate is still set at 20Hz.
>
>Currently Hyper-V only takes a physical address from guest as the starting
>address of frame buffer. This implies the guest must allocate contiguous
>physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
>accept address from MMIO region as frame buffer address. Due to these
>limitations on Hyper-V host, we keep a shadow copy of frame buffer
>in the guest. This means one more copy of the dirty rectangle inside
>guest when doing the on-demand refresh. This can be optimized in the
>future with help from host. For now the host performance gain from deferred
>IO outweighs the shadow copy impact in the guest.
>
>Signed-off-by: Wei Hu <weh@microsoft.com>

What tree is this based on? I can't get it to apply.

--
Thanks,
Sasha
