Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE4320811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfCZViE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:38:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:54534 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZViD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:38:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 14:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="137508707"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2019 14:38:03 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1003B301BD4; Tue, 26 Mar 2019 14:38:03 -0700 (PDT)
Date:   Tue, 26 Mar 2019 14:38:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190326213803.GN18020@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 06:03:59PM +0100, Thomas Gleixner wrote:
> Andi,
> 
> On Thu, 21 Mar 2019, Andi Kleen wrote:
> 
> > With gcc 8 toplevel assembler statements that do not mark themselves
> > as .text may end up in other sections.
> 
> Which is clearly a change in behaviour. Is that intended or just yet
> another feature of GCC?

I'm not sure it's a new behavior, but I've seen it first
with gcc 8.

> 
> Your subject says: 'x86, lto:'
> 
> So is this a LTO related problem or is the section randomization
> independent of LTO?

The basic behavior is independent of LTO, but I've only seen
failures with LTO. But I believe in theory it could lead
to failures even without LTO.

-Andi
