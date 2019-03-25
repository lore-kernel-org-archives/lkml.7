Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 02:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qef6YXkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfCYCbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 22:31:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfCYCbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 22:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Cc:From:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J6jg6kBLgFKMOwQ0kaoV8+aDrdID5J7wq9Obg02yBzA=; b=qef6YXkqlZNV7gnLA3TcpqUEh
        E9HKsdxMeeN+UlSMr9PWWQtp6dwl/BD6o8SymnG/vXlwkRC2mllH3ImqEFMTg3111yIJxzuCvuE5C
        hnFR3FUByKtzVJ0SKzKIC/GTOVEQGZTSYQCdIDbMOQS/tgxWDq6DcSYFAvy21V1AekyhBPJGZ2Xi5
        PAeE5XhuTYxQmEtQioZFRH26Cs8BzBFqtizy6AI24n6o5gywh2LiVTpKyGTJtXfaV5lGdZaR2+bVg
        y3MPIWvOZBw7VurSPYhm7bZJgc2IRqkA0tyiQX/GEIW6rO7HS8VGN1FrX/bAGA4bRunB6V6g7mgWR
        isWOYJYxw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8FOS-0007nN-F7; Mon, 25 Mar 2019 02:31:20 +0000
Subject: Re: Linux 5.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        James Morris <jmorris@namei.org>
Message-ID: <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
Date:   Sun, 24 Mar 2019 19:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/19 2:26 PM, Linus Torvalds wrote:
> Well, we're a week away from the merge window close, and here's rc2.
> Things look fairly normal, but honestly, rc2 is usually too early to
> tell.  People haven't necessarily had time to notice problems yet.
> Which is just another way of saying "please test harder".
> 
> Nothing particularly stands out. Yes, we had some fixes for the new
> io_ring code for issues that were discussed when merging it. Other
> than that, worth noting is that the bulk of the patches are for
> tooling, not the core kernel. In fact, about two thirds of the patch
> is just for the tools/ subdirectory, most of it due to some late perf
> tool updates. The people involved promise they're done.

Hmph.  I'm still looking for the patch that restores the various
CONFIG_DEFAULT_<security> kconfig options to be merged.

https://lore.kernel.org/linux-security-module/2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp/

since commit 70b62c25665f636c9f6c700b26af7df296b0887e dropped them somehow.


-- 
~Randy
