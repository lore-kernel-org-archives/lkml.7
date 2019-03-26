Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E353C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769272070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfCZRED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:04:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:04:03 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8pUV-000267-Ef; Tue, 26 Mar 2019 18:03:59 +0100
Date:   Tue, 26 Mar 2019 18:03:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
In-Reply-To: <20190321220009.29334-3-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-3-andi@firstfloor.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-436328035-1553619839=:1789"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-436328035-1553619839=:1789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Andi,

On Thu, 21 Mar 2019, Andi Kleen wrote:

> With gcc 8 toplevel assembler statements that do not mark themselves
> as .text may end up in other sections.

Which is clearly a change in behaviour. Is that intended or just yet
another feature of GCC?

Your subject says: 'x86, lto:'

So is this a LTO related problem or is the section randomization
independent of LTO?

This wants to be clearly documented in the changelog.

Aside of that the proper Subject prefix is either:

    x86/asm/lto:

or

    x86/asm:

dependent on the nature. Like it or not, but this has been the prefix x86
uses for a very long time already.

> I had boot crashes because
> various assembler statements ended up in the middle of the initcall
> section.
> 
> Always mark all the top level assembler statements as text
> so that they switch to the right section.
> 
> For AMD "vide", which is only used on 32bit kernels, I also
> marked it as 32bit only.

Once more. See

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

  "Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
  instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to
  do frotz”, as if you are giving orders to the codebase to change its
  behaviour."

This is the last time, I'm asking for this.
 
Thanks,

	tglx
--8323329-436328035-1553619839=:1789--
