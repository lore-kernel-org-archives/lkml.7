Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40862082F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbfHVVvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389740AbfHVVvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:51:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED7033175291;
        Thu, 22 Aug 2019 21:51:16 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6269A5D713;
        Thu, 22 Aug 2019 21:51:15 +0000 (UTC)
Date:   Thu, 22 Aug 2019 16:51:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien <julien.thierry.kdev@gmail.com>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 07/18] objtool: Introduce INSN_UNKNOWN type
Message-ID: <20190822215112.n36slswph64nbzhb@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-8-raphael.gault@arm.com>
 <20190822200406.jc3yf77pomxxwep6@treble>
 <3c4e3227-eeb3-371a-d015-a0e0e60e5332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c4e3227-eeb3-371a-d015-a0e0e60e5332@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 21:51:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 09:45:00PM +0100, Julien wrote:
> Hi Josh,
> 
> On 22/08/19 21:04, Josh Poimboeuf wrote:
> > On Fri, Aug 16, 2019 at 01:23:52PM +0100, Raphael Gault wrote:
> > > On arm64 some object files contain data stored in the .text section.
> > > This data is interpreted by objtool as instruction but can't be
> > > identified as a valid one. In order to keep analysing those files we
> > > introduce INSN_UNKNOWN type. The "unknown instruction" warning will thus
> > > only be raised if such instructions are uncountered while validating an
> > > execution branch.
> > > 
> > > This change doesn't impact the x86 decoding logic since 0 is still used
> > > as a way to specify an unknown type, raising the "unknown instruction"
> > > warning during the decoding phase still.
> > > 
> > > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > 
> > Is there a reason such data can't be moved to .rodata?  That would seem
> > like the proper fix.
> > 
> 
> Raphaël can confirm, if I remember correctly, that issue was encountered on
> assembly files implementing crypto algorithms were some words/double-words
> of data were in the middle of the .text. I think it is done this way to make
> sure the data can be loaded in a single instruction. So moving it to another
> section could impact the crypto performance depending on the relocations.
> 
> That was my understanding at least.

Thanks.  If that's the case then that would be useful information to put
in the patch description.  A code excerpt of an example code site would
be useful too.

I'm not sure INSN_UNKNOWN is the right name though, since the decoder
does actually know about it.  Maybe INSN_DATA or something?

-- 
Josh
