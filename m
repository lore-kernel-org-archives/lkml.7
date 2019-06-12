Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA012086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfFLIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:35:39 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:7082 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727241AbfFLIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:35:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0AAC818224D63;
        Wed, 12 Jun 2019 08:35:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coat46_4dee5fffc4c39
X-Filterd-Recvd-Size: 2907
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Jun 2019 08:35:35 +0000 (UTC)
Message-ID: <1e403b07f8e9843deb893de156e6c03f53948cca.camel@perches.com>
Subject: Re: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
From:   Joe Perches <joe@perches.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Wed, 12 Jun 2019 01:35:34 -0700
In-Reply-To: <20190612071444.5uih6em5o73dbvtf@pali>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
         <20190605142428.84784-5-wangkefeng.wang@huawei.com>
         <20190605144240.pfrvlgxsdpacpwxf@pali>
         <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
         <a1908a998b6d1d1e4cdd097a50b9c9ac9b00caae.camel@perches.com>
         <20190612005913.GJ143729@dtor-ws> <20190612071444.5uih6em5o73dbvtf@pali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 09:14 +0200, Pali Rohár wrote:
> On Tuesday 11 June 2019 17:59:13 Dmitry Torokhov wrote:
> > Hi Joe,
> > 
> > On Wed, Jun 05, 2019 at 07:28:53PM -0700, Joe Perches wrote:
> > > On Thu, 2019-06-06 at 09:08 +0800, Kefeng Wang wrote:
> > > > On 2019/6/5 22:42, Pali Rohár wrote:
> > > > > On Wednesday 05 June 2019 22:24:28 Kefeng Wang wrote:
> > > > > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> > > > > > so no need to do that again from its callers. Drop it.
> > > > > Hi! I already reviewed this patch and rejected it, see:
> > > > > https://patchwork.kernel.org/patch/10817475/
> > > > OK, please ignore it.
> > > 
> > > I think the stated reason of better readability isn't
> > > particularly sensible as the object code produced is
> > > actually slightly larger.
> > > 
> > > x86-64 defconfig (gcc 8.3.0)
> > > 
> > > $ size drivers/input/mouse/alps.o*
> > >    text	   data	    bss	    dec	    hex	filename
> > >   29416	     56	      0	  29472	   7320	drivers/input/mouse/alps.o.new
> > >   29432	     56	      0	  29488	   7330	drivers/input/mouse/alps.o.old
> > 
> > If gcc produces worse code for double unlikely, you should probably
> > report it to gcc folks, no? Or double unlikely turns into likely?
> 
> Is measured size of stripped or unstripped binary? Plus with or without
> debug symbols? Double unlikely version should have more debug symbols
> and therefore also larger size.
> 
> But if unstripped version with double unlikely is larger then it is for
> sure compiler bug.

defconfig so no debug symbols.

It's not necessarily a gcc bug as gcc doesn't
guarantee compiler repeatability.


