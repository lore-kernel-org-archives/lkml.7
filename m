Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BFC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AF020862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 23:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557963236;
	bh=vy+VFByWZpBcZJS+x+zDXWWK4vc1948YkZDdImJfXt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RG7Njbwxh+LrctTtGUy21NNOetWciTv0493n5R3dvGOA6i7P+EOCWI4hlEtzg35ZR
	 5zHBrNOjp9yqu+XyruuWCv4+53cso25KUsP4CjnzGZZJWODee8dpohz7XxfvHfSe+i
	 VC4efn2G2rgkOGRnkynID6en9AAxccFlhG/9j7G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEOXdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 19:33:54 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36503 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfEOXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:31:54 -0400
Received: by mail-lj1-f173.google.com with SMTP id z1so1361277ljb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O821PFVQcmUzDw+ClN21Dk/2JbyQeuDOYDUBLRj/u2k=;
        b=A78Teddfh1YhL1soJd7LNhYcXrvlyqK4Kc3vdaOAMu5c8k1jOFXAvEr7XGLgepjug1
         0d2fNXS4jnwj6r8hxFpjY//Wmfhsq8p0GDy9LNbArvdhKCoefmCn5Ui4ybYNXCg5HYhz
         nSH4sgiTc0szmPt1XaFA9Zc1ScZUgfvMlc37I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O821PFVQcmUzDw+ClN21Dk/2JbyQeuDOYDUBLRj/u2k=;
        b=iM3O718ABOVFO+TAv/cIEMaM2M7ViLboC0iO9B3c6VGVbQi2OYJpM1LBinzmYh3OX+
         wXlZtdpYcoWPPnJ3MOfQVQBhcMlfZp1OPtVxfsKr1jDpMFXIDODYbdOBlrIxV43RFTN7
         nJKC1ZDrl/Rn+EhOjGBz+lRsnp1e9DINrwUnnd2GPVwLrcdgE/9S+n9f637Q//u/wpEW
         3JHGbqif4TimsYFGzZPWkIj4KTOt4cq84o5yF8TQZVz9qGOeZ0fKoD/+yjLNggAgHipt
         zN+G2dAtCMOMFTQ+nVXl1Nq+zy512Gj/vD6D0Mzro506tNg2V0jKPlt5cqoW5LIovgoG
         p1zg==
X-Gm-Message-State: APjAAAUe0AmhX3ZV5PLaWTiu1VcUuvVEj45lJVD78ApmeQ2l755toFru
        aT8ddPQUeRTHPTJU3JUJk++YPgV7rKk=
X-Google-Smtp-Source: APXvYqzEu5o2fIOiUNMgccellRbCOwxqd91tS/z/xE/sYYjAR4QvwmJuFJZX0A0eZhwA8523U2c6Mw==
X-Received: by 2002:a2e:98c1:: with SMTP id s1mr13756835ljj.68.1557963111124;
        Wed, 15 May 2019 16:31:51 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id i12sm432695lfo.67.2019.05.15.16.31.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 16:31:50 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m20so1372611lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:31:50 -0700 (PDT)
X-Received: by 2002:a2e:9a94:: with SMTP id p20mr11957491lji.2.1557963109896;
 Wed, 15 May 2019 16:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190515133614.31dcbbe0@oasis.local.home> <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
In-Reply-To: <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 May 2019 16:31:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbVZcZXkq5xOnBk3ibXorEYKdmRG5YFzzV-Rw3Q-VUEA@mail.gmail.com>
Message-ID: <CAHk-=wjbVZcZXkq5xOnBk3ibXorEYKdmRG5YFzzV-Rw3Q-VUEA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 4:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> One option is to just rewrite it something like
>
>         const unsigned int offset = offsetof(struct trace_iterator, seq);
>         memset(offset+(void *)&iter, 0, sizeof(iter) - offset);

Side note: make it a well-named helper function, since
"ftrace_dump_buf()" does this too in kernel/trace/trace_kdb.c, and
gets the exact same warning.

              Linus
