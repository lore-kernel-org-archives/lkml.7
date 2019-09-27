Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF73C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF1921850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLQf3+58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfI0Lqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:46:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41404 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfI0Lqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:46:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so2368172wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mo7w1y+kTxQvAhwo3KNKSDDsQrA2Q4cN6VWd/Y+DTgg=;
        b=eLQf3+58GleOYNxjl36MGqUEZ9Mz97JQrIZ0wcBlZySF37+bB4SXVYkO9JeCO1ZdTu
         WpsxmTCLhiUx4a56NRkegqpijByiDrYtr5E10yx2AOL7moE7RRGoOcO/9MS0Dp25qLan
         UUyTEYT/atpvCbBcG1zBLdqANesE2OhVPr/MqHZmL3SVT9ZMhl7yt7vTZf/LMSDjyaKw
         QcjK+R8UJevHyp+Bqp5bJtCu4ERVMKT3/8cqBqSNgvRSSyOU9oHQ+Cx6jWzzis82lj02
         CdP8Eof5378ZxsQGgWIkEwPOghh8v9imHLXt5JOudD1vUrC9XwW/9k1t+wG0ZSpEQMnW
         tRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mo7w1y+kTxQvAhwo3KNKSDDsQrA2Q4cN6VWd/Y+DTgg=;
        b=g9BdshwrexbbYFLjx0sAbRSa6rwXOoTxplbrTUowLn1OA98yYcWZ8rYQJAhollgwb8
         UGPaWJR9tpvT6H5vrWjnP7DhjNKQb5c5k0f9IK0WtvIiDt0H8704fcI2JgneVOfPtQC0
         Z2+AtbRp8FNuU2lLtogpKHcAedJZUYdHGJk34Calomfe6Fpwe8yviE02m0VDs2INsR3E
         Hr2jTKho1z9M5AAxTccaSRalda3apkeAMH3fPcKFDDae1fXaYhCeWyrNVIXoWMFcN3oK
         SU6az0j40uSBZsrRb7ffaYM+QWgoenwTfH3yfn3NpOa9B/8PVoahwi/1lUY0V8FeD9iU
         ofmQ==
X-Gm-Message-State: APjAAAVG+jzXKDVCFNhW2kS9/mS1S+zbuc/aiaH21a4AzeuHsHWGKMA6
        ehPiBO+/3fS40sYx+/bHciFO7w==
X-Google-Smtp-Source: APXvYqwy1DGFKXlpnTExzTNGWK+e0W8dkUR8pVsDsBen4nsykmIsm2BuGoNRS6tDQ3AE19WsHhG5yA==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr2701094wru.92.1569584809858;
        Fri, 27 Sep 2019 04:46:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id o19sm6262169wmh.27.2019.09.27.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 04:46:49 -0700 (PDT)
Date:   Fri, 27 Sep 2019 12:46:46 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shaun Ruffell <sruffell@sruffell.net>
Subject: Re: [PATCH 1/7] modpost: fix broken sym->namespace for external
 module builds
Message-ID: <20190927114646.GA259443@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-2-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927093603.9140-2-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:35:57PM +0900, Masahiro Yamada wrote:
>Currently, external module builds produce tons of false-positives:
>
>  WARNING: module <mod> uses symbol <sym> from namespace <ns>, but does not import it.
>
>Here, the <ns> part shows a random string.
>
>When you build external modules, the symbol info of vmlinux and
>in-kernel modules are read from $(objtree)/Module.symvers, but
>read_dump() is buggy in multiple ways:
>
>[1] When the modpost is run for vmlinux and in-kernel modules,
>sym_extract_namespace() correctly allocates memory for the namespace.
>On the other hand, read_dump() does not, then sym->namespace will
>point to somewhere in the line buffer of get_next_line(). The data
>in the buffer will be replaced soon, and sym->namespace will end up
>with pointing to unrelated data. As a result, check_exports() will
>show random strings in the warning messages.
>
>[2] When there is no namespace, sym_extract_namespace() returns NULL.
>On the other hand, read_dump() sets namespace to an empty string "".
>(but, it will be later replaced with unrelated data due to bug [1].)
>The check_exports() shows a warning unless exp->namespace is NULL,
>so every symbol read from read_dump() emits the warning, which is
>mostly false positive.
>
>To address [1], I added NOFAIL(strdup(...)) to allocate memory.
>For [2], I changed the if-conditional in check_exports().


Thanks for addressing this. Greg had reported this earlier this week and
Shaun was proposing a fix earlier today. Shaun's fix also ensures that
memory is released when updating the namespace. But judging from the
code around 'symbolhash' it seems that leaking this is accepted for
modpost. Not sure about that. Having said that, please feel free to add

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> scripts/mod/modpost.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index 3961941e8e7a..5c628a7d80f7 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -2195,7 +2195,7 @@ static int check_exports(struct module *mod)
> 		else
> 			basename = mod->name;
>
>-		if (exp->namespace) {
>+		if (exp->namespace && exp->namespace[0]) {
> 			add_namespace(&mod->required_namespaces,
> 				      exp->namespace);
>
>@@ -2453,7 +2453,7 @@ static void read_dump(const char *fname, unsigned int kernel)
> 			mod = new_module(modname);
> 			mod->skip = 1;
> 		}
>-		s = sym_add_exported(symname, namespace, mod,
>+		s = sym_add_exported(symname, NOFAIL(strdup(namespace)), mod,
> 				     export_no(export));
> 		s->kernel    = kernel;
> 		s->preloaded = 1;
>-- 
>2.17.1
>
