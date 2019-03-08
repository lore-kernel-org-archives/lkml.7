Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF89C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B7020675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCHArs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:47:48 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:38844 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHArs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:47:48 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x280lDiH031397;
        Fri, 8 Mar 2019 00:47:15 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x280kkci391076;
        Thu, 7 Mar 2019 21:46:46 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
        <orbm3i5xrn.fsf@lxoliva.fsfla.org>
        <20190211125506.GA21280@localhost.localdomain>
        <orimxq3q9j.fsf@lxoliva.fsfla.org>
        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
        <orva1jj9ht.fsf@lxoliva.fsfla.org>
        <20190217235951.GA20700@darkstar.musicnaut.iki.fi>
        <orpnrpj2rk.fsf@lxoliva.fsfla.org>
        <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>
        <orlg1ryyo2.fsf@lxoliva.fsfla.org>
        <alpine.LFD.2.21.1903071744560.7728@eddie.linux-mips.org>
Date:   Thu, 07 Mar 2019 21:46:46 -0300
In-Reply-To: <alpine.LFD.2.21.1903071744560.7728@eddie.linux-mips.org> (Maciej
        W. Rozycki's message of "Thu, 7 Mar 2019 17:59:42 +0000 (GMT)")
Message-ID: <orwolaw5u1.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar  7, 2019, "Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  So this seems backwards to me, port I/O is supposed to be strongly 
> ordered, so if removing the ordering guarantee "fixes" your problem, then 
> there must be a second bottom here.

Well, it partially restores the earlier state, so the actual bug goes
back to latent.  We just have to find out what it is.  My plan, in the
next time slot I can devote to this investigation, is to try to bisect
source files that use these interfaces to identify a minimal set that
can switch to the new barriers without breaking anything, then report
back after failing to make sense of it myself ;-)  So, yeah, several
more bottoms to dig through.

> Does your platform use `war_io_reorder_wmb'?

Err...  I'm not sure I understand your question.

It uses it in __BUILD_IOPORT_SINGLE within the expanded out function,
given !barrier, but you already knew that.

Did you mean to ask what war_io_reorder_wmb expand to, or whether there
are other uses of war_io_reorder_wmb, or what?

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
