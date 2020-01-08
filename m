Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CF5C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191A52067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IxLb/Hbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgAHPoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:44:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RYC0L/1SMwgYk6wXk0aDr7brdNKcxmstrJntjhD4+po=; b=IxLb/HbkOja5rnvJTVbrCpF65
        UgSiv47EmvwEQ9whZz+A/GU/irB5t84FnikD/saJaoUABMWOm6LyT313C2OWECNWPNF7FSIlgwNTi
        PsgG0+APuZ7t8P3fP3tevBbGcoTW+aMtXOwjZY9f9AlmmXDaQ0Zz/P+m8Urx6jFGcNIUZ4Jn+qrnn
        sYPp7Qj1WGvqrgLmU7NgkO6zW3WmyJ1ApH6v63mdwbIUljLsln1+EkZuQ4xIWU1sX5yLe+2z3nkNU
        rhAcefyk8A7zRNq1SjLaVxGXG7+UFpftPRpX4yFxV/gC8fkMuU0JXQPw3KfFN/5fWBiUBndfLp9Nf
        JyE+kOekw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipDV8-0006SP-Ol; Wed, 08 Jan 2020 15:44:06 +0000
Date:   Wed, 8 Jan 2020 07:44:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Fumiya Shigemitsu <shfy1014@gmail.com>,
        Yongxin Liu <yongxin.liu@windriver.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: allow modules to link *.a archives
Message-ID: <20200108154406.GA21695@infradead.org>
References: <20200106032324.3147-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106032324.3147-1-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:23:24PM +0900, Masahiro Yamada wrote:
> Since commit 69ea912fda74 ("kbuild: remove unneeded link_multi_deps"),
> modules cannot link *.a archives.
> 
> I do not see such a usecase in the upstream code, but multiple people
> reported this issue, so it seems to be a desired feature for external
> modules.

Kernel policy is to not keep around infrastructure not used upstream.
And linking archives in the kernel doesn't really make any sense, so
this shouldn't go in in any form.
