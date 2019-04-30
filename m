Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B489EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E11E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNvxekfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfD3Jhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:37:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38642 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3Jhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:37:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so4958085edl.5;
        Tue, 30 Apr 2019 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=drPZ7KoEDZSmxCF+WsAn2EdRoQpZ9ONUXMxh/61qnOY=;
        b=aNvxekfqNqjBjZximPsvLr2kRZDfj/FaSXo2W0BuDi4PI/n49Kro/yAVpAiSkjA/FZ
         A9a+2mgS4KR9OzuZ4iXOvlxEo6SIj6bzEhvj/D5/H7k5vHAVzl1xhrf4Q19MKJWUDLLJ
         5zeQXrWaF+EriPjmiSI+gUwvpmVyLTyvaeM82WVoxD8gcxFHZIhwLXjnHKvynrYddBmk
         B/K0BAM5Ab38A8OJxcjoRVnLjmgJ693xcuH0pV5M7o6n7AScB2Koq6b7gpwCczJ6rAWF
         LLJAJop8kY82YlMTv+xkXrl2tlnqBT2iWYl7Y5s/pNF3OoF8wnPZITJMgfAD+cml01Wb
         nOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=drPZ7KoEDZSmxCF+WsAn2EdRoQpZ9ONUXMxh/61qnOY=;
        b=OOv4RKndLkrFvJpe6Kc9v7bklElA8x5EmNW1C6xuduN9cWlmYETCmgq9zlKvP9gKMV
         kpSAqGWLKhVTGtQoMWPkr1E80qxbTOehz/8Od9+t4fTdgNC0L9OAWqLY1cfHcoLnaiyL
         8jo5FEN1FNgO9j8ZDOay/mbqdjORWVuKpnXvdiTR0Ra0ZxfnV5fd2i1ZWmMz6RTXjo4Q
         Y+lh5/MkYoc4moxTs7LkpXMeNFY7ciYEGZpsF0JbGoo3pD3JSIy7TeUpzzefM7+ogf8N
         /48N1Wq2hUjXRLKmCOvBomYibIp2EdRXxiRnW/c2gh4u3UoPmTXn/QI28KavSeCAFFqw
         hS2Q==
X-Gm-Message-State: APjAAAU4ckIAlXOUqWvEnmTjELmHZq2olPG1mKMQMtzxHSbk78lqLe4+
        YP4pT2qL3uQuq+7e1FPP/oc=
X-Google-Smtp-Source: APXvYqzCLE+57MgejEVLrV4lXRIfrhIdN91f5tmUH6A98tC/stesp++PZAFiDzr4K2t7wXcpwZKXlw==
X-Received: by 2002:a17:906:3e91:: with SMTP id a17mr33572986ejj.73.1556617071923;
        Tue, 30 Apr 2019 02:37:51 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id o62sm8745742eda.42.2019.04.30.02.37.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Apr 2019 02:37:50 -0700 (PDT)
Date:   Tue, 30 Apr 2019 02:37:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] of: replace be32_to_cpu to be32_to_cpup
Message-ID: <20190430093749.GA29126@archlinux-i9>
References: <20190430090044.16345-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430090044.16345-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Nick and the list

On Tue, Apr 30, 2019 at 04:00:44PM +0700, Phong Tran wrote:
> The cell is a pointer to __be32.
> with the be32_to_cpu a lot of clang warning show that:
> 
> ./include/linux/of.h:238:37: warning: multiple unsequenced modifications
> to 'cell' [-Wunsequenced]
>                 r = (r << 32) | be32_to_cpu(*(cell++));
>                                                   ^~
> ./include/linux/byteorder/generic.h:95:21: note: expanded from macro
> 'be32_to_cpu'
>                     ^
> ./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
> from macro '__be32_to_cpu'
>                                                           ^
> ./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
>         ___constant_swab32(x) :                 \
>                            ^
> ./include/uapi/linux/swab.h:18:12: note: expanded from macro
> '___constant_swab32'
>         (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
>                   ^
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  include/linux/of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e240992e5cb6..1c35fc8f19b0 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -235,7 +235,7 @@ static inline u64 of_read_number(const __be32 *cell, int size)
>  {
>  	u64 r = 0;
>  	while (size--)
> -		r = (r << 32) | be32_to_cpu(*(cell++));
> +		r = (r << 32) | be32_to_cpup(cell++);
>  	return r;
>  }
>  
> -- 
> 2.21.0
> 

While the patch does remove the warning, I am not convinced that this
isn't a clang bug based on my brief analysis here:

https://github.com/ClangBuiltLinux/linux/issues/460#issuecomment-487808008

However, I'm waiting for people smarter than I am to comment on whether
that sounds correct or not.

I am not familiar with the various different big/little endian functions
enough to review this but thank you for the patch!

Nathan
