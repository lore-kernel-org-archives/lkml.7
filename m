Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A0A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sruffell-net.20150623.gappssmtp.com header.i=@sruffell-net.20150623.gappssmtp.com header.b="f6BL1mz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfJAThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:37:14 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40466 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfJAThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:37:13 -0400
Received: by mail-yw1-f65.google.com with SMTP id e205so5251320ywc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sruffell-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=foVLqaSKdSg7KmJBN5U8BgO8IzOWWXDLHAODqmx68uA=;
        b=f6BL1mz0QqZj0+WznWUS9I25oBoxdz9Cf3bRimTBX4VM32Ye4yoO64y2aAy2cUvIpw
         80ooiSnOAFSVDmVKYcvk/WAla/naO3RqjHpdxg7HXoQnS4yq2eA9AA0uSVPlw22VLaWU
         9hCOGeGlm/mAZYZ+zFQ1e8R4q2M8Xq2qDopwUIskeiK4sydFl6kYhEUyIQDVdopg52Hi
         iEmj2262XPoAIDDCTjzhhfFFuaE63a8h1HLVVFT+pyFDxTt3REuz+lM5ZdkndZGYD6bl
         TnlnvRiTnEK/gmzzx37r1whlD6AzCkvUW3bJfjvBjfktpKwNzh1OOgwOXZY/XzBidAgO
         bdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foVLqaSKdSg7KmJBN5U8BgO8IzOWWXDLHAODqmx68uA=;
        b=P2TMHV5MVNZzyuQWrEjEFHDPSb+16swNt/K8IOMfBeBRnevv/Rw4Kc7HQXxEncSmSx
         O7TctlskmgID6ELwdneh+D0WdXaifYjNrxklcuazTZNGqOU+37AOUohfq3+x/5bq7lkf
         pga+BWsP0mMrZwoGEofeYf+vb68LyRhaVG0pRKoMAv1ag85NFy0fVb55o9k9CndhyRfv
         YJ1j++22TQdWmqYzqskzUruW+oyQRl9GVfcXTF/CGbK8dOKkJURhDI4Hg3edpU6pW6Ql
         H43NYzMO8D1F+tsZrU/UbPP2TvY7wMp5g2HGYIMU+rU4DiVsksSMqLTzjDbfEVBW9qUi
         IaAA==
X-Gm-Message-State: APjAAAXCr3LngIUR/1tZ6rybuLxB/1I4geHCWTsYqSfq4QhWFmJKl4Tc
        FcRlMGmWMLHynP875XGKc5sr
X-Google-Smtp-Source: APXvYqxVDSWTsEqdYFLLjwLmGzfkNYXsoRCzlp7MyqHhmyzZeS1l5DvbS4oh7nHfLLFPJnA+lp4Mcg==
X-Received: by 2002:a81:a24f:: with SMTP id z15mr22776ywg.55.1569958632192;
        Tue, 01 Oct 2019 12:37:12 -0700 (PDT)
Received: from sruffell.net ([136.53.91.217])
        by smtp.gmail.com with ESMTPSA id g128sm3696526ywb.13.2019.10.01.12.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 12:37:11 -0700 (PDT)
Date:   Tue, 1 Oct 2019 14:37:04 -0500
From:   Shaun Ruffell <sruffell@sruffell.net>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] modpost: Copy namespace string into 'struct symbol'
Message-ID: <20191001193704.txidwxf3h4te4rtr@sruffell.net>
References: <20190906103235.197072-5-maennich@google.com>
 <20190926222446.30510-1-sruffell@sruffell.net>
 <20190927080346.GC90796@google.com>
 <20190930212046.rhtqmnueoffe7dnr@sruffell.net>
 <20191001161923.GH90796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001161923.GH90796@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:19:23PM +0100, Matthias Maennich wrote:
