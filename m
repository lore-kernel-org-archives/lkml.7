Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3335220715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577101928;
	bh=fW6/Ba/3jwXrnTwtP/ZVvHq5lvrpzfvzOmqjNbapGoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EobEKFGC90Ny3AeGzTSkUJlkZHTzreSEHECBHWwLIJ1pQHjIIMtBPgZQb+exhc7/4
	 LHA4GQ01ndsAirJEe85Lwa4bwIfnaCttgDPWM+m2/S1XOcrnPpbuNNwtS0g0+Nd8ZA
	 alHDYO0kBj218lrIJK5JQapZqWnAkdnD2ct5Mprc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWLwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:52:07 -0500
Received: from localhost (50-198-241-253-static.hfc.comcastbusiness.net [50.198.241.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3E620709;
        Mon, 23 Dec 2019 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577101926;
        bh=fW6/Ba/3jwXrnTwtP/ZVvHq5lvrpzfvzOmqjNbapGoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c65IAMtHmg2Wxi6bNFNbtuTXaruTdQlSsfKj6fqb9PewVLimIy3sGQCNHX5GtXSoH
         8ZaX5ayKT6zaq/nm3zO0vlF4TD7cgpJPqZnr7Y5E0J5L3ychEV+u/nQ6YVXvFWb3uy
         wUb7CnYygrZ9egGnTRth3Zuibbm1OshNo/Wsfsqg=
Date:   Mon, 23 Dec 2019 06:52:04 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Colin King <colin.king@canonical.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thunderbolt: fix memory leak of object sw
Message-ID: <20191223115204.GA107995@kroah.com>
References: <20191220220526.11307-1-colin.king@canonical.com>
 <20191223101317.GF2628@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223101317.GF2628@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 12:13:17PM +0200, Mika Westerberg wrote:
> On Fri, Dec 20, 2019 at 10:05:26PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > In the case where the call tb_switch_exceeds_max_depth is true
> > the error reurn path leaks memory in sw.  Fix this by setting
> > the return error code to -EADDRNOTAVAIL and returning via the
> > error exit path err_free_sw_ports to free sw. sw has been kzalloc'd
> > so the free of the NULL sw->ports is fine.
> >
> > Addresses-Coverity: ("Resource leak")
> > Fixes: b04079837b20 ("thunderbolt: Add initial support for USB4")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Greg, can you take this to your usb-next branch where the rest of the
> USB4 stuff is?

Will do, thanks.

greg k-h
