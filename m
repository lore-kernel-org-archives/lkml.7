Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D820C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256C42184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCNOeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:34:09 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:59682 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCNOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:34:09 -0400
Received: from localhost.localdomain ([127.0.0.1]:57138 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992786AbfCNOeGqbyS4 (ORCPT <rfc822;linux-mips@vger.kernel.org>
        + 1 other); Thu, 14 Mar 2019 15:34:06 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.15.2) with ESMTP id x2EEVxlr003253;
        Thu, 14 Mar 2019 15:31:59 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id x2EEVwVc003252;
        Thu, 14 Mar 2019 15:31:58 +0100
Date:   Thu, 14 Mar 2019 15:31:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, kbuild-all@01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro
 'pr_warn_ratelimited'
Message-ID: <20190314143158.GC27249@linux-mips.org>
References: <201903140234.4FpTWdW3%lkp@intel.com>
 <20190314083758.GA16658@quack2.suse.cz>
 <CAOQ4uxhZH9=U63J1_bVrMbNO-Quy-8S300Qi6VmZxvKwYCogQQ@mail.gmail.com>
 <20190314123811.GH16658@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314123811.GH16658@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 01:38:11PM +0100, Jan Kara wrote:

> On Thu 14-03-19 14:01:18, Amir Goldstein wrote:
> > On Thu, Mar 14, 2019 at 10:37 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > AFAICS this is the known problem with weird mips definitions of
> > > __kernel_fsid_t which uses long whereas all other architectures use int,
> > > right? Seeing that mips can actually have 8-byte longs, I guess this
> > > bogosity is just wired in the kernel API and we cannot easily fix it in
> > > mips (mips guys, correct me if I'm wrong). So what if we just
> > > unconditionally typed printed values to unsigned int to silence the
> > > warning?
> > 
> > I don't understand why. To me that sounds like papering over a bug.
> > 
> > See this reply from mips developer Paul Burton:
> > https://marc.info/?l=linux-fsdevel&m=154783680019904&w=2
> > mips developers have not replied to the question why __kernel_fsid_t
> > should use long.
> 
> Ah, right. I've missed that mips defines __kernel_fsid_t only if
> sizeof(long) == 4. OK, than fixing MIPS headers is definitely what we ought
> to do. Mips guys, any reason why the patch from Ralf didn't get merged yet?

Paul's patch :-)

As for the reason why the definition is as it is - 32-bit MIPS was
born using long, then in 2000 64-bit MIPS started off as arch/mips64
using int.  Eventually the two ports were combined using:

ypedef struct {
#if (_MIPS_SZLONG == 32)
        long    val[2];
#endif
#if (_MIPS_SZLONG == 64)
        int     val[2];
#endif
} __kernel_fsid_t;

A desparate attempt to use asm-generic where ever possible then resulted
in the confusing definition we'e having today.

Normally APIs are cast into stone not to be changed.  But fsid is used in
struct statfs and the man page states "Nobody knows what f_fsid is supposed
to contain (but see below)." and f_fsid is supposed to be opaque anyway so
I'm wondering if something could break at all.  Researching that.

  Ralf
