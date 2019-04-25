Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4772F20578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfDYJYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:24:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:26219 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfDYJYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:24:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 02:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="167793343"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Apr 2019 02:22:46 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 25 Apr 2019 12:22:45 +0300
Date:   Thu, 25 Apr 2019 12:22:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] thunderbolt: Make priority unsigned in struct tb_path
Message-ID: <20190425092245.GV2654@lahna.fi.intel.com>
References: <20190424183413.13854-1-natechancellor@gmail.com>
 <CAKwvOdkHiBhFsgEvLrr6oD84GKetDFV2b=n1DYDewCUyHWf7oA@mail.gmail.com>
 <20190424190005.GA9406@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424190005.GA9406@archlinux-i9>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:00:05PM -0700, Nathan Chancellor wrote:
> On Wed, Apr 24, 2019 at 11:49:37AM -0700, Nick Desaulniers wrote:
> > On Wed, Apr 24, 2019 at 11:34 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns:
> > >
> > > drivers/thunderbolt/tunnel.c:504:17: warning: implicit truncation from
> > > 'int' to bit-field changes value from 5 to -3
> > > [-Wbitfield-constant-conversion]
> > >         path->priority = 5;
> > >                        ^ ~
> > > 1 warning generated.
> > >
> > > The priority member in struct tb_path is only ever assigned a positive
> > > number:
> > >
> > > $ rg -n priority drivers/thunderbolt/path.c
> > > drivers/thunderbolt/tunnel.c:99:        path->priority = 3;
> > > drivers/thunderbolt/tunnel.c:308:       path->priority = 2;
> > > drivers/thunderbolt/tunnel.c:323:       path->priority = 1;
> > > drivers/thunderbolt/tunnel.c:504:       path->priority = 5;
> > 
> > LGTM.  Looks like drivers/thunderbolt/tb_regs.h also defines it as u32
> > (no change needed here).
> > Triple checking it's uses, looks like it gets assigned:
> > drivers/thunderbolt/path.c#L492:
> > hop.priority = path->priority;
> > hop is an instance of a struct tb_regs_hop, which is the definition I
> > was looking at above.  LGTM thanks Nathan!
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks for the review!
> 
> > 
> > >
> > > Furthmore, that value is only assigned to an unsigned integer in
> 
> Although apparently I can't spell... should be "Furthermore".

Fixed the typo and applied to thunderbolt.git/next, thanks!
