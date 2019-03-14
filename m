Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17315C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C202184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCNPHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:07:49 -0400
Received: from muru.com ([72.249.23.125]:41846 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfCNPHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:07:49 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6054780FB;
        Thu, 14 Mar 2019 15:08:01 +0000 (UTC)
Date:   Thu, 14 Mar 2019 08:07:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: remove incorrect __init annotation
Message-ID: <20190314150745.GC19425@atomide.com>
References: <20190307103557.1688556-1-arnd@arndb.de>
 <20190307153620.GK20201@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307153620.GK20201@archlinux-ryzen>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Chancellor <natechancellor@gmail.com> [190307 15:36]:
> On Thu, Mar 07, 2019 at 11:35:50AM +0100, Arnd Bergmann wrote:
> > omap3xxx_prm_enable_io_wakeup() is marked __init, but its caller is not, so
> > we get a warning with clang-8:
> > 
> > WARNING: vmlinux.o(.text+0x343c8): Section mismatch in reference from the function omap3xxx_prm_late_init() to the function .init.text:omap3xxx_prm_enable_io_wakeup()
> > The function omap3xxx_prm_late_init() references
> > the function __init omap3xxx_prm_enable_io_wakeup().
> > This is often because omap3xxx_prm_late_init lacks a __init
> > annotation or the annotation of omap3xxx_prm_enable_io_wakeup is wrong.
> > 
> > When building with gcc, omap3xxx_prm_enable_io_wakeup() is always
> > inlined, so we never noticed in the past.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Arnd please just apply this directly, this should not cause
merge conflicts:

Acked-by: Tony Lindgren <tony@atomide.com>
