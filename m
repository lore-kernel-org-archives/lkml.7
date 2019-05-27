Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18AC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549F621743
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558941784;
	bh=DkUuoc02LMNVzqW31q31YJk6Lkll7SmCa0g24wRTrw0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Aoj6CYrS+/FJGsWxEkoRxqu136p4T76ghHcr0rjAN25wbDthQ9539UQTj+6MWcNPG
	 tDLVGrZjRvRGm7UbQeFG1IIkIlScfaqfBRohm5hPYHMOtSrxHCRr2WklFVg23w9F4R
	 8fAzus5Gdcr4Rvt7n190ty3avW0+atFRf5LEUJ8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0HXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfE0HXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:23:03 -0400
Received: from localhost (unknown [84.241.203.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B2D21734;
        Mon, 27 May 2019 07:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558941782;
        bh=DkUuoc02LMNVzqW31q31YJk6Lkll7SmCa0g24wRTrw0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=HWyzED+XsXUB4UT+il2PmmV5ynBrIMCFuGKRXEr9/InHesUoAkR2w1L0gwxNH7lIR
         a3cRoz/XuiUxk5qjuaAinh+IbkadXNEn6LA31A977Pda8e6csn7ApYXAhUnC1CJbqN
         3mDC/07jYD70RYAm+ltyYc64shQHrnufhaXOthZw=
Date:   Mon, 27 May 2019 09:22:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: Re: [PATCH 32/33] staging/olpc_dcon: Add drm conversion to TODO
Message-ID: <20190527072258.GD7997@kroah.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-33-daniel.vetter@ffwll.ch>
 <20190527071126.GL21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527071126.GL21222@phenom.ffwll.local>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 09:11:26AM +0200, Daniel Vetter wrote:
> On Fri, May 24, 2019 at 10:53:53AM +0200, Daniel Vetter wrote:
> > this driver is pretty horrible from a design pov, and needs a complete
> > overhaul. Concrete thing that annoys me is that it looks at
> > registered_fb, which is an internal thing to fbmem.c and fbcon.c. And
> > ofc it gets the lifetime rules all wrong (it should at least use
> > get/put_fb_info).
> > 
> > Looking at the history, there's been an attempt at dropping this from
> > staging in 2016, but that had to be reverted. Since then not real
> > effort except the usual stream of trivial patches, and fbdev has been
> > formally closed for any new hw support. Time to try again and drop
> > this?
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Jens Frederich <jfrederich@gmail.com>
> > Cc: Daniel Drake <dsd@laptop.org>
> > Cc: Jon Nettleton <jon.nettleton@gmail.com>
> 
> Hi Greg
> 
> Again get_mainatiners didn't pick you up on this somehow (I manually added
> you now for the next round). Do you want to pick this up to staging, or
> ack for merging through drm/fbdev as part of the larger fbdev/fbcon
> rework?
> 
> Also, I think time to retry and attempt at dropping this imo ...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
