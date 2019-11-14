Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6BFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09DB206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNAWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:22:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfKNAWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:22:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C4113133E9058;
        Wed, 13 Nov 2019 16:21:59 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:21:57 -0800 (PST)
Message-Id: <20191113.162157.111707512627631395.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     yamada.masahiro@socionext.com, sparclinux@vger.kernel.org,
        matorola@gmail.com, gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <201911131558.6B0778229@keescook>
References: <20190922113436.10396-1-yamada.masahiro@socionext.com>
        <201911131558.6B0778229@keescook>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Nov 2019 16:22:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 13 Nov 2019 15:59:27 -0800

> On Sun, Sep 22, 2019 at 08:34:36PM +0900, Masahiro Yamada wrote:
>> Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
>> take the path relative to $(obj)"), sparc allmodconfig fails to build
>> as follows:
>> 
>>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
>> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
>> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
>> 
>> The cause of the breakage is that -pg flag not being dropped.
>> 
>> The vdso32 files are located in the vdso32/ subdirectory, but I missed
>> to update the Makefile.
>> 
>> Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
>> Reported-by: Anatoly Pugachev <matorola@gmail.com>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> I've tripped over this as well. Since no one has picked this up, can you
> take it via your tree Masahiro?

Yes, please do.  Sorry, I haven't had a lot of time for Sparc work lately.

Acked-by: David S. Miller <davem@davemloft.net>
