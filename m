Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80491C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B01920661
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfLBTmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:42:22 -0500
Received: from gentwo.org ([3.19.106.255]:46878 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbfLBTmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:42:22 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 6B0D53EEE1; Mon,  2 Dec 2019 19:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 69F1C3EED9;
        Mon,  2 Dec 2019 19:42:21 +0000 (UTC)
Date:   Mon, 2 Dec 2019 19:42:21 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Dennis Zhou <dennis@kernel.org>
cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
In-Reply-To: <20191202190718.GA18019@dennisz-mbp>
Message-ID: <alpine.DEB.2.21.1912021939320.2675@www.lameter.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com> <alpine.DEB.2.21.1911271553560.16980@www.lameter.com> <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com> <20191127225432.ttwxm3hxtg5utfaz@ltop.local> <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local> <20191202190718.GA18019@dennisz-mbp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019, Dennis Zhou wrote:

> I think typeof_cast_kernel() or typeof_force_kernel() are reasonable
> names. I kind of like the idea of cast/force over strip because we're
> really still moving address spaces even if it is moving it back.

I vote for typeof_cast_kernel()...

percpu addresses are more like an alias.... or more precisely an offset to
a base pointer (that already belongs to a certain "address space") and we
use the notion of a distinctly different "address space" in the linker to
categorize these references.

