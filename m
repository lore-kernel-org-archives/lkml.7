Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB0C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0112D20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfKYPRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:17:50 -0500
Received: from smtp1.axis.com ([195.60.68.17]:47971 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbfKYPRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:17:49 -0500
IronPort-SDR: v9qq5ru8n09NwMwAv62WLnVblLhJV7NObe8FOI3PcYeHa9Z52LrN2MGXYxRgfbNcnjSkPmUo2P
 NXwc1sZ1b9qcXO6NxH44PtgOm79Gfc1NcFHXxqqRyuP/+KLGo2f1qgxgMWNucDfkaZeui6gHjE
 lWp9iRTJCgvmlogGG+EUwlJW2+RngiFDVnue1V8H9KxGazln0LyuodC4Y43tTGC6b4n9I12rgs
 XyBChdNteBYEnsa8SPYYOJUDTfe7xcSHuAgdPaMoWHtfs8Z4MPG0QWDHpUXiTs4kdpNHmg3sZD
 wNw=
X-IronPort-AV: E=Sophos;i="5.69,241,1571695200"; 
   d="scan'208";a="2895546"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Date:   Mon, 25 Nov 2019 16:17:47 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH] of: overlay: add_changeset_property() memory leak
Message-ID: <20191125151747.hqm55drde5ldkrte@axis.com>
References: <1574363816-13981-1-git-send-email-frowand.list@gmail.com>
 <9eda204f-aaa0-54a1-83eb-a012ddeeaac3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eda204f-aaa0-54a1-83eb-a012ddeeaac3@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:20:21PM +0100, Frank Rowand wrote:
> On 11/21/19 1:16 PM, frowand.list@gmail.com wrote:
> > From: Frank Rowand <frank.rowand@sony.com>
> > 
> > No changeset entries are created for #address-cells and #size-cells
> > properties, but the duplicated properties are never freed.  This
> > results in a memory leak which is detected by kmemleak:
> > 
> >  unreferenced object 0x85887180 (size 64):
> >    backtrace:
> >      kmem_cache_alloc_trace+0x1fb/0x1fc
> >      __of_prop_dup+0x25/0x7c
> >      add_changeset_property+0x17f/0x370
> >      build_changeset_next_level+0x29/0x20c
> >      of_overlay_fdt_apply+0x32b/0x6b4
> >      ...
> > 
> > Fixes: 6f75118800acf77f8 ("of: overlay: validate overlay properties #address-cells and #size-cells")
> > Reported-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> Can you please check whether this patch fixes the memleak that you
> found and fixed in "[PATCH 1/2] of: overlay: fix properties memory leak"?

Tested-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Thanks.
