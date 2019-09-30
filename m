Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E38BC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ED621906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sruffell-net.20150623.gappssmtp.com header.i=@sruffell-net.20150623.gappssmtp.com header.b="QHTB/WUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfI3VU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:20:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46512 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732463AbfI3VUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:20:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id 201so4043777ywn.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sruffell-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t1DMptwtSjTyh908HFMMNc4K8kCY1DcChDdU+qVTdeg=;
        b=QHTB/WUVNv8RQbJmI/eGoXC6Eleaoq8x2acVasDl4TdliJL6lH7eYhOu9b83Gf//bd
         QYUdub0nQ3jHQiSJl82YiJsxWw6NKrz6FnZIBu2jKNMlw+s/rt4P8JyWtFje6r0IeV8o
         wkyAyXYG+2kK8dmssjIt+g1aSz/IJe749xgFuwHHNNMTycZ1aX1NrXhaeygqXNucqKVY
         mBoPtcwDLFNjr1RdWxswfNdt3uikz7ixGeSgDy/DrAPKJmsbpLzrSszY5Q7CD/4PlbGz
         yWx7dVWLcFTNzsN3Jal/wZWgA0ArSuTs+W5kfWOgqLgj/5V1u8hR2dYp81iPiefSaWzT
         TGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t1DMptwtSjTyh908HFMMNc4K8kCY1DcChDdU+qVTdeg=;
        b=ktEWydljaLLBKJfxu/EgxP4e+wGgskrH/C+OctTeZ3lnbIfJ96ExWynfCTb2OhErZq
         SW9LYh305b9zXyPAFqAexyB9ApDSw9MUSePc4yLsuy2meHPn2o/r5YGf3trpXDIrJlHd
         Qp3J41yt3OSv9CXKi5334CVZjNHH9iSRTXOTvqgzAZnzIORAMD1+XNJEO2joUWkeEipQ
         uJKU0r9GwlnpmUYbKDwS4CSu2PSC5xK9koHfGCj6dLXwWjh/kmXTa0vfPoJZxCiy+pv3
         RZuDbcnVjy5uc5CXy6ymPnM2tY6rdg3loPBYCcHKOpVgpVL8cm2c6J0hh40CZZGHnjJT
         x9bQ==
X-Gm-Message-State: APjAAAXZoVFLQxGu1V6Y5mZij4v8MpjMJdR1KWwwWWpH7aA+T/fTu/yW
        hKQXhRzzCcAzYjYz7VzufaFJ
X-Google-Smtp-Source: APXvYqz2yeYPBDeFDLFFSJ/4R+hzebzTIS+7MBHjeyBLrxVZO3PGBN0WsO+B5fo7VQDcSGLuqRXD1g==
X-Received: by 2002:a81:9182:: with SMTP id i124mr14557184ywg.279.1569878452988;
        Mon, 30 Sep 2019 14:20:52 -0700 (PDT)
Received: from sruffell.net ([136.53.91.217])
        by smtp.gmail.com with ESMTPSA id v143sm3017803ywa.57.2019.09.30.14.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 14:20:52 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:20:46 -0500
From:   Shaun Ruffell <sruffell@sruffell.net>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] modpost: Copy namespace string into 'struct symbol'
Message-ID: <20190930212046.rhtqmnueoffe7dnr@sruffell.net>
References: <20190906103235.197072-5-maennich@google.com>
 <20190926222446.30510-1-sruffell@sruffell.net>
 <20190927080346.GC90796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927080346.GC90796@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 09:03:46AM +0100, Matthias Maennich wrote:
> On Thu, Sep 26, 2019 at 05:24:46PM -0500, Shaun Ruffell wrote:
> > When building an out-of-tree module I was receiving many warnings from
> > modpost like:
> > 
> >  WARNING: module dahdi_vpmadt032_loader uses symbol __kmalloc from namespace ts/dahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> >  WARNING: module dahdi_vpmadt032_loader uses symbol vpmadtreg_register from namespace linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> >  WARNING: module dahdi_vpmadt032_loader uses symbol param_ops_int from namespace ahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> >  WARNING: module dahdi_vpmadt032_loader uses symbol __init_waitqueue_head from namespace ux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> >  ...
> > 
> > The fundamental issue appears to be that read_dump() is passing a
> > pointer to a statically allocated buffer for the namespace which is
> > reused as the file is parsed.
> 
> Hi Shaun,
> 
> Thanks for working on this. I think you are right about the root cause
> of this. I will have a closer look at your fix later today.

Thanks Matthias.

> > @@ -672,7 +696,6 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
> > 	unsigned int crc;
> > 	enum export export;
> > 	bool is_crc = false;
> > -	const char *name, *namespace;
> > 
> > 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
> > 	    strstarts(symname, "__ksymtab"))
> > @@ -744,9 +767,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
> > 	default:
> > 		/* All exported symbols */
> > 		if (strstarts(symname, "__ksymtab_")) {
> > +			const char *name, *namespace;
> > +
> > 			name = symname + strlen("__ksymtab_");
> > 			namespace = sym_extract_namespace(&name);
> > 			sym_add_exported(name, namespace, mod, export);
> > +			if (namespace)
> > +				free((char *)name);
> 
> This probably should free namespace instead.

Given the implementation of sym_extract_namespace below, I believe
free((char *)name) is correct.

  static const char *sym_extract_namespace(const char **symname)
  {
  	size_t n;
  	char *dupsymname;
  
  	n = strcspn(*symname, ".");
  	if (n < strlen(*symname) - 1) {
  		dupsymname = NOFAIL(strdup(*symname));
  		dupsymname[n] = '\0';
  		*symname = dupsymname;
  		return dupsymname + n + 1;
  	}
  
  	return NULL;
  }

I agree that freeing name instead of namespace is a little surprising
unless you know the implementation of sym_extract_namespace.

I thought about changing the the signature of sym_extract_namespace() to
make it clear when the symname is used to return a new allocation or
not, and given your comment, perhaps I should have.
