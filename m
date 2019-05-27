Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD8C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FC921721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558941739;
	bh=CxB+YRQgE6cg6pK9JoVm/avHUmPTbThAgAVMMNqahMQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=ZqVi1MeYTYQhc4SZHF/OYRxZgeHWfS6+2EmZudk3k3rP4YZKNLbG3bygLijhqtxle
	 WWpKZBGR7fc+kMMQ5IOYPvH8Jw7mNFbEnRG3yX+gapWDTLlAyA158LM59PH7x+l090
	 BJwm2pvVZJtvziZ/nzcBXavV1nz8zeo/UTZHG+GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE0HWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfE0HWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:22:18 -0400
Received: from localhost (unknown [84.241.203.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B26B216FD;
        Mon, 27 May 2019 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558941738;
        bh=CxB+YRQgE6cg6pK9JoVm/avHUmPTbThAgAVMMNqahMQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Q1LE5GpeWeMfjI+hQTRVaCT6KkOhR4yTvtSxlGlomgJOpBdtnKVWXl/IoF5xSw+Xb
         lIYZ5Lhm2x1hJ5Fxz5OXkIluhD211azcL8pdZtwteQd5ZUl3NmbY56G5/UzV3ndz+Q
         D7a3oyLH+7yUgzfhkv2zHrBs0yJZif7v2zhgNbek=
Date:   Mon, 27 May 2019 09:22:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 04/33] vt: More locking checks
Message-ID: <20190527072214.GB7997@kroah.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-5-daniel.vetter@ffwll.ch>
 <20190527070858.GJ21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527070858.GJ21222@phenom.ffwll.local>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 09:08:58AM +0200, Daniel Vetter wrote:
> On Fri, May 24, 2019 at 10:53:25AM +0200, Daniel Vetter wrote:
> > I honestly have no idea what the subtle differences between
> > con_is_visible, con_is_fg (internal to vt.c) and con_is_bound are. But
> > it looks like both vc->vc_display_fg and con_driver_map are protected
> > by the console_lock, so probably better if we hold that when checking
> > this.
> > 
> > To do that I had to deinline the con_is_visible function.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Martin Hostettler <textshell@uchuujin.de>
> > Cc: Adam Borowski <kilobyte@angband.pl>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> 
> Hi Greg,
> 
> Do you want to merge this through your console tree or ack for merging
> through drm/fbdev? It's part of a bigger series, and I'd like to have more
> testing with this in our trees, but also ok to merge stand-alone if you
> prefer that. It's just locking checks and some docs.
> 
> Same for the preceeding patch in this series here.

For all of these, please take them through your tree(s):

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
