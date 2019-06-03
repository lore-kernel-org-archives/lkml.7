Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302E5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017D24927
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfFCOSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:18:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34400 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfFCOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:18:31 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 38AF52680AC;
        Mon,  3 Jun 2019 15:18:30 +0100 (BST)
Date:   Mon, 3 Jun 2019 16:18:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/3] mtd: nand: raw: brcmnand: Refactored code and
 introduced inline functions
Message-ID: <20190603161825.4044f953@collabora.com>
In-Reply-To: <CAC=U0a1q2CTZx+btLBJNewK8Rv3WXVE-ZV+j5fFWZPJLoJ94NA@mail.gmail.com>
References: <1559251257-12383-1-git-send-email-kdasu.kdev@gmail.com>
        <20190601095748.35d1c1aa@collabora.com>
        <CAC=U0a1q2CTZx+btLBJNewK8Rv3WXVE-ZV+j5fFWZPJLoJ94NA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 10:11:20 -0400
Kamal Dasu <kdasu.kdev@gmail.com> wrote:

> Boris,
> 
> On Sat, Jun 1, 2019 at 3:57 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Thu, 30 May 2019 17:20:35 -0400
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >  
> > > Refactored NAND ECC and CMD address configuration code to use inline
> > > functions.  
> >
> > I'd expect the compiler to be smart enough to decide when inlining is
> > appropriate. Did you check that adding the inline specifier actually
> > makes a difference?  
> 
> This was done to make the code more readable. It does not make any
> difference to performance.

I meant dropping the inline specifier, not going back to manual
inlining. As a general rule, you don't need to add the 'inline'
specifier unless your function is defined in a header. In all other
cases the compiler is able to inline things on its own when it sees the
number of instructions is small enough or when the function is only
called once.
