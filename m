Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91454C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644522081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eZN7c45p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfGOJiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:38:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfGOJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CaCJ3BP9sWiklXE7o4fAAusvuuS7iaTXDeBKOpK31ZM=; b=eZN7c45pM+dwp3/PuatRJPz8W
        ibT8EKGHYxtJwBtxuxgiWX6aNp1KvxIO95/ysl6XGIzcN1TwECB9GNMNxJjcBDrEqi82BFbJcl//Q
        d7xM2G085JC0+5CzCE8uMuttpWTkOVpG8wWVTAPzO/M1VD8zr3LEKmD9loYxZtV+SbSXM5EKWYkhz
        ILoE8Ju9qJz9FLbIMGBAzT8JwDgVECqzFPjhjeo5dNKOTg4Ds1uaDbhC/3jvW5Q8zlTW0IU1TXRoq
        12vaoXH6JZl/3RjtGz8bgehQpJYSKYR3S3vUOFcKI0qKCV4neuZMCBeEdL/ARbvnpQgGl2x0btKrE
        wGRbnBvHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmxRT-0001nA-Hc; Mon, 15 Jul 2019 09:38:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C5ED20B29100; Mon, 15 Jul 2019 11:38:40 +0200 (CEST)
Date:   Mon, 15 Jul 2019 11:38:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 18/22] objtool: Refactor jump table code
Message-ID: <20190715093840.GY3419@hirez.programming.kicks-ass.net>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <6735a6cb9c18c3af5a65ee5078b9b754358935f6.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6735a6cb9c18c3af5a65ee5078b9b754358935f6.1563150885.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 07:37:13PM -0500, Josh Poimboeuf wrote:
> Now that C jump tables are supported, call them "jump tables" instead of
> "switch tables".  Also rename some other variables, add comments, and
> simplify the code flow a bit.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/check.c | 82 +++++++++++++++++++++++--------------------
>  tools/objtool/elf.c   |  2 +-
>  tools/objtool/elf.h   |  2 +-
>  3 files changed, 46 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index a190a6e79a91..b21e9f7768d0 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -627,7 +627,7 @@ static int add_jump_destinations(struct objtool_file *file)
>  			 * However this code can't completely replace the
>  			 * read_symbols() code because this doesn't detect the
>  			 * case where the parent function's only reference to a
> -			 * subfunction is through a switch table.
> +			 * subfunction is through a switch jump table.

s/switch// ?
