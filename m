Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E8C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFF52082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557988834;
	bh=lDXJwF8L6Q3G9lM+UuPh8HMotl/xHXPZGZPwBCQSEQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YcVESb/HIWiJAMsz1c7QUI3MCU1BQdmNF5ebSKJyW5UQYMj2ZdjdANfvXQROx0OtO
	 ElmHKquFEil6A2Ez0MKWGV7Ug8Nq0Of2oWn9zoG0WVKjVlADb5fs9BRT6oQw1CiAUX
	 +ZsRf/ZdQleJafikzds/JZQOzpAJcvkPCdy+gr0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPGke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfEPGkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:40:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C332082E;
        Thu, 16 May 2019 06:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557988831;
        bh=lDXJwF8L6Q3G9lM+UuPh8HMotl/xHXPZGZPwBCQSEQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNIqYmstZpb+wXit7EojqiyIsSgJEunDeQWaq6Im3GG0QSpy4UF9UchyzUMGcfr75
         OoURW/fXvIvahUMSzzbIdrMDWY5orpuWEZehhqKrbrDjtBZjBy7w8XdRlpF5/Spays
         Fmtdqha8XUD4kOzSqoVZhdopv8p0dddBIdtF/elA=
Date:   Thu, 16 May 2019 08:40:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kobject: Clean up allocated memory on failure
Message-ID: <20190516064029.GA17068@kroah.com>
References: <20190516000716.24249-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516000716.24249-1-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:07:16AM +1000, Tobin C. Harding wrote:
> Currently kobject_add_varg() calls kobject_set_name_vargs() then returns
> the return value of kobject_add_internal().  kobject_set_name_vargs()
> allocates memory for the name string.  When kobject_add_varg() returns
> an error we do not know if memory was allocated or not.  If we check the
> return value of kobject_add_internal() instead of returning it directly
> we can free the allocated memory if kobject_add_internal() fails.  Doing
> this means that we now know that if kobject_add_varg() fails we do not
> have to do any clean up, this benefit goes back up the call chain
> meaning that we now do not need to do any cleanup if kobject_del()
> fails.  Moving further back (in a theoretical kobject user callchain)
> this means we now no longer need to call kobject_put() after calling
> kobject_init_and_add(), we can just call kfree() on the enclosing
> structure.  This makes the kobject API better follow the principle of
> least surprise.
> 
> Check return value of kobject_add_internal() and free previously
> allocated memory on failure.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> Hi Greg,
> 
> Pretty excited by this one, if this is correct it means that kobject
> initialisation code, in the error path, can now use either kobject_put()
> (to trigger the release method) OR kfree().  This means most of the
> call sites of kobject_init_and_add() will get fixed for free!
> 
> I've been wrong before so I'll state here that this is based on the
> assumption that kobject_init() does nothing that causes leaked memory.
> This is _not_ what the function docs in kobject.c say but it _is_ what
> the code seems to say since kobject_init() does nothing except
> initialise kobject data member values?  Or have I got the dog by the
> tail?

I think you are correct here.  In looking at the code paths, all should
be good and safe.

But, if you use your patch, then you have to call kfree, and you can not
call kobject_put(), otherwise kfree_const() will be called twice on the
same pointer, right?  So you will have to audit the kernel and change
everything again :)

Or, maybe this patch would prevent that:


diff --git a/lib/kobject.c b/lib/kobject.c
index f2ccdbac8ed9..03cdec1d450a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -387,7 +387,14 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
 		return retval;
 	}
 	kobj->parent = parent;
-	return kobject_add_internal(kobj);
+
+	retval = kobject_add_internal(kobj);
+	if (retval && !is_kernel_rodata((unsigned long)(kobj->name))) {
+		kfree_const(kobj->name);
+		kobj->name = NULL;
+	}
+
+	return retval;
 }
 
 /**


But that feels like a huge hack to me.  I think, to be safe, we should
keep the existing lifetime rules, as it mirrors what happens with
'struct device', and that is what people _should_ be using, not "raw"
kobjects if at all possible.

Yeah, I know filesystems don't do that, my fault, I never thought a
filesystem would care about sysfs all those years ago :)

thanks,

greg k-h
