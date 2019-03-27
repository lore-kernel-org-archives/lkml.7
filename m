Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB3F2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfC0GKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:10:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfC0GKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:10:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BABB2315009D;
        Wed, 27 Mar 2019 06:10:32 +0000 (UTC)
Received: from ovpn-118-18.phx2.redhat.com (ovpn-118-18.phx2.redhat.com [10.3.118.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F34A05C231;
        Wed, 27 Mar 2019 06:10:31 +0000 (UTC)
Message-ID: <29827fcdcdd4fb46b680a6bd184b44fca638666e.camel@redhat.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
From:   Scott Wood <swood@redhat.com>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Date:   Wed, 27 Mar 2019 01:10:31 -0500
In-Reply-To: <20190327043743.GA20968@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
         <1553483264-5379-4-git-send-email-hao.wu@intel.com>
         <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
         <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
         <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
         <580c6c604d3915c105f076fc7f22ab5da98598fc.camel@redhat.com>
         <20190327043743.GA20968@hao-dev>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 27 Mar 2019 06:10:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 12:37 +0800, Wu Hao wrote:
> On Tue, Mar 26, 2019 at 04:22:34PM -0500, Scott Wood wrote:
> > On Tue, 2019-03-26 at 14:33 -0500, Alan Tull wrote:
> > > On Mon, Mar 25, 2019 at 5:58 PM Scott Wood <swood@redhat.com> wrote:
> > > > > 
> > > Hi Scott,
> > > 
> > > > On Mon, 2019-03-25 at 17:53 -0500, Scott Wood wrote:
> > > > > On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > > > > > +#else
> > > > > > +static inline void copy512(void *src, void __iomem *dst)
> > > > > > +{
> > > > > > +   WARN_ON_ONCE(1);
> > > > > > +}
> > > > > > +#endif
> > > > > 
Likewise, this will be called if a revision 2 device is used on non-
> > > > > x86
> > > > > (or on x86 with an old binutils).  The driver should fall back to
> > > > > 32-
> > > > > bit
> > > > > in such cases.
> 
> Unfortunately revision 2 is only for integrated FPGA solution, and it
> doesn't
> support any fallback solution (original 32bit data partial reconfiguration
> is
> not supported any more), so driver has to WARN in such path.

From the commit message it seemed like this was just an optimization, not
something necessary to support revision 2.

If there's no way to program the device without AVX512, then printing an
error message and returning an error to userspace would be better than
WARN_ON, since it's not actually a kernel bug.

-Scott


