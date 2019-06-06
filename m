Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0861FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67752083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VlocscIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfFFIo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:44:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38206 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFFIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:44:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so1482903wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THwh6PEFB0S8Bkrg5GfNlp+3ZmR5izUnobK9xrlz/xk=;
        b=VlocscIlXrXwXXtxerX9ivwj6pk4yDu67JX91ydwnNcYn7miZhFGFsXyV0K8UKur0V
         XOqQTS/jcKTiOUA0ZPXkLBRojLu/eHVzve0KE/h7mWRce83xjng2XUreMGB5FmvbKBQv
         zXKU/P2HhuXZ/lrsR2sDBaK4Ob6D6poOJfk6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THwh6PEFB0S8Bkrg5GfNlp+3ZmR5izUnobK9xrlz/xk=;
        b=KAlcRrlzxdVc47GNwEutQsyyUfcSUhixh7ks16zhT7gTfm1nNZE/bheT5pfHfZFFCR
         lJA8Dxb+lmXsnvfUL/Ki10nKtXNdPF+ZmFCHwWCgur5OePkIyqxU7mFAnq2QQWT7k7XH
         9rgot3TRsAhvsoL1hVA6rXCPBsQkP1C008oD5cQHGHDs8hQIMRd6XRzwcuh+Lseq8TuN
         yVfr3z+qVB5ykwEC2Z04fEVJ5oS+LhWRj3vYaDisaQF9fGCpU35YYqQdtOu0yVCUy4hi
         cGz+LUqG+jyo4jxEleaKjRMNKjRzPePThxLlUB4Lwx+BzWab9bzn8R5imoTR8GbBb5HQ
         PZeQ==
X-Gm-Message-State: APjAAAU/Uo+7EA3PXrkIN+MQr9zvCZOSmYRkxv3AaFmoJF/2OzIo5gfH
        WLcJkq0tB3tPV1Kcr6qr5E4zLVUGxbqXyg==
X-Google-Smtp-Source: APXvYqx6oWHNuTxCzsF/rApg13L9JJVVUStzvxw3D/47tNMLA6KGin8oUAQfsg/f3HlBraFLbNyZ7A==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr6377313wru.195.1559810667227;
        Thu, 06 Jun 2019 01:44:27 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id q9sm1281432wmq.9.2019.06.06.01.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:44:26 -0700 (PDT)
Date:   Thu, 6 Jun 2019 10:44:21 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     torvalds@linux-foundation.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] Documentation/atomic_t.txt: Clarify pure
 non-rmw usage
Message-ID: <20190606084421.GA5523@andrea>
References: <20190524115231.GN2623@hirez.programming.kicks-ass.net>
 <tip-fff9b6c7d26943a8eb32b58364b7ec6b9369746a@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-fff9b6c7d26943a8eb32b58364b7ec6b9369746a@git.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:46:54AM -0700, tip-bot for Peter Zijlstra wrote:
> Commit-ID:  fff9b6c7d26943a8eb32b58364b7ec6b9369746a
> Gitweb:     https://git.kernel.org/tip/fff9b6c7d26943a8eb32b58364b7ec6b9369746a
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Fri, 24 May 2019 13:52:31 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 3 Jun 2019 12:32:57 +0200
> 
> Documentation/atomic_t.txt: Clarify pure non-rmw usage
> 
> Clarify that pure non-RMW usage of atomic_t is pointless, there is
> nothing 'magical' about atomic_set() / atomic_read().
> 
> This is something that seems to confuse people, because I happen upon it
> semi-regularly.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20190524115231.GN2623@hirez.programming.kicks-ass.net
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

I'd appreciate if you could Cc: me in future changes to this doc.
(as currently suggested by get_maintainer.pl).

This is particularly annoying when you spend time to review such
changes:

  https://lkml.kernel.org/r/20190528111558.GA9106@andrea

Thanks,
  Andrea


> ---
>  Documentation/atomic_t.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index dca3fb0554db..89eae7f6b360 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -81,9 +81,11 @@ Non-RMW ops:
>  
>  The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
>  implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
> -smp_store_release() respectively.
> +smp_store_release() respectively. Therefore, if you find yourself only using
> +the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
> +and are doing it wrong.
>  
> -The one detail to this is that atomic_set{}() should be observable to the RMW
> +A subtle detail of atomic_set{}() is that it should be observable to the RMW
>  ops. That is:
>  
>    C atomic-set
