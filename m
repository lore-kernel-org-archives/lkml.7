Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EFCC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08CA20684
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYedy/H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfFLSCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:02:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42800 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfFLSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:02:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so15891391lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TGyEZqVem3TEHwS4z5kwkz/UD1vaH7FY4ZFlgRPNsPc=;
        b=DYedy/H2MeX/ziKv4RNgxEi0S6NxTFXFYkyu741FLGtX7iVxx+6oZzIcnNBFu2Ye71
         cDVvYW0kcbrN0dvMf8LJED0Dkk0JwvuWJwYj450fJgO8+Q/OgbKwwtIj3i529pXZclB2
         UyC14KmtGU7sTvSoi8nArLvN3IV7VlGwrzRDHm2BUvFBg9Y3gP8xm7lAc9Zvv/5zR5Rd
         GXYGoI+aK1hdsXSs4iEr0dm3gc+6W0xmMz+D7e8DW5lhXAzvLPiGt0sXN8O9glJg4BNs
         PemyILlzELQSOLcT3muorEFb5AOxn5EK2SkerwECrH1sHxiUfLdMzKerggyqBGZRAIan
         aTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TGyEZqVem3TEHwS4z5kwkz/UD1vaH7FY4ZFlgRPNsPc=;
        b=BKpex052unI/r4zymV8UVio6NcF9baciJVTfZ4gCfWlokjitpccT1HpVai+nfJ3/jd
         UK+e6uy6REZTqRj7j2KMXLN+bdx3BDdAtUEKy3zeBY1MCb4yUfrbQ6Ke/S7YkDrS62h4
         gCC8xmPwy8AU5MVztzGKF/0I7DsrJCDL8y+3i/nyu/dVLQ25MglRSTx6Ga+gO9QqeqO1
         BrE5srJnKJvKSmZpp2AluqnnsVFz4L13nlRMIhj3yYNlvyif1GDl02GBMbV75R4+sDcc
         +wRmj0cHGFYaWF1pcFeNZ8RMDoBbWWhZrbpxwBkydTjfAtBxlN8S5RNePfxDt7wGODiZ
         DSbw==
X-Gm-Message-State: APjAAAWrc4jD93Krnsak2NSYjx2J7rns/NqvQ1kxmZ3A4ev6KZCQe3kh
        pdh611vVIFDysMoaPmcQC9yKk9ud
X-Google-Smtp-Source: APXvYqxlUkVBSYAPr4HvZbkTUk9XwAEtvl/HstLRHv/G7/ed4CIK4pz5Oot+oHDdl/jEJ4yghTPD3Q==
X-Received: by 2002:a2e:5b94:: with SMTP id m20mr35412878lje.7.1560362550740;
        Wed, 12 Jun 2019 11:02:30 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id u18sm91160ljj.32.2019.06.12.11.02.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 11:02:29 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 69C864605BC; Wed, 12 Jun 2019 21:02:29 +0300 (MSK)
Date:   Wed, 12 Jun 2019 21:02:29 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [RFC PATCH] binfmt_elf: Protect mm_struct access with mmap_sem
Message-ID: <20190612180229.GD23535@uranus.lan>
References: <20190612142811.24894-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612142811.24894-1-mkoutny@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:28:11PM +0200, Michal Koutný wrote:
> find_extend_vma assumes the caller holds mmap_sem as a reader (explained
> in expand_downwards()). The path when we are extending the stack VMA to
> accomodate argv[] pointers happens without the lock.
> 
> I was not able to cause an mm_struct corruption but
> BUG_ON(!rwsem_is_locked(&mm->mmap_sem)) in find_extend_vma could be
> triggered as
> 
>     # <bigfile xargs echo
>     xargs: echo: terminated by signal 11
> 
> (bigfile needs to have more than RLIMIT_STACK / sizeof(char *) rows)
> 
> Other accesses to mm_struct in exec path are protected by mmap_sem, so
> conservatively, protect also this one. Besides that, explain why we omit
> mm_struct.arg_lock in the exec(2) path.
> 
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
> 
> When I was attempting to reduce usage of mmap_sem I came across this
> unprotected access and increased number of its holders :-/
> 
> I'm not sure whether there is a real concurrent writer at this early
> stages (I considered khugepaged especially as setup_arg_pages invokes
> khugepaged_enter_vma_merge but we're lucky because khugepaged skips it
> because of VM_STACK_INCOMPLETE_SETUP).
> 
> A nicer approach would perhaps be to do all this exec setup when the
> mm_struct is still not exposed via current->mm (and hence no need to
> synchronize via mmap_sem). But I didn't look enough into binfmt specific
> whether it is even doable and worth it.
> 
> So I'm sending this for a discussion.
> 
>  fs/binfmt_elf.c | 10 +++++++++-
>  fs/exec.c       |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 8264b468f283..48e169760a9c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -299,7 +299,11 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  	 * Grow the stack manually; some architectures have a limit on how
>  	 * far ahead a user-space access may be in order to grow the stack.
>  	 */
> +	if (down_read_killable(&current->mm->mmap_sem))
> +		return -EINTR;
>  	vma = find_extend_vma(current->mm, bprm->p);
> +	up_read(&current->mm->mmap_sem);
> +

Good catch, Michal! Actually the loader code is heavy on its own so
I think having readlock taken here should not cause any perf problems
but worth having for consistency.

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
