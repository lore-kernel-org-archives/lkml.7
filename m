Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5CBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106E62190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCWOfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:35:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:10990 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWOfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:35:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 07:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="285263886"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2019 07:35:19 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id F0E51300DF5; Sat, 23 Mar 2019 07:35:18 -0700 (PDT)
Date:   Sat, 23 Mar 2019 07:35:18 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] x86/kprobes: Make trampoline_handler global and
 visible
Message-ID: <20190323143518.GB18020@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-12-andi@firstfloor.org>
 <20190323184521.a443cc741997cb0d3ed26395@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323184521.a443cc741997cb0d3ed26395@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 06:45:21PM +0900, Masami Hiramatsu wrote:
> On Thu, 21 Mar 2019 15:00:03 -0700
> Andi Kleen <andi@firstfloor.org> wrote:
> 
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > This function is referenced from assembler, so in LTO
> > it needs to be global and visible to not be optimized away.
> > 
> 
> I got it.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Andi, out of curiousity, that is not only for x86, but
> does all arch have to care it?

Yes all architectures need it for LTO, but I currently
only test x86. There are some other people who made it work
on ARM / MIPS / PowerPC before.

-Andi
