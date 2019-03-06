Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6BF20652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfCFM4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:56:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:24698 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfCFM4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:56:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 04:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,448,1544515200"; 
   d="scan'208";a="149767893"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2019 04:56:13 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 4DCB8205BD; Wed,  6 Mar 2019 14:56:12 +0200 (EET)
Date:   Wed, 6 Mar 2019 14:56:12 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Forney <forney@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND PATCH 1/1] headers_install.sh: Support __aligned(x) for
 uAPI headers
Message-ID: <20190306125611.7xt3l2esk563zrlr@paasikivi.fi.intel.com>
References: <20190221132853.32043-1-sakari.ailus@linux.intel.com>
 <CAK7LNAR99+J1LOiy66+QA_uYf328B6EfecrBk0iUvuQEDnf5pQ@mail.gmail.com>
 <20190222113512.abpmbptqsnroibsi@paasikivi.fi.intel.com>
 <CAK7LNASh+HM_yuSHpjDgRWQnqauMwjb7fqioMQ8dURjt2L_aNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASh+HM_yuSHpjDgRWQnqauMwjb7fqioMQ8dURjt2L_aNw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:14:56PM +0900, Masahiro Yamada wrote:
> On Fri, Feb 22, 2019 at 8:37 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Yamada-san,
> >
> > On Fri, Feb 22, 2019 at 01:36:03PM +0900, Masahiro Yamada wrote:
> > > On Thu, Feb 21, 2019 at 10:29 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > The headers-install.sh already supports __packed conversion to
> > > > __attribute__((packed)) for uAPI headers but it does not support similar
> > > > __aligned(x) conversion.
> > > >
> > > > Add support for __aligned(x).
> > >
> > >
> > > I am not a big fan of sed scripting in headers_install.sh
> > >
> > > Is it a problem to write __attribute__((aligned(x)) in UAPI headers?
> >
> > Not really as such. __packed is supported in uAPI headers so I thought
> > __aligned should probably be as well. One factor here would seem to be that
> > __packed is way more common than __aligned is.
> >
> > FWIW, a corresponding change has been done to scripts/kernel-doc; see
> > commit 3d9bfb19bd705f503ac7afc2776d5d56dab88858 so kerneldoc does correctly
> > handle that now.
> 
> I am fine with using __aligned(x) shorthand for kernel-space code.
> 
> For UAPI headers, we get it back to __attribute__(aligned(x)) anyway,
> and I'd like to minimize the complex text processing.
> 
> 
> Since __aligned(x) takes an argument,
> this is not feasible to process it by sed.
> 
> 
> For example, please see
> include/uapi/linux/netfilter_bridge/ebtables.h
> 
> 
> 
> If
> 
> __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> 
> is converted into
> 
> __aligned(__alignof__(struct ebt_replace))
> 
> 
> it would be difficult to revert it by sed

Fair enough. Sed doesn't really bend for that too well indeed. I can submit
a patch to remove the similar conversion from the kernel-doc as well based
on this discussion.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
