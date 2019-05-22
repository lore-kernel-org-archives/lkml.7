Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99962C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2CA2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay7EE+Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfEVBvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:51:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46381 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfEVBvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:51:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so225184pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzHrjRS92ZANYX17XXnDROsRuQC8/NkfxYyb1LR6j7Y=;
        b=Ay7EE+LfbC4CS2hMLvVDWrxe7aWf6xecxgolLuXeb/rG0Uo1BpLuGx9rpVTPaf+AGx
         qBg/dW5r+BoH3WfVcQodRQzJD9lDOe8JjtbCJyrTaOuHx9aUihUwEEkKiZE9ECgucdxP
         UxO/dIWgo+7Uoq1jtqoCSPYcAJrmR2cDEaEDkBww1ZuaWN2eUBST7LVaQiumc3KD9a35
         m+UtUqTJQ+jeIcdJ7i/ZuuCTj6hYRhByx1uxXJEFmdtwaAnTtUu73hyoEg+aqDu7leHU
         EaHI9KN3NhUTIYNf5huUSPn6Rr+N3GGZCE4i5LCT6V/4ia4sn4Ejl7o5AVSNYczW8ur6
         ku/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzHrjRS92ZANYX17XXnDROsRuQC8/NkfxYyb1LR6j7Y=;
        b=mGEzARtusgTBcWmbnJdQ06uzZMdUIf8fVORJIzXaDQRyZs9t3cQAmGqeTrr8aizjTd
         S75V+QJ7QAcif2XPdgHw2KuJ4Fik2suIZf8nFQbsx+4Zb1qXIixTzO6z4x5YiOE5Bwm6
         MEHZFf7upmNG9dWOnjAIwoTK0QGuRaxJvaOjtulL/o5JPVbuRNwnP7cmweqQwA/mwD5i
         6yq0L0DxQwaDVcOt3uhtUw2Qt7CIrJMWV1qu5ZIWMZPhC0LUd6MIoWQhaVFqXxvdrqX4
         KUwlsBpoJUE1hsMF6w57LvIngVl6p2XKlqJBcgDWkit1w200DpQd94HPiObv/AJyBs58
         YrGw==
X-Gm-Message-State: APjAAAW7oUSbVwmnFWfpMoYMHKflKjMgGy40YXGah4EOYt7wTbbxU0os
        sLQW+3KKgoXvY+MV7PA1l0XSMdbya+s=
X-Google-Smtp-Source: APXvYqwwUP5b1+y7AnETZywLWoKux6CiWxk/ty9G4/TJs2HaWrtMUIVtxBry30vpE1dgJd2GgHu4jw==
X-Received: by 2002:a17:902:18a:: with SMTP id b10mr61413462plb.277.1558489880665;
        Tue, 21 May 2019 18:51:20 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q17sm37739216pfq.74.2019.05.21.18.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:51:20 -0700 (PDT)
Date:   Wed, 22 May 2019 09:50:55 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <20190522015055.GC4093@zhanggen-UX430UQ>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905211342.DE554F0D@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:44:33PM -0700, Kees Cook wrote:
> This doesn't look safe to me: p->uni_pgdir[n] will still have a handle
> to the freed memory, won't it?
> 
Thanks for your reply, Kees!
I think you are right. Maybe we should do this:
	kfree(p1);
	p->uni_pgdir[n] = NULL;
Is this correct?
> (And please direct these patches to Greg, as he's the current
> maintainer; I'm happy to stay CCed, of course.)
> 
I will follow your suggestions, thanks!
Gen
> -Kees
> 
> >  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
> >  	}
> >  
> 
> -- 
> Kees Cook
