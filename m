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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A48C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB2F217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1ofcE/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfI0IDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:03:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37676 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfI0IDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:03:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so1606635wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXDECIdI+5sEzaIUkCBUCMKW4ivbvbfbv+7BIMvn93U=;
        b=Z1ofcE/kKnhiFs1EHfqUgBzBhP7aONFvXUk1CaT579REfuDhrl34PTSbnIUYv/U8CE
         xF1dMcA0YEGeOpdYXQhn5w118mXhDAdea8FnsBVDaQJnxio45TSgShXgL/MOaYxCafmB
         oTzwctwO+llfcZynufRP+CPpdBgsNF0JOXDyyyV+pUEoDFZewXATbqwW6fwUhxfb9w9v
         wgb5vO4nHN1NMYeMoRsvscZ/loGaeACvFJdfmNtIQIleuzpPDs6W/c19ASsC99mIeCU/
         kp7GgjrBsoQvA3u3xrkwdgCEMGQq/9o2e//uCJzmXvABnBJzgZAHgN8CcgjJOziO2/+F
         ALYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXDECIdI+5sEzaIUkCBUCMKW4ivbvbfbv+7BIMvn93U=;
        b=dWkh0KXp2PHoY2cKQjtk2MT9Be3snvBOdPSEULj7dLtv+BOBRWKjhS3xl5MdF4whja
         hvEDsEvVY9tzvU7vCUweW8AsRY2N1ZWBi03ygVC2sQkkT0cDterRCYNfCNcWZb+YiJ6J
         UoFQoHaeKizcs96/Zar4wBOUx8QTSU0iYo+eAEHCFOr9idosnjbEmfEP8O52jZgg6woH
         DVmRDN9uBQRgAwHDhbFc/hUb37cOo5ykBhzZQeGA7IogyDh390kRuVl7LwcTsPi298wT
         fP6C8epFoJG/AWY6ppE4XMNOKHbvFqLXB4cDGSjPAF5biufxRdV3wyoltd9qnhIGun+U
         cDWQ==
X-Gm-Message-State: APjAAAXVVPuM6KSt8qHFTe9QDNyeccG4P96uZq/io8VklhjpsMrGFhFQ
        49nwMfRnaN3wT9TvyN0d0bKln1m7uOtcrzT8
X-Google-Smtp-Source: APXvYqxl6ymcCE7XvmZVPpw4C9/MDPoRjn6lHAeLgy7nzoITftR60pL2ZJ+DlZ3vV3p4PrACeQPSJA==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr1694797wrq.377.1569571430103;
        Fri, 27 Sep 2019 01:03:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id y13sm3051266wrg.8.2019.09.27.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:03:49 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:03:46 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Shaun Ruffell <sruffell@sruffell.net>
Cc:     linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] modpost: Copy namespace string into 'struct symbol'
Message-ID: <20190927080346.GC90796@google.com>
References: <20190906103235.197072-5-maennich@google.com>
 <20190926222446.30510-1-sruffell@sruffell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190926222446.30510-1-sruffell@sruffell.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:24:46PM -0500, Shaun Ruffell wrote:
>When building an out-of-tree module I was receiving many warnings from
>modpost like:
>
>  WARNING: module dahdi_vpmadt032_loader uses symbol __kmalloc from namespace ts/dahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>  WARNING: module dahdi_vpmadt032_loader uses symbol vpmadtreg_register from namespace linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>  WARNING: module dahdi_vpmadt032_loader uses symbol param_ops_int from namespace ahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>  WARNING: module dahdi_vpmadt032_loader uses symbol __init_waitqueue_head from namespace ux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>  ...
>
>The fundamental issue appears to be that read_dump() is passing a
>pointer to a statically allocated buffer for the namespace which is
>reused as the file is parsed.

Hi Shaun,

Thanks for working on this. I think you are right about the root cause
of this. I will have a closer look at your fix later today.

>This change makes it so that 'struct symbol' holds a copy of the
>namespace string in the same way that it holds a copy of the symbol
>string. Because a copy is being made, handle_modversion can now free the
>temporary copy
>
>Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
>Cc: Martijn Coenen <maco@android.com>
>Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Matthias Maennich <maennich@google.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>Signed-off-by: Shaun Ruffell <sruffell@sruffell.net>
>---
>
>Hi,
>
>I didn't test that this change works with the namespaces, or investigate why
>read_dump() is only called first while building out-of-tree modules, but it does
>seem correct to me for the symbol to own the memory backing the namespace
>string.
>
>I also realize I'm jumping the gun a bit by testing against master before
>5.4-rc1 is tagged.
>
>Shaun
>
> scripts/mod/modpost.c | 31 +++++++++++++++++++++++++++++--
> 1 file changed, 29 insertions(+), 2 deletions(-)
>
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index 3961941e8e7a..349832ead200 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -364,6 +364,24 @@ static const char *sym_extract_namespace(const char **symname)
> 	return NULL;
> }
>
>+static const char *dup_namespace(const char *namespace)
>+{
>+	if (!namespace || (namespace[0] == '\0'))
>+		return NULL;
>+	return NOFAIL(strdup(namespace));
>+}
>+
>+static bool is_equal(const char *n1, const char *n2)
>+{
>+	if (n1 && !n2)
>+		return false;
>+	if (!n1 && n2)
>+		return false;
>+	if (!n1 && !n2)
>+		return true;
>+	return strcmp(n1, n2) == 0;
>+}
>+
> /**
>  * Add an exported symbol - it may have already been added without a
>  * CRC, in this case just update the CRC
>@@ -375,7 +393,7 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
>
> 	if (!s) {
> 		s = new_symbol(name, mod, export);
>-		s->namespace = namespace;
>+		s->namespace = dup_namespace(namespace);
> 	} else {
> 		if (!s->preloaded) {
> 			warn("%s: '%s' exported twice. Previous export was in %s%s\n",
>@@ -384,6 +402,12 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
> 		} else {
> 			/* In case Module.symvers was out of date */
> 			s->module = mod;
>+
>+			/* In case the namespace was out of date */
>+			if (!is_equal(s->namespace, namespace)) {
>+				free((char *)s->namespace);
>+				s->namespace = dup_namespace(namespace);
>+			}
> 		}
> 	}
> 	s->preloaded = 0;
>@@ -672,7 +696,6 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
> 	unsigned int crc;
> 	enum export export;
> 	bool is_crc = false;
>-	const char *name, *namespace;
>
> 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
> 	    strstarts(symname, "__ksymtab"))
>@@ -744,9 +767,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
> 	default:
> 		/* All exported symbols */
> 		if (strstarts(symname, "__ksymtab_")) {
>+			const char *name, *namespace;
>+
> 			name = symname + strlen("__ksymtab_");
> 			namespace = sym_extract_namespace(&name);
> 			sym_add_exported(name, namespace, mod, export);
>+			if (namespace)
>+				free((char *)name);

This probably should free namespace instead.

> 		}
> 		if (strcmp(symname, "init_module") == 0)
> 			mod->has_init = 1;
>-- 
>2.17.1

Cheers,
Matthias
