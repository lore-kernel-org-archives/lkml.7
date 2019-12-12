Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79654C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1F12173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576159365;
	bh=sy+crXeHM5W71lQNmFRu6qQnDoDFhxVk2fBkN0YDLvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PKp9Iy54XPFUJerlf/lSJkZAFd1FGbszxasCQmLtig0q7dr187sFE1Vc+g316dIAO
	 R/2/zMthSGy4GhKEntMU0tpKBFQl+wjspRJ6NXwnpFFlUYIoI0TjnwefDaHKppWJJF
	 M03S30u9ba6CQq4O/zKNgi5aTjSxAXE0JMlJEvns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfLLOCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbfLLOCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:02:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0637121655;
        Thu, 12 Dec 2019 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576159363;
        bh=sy+crXeHM5W71lQNmFRu6qQnDoDFhxVk2fBkN0YDLvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOv4MI7/GQ1xpFQY6FYZg2qCsAoA+Ko1l/1LUW/pXJbfesTD3iU3inIzu/d0jg/fL
         uXJCtAilUMGgApsr2r/uMaw65wENLo4ZX0kPLEAEL79mr0ew9rx9kC8BwMw4XN9y8e
         iZdlFXwA/yX/gYw1G/Cn6571Q9YbOBZdNfqF5W6c=
Date:   Thu, 12 Dec 2019 15:02:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 185/243] ARM: dts: sun8i: a23/a33: Fix up RTC device
 node
Message-ID: <20191212140241.GA1595136@kroah.com>
References: <20191211150339.185439726@linuxfoundation.org>
 <20191211150351.658072828@linuxfoundation.org>
 <20191212133132.GA13171@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212133132.GA13171@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:31:32PM +0100, Pavel Machek wrote:
> Hi!
> 
> > The RTC module on the A23 was claimed to be the same as on the A31, when
> > in fact it is not. The A31 does not have an RTC external clock output,
> > and its internal RC oscillator's average clock rate is not in the same
> > range. The A33's RTC is the same as the A23.
> > 
> > This patch fixes the compatible string and clock properties to conform
> > to the updated bindings. The register range is also fixed.
> 
> No, this is not okay for v4.19. New compatible is not in
> ./drivers/rtc/rtc-sun6i.c, so this will completely break rtc support.

Good catch, I would have thought both of those would happen at the same
time.

Now dropped, thanks.

greg k-h
