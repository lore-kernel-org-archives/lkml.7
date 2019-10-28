Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBDFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C26421721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572279878;
	bh=GtCFoGMERsUGxgb1hU/OwPPBWzySYFGHXpzD+cvXinM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=063VnzARU9X3l/oE73dOFqPm+FvZ89+iKfgh1y4//R52zC1R66FHBYbGRjGl+9zfx
	 xcVLj8GTzJsTIJ/non2Kf2X44MrNkviJRlWaiiANGANim8E0VZjh4QxIj9/LBl2O/T
	 r2orgS/1reJ4JJbTT5XPNyD9PTSZH1/fCuaRt9J8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbfJ1QYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfJ1QYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:24:37 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4153B214E0;
        Mon, 28 Oct 2019 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572279876;
        bh=GtCFoGMERsUGxgb1hU/OwPPBWzySYFGHXpzD+cvXinM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6y+eyGCxJom/VV4tXpf2cMMHMwElQH3gocwgluoH4gY/G2VrIAAjKnDErtp3JrWg
         LuNqKEfD5Fk7AkcAGHOwQB3L4z0k6pUjKT2HEPoh+ZJwDfmyhOWbyJQ3FfmqBdfl1U
         gWQXO/f5sqWiAS5KLZyuKyf3FQfAz4+YkOBNrXpo=
Date:   Mon, 28 Oct 2019 17:24:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove an redundant null check
 before kfree()
Message-ID: <20191028162434.GB321492@kroah.com>
References: <1571211506-19005-1-git-send-email-zhongjiang@huawei.com>
 <20191025024216.GB331827@kroah.com>
 <5DB711AE.1040904@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DB711AE.1040904@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:05:02AM +0800, zhong jiang wrote:
> On 2019/10/25 10:42, Greg KH wrote:
> > On Wed, Oct 16, 2019 at 03:38:26PM +0800, zhong jiang wrote:
> >> kfree() has taken null pointer into account. hence it is safe to remove
> >> the unnecessary check.
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >> ---
> >>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> >> index 7011c2a..4597f4f 100644
> >> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> >> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> >> @@ -2210,8 +2210,7 @@ void rtw_free_hwxmits(struct adapter *padapter)
> >>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> >>  
> >>  	hwxmits = pxmitpriv->hwxmits;
> >> -	if (hwxmits)
> >> -		kfree(hwxmits);
> >> +	kfree(hwxmits);
> >>  }
> >>  
> >>  void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
> >> -- 
> >> 1.7.12.4
> >>
> > Patch does not apply to my tree :(
> >
> > .
> >
> Greg,  Could you apply the patch to your  tree ?

It did not apply, so what do you want me to do with it?

confused,

greg k-h
