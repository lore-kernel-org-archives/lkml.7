Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD48C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF7A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725464;
	bh=K3UBGXrrHfd4Rj6E4sYT2Xo8TM8WdQzvGLsW84DNbmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pr+DJ/wAI7i9M8qfFexZfgkp5v81ZLZ2baVToojjlwOgjd1LdJAz4fU/RY+ZMgnnY
	 j9N4A2YlDctWTqPoCUtcvR7cHHMvGDh8emIHZ5Gd0pIUWBTl+uOzdfyzbJNdYVa/aP
	 umsUNkMSiVxFuNMqvRjnd2YCeh4KLjrMY5qPawSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfF1Mhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1Mhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:37:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931D22086D;
        Fri, 28 Jun 2019 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561725461;
        bh=K3UBGXrrHfd4Rj6E4sYT2Xo8TM8WdQzvGLsW84DNbmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAx3cZYO9TbLmxfJsvb08T1MROzkNh1KsIMn4RpIHOzGOiM3IlGcluHRsll0SqLzO
         FtpwpndZu4NOK0XrNWqRpb/ti5PNaGeunsEkPxmbFyU+C1QvdaBQcWVIfvOYDBfL0H
         muRjP0UnsdqYgUcCFyLzvTxG1+Fyef2TKX8kR9+o=
Date:   Fri, 28 Jun 2019 14:37:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Donggeun Kim <dg77.kim@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] extcon: Add fsa9480 extcon driver
Message-ID: <20190628123738.GA25339@kroah.com>
References: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
 <CACRpkdYD7Z7XX9wXFtBehJG_4NCt=m_MNsR5cESPRnO3tomKmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYD7Z7XX9wXFtBehJG_4NCt=m_MNsR5cESPRnO3tomKmQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:28:11AM +0100, Linus Walleij wrote:
> On Fri, Jun 21, 2019 at 12:14 PM Paweł Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> 
> > This small patchset adds support for Fairchild Semiconductor FSA9480
> > microUSB switch.
> >
> > It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
> > but it can be found also on other Samsung Aries (s5pv210) based devices.
> >
> > Tomasz Figa (2):
> >   dt-bindings: extcon: Add support for fsa9480 switch
> >   extcon: Add fsa9480 extcon driver
> 
> This is surely an important driver since almost all elder Samsung
> mobiles use this kind of switch. So
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This driver I see is already sent to Greg for inclusion in the next kernel.
> I just wonder if you guys are even aware of this driver for the same
> hardware added by Donggeun Kim in 2011:
> drivers/misc/fsa9480.c
> 
> That said I am all for pulling in this new driver because it is surely
> better and supports device tree.
> 
> But can we please also send Greg a patch to delete the old driver
> so we don't have two of them now?
> 
> The old driver have no in-tree users so it can be deleted without
> side effects. Out-of-tree users can certainly adapt to the new
> extcon driver.
> 
> If you want I can send a deletion patch for the misc driver?

Please, I'll gladly take a patch that deletes code :)

thanks,

greg k-h
