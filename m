Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150EBC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65E72146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfIXMPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:15:20 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46696 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfIXMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:15:19 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iCjir-0005vn-FO; Tue, 24 Sep 2019 14:15:13 +0200
Message-ID: <106a01a6027fc0587ea9f01678fb86732a8dbe1e.camel@sipsolutions.net>
Subject: Re: [PATCH] modpost: fix static EXPORT_SYMBOL warnings for UML build
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Sep 2019 14:15:12 +0200
In-Reply-To: <20190924120740.12425-1-yamada.masahiro@socionext.com>
References: <20190924120740.12425-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-24 at 21:07 +0900, Masahiro Yamada wrote:
> Johannes Berg reports lots of modpost warnings on ARCH=um builds:
> 
> WARNING: "rename" [vmlinux] is a static EXPORT_SYMBOL
> [snip]
> WARNING: "__stack_smash_handler" [vmlinux] is a static EXPORT_SYMBOL
> 
> When you run "make", the modpost is run twice; before linking vmlinux,
> and before building modules. All the warnings above are from the second
> modpost.
> 
> The offending symbols are defined not in vmlinux, but in the C library.
> The first modpost is run against the relocatable vmlinux.o, and those
> warnings are nicely suppressed because the SH_UNDEF entries from the
> symbol table clear the ->is_static flag.
> 
> The second modpost is run against the executable vmlinux (+ modules),
> where those symbols have been resolved, but the definitions do not
> exist.
> 
> This commit fixes it in a straight forward way. Suppress the static
> EXPORT_SYMBOL warnings from "vmlinux".

Yep, that fixes it.

Tested-by: Johannes Berg <johannes@sipsolutions.net>

Thanks!

johannes

