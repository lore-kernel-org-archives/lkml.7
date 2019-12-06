Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B553CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BF5206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSBoCzzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLFQJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:09:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLFQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EcvpdwTgGf+qsFdhkXPedvlI2rui3QKW0BzCUUFP9tE=; b=NSBoCzzxwHwDOC0geBuVnjlEE
        RJ18z8zgSQKyDSWVeXT/A/WKS15yazSwxYfLdx0Twkh8ljeVSDDriz9yolnt4gJ03nRnmal8Th2/r
        7GOvD0Y9/9OiX9DPK062+fcbadmQ6tgzGAfS0YdZJ4LvDevXo6Xv9c1bADb6SQNpALQejJAS7ojyb
        nuOdLXyxbVnWDFKulEJp8FNvRkSUL2KTxaWfexHf4WIc5P3gWz+qxazlwl7BrT3x+a14vxy1wtcO8
        bXGv3bT7RBWYHXXBZOfeEvx8Lu7+YIx1C2PIjr/VIXOInMEKjrnrM9BNXn82K4I8ODM/+PsTYmQ1H
        j52mmfFpQ==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idGAC-0005X4-OE; Fri, 06 Dec 2019 16:09:04 +0000
Subject: Re: [PATCH] kconfig: Add yes2modconfig and mod2yesconfig targets.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <1575625847-6384-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a473c6c-cc1f-6648-31ec-3b40e415a836@infradead.org>
Date:   Fri, 6 Dec 2019 08:09:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575625847-6384-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/19 1:50 AM, Tetsuo Handa wrote:
> Since kernel configs provided by syzbot are close to "make allyesconfig",
> it takes long time to rebuild. This is especially waste of time when we
> need to rebuild for many times (e.g. doing manual printk() inspection,
> bisect operations).
> 
> We can save time if we can exclude modules which are irrelevant to each
> problem. But "make localmodconfig" cannot exclude modules which are built
> into vmlinux because /sbin/lsmod output is used as the source of modules.
> 
> Therefore, this patch adds "make yes2modconfig" which converts from =y
> to =m if possible. After confirming that the interested problem is still
> reproducible, we can try "make localmodconfig" (and/or manually tune
> based on "Modules linked in:" line) in order to exclude modules which are
> irrelevant to the interested problem. While we are at it, this patch also
> adds "make mod2yesconfig" target which converts from =m to =y in case
> someone wants to convert from =m to =y after "make localmodconfig".
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  scripts/kconfig/Makefile   |  2 +-
>  scripts/kconfig/conf.c     | 17 +++++++++++++++++
>  scripts/kconfig/confdata.c | 26 ++++++++++++++++++++++++++
>  scripts/kconfig/lkc.h      |  3 +++
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 2f1a59fa5169..3516809255be 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -67,7 +67,7 @@ localyesconfig localmodconfig: $(obj)/conf
>  #  deprecated for external use
>  simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
>  	alldefconfig randconfig listnewconfig olddefconfig syncconfig \
> -	helpnewconfig
> +	helpnewconfig yes2modconfig mod2yesconfig
>  
>  PHONY += $(simple-targets)


In this Makefile (above), please also update the available 'help' targets.

-- 
~Randy

