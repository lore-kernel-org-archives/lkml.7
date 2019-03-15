Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92016C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C058218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvLDJeUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfCOQHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:07:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37426 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfCOQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:07:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so10159573wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZZuhlq6MQnsqxQA6cT5CILW35WErS0GJwl1jyOW5oTU=;
        b=VvLDJeUPjEWcehsDKfhyGcNtduiLdxzn261rjS8+qGjwpCgYv4zTxYVbgcIjrdoTL+
         RLIbnuhbq/Tgx9OXW3iW8hAJOiCTvArD//cw5hIwWyGGCxkwbYP8AKwsJ36HdnG9NAvt
         XtlIELyllqTnywIXlY6CZKjc+VE+xzwEJoR7fHDNNny8znWBjPFUruhjy+Fho6LrZYJ6
         dndLQyZUgtgRf6WB8+eJVcVb9j0d9Y/ZsLibpxywiAko2k9ZO5y1m6A4PcEBYsLxDPBh
         Fy6xBDFms2Q/zxnd2oJLcrVL5LWxaxWsS8rJie/mHy6hMGvBD7CfTvyWyTm2Fj/fqEeH
         q7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZZuhlq6MQnsqxQA6cT5CILW35WErS0GJwl1jyOW5oTU=;
        b=UraifpMG4I4n81orlA62JuRJ7ryO4FV88DS30MiAjPE2Br1yN9rSha+tJSxRQlbRBY
         2+Hbvjz/paEsTeEUpU+tXwRQzV4QASQQjyjwIwTyPtVfIaqMBACljdVptpd5cINBmwNc
         vIfu+DgSMQpThTbTgsCkdjBMhGMuJdyq9VikDL7k2bv/m3mh+3OzpedNfrzCqqSRl5IJ
         eyZKACLhd5nMVMv0dP1uykLl45BWcB0x7U+g25IUSWNSp4n8hI8tD0HiDDxrKp4wbXRC
         sJ4WFK7Ew6UJYv7FwI7ouANOfgZcQB9JfE9ei7dgUGhZ/BoNlQ6XPxeHx4Opsz8Pbqb3
         d4xw==
X-Gm-Message-State: APjAAAUF8iHDKGId6CvpG9kZtWecmvfZk3iI97ogXDGJC2XfEBCh4Fda
        S2RSE6+aSa5MiyD4h02N4AHGPVQ=
X-Google-Smtp-Source: APXvYqwUbZ4FT6l14PSyeFURK25aWZ13Kxh70yixU5KTegCUqKcRkjjcee2jXILOrdFZklPTdENPYw==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr2252839wrq.266.1552666019203;
        Fri, 15 Mar 2019 09:06:59 -0700 (PDT)
Received: from avx2 ([46.53.240.56])
        by smtp.gmail.com with ESMTPSA id z12sm2387906wrt.10.2019.03.15.09.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:06:58 -0700 (PDT)
Date:   Fri, 15 Mar 2019 19:06:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] elf: print userspace address with %lx
Message-ID: <20190315160656.GB2135@avx2>
References: <20190314204548.GB18143@avx2>
 <20190315065327.GA15672@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190315065327.GA15672@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 07:53:27AM +0100, Michal Hocko wrote:
> On Thu 14-03-19 23:45:48, Alexey Dobriyan wrote:
> > Use %lx, save a cast.
> > 
> > "addr" is userspace address so using (and mangling) pointer was never
> > necessary.
> 
> There shouldn't be any mangling AFAIU. Documentation for pointer()
> says
> 
>  * - 'x' For printing the address. Equivalent to "%lx".

The implication of using %p/%px is that the address is kernel pointer
which should or should not be mangled. But "map_addr" is not a kernel
pointer. And it saves a cast.

> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -376,8 +376,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  		map_addr = vm_mmap(filep, addr, size, prot, type, off);
> >  
> >  	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
> > -		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> > -			task_pid_nr(current), current->comm, (void *)addr);
> > +		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
> > +			task_pid_nr(current), current->comm, addr);
