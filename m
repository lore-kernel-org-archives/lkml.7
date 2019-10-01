Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FBAECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7665D21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvviHFuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbfJAQTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:19:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJAQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:19:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so16296428wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olW9g7ZJ1YdKje93pPyqYLV/2GhovO1OgxzrOxQyECE=;
        b=BvviHFuvKJ8tu5f6ZYQhFExw9xJYWYErknsa9Npz5HWq7rufaDPABP32en6lqfUEGH
         qhp9tWCEKzDVTgk3wpnp73erc9W3PPFFcRg7+XgbBNzdXv0HVQB5ZPEPu0TxKgj/rie5
         9+GICPTEeO6nuq2Y6Gjm6Un3AgbWzrgA11UFJD7j5waM171hkrn62x2xv1l0tu9Jz2eN
         jOpyGDTfK9Wo2en9rKm4XLzlTHxp5irN1vkVUIlSI4YVdYVyi2StxDYNZG8GiCuYdXUL
         3B8D8VVUNgsc3zLx9l6vQo7YD9wTB9gk37dYwjFrXjOO/cR3gJOIzp9rnGg1VfeIPtvL
         y2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olW9g7ZJ1YdKje93pPyqYLV/2GhovO1OgxzrOxQyECE=;
        b=MG1eHdwN6XV6JxN31fzhTu38rCC/S8dfhQTXsbfr6MUmvVxR7dmyklPfJRUZAkZThP
         z1y7AJDXFLV0MvpWCTH62FBXItP3H1EUR3y+Hn7lMDlaVzHOdva69eqvhFjJHx7914Pc
         8zC0M6BEv9n0IFU2VvCFTADc9KlYseOazlmIKupaVxMJjyIiAp+roPyLdtHWo3NMog4k
         Xkq6umaUZZGTCmq3/7iXkxB/HhR5AO+j1Gy1nVm8rtW/VcnVOmBPhMxEVNeOlUA86zCR
         q03DXWTpZTHMyRoNYV26t76uFtUnkTchaSrRScRipRcDa/skcCBkl1bieK1+O2sxwRu3
         AcgA==
X-Gm-Message-State: APjAAAWu+42/LXP/f83eL+8MFcyyRX+z9p1mJyzZjtUU+B0bA57G12+j
        ySqlSQ6VOjmAfIm05tVHurboj3tssT8RmA==
X-Google-Smtp-Source: APXvYqxMEx7sw497JP7p3C1ijxZVtn0IzGNXlcqhPjHzNhGlYVIGtqR4n0Oo0+KB2UYJrwDs5nc5xg==
X-Received: by 2002:adf:b3d2:: with SMTP id x18mr3891320wrd.264.1569946767617;
        Tue, 01 Oct 2019 09:19:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id e6sm14665069wrp.91.2019.10.01.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:19:26 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:19:23 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Shaun Ruffell <sruffell@sruffell.net>
Cc:     linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] modpost: Copy namespace string into 'struct symbol'
Message-ID: <20191001161923.GH90796@google.com>
References: <20190906103235.197072-5-maennich@google.com>
 <20190926222446.30510-1-sruffell@sruffell.net>
 <20190927080346.GC90796@google.com>
 <20190930212046.rhtqmnueoffe7dnr@sruffell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190930212046.rhtqmnueoffe7dnr@sruffell.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:20:46PM -0500, Shaun Ruffell wrote:
>On Fri, Sep 27, 2019 at 09:03:46AM +0100, Matthias Maennich wrote:
>> On Thu, Sep 26, 2019 at 05:24:46PM -0500, Shaun Ruffell wrote:
>> > When building an out-of-tree module I was receiving many warnings from
>> > modpost like:
>> >
>> >  WARNING: module dahdi_vpmadt032_loader uses symbol __kmalloc from namespace ts/dahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>> >  WARNING: module dahdi_vpmadt032_loader uses symbol vpmadtreg_register from namespace linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>> >  WARNING: module dahdi_vpmadt032_loader uses symbol param_ops_int from namespace ahdi-linux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>> >  WARNING: module dahdi_vpmadt032_loader uses symbol __init_waitqueue_head from namespace ux/drivers/dahdi/dahdi-version.o: ..., but does not import it.
>> >  ...
>> >
>> > The fundamental issue appears to be that read_dump() is passing a
>> > pointer to a statically allocated buffer for the namespace which is
>> > reused as the file is parsed.
>>
>> Hi Shaun,
>>
>> Thanks for working on this. I think you are right about the root cause
>> of this. I will have a closer look at your fix later today.
>
>Thanks Matthias.

In the meantime, Masahiro came up with an alternative approach to
address this problem:
https://lore.kernel.org/lkml/20190927093603.9140-2-yamada.masahiro@socionext.com/
How do you think about it? It ignores the memory allocation problem that
you addressed as modpost is a host tool after all. As part of the patch
series, an alternative format for the namespace ksymtab entry is
suggested that also changes the way modpost has to deal with it.

>> > @@ -672,7 +696,6 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
>> > 	unsigned int crc;
>> > 	enum export export;
>> > 	bool is_crc = false;
>> > -	const char *name, *namespace;
>> >
>> > 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
>> > 	    strstarts(symname, "__ksymtab"))
>> > @@ -744,9 +767,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
>> > 	default:
>> > 		/* All exported symbols */
>> > 		if (strstarts(symname, "__ksymtab_")) {
>> > +			const char *name, *namespace;
>> > +
>> > 			name = symname + strlen("__ksymtab_");
>> > 			namespace = sym_extract_namespace(&name);
>> > 			sym_add_exported(name, namespace, mod, export);
>> > +			if (namespace)
>> > +				free((char *)name);
>>
>> This probably should free namespace instead.
>
>Given the implementation of sym_extract_namespace below, I believe
>free((char *)name) is correct.

Yeah, you are right. I was just noticing the inconsistency and thought
it was obviously wrong. So, I was wrong. Sorry and thanks for the
explanation.

>
>  static const char *sym_extract_namespace(const char **symname)
>  {
>  	size_t n;
>  	char *dupsymname;
>
>  	n = strcspn(*symname, ".");
>  	if (n < strlen(*symname) - 1) {
>  		dupsymname = NOFAIL(strdup(*symname));
>  		dupsymname[n] = '\0';
>  		*symname = dupsymname;
>  		return dupsymname + n + 1;
>  	}
>
>  	return NULL;
>  }
>
>I agree that freeing name instead of namespace is a little surprising
>unless you know the implementation of sym_extract_namespace.
>
>I thought about changing the the signature of sym_extract_namespace() to
>make it clear when the symname is used to return a new allocation or
>not, and given your comment, perhaps I should have.

I would rather follow-up with Masahiro's approach for now. What do you
think?

Cheers,
Matthias

