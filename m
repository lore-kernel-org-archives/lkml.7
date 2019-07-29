Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EB62073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfG2Vwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:52:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:52742 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388888AbfG2Vwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:52:41 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6TLq2Kf032552;
        Mon, 29 Jul 2019 16:52:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6TLq0h1032546;
        Mon, 29 Jul 2019 16:52:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 29 Jul 2019 16:52:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr, arnd@arndb.de,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
Message-ID: <20190729215200.GN31406@gate.crashing.org>
References: <20190729202542.205309-1-ndesaulniers@google.com> <20190729203246.GA117371@archlinux-threadripper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729203246.GA117371@archlinux-threadripper>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:32:46PM -0700, Nathan Chancellor wrote:
> For the record:
> 
> https://godbolt.org/z/z57VU7
> 
> This seems consistent with what Michael found so I don't think a revert
> is entirely unreasonable.

Try this:

  https://godbolt.org/z/6_ZfVi

This matters in non-trivial loops, for example.  But all current cases
where such non-trivial loops are done with cache block instructions are
actually written in real assembler already, using two registers.
Because performance matters.  Not that I recommend writing code as
critical as memset in C with inline asm :-)


Segher
