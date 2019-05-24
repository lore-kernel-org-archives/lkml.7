Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495F221850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Er9FNhr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfEXTov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:44:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46548 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfEXTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:44:50 -0400
Received: by mail-yw1-f67.google.com with SMTP id a130so4054012ywe.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADEutigkZQvxy3EBwjlB2BuRYdbXhSOGTYdGfWJ/hgk=;
        b=Er9FNhr9eg4ELo6L0x8EYqvzpTpab9TijYy1x8WYGrzCTaffnMkdDEaiQns3/5AszK
         GJXVhg7UJVB6K+VgJqeD5xsagjhKQrAvHoEqF95pUS12aIy7Mv1NLA4crNkU0onJQ1A0
         3A0FyTgXiEWKfVMcUJYDPl7FworQ1U9CfppjrlnKnX2RiqjsivzpMegz4MVi5cg7Yq7q
         HPKjoqLbxLr46mPY3lIg0TQkLEUXbclrW/GErPV4Gb75UK2cyYlMQe6E4Oal+BP2DZq+
         hGM1MnMoeGl8pJ0XCcjtJYKO3A9qvk5JEIumsdUXP9LkmpssUtdGzUKjm0Q/psK1ORYG
         lBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADEutigkZQvxy3EBwjlB2BuRYdbXhSOGTYdGfWJ/hgk=;
        b=GFwgiumCeiSLEdYujXZM0gCAotdt8Lt7xjU4d5OodUeV6N/RQo8laonQ1VsYUJVvFN
         Ad7EqRP5OiYunHdNauAsbWPJK5F3vBnwivJB1YAXCme8AEyCaVLEyv19QJm/6IkhAi5b
         6hOGI6mPmMJYck5ibriQfGDL0/qtm23BbWWn10GAYK5s6z7zBa1y3977+vFs/iucK2C7
         j6wLG3MlFIymjhJwos/qgHkVe9J8tV8P6dXJ6IuGGxvSm1haK4+89LmfbmjbrXCO5Skc
         lhvcSZfeU8gIwTiNxj/yoduApbB5l5+pPXkyN/2evji2/50aE5dAA0FYPrVJwPXZMRCP
         IrlA==
X-Gm-Message-State: APjAAAU5sYoP0TrD1eHV7qq2+UMI3x718A1rJwqsR4MCtTAj+5wMLB3h
        V9ogKoanhvlfhyuiPiM9rHHAhyqiHz1rMEBEAwcsLg==
X-Google-Smtp-Source: APXvYqypIZdiln4PLwmtk+QLb5X4U7MRP6LQ1aIjVkWxjTJtR6cQUSay/7LPwd2gr1TnddV4dndw6kAxArlu6UCxIhU=
X-Received: by 2002:a81:a6d5:: with SMTP id d204mr17941600ywh.205.1558727089835;
 Fri, 24 May 2019 12:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190524193415.9733-1-ira.weiny@intel.com>
In-Reply-To: <20190524193415.9733-1-ira.weiny@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 May 2019 12:44:38 -0700
Message-ID: <CALvZod6skK6NxeRXjKS64+1jpF9NwbLp7DhpWueB0F6Tj4MNUw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/swap: make release_pages() and put_pages() match
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:33 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> RFC I have no idea if this is correct or not.  But looking at
> release_pages() I see a call to both __ClearPageActive() and
> __ClearPageWaiters() while in __page_cache_release() I do not.
>
> Is this a bug which needs to be fixed?  Did I miss clearing active
> somewhere else in the call chain of put_page?
>
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  mm/swap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 3a75722e68a9..9d0432baddb0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -69,6 +69,7 @@ static void __page_cache_release(struct page *page)
>                 del_page_from_lru_list(page, lruvec, page_off_lru(page));

see page_off_lru(page) above which clear active bit.

>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>         }
> +       __ClearPageActive(page);
>         __ClearPageWaiters(page);
>         mem_cgroup_uncharge(page);
>  }
> --
> 2.20.1
>
