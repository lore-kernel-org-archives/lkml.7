Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A38ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE39206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570466622;
	bh=18jBfXv9rylAjh6k7GAxABb+qhImwkW083rbcWQbSpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tVxOtUbLNpzJHuoUPJa2JWg0gAfahsD4G4xKS4B2DS6EBbkYUKn/23YDCSE25S1Tk
	 Bf/zPTWpdxXFyJpd6cX4606f7lt0ySzXW+fg/Cp7UNHQDYRgjCI1Mdatgt+0wm/WIR
	 9driPzjBMh4zsGC+Tsor2FNl8pt93ZIPxk8wlD2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfJGQnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfJGQnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:43:40 -0400
Received: from linux-8ccs (ip5f5ade87.dynamic.kabel-deutschland.de [95.90.222.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E0E20700;
        Mon,  7 Oct 2019 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570466619;
        bh=18jBfXv9rylAjh6k7GAxABb+qhImwkW083rbcWQbSpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L41iUj+ZaQkgvmNDSRNeXBh1OnhPFuJg4lBFldlglcR1Pswi/z8i+ccMEHi3wm6tW
         yvvpUFglAJfvJ9H2Rn/evA/K3h9PU15zmZRnL4lEJmyitLjJxzRZkDknzjjXxBrd1d
         RNlIph9vM2Fa/OR0I86t+iVAIKy/DQyLSK4YPjBw=
Date:   Mon, 7 Oct 2019 18:43:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shaun Ruffell <sruffell@sruffell.net>,
        linux-kbuild@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] module: various bug-fixes and clean-ups for
 module namespace
Message-ID: <20191007164332.GA6021@linux-8ccs>
References: <20191003075826.7478-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191003075826.7478-1-yamada.masahiro@socionext.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [03/10/19 16:58 +0900]:
>
>I was hit by some problems caused by the module namespace feature
>that was merged recently. At least, the breakage of
>external module builds is a fatal one. I just took a look at the code
>closer, and I noticed some more issues (some are nit-picking).
>
>V2:
> - I dropped "module: avoid code duplication in include/linux/export.h"
>   because Matthias offered to refactor the code by himself.
>
> - V1 missed the problem when a symbol is preloaded before
>  sym_add_exported() is called.  I fixed it too.

Hi Masahiro!

Thanks for the v2. I've queued this up in the module tree with the
intention of getting the fixes in for -rc3.

Matthias is working on some modpost fixes that would get rid of the
__ksymtab_<symbol>.<ns>/__ksymtab_<ns>.<symbol> naming scheme
altogether in favor of just getting the namespace string from
__kstrtabns and __ksymtab_strings -- this may render patch 1
unnecessary. But since we want to fix this asap, we can just keep it
and apply Matthias's fix on top later.

Thanks!

Jessica
