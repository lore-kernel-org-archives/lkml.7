Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53655C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBA9218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfCVQbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:31:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:18877 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCVQbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:31:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="136380317"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2019 09:31:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 400E4300E46; Fri, 22 Mar 2019 09:31:06 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:31:06 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andi Kleen <andi@firstfloor.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc
 9
Message-ID: <20190322163106.GD24002@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-2-andi@firstfloor.org>
 <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:58:51PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 21, 2019 at 11:00 PM Andi Kleen <andi@firstfloor.org> wrote:
> >
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > This warning is very noisy in a default build with gcc 9.
> > Move it into W=2 only.
> >
> > Cc: arnd@arndb.de
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> I think W=2 is too aggressive. On many architectures, this finds
> real bugs and the false positives tend to be trivial to fix
> (by removing the bogus __packed annotation), which improves
> the generated code in the process.

It might waste more memory or make the data structure incompatible
with something external.

> 
> Moving it to W=1 for the moment is probably fine, but ideally
> I think we should fix the kernel to behave according to the
> C standard.

Okay, so is there anybody working on this?

AFAIK it's not an issue on x86 at all.

-Andi
