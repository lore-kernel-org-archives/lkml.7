Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8862D21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfCMXBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:01:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:16574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfCMXBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:01:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 16:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,476,1544515200"; 
   d="scan'208";a="328395288"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2019 16:01:37 -0700
Date:   Wed, 13 Mar 2019 16:01:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190313230137.GA12529@agluck-desk>
References: <20190305132147.3739133-1-arnd@arndb.de>
 <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
 <20190306175808.GA30016@agluck-desk>
 <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:15:13PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 6, 2019 at 6:58 PM Luck, Tony <tony.luck@intel.com> wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
> > This seems cleaner than adding all the EXPORTs to skx_common.c
> > I also tried a build with the 0x8A152468-config.gz that Arnd
> > supplied.
> 
> It's still a bit fragile since you do something that kbuild doesn't
> expect with having a file in both a module and built-in code
> in some configurations. I'm fairly sure this version works today,
> but it would break the next time that file gets changed to include
> a reference to THIS_MODULE, or anything else that is different
> between built-in and modular code.
> 
> Another alternative would be to mark all symbols in this file
> 'static' and then include skx_common.c from the other two files.
> Of course that is also ugly and it increases the overall code size,
> so I don't see a way to win this.

Boris,

So where should we go. Proposed solutions are piling up:

1) Make skx_common a module
	[downside: have to EXPORT everything in it]
2) Move module-ish bits out of skx_common
	[downside: perhaps fragile]
3) #include skx_common.c into {skx,i10nm}_edac.c
	[downside: no patch yet, bigger code size]

-Tony