> On Mon, Sep 30, 2019 at 04:20:46PM -0500, Shaun Ruffell wrote:
> > On Fri, Sep 27, 2019 at 09:03:46AM +0100, Matthias Maennich wrote:
> > > On Thu, Sep 26, 2019 at 05:24:46PM -0500, Shaun Ruffell wrote:
> > > > When building an out-of-tree module I was receiving many warnings from
> > > > modpost like:
> > > >
> > > >  WARNING: module dahdi_vpmadt032_loader uses symbol __kmalloc from namespace ts/dahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> > > >  WARNING: module dahdi_vpmadt032_loader uses symbol vpmadtreg_register from namespace linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> > > >  WARNING: module dahdi_vpmadt032_loader uses symbol param_ops_int from namespace ahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> > > >  WARNING: module dahdi_vpmadt032_loader uses symbol __init_waitqueue_head from namespace ux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
> > > >  ...
> > > >
> > > > The fundamental issue appears to be that read_dump() is passing a
> > > > pointer to a statically allocated buffer for the namespace which is
> > > > reused as the file is parsed.
> > > 
> > > Hi Shaun,
> > > 
> > > Thanks for working on this. I think you are right about the root cause
> > > of this. I will have a closer look at your fix later today.
> > 
> > Thanks Matthias.
> 
> In the meantime, Masahiro came up with an alternative approach to
> address this problem:
> https://lore.kernel.org/lkml/20190927093603.9140-2-yamada.masahiro@socionext.com/
> How do you think about it? It ignores the memory allocation problem that
> you addressed as modpost is a host tool after all. As part of the patch
> series, an alternative format for the namespace ksymtab entry is
> suggested that also changes the way modpost has to deal with it.

Masahiro's patch set looks good to me.

My only comment would be that I felt it preferable for
sym_add_exported() to treat the two string arguments passed to it the
same way. I feel the way it is currently violates the princple of least
surprise. However I accept this is just my personal opinion.

> > > > @@ -672,7 +696,6 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
> > > > 	unsigned int crc;
> > > > 	enum export export;
> > > > 	bool is_crc = false;
> > > > -	const char *name, *namespace;
> > > >
> > > > 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
> > > > 	    strstarts(symname, "__ksymtab"))
> > > > @@ -744,9 +767,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
> > > > 	default:
> > > > 		/* All exported symbols */
> > > > 		if (strstarts(symname, "__ksymtab_")) {
> > > > +			const char *name, *namespace;
> > > > +
> > > > 			name = symname + strlen("__ksymtab_");
> > > > 			namespace = sym_extract_namespace(&name);
> > > > 			sym_add_exported(name, namespace, mod, export);
> > > > +			if (namespace)
> > > > +				free((char *)name);
> > > 
> > > This probably should free namespace instead.
> > 
> > Given the implementation of sym_extract_namespace below, I believe
> > free((char *)name) is correct.
> 
> Yeah, you are right. I was just noticing the inconsistency and thought
> it was obviously wrong. So, I was wrong. Sorry and thanks for the
> explanation.
> 
> > 
> >  static const char *sym_extract_namespace(const char **symname)
> >  {
> >  	size_t n;
> >  	char *dupsymname;
> > 
> >  	n = strcspn(*symname, ".");
> >  	if (n < strlen(*symname) - 1) {
> >  		dupsymname = NOFAIL(strdup(*symname));
> >  		dupsymname[n] = '\0';
> >  		*symname = dupsymname;
> >  		return dupsymname + n + 1;
> >  	}
> > 
> >  	return NULL;
> >  }
> > 
> > I agree that freeing name instead of namespace is a little surprising
> > unless you know the implementation of sym_extract_namespace.
> > 
> > I thought about changing the the signature of sym_extract_namespace() to
> > make it clear when the symname is used to return a new allocation or
> > not, and given your comment, perhaps I should have.
> 
> I would rather follow-up with Masahiro's approach for now. What do you
> think?

I agree that following-up with Masahiro's patch set is the better
option.

Cheers,
Shaun
