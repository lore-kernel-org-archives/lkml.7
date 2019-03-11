Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD99A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyhZnsyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCKRKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:10:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKRKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:10:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so1503884wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzgqU2PlXs330QQdmskA3r2zVUJBgkkVKy68/kbmpZM=;
        b=eyhZnsyz6ka6Prn2IED8nli5+vlW53eGwasip71b3t2FFVJdL3aQE15FgaqBHQw5hd
         GZ5DjM2WN5QhRfsaxjIJ4MjO9Db5ly8gSFNXsi9h6Ky2Z4CzFmH0+7OT8CEw8Ss0UZyY
         hFsaagjhDA522dCsKIEFjYslhUztVmADt+DZrqcbEQG4iUsyApBlXVZZJJ+jeQXjqgI2
         v/VWaFnF4xBUmhTa1zfhGSR+guyqroAIcNWKEIzAlUvVovEyxe1r7a7AZdNDNPLrkSj2
         D6rgiR2kAnnPco4DDk72PCpthqFlLVcGH+T+Ws5fx05YLlt29Wmijnu6vmk4+ug7sgo7
         ZfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzgqU2PlXs330QQdmskA3r2zVUJBgkkVKy68/kbmpZM=;
        b=BWokydacjSMEE5NnXi0qssQm6TzLS3GZC99pJ8JOEZY9GvNlw+mhrkrUnxTf8QmWnj
         uHL3fTum+HNI4oenqRt1XKhWLm+skeuRxXNQsJkQkNK8uZeJxghgOgk0cpYOALpzRuNW
         1dPX28Ph8v1QRm27VEyib5WLo2lK15nd8C8mniD3JR9hGeLcVb3mYjSimy8o8z9aOpus
         5DyyaeYNr2pbQeo4LTk2C9ZAMsEJQhn56XzrsIdYpCsmZrKjKuDMx586KrgTcnIucZf+
         +TgchXP1aW02g1XhfUKRvm8rJRbkkt9X9cXqX/4IE8Ok24ovXnMK7HeEOAk8yu4M5+4X
         /K0Q==
X-Gm-Message-State: APjAAAUyYLCEVRRLAjmN8rZnKBqi+dRcT62xLxTo4DaAOQxmf5kZi86t
        VnD8MKvykMhsLklzES2ItARrWN4=
X-Google-Smtp-Source: APXvYqwBVSuFHBZjiIKCSHYwTbpEripNZa7A6jYYRG8mYGWDhtDek3ihBNfQxVitb6pKqUNjnJRUMQ==
X-Received: by 2002:a5d:6643:: with SMTP id f3mr709919wrw.120.1552324208947;
        Mon, 11 Mar 2019 10:10:08 -0700 (PDT)
Received: from avx2 ([46.53.240.176])
        by smtp.gmail.com with ESMTPSA id y13sm7433524wrw.31.2019.03.11.10.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:10:08 -0700 (PDT)
Date:   Mon, 11 Mar 2019 20:10:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] elf: don't be afraid of overflow
Message-ID: <20190311171006.GA2141@avx2>
References: <20190204202715.GA27482@avx2>
 <20190311110423.GC14118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311110423.GC14118@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:04:23PM +0100, Pavel Machek wrote:
> On Mon 2019-02-04 23:27:15, Alexey Dobriyan wrote:
> > Number of ELF program headers is 16-bit by spec, so total size
> > comfortably fits into "unsigned int".
> 
> If it can't overflow, gcc should know too, and optimize checks
> out... right?

Turns out it doesn't.

> > @@ -429,13 +430,9 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
> >  		goto out;
> >  
> >  	/* Sanity check the number of program headers... */
> > -	if (elf_ex->e_phnum < 1 ||
> > -		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
> > -		goto out;
> > -
> >  	/* ...and their total size. */
> 
> This is just wrong. You removed check for zero, and I'm pretty sure
> sizeof() is not 1, so this one can trigger, too.

No. ->e_phnum is 65535 max.

	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
        if (size == 0 || size > 65536 || size > ELF_MIN_ALIGN)
                goto out;
