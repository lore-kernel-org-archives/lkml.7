Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A2FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8012064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aW3vk4Pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDJTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:11:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36831 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDJTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:11:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck15so1994013plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epf1jTga2sUYPnvV+HKAcd7CD5M0nQur5VWq7xl7/+A=;
        b=aW3vk4PmkKJ3+s5QstWFSvn3XokjFFLL9KywsAVWS3QHMaeAWG9LM0hVyJdGMxAzzY
         cq/ehsoE0ok+i0B+wQB7ySLnIyL58jzCWloyMQly1OB/12REciWxiykXK9eHehhFvVN7
         ljFwj8p5vMrVHLwNrtPONeNQLCWtho3BKlJsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epf1jTga2sUYPnvV+HKAcd7CD5M0nQur5VWq7xl7/+A=;
        b=NwyM8qi7fMrBpPZk7AvJgwkInGGsF2M21Syfx91tmPJlIIvnHiRXBp5lcu850E8ASv
         9mp40LpeAt4wHt/R1rhe+uHzc20szI7RJovvCIWmGELiz4fLCN+7ieYDNSGPKd1qczmw
         9FTLtQ+D4VuZzgY/flBoDdaqxpkiBI/5TLlHrntNEkhKn5htaeHkWaosJsJbkL/lVQJp
         4TDPKOlGBmEXKBd3z/OVjqSEdcfaUJE2eCZw96WrhdYKWqE6Liwv55l+G0Euj9QCHCzO
         5d/ZKru11DpdO1fxvgftuhfAyU0d2X8f8T2WshA1d3qB9K6c+XKjRZi7l5CqtFsesnnb
         Effw==
X-Gm-Message-State: APjAAAWXSVAxnBGHLCG1DDj9J0AgQQT/d3TqNZ3URodaSSlrOWojSv3H
        9I0egwTjyNXAmccU2t4olz823IB28rY=
X-Google-Smtp-Source: APXvYqwBYuhcm0WJMU3wQytbxKV/sxfR0zBawzwpendd3plns+Pqom3qYpHbuwUcy24bMOStT/QoeA==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr45880910plb.272.1554923482834;
        Wed, 10 Apr 2019 12:11:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a24sm39739987pgv.10.2019.04.10.12.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:11:21 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:11:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        keescook@chromium.org, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v2 1/3] module: Prepare for addition of new ro_after_init
 sections
Message-ID: <20190410191120.GA109588@google.com>
References: <20190410190823.109172-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410190823.109172-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:08:21PM -0400, Joel Fernandes (Google) wrote:
> For the purposes of hardening modules by adding sections to
> ro_after_init sections, prepare for addition of new ro_after_init
> entries which we do in future patches. Create a table to which new
> entries could be added later. This makes it less error prone and reduce
> code duplication.
> 
> Cc: paulmck@linux.vnet.ibm.com
> Cc: rostedt@goodmis.org
> Cc: mathieu.desnoyers@efficios.com
> Cc: rcu@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> Cc: kernel-team@android.com
> Suggested-by: keescook@chromium.org
> Reviewed-by: keescook@chromium.org
> Acked-by: rostedt@goodmis.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  kernel/module.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 524da609c884..1acddb93282a 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3300,11 +3300,27 @@ static bool blacklisted(const char *module_name)
>  }
>  core_param(module_blacklist, module_blacklist, charp, 0400);
>  
> +/*
> + * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> + * layout_sections() can put it in the right place.
> + * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> + */
> +static char *ro_after_init_sections[] = {
> +	".data..ro_after_init",
> +
> +	/*
> +	 * __jump_table structures are never modified, with the exception of
> +	 * entries that refer to code in the __init section, which are
> +	 * annotated as such at module load time.
> +	 */
> +	"__jump_table",
> +};
> +
>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
>  	struct module *mod;
>  	unsigned int ndx;
> -	int err;
> +	int err, i;
>  
>  	err = check_modinfo(info->mod, info, flags);
>  	if (err)
> @@ -3319,23 +3335,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	/* We will do a special allocation for per-cpu sections later. */
>  	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>  
> -	/*
> -	 * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> -	 * layout_sections() can put it in the right place.
> -	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> -	 */
> -	ndx = find_sec(info, ".data..ro_after_init");
> -	if (ndx)
> -		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> -	/*
> -	 * Mark the __jump_table section as ro_after_init as well: these data
> -	 * structures are never modified, with the exception of entries that
> -	 * refer to code in the __init section, which are annotated as such
> -	 * at module load time.
> -	 */
> -	ndx = find_sec(info, "__jump_table");
> -	if (ndx)
> -		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +	/* Set sh_flags for read-only after init sections */
> +	for (i = 0; ro_after_init_sections[i]; i++) {

Seems the fixup for this based on Kees suggestion of using NULL got squashed
into 2/3, so allow me to send a v3 to fix this ;-) Sorry! I am doing that
now.

The patches applied together are still code-correct thought.

thanks,

 - Joel

