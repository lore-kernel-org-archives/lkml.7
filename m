Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F94C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF02173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfGRPUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:20:50 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:50776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbfGRPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:20:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7ACC7613C;
        Thu, 18 Jul 2019 15:20:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bead63_23f9ecf6bca52
X-Filterd-Recvd-Size: 3930
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jul 2019 15:20:47 +0000 (UTC)
Message-ID: <cedfd2fb31d943564e19c1652bc8983a18de45d4.camel@perches.com>
Subject: Re: [PATCH] reiserfs: fix code unwinding with clang
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 18 Jul 2019 08:20:45 -0700
In-Reply-To: <20190718134928.2472465-1-arnd@arndb.de>
References: <20190718134928.2472465-1-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 15:49 +0200, Arnd Bergmann wrote:
> Building reiserfs with clang leads to objtool warnings about a part of the
> unreachable code that may confuse the ORC unwinder:
> 
> fs/reiserfs/ibalance.o: warning: objtool: balance_internal()+0xe8f: stack state mismatch: cfa1=7+240 cfa2=7+248
> fs/reiserfs/ibalance.o: warning: objtool: internal_move_pointers_items()+0x36f: stack state mismatch: cfa1=7+152 cfa2=7+144
> fs/reiserfs/lbalance.o: warning: objtool: leaf_cut_from_buffer()+0x58b: stack state mismatch: cfa1=7+128 cfa2=7+112
> fs/reiserfs/lbalance.o: warning: objtool: leaf_copy_boundary_item()+0x7a9: stack state mismatch: cfa1=7+104 cfa2=7+96
> fs/reiserfs/lbalance.o: warning: objtool: leaf_copy_items_entirely()+0x3d2: stack state mismatch: cfa1=7+120 cfa2=7+128
> fs/reiserfs/do_balan.o: warning: objtool: replace_key()+0x158: stack state mismatch: cfa1=7+40 cfa2=7+56
> fs/reiserfs/do_balan.o: warning: objtool: balance_leaf()+0x2791: stack state mismatch: cfa1=7+176 cfa2=7+192
> 
> Reword this to use the regular BUG() call directly from the original code
> location, since objtool finds the generated object code more reasonable.
> 
> This will likely get fixed in a future clang release, but in the meantime
> the workaround helps us build cleanly with existing releases.

The original code read better.

This is kinda a gross solution that should probably be
commented on in the code rather than just the commit message.

> diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
[]
> @@ -387,7 +387,6 @@ void __reiserfs_panic(struct super_block *sb, const char *id,
>  	else
>  		printk(KERN_WARNING "REISERFS panic: %s%s%s: %s\n",
>  		      id ? id : "", id ? " " : "", function, error_buf);
> -	BUG();
>  }
>  
>  void __reiserfs_error(struct super_block *sb, const char *id,
> @@ -397,8 +396,10 @@ void __reiserfs_error(struct super_block *sb, const char *id,
>  
>  	BUG_ON(sb == NULL);
>  
> -	if (reiserfs_error_panic(sb))
> +	if (reiserfs_error_panic(sb)) {
>  		__reiserfs_panic(sb, id, function, error_buf);
> +		BUG();
> +	}
>  
>  	if (id && id[0])
>  		printk(KERN_CRIT "REISERFS error (device %s): %s %s: %s\n",
> diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
> index e5ca9ed79e54..f5bd17ee21f6 100644
> --- a/fs/reiserfs/reiserfs.h
> +++ b/fs/reiserfs/reiserfs.h
> @@ -3185,10 +3185,9 @@ void unfix_nodes(struct tree_balance *);
>  
>  /* prints.c */
>  void __reiserfs_panic(struct super_block *s, const char *id,
> -		      const char *function, const char *fmt, ...)
> -    __attribute__ ((noreturn));
> +		      const char *function, const char *fmt, ...);
>  #define reiserfs_panic(s, id, fmt, args...) \
> -	__reiserfs_panic(s, id, __func__, fmt, ##args)
> +	do { __reiserfs_panic(s, id, __func__, fmt, ##args); BUG(); } while (0)
>  void __reiserfs_error(struct super_block *s, const char *id,
>  		      const char *function, const char *fmt, ...);
>  #define reiserfs_error(s, id, fmt, args...) \

