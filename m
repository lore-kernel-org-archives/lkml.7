Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550CA2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575445297;
	bh=mXmse0izUm18/vYwWZA7L1FmvwrmsFcAgHgaFLg8fWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZA9HVh8EgEW17WkI2STsiXn54QLgLmhdZ5+0zPlBih/p369BFGt8A2FMDDAHLxCSb
	 3dAiKWXVNMGNZU0UlGZhZw2m7WrNZEXYaURIe6m+cB+hfKmAM+7/GlKXeTTEkWJVGe
	 3cWeDVUSmuD93zHyA9K9E8crYy/bm8rpMBpsB0H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLDHlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfLDHlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:41:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064132054F;
        Wed,  4 Dec 2019 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575445295;
        bh=mXmse0izUm18/vYwWZA7L1FmvwrmsFcAgHgaFLg8fWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPVuNcSihDBFHN/wNcDvXq3nX0PneSL8zEKch9efO0LW0YXIFLkRq65kWAWxSUa6r
         p8e7vcAFueJXx/qpiT31yGnClZWi5Bv0OKijGX1xLFCqOU8nYNYlG3eWC7+TNzffly
         wRtG9NEGan8H8WOT2lSbnvfmPvioK70OMUP089yg=
Date:   Wed, 4 Dec 2019 08:41:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guoheyi <guoheyi@huawei.com>
Cc:     Mike Waychison <mikew@google.com>, linux-kernel@vger.kernel.org,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: firmware: dmi-sysfs: why is the access mode of dmi sysfs entries
 restricted to 0400?
Message-ID: <20191204074133.GA3548765@kroah.com>
References: <42bb2db8-66e0-3df4-75b7-98b2b2bcfca8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bb2db8-66e0-3df4-75b7-98b2b2bcfca8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:31:22PM +0800, Guoheyi wrote:
> Hi,
> 
> Why is the access mode of dmi sysfs entries restricted to 0400? Is it for
> security concern? If it is, which information do we consider as privacy?

There's lots of "interesting" information in dmi entries that you
probably do not want all processes reading, which is why they are
restricted.

> We would like to fetch CPU information from non-root application, is there
> feasible way to do that?

What specific CPU information is not currently exported in /proc/cpuinfo
that only shows up in DMI entries that you are interested in?

You can always have root change the permissions of a sysfs file if you
have a service that wants to allow non-root programs to read specific
entries.

thanks,

greg k-h
