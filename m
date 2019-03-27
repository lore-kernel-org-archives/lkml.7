Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D42E206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfC0GTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:19:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:15861 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfC0GTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:19:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="331042090"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2019 23:18:58 -0700
Date:   Wed, 27 Mar 2019 14:03:34 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190327060334.GA13084@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-4-git-send-email-hao.wu@intel.com>
 <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
 <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
 <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
 <580c6c604d3915c105f076fc7f22ab5da98598fc.camel@redhat.com>
 <20190327043743.GA20968@hao-dev>
 <29827fcdcdd4fb46b680a6bd184b44fca638666e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29827fcdcdd4fb46b680a6bd184b44fca638666e.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 01:10:31AM -0500, Scott Wood wrote:
> On Wed, 2019-03-27 at 12:37 +0800, Wu Hao wrote:
> > On Tue, Mar 26, 2019 at 04:22:34PM -0500, Scott Wood wrote:
> > > On Tue, 2019-03-26 at 14:33 -0500, Alan Tull wrote:
> > > > On Mon, Mar 25, 2019 at 5:58 PM Scott Wood <swood@redhat.com> wrote:
> > > > > > 
> > > > Hi Scott,
> > > > 
> > > > > On Mon, 2019-03-25 at 17:53 -0500, Scott Wood wrote:
> > > > > > On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > > > > > > +#else
> > > > > > > +static inline void copy512(void *src, void __iomem *dst)
> > > > > > > +{
> > > > > > > +   WARN_ON_ONCE(1);
> > > > > > > +}
> > > > > > > +#endif
> > > > > > 
> Likewise, this will be called if a revision 2 device is used on non-
> > > > > > x86
> > > > > > (or on x86 with an old binutils).  The driver should fall back to
> > > > > > 32-
> > > > > > bit
> > > > > > in such cases.
> > 
> > Unfortunately revision 2 is only for integrated FPGA solution, and it
> > doesn't
> > support any fallback solution (original 32bit data partial reconfiguration
> > is
> > not supported any more), so driver has to WARN in such path.
> 
> >From the commit message it seemed like this was just an optimization, not
> something necessary to support revision 2.
> 
> If there's no way to program the device without AVX512, then printing an
> error message and returning an error to userspace would be better than
> WARN_ON, since it's not actually a kernel bug.

Fair enough. Will do. Thanks for the suggestion.

Hao

> 
> -Scott
> 
