Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F0721871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfCOP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:57:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:41100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfCOP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:57:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 08:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="282999895"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2019 08:57:19 -0700
Date:   Fri, 15 Mar 2019 08:57:18 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190315155718.GA17775@agluck-desk>
References: <20190305132147.3739133-1-arnd@arndb.de>
 <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
 <20190306175808.GA30016@agluck-desk>
 <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk>
 <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic>
 <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315094341.GA12523@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:43:42AM +0100, Borislav Petkov wrote:
> On Thu, Mar 14, 2019 at 02:59:52PM -0700, Luck, Tony wrote:
> > I made a patch based on option #3. Rough steps were:
> > 
> > $ cat skx_common.c >> skx_common.h
> 
> That doesn't look real clean to me. So we have fsl_ddr_edac.c which
> gets linked in in two drivers and I think you could librarize that
> skx_common.c the same way and have the function exports in the wrapper
> drivers skx_edac and i10nm_edac calling those "library" functions in
> skx_common.c. IMNSVHO.

fsl_ddr_edac.c looks to be doing exactly what we are doing with
skx_common.c. They just get away with it for now because they don't
have a reference to THIS_MODULE since they don't set up anything
in sysfs.

If this is your goal, then Qiuxu's patch that moves the problem
piece out of skx_common.c does what you are asking for.

-Tony
