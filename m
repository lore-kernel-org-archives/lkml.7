Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69294C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462FA2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfHSOZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:25:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:53116 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfHSOZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:25:26 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7JEOx1K022323;
        Mon, 19 Aug 2019 09:25:00 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7JEOxlG022322;
        Mon, 19 Aug 2019 09:24:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Aug 2019 09:24:59 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powerpc/64: optimise LOAD_REG_IMMEDIATE_SYM()
Message-ID: <20190819142459.GJ31406@gate.crashing.org>
References: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr> <92bf50b31f5f78cc76ed055b11a492e8e9e2c731.1566223054.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bf50b31f5f78cc76ed055b11a492e8e9e2c731.1566223054.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:58:12PM +0000, Christophe Leroy wrote:
> -#define LOAD_REG_IMMEDIATE_SYM(reg,expr)	\
> -	lis     reg,(expr)@highest;		\
> -	ori     reg,reg,(expr)@higher;	\
> -	rldicr  reg,reg,32,31;		\
> -	oris    reg,reg,(expr)@__AS_ATHIGH;	\
> -	ori     reg,reg,(expr)@l;
> +#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
> +	lis	reg, (expr)@highest;		\
> +	lis	tmp, (expr)@__AS_ATHIGH;	\
> +	ori	reg, reg, (expr)@higher;	\
> +	ori	tmp, reg, (expr)@l;		\
> +	rldimi	reg, tmp, 32, 0

That should be

#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
	lis	tmp, (expr)@highest;		\
	ori	tmp, tmp, (expr)@higher;	\
	lis	reg, (expr)@__AS_ATHIGH;	\
	ori	reg, reg, (expr)@l;		\
	rldimi	reg, tmp, 32, 0

(tmp is the high half, reg is the low half, as inputs to that rldimi).


Segher
