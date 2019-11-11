Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A371C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0123206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKBcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:32:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfKKBcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:32:07 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4E1E5154245B8;
        Sun, 10 Nov 2019 17:32:06 -0800 (PST)
Date:   Sun, 10 Nov 2019 17:32:03 -0800 (PST)
Message-Id: <20191110.173203.1243596361382467520.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, yamada.masahiro@socionext.com,
        maz@kernel.org
Subject: Re: [PATCH] sparc: vdso: Fix build failure seen due to kbuild
 changes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191111011106.18427-1-linux@roeck-us.net>
References: <20191111011106.18427-1-linux@roeck-us.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Nov 2019 17:32:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 10 Nov 2019 17:11:06 -0800

> sparc64:allmodconfig fails to build with the following error.
> 
> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> make[2]: *** [arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> make[2]: *** Waiting for unfinished jobs....
> 
> The problem bisects to commit a3de7a72c517 ("kbuild: change
> *FLAGS_<basetarget>.o to take the path relative to $(obj)").
> Duplicate the x86 specific defines from this commit to the sparc
> vdso Makefile to fix the problem.
> 
> Fixes: a3de7a72c517 ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: David S. Miller <davem@davemloft.net>
