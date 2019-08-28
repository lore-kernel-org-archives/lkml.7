Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C84C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346C42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EWma0uMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfH1PxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:53:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfH1PxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gQZskAU+8k336EC6UmUC7ikUT5tx26F1fzK9gaSbLLs=; b=EWma0uMu9kw+jEO+hZ+1+Tyw1
        wIMr90xNPIQTuwomkBqe4oh4/4hoMaV+W7N3hLa6GYx3WRLvMJUSfwfAPR2r/K/9wROl9EpNL+/+A
        prWlsPA7sjxqjUisFU42ap0eHmRf2WPAiwJtg4KdjTasczha8bCIb/9m4ni1W5fikZVQHBef3Hs3M
        irW7e2qwgx9hhV7k0AFtRq0pGSgtn0KRwua7wPgztbYmdds+Dl0rRIn2rdfenDH9dpdXqmO55ASPs
        VGkobLGAcWFmdfgJ+8DqM8Lm7XTMq8xgqIh7WM5C+tPSr3Nnu2Apb26WpeLU8o580KQMrGhVzp+Oc
        4NS/JhWLQ==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i30Fe-0005vm-Pb; Wed, 28 Aug 2019 15:52:50 +0000
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4856aac6-1760-8ba5-dee0-aecfedbbe266@infradead.org>
Date:   Wed, 28 Aug 2019 08:52:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828093143.163302-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 2:31 AM, Brendan Higgins wrote:
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by removing call to
> vprintk_emit, and calling printk directly.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  include/kunit/test.h | 11 ++++-----
>  kunit/test.c         | 57 +++++---------------------------------------
>  2 files changed, 11 insertions(+), 57 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

-- 
~Randy
