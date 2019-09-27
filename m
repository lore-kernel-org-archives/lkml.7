Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1743BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5B720872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569562296;
	bh=b1Jjpebwjo+hSOp77MSaaQmC5zmGryJcUvrk+YALm+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jckigUQOD4hnm+AQzwljyiy6gwfTQmP3DHDJTkm4dE8uQAvpgMTkYmsI6XDA9RNP2
	 zqrw4Q07a/0Cpn+zriRcTfMqg2bUHcWKjgjxmgCJ43HHNmOZ4qvBeEFUQuHyuRJmeU
	 +GJ+Caq/fwv4NHwAQD83mTXG3MrobWG2ZN/QtFZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfI0FbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfI0FbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:31:16 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3B920872;
        Fri, 27 Sep 2019 05:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569562276;
        bh=b1Jjpebwjo+hSOp77MSaaQmC5zmGryJcUvrk+YALm+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bek41nOQJPaF14byVp+Nj/5tEwap5q6vOtUf07CZXSfIV87Jemt6udrPxDZdmC03o
         J4zuD1t8eG6wxagD42XaYKgSeolIA39HiMCCctTiTNxqw9IjCkC/MeibzuXSc9n+Bz
         XwQWU61F6005VPfEH4kfLOwENcPxdIgQ+AUh/A7s=
Date:   Fri, 27 Sep 2019 07:31:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shaun Ruffell <sruffell@sruffell.net>
Cc:     linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] modpost: Copy namespace string into 'struct symbol'
Message-ID: <20190927053101.GA1781519@kroah.com>
References: <20190906103235.197072-5-maennich@google.com>
 <20190926222446.30510-1-sruffell@sruffell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926222446.30510-1-sruffell@sruffell.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:24:46PM -0500, Shaun Ruffell wrote:
> When building an out-of-tree module I was receiving many warnings from
> modpost like:
> 
>   WARNING: module dahdi_vpmadt032_loader uses symbol __kmalloc from namespace ts/dahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>   WARNING: module dahdi_vpmadt032_loader uses symbol vpmadtreg_register from namespace linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>   WARNING: module dahdi_vpmadt032_loader uses symbol param_ops_int from namespace ahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>   WARNING: module dahdi_vpmadt032_loader uses symbol __init_waitqueue_head from namespace ux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>   ...
> 
> The fundamental issue appears to be that read_dump() is passing a
> pointer to a statically allocated buffer for the namespace which is
> reused as the file is parsed.
> 
> This change makes it so that 'struct symbol' holds a copy of the
> namespace string in the same way that it holds a copy of the symbol
> string. Because a copy is being made, handle_modversion can now free the
> temporary copy
> 
> Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
> Cc: Martijn Coenen <maco@android.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Matthias Maennich <maennich@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Shaun Ruffell <sruffell@sruffell.net>
> ---
> 
> Hi,
> 
> I didn't test that this change works with the namespaces, or investigate why
> read_dump() is only called first while building out-of-tree modules, but it does
> seem correct to me for the symbol to own the memory backing the namespace
> string.
> 
> I also realize I'm jumping the gun a bit by testing against master before
> 5.4-rc1 is tagged.

Yes!!!

This fixes the issue that I reported to Mattias a few days ago on irc.
I am hitting this by just trying to build a single directory work of
modules:
	make M=drivers/usb/

I just tested this patch and it works for me, thanks so much!

Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
