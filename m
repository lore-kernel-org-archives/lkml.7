Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36899C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0149120848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551470056;
	bh=4LyKc2gT3qmCcUNTKd8DeQD7aa9Ak6rUFFAK/6pVKZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ApKKqbedz74JDNB5Xv1UDVPCSpYealHoE4zFSg22eewn2NdGy7YCN2yIiXUDDoj/c
	 s5tyDTsxJFw+v8ejlxP9h24CUDelYrBgFVnhp+qTVihPLzOhOyyOFFPjpjhG6UkA+z
	 i5UvO3TGOXz20ZyZ4RGUzclLo9nQVe37pYX4Aux0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCATyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:54:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfCATyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:54:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49F020857;
        Fri,  1 Mar 2019 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551470052;
        bh=4LyKc2gT3qmCcUNTKd8DeQD7aa9Ak6rUFFAK/6pVKZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxGBzf5ThAU5Jnw0SPf+8G7uKo7FdOqTu3U1Z44/WTQmtx66FrhSpHI2JKW186QII
         fwAG1RjAtrUxUGnIYATj6F63huFOAjNQoHDx9Fr/afV5JVKGxV3Ucp3JRV7tXSnoSm
         EUzrNHcrldFNfJnn+ISD0CSneWQXCKx6AkzVfs0s=
Date:   Fri, 1 Mar 2019 20:54:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>, Jon Flatley <jflat@chromium.org>,
        Louis Taylor <louis@kragniz.eu>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] wusb: Remove unnecessary static function ckhdid_printf
Message-ID: <20190301195409.GA15026@kroah.com>
References: <20190228115256.5446-1-louis@kragniz.eu>
 <20190228122417.9318-1-louis@kragniz.eu>
 <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
 <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
 <1450785b937f4a2b5f98c8548986b162684a719b.camel@perches.com>
 <CACJJ=pz50c3oovHbKkjDDF=pabAj_9RtKGWvtpwx4nO+E_EtJg@mail.gmail.com>
 <3f515cdb5cb6f77acb5cd8029bacd0be782eed64.camel@perches.com>
 <CAKwvOdnzArsYOdMc=NC=LQym3CDZG+bvMz0AAbYgo5Le6+aJdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnzArsYOdMc=NC=LQym3CDZG+bvMz0AAbYgo5Le6+aJdw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:18:32AM -0800, Nick Desaulniers wrote:
> On Thu, Feb 28, 2019 at 8:38 PM Joe Perches <joe@perches.com> wrote:
> >
> > This static inline is unnecessary and can be removed
> > by using the vsprintf %ph extension.
> >
> > This reduces overall object size by more than 2K.
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Deserves a reported by tag from (https://lkml.org/lkml/2019/2/28/1138)
> Reported-by: Louis Taylor <louis@kragniz.eu>

Good idea, will go add that...
