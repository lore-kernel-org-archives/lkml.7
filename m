Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B4420650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571826379;
	bh=z4ipP4Ck0yBqTHzgeKqG4ObZnNyOh+UsmqwlDY/xwzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C+LH4EmDdfpiwqX1+k3j7ayf2L3N5061q5rQfxQbd91/bc1n4rado98YX3zDKmTKJ
	 RxHnU6kzCR0+ucXCDQAAPEt6D3PWVOYRcbV5emFGtSe4WiyGp04YJwvbsnHf0bqKE0
	 SlqIju7qiKOmbgZqPwG8QJEOosfFiNLig8y7k6Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404315AbfJWK0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:26:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42961 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391001AbfJWK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:26:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id z12so15592582lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRWUNj4J7qgXSXD2PSfXvGDEs07MKcTmNuTdcaVnUGw=;
        b=Slb+IaA7gxUyVr09pbGzJOB54Jv239tGUr7XIcQxfolpIG44u/NoAMOhLnza+Em4WR
         TEPsZuhBtQdRHRD82otLdcY2uJ9E7K4xMc5ZFii1pfI6kkUC5qwEGbYYfYuTwlvtQiDO
         wMOTH/ObIO23qcZyZJ2PI3HvK563JGx6aHaAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRWUNj4J7qgXSXD2PSfXvGDEs07MKcTmNuTdcaVnUGw=;
        b=JGoxbDuy0m5K0RU28WFiqJ9idHmOrGFOtbMqPAGA0Rs+oL1eJCljvBkxfHPr4jTR9z
         oGxuTJzjIB81W/CujJ4/qjdtRVLb0aNxsm0CIuzUPKFCANfgF+y6xAdCy3IgdrJ1lihl
         UJbPmsoe/YHzdu19oy1B3KQVEN66XQ7/jkwl2M4Sdj+Rj0zhtKEhkgKlMHR9KG3zXzJj
         nf/bDqdEJuenXTZBUga2HtyDnq6JtpyC76cIAFoNuRLaQfVhX8f3GDTnxeCY8Dh/mKME
         R4kaseSQcqb55O29881ymY59sJ8OmabIQ6X3KX7mVwLaEgKcxPeBBEs69k2gdLGf+hyW
         l4cw==
X-Gm-Message-State: APjAAAU6fY5YUSy2bBffJTmtNT8NE4RtEu5BU6FoZQDaC1tiSxdbxitj
        JjHjL6q2JZt+ikIIN2rQ61XMAu0eKB3/ag==
X-Google-Smtp-Source: APXvYqzWg7bFb/Mv2tuV7W5xFInN2aMIyFzfUf0tolc1jhbB7dOKT9cHv9wH7nO0ctnfcTeWj8P+LA==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr10397159lfa.137.1571826375904;
        Wed, 23 Oct 2019 03:26:15 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b25sm10210171ljj.36.2019.10.23.03.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 03:26:11 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id j19so20496851lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:26:06 -0700 (PDT)
X-Received: by 2002:a2e:29dd:: with SMTP id p90mr21979653ljp.26.1571826364626;
 Wed, 23 Oct 2019 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Oct 2019 06:25:48 -0400
X-Gmail-Original-Message-ID: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
Message-ID: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
Subject: Re: [PATCH 00/12] mm: remove __ARCH_HAS_4LEVEL_HACK
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 5:29 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.

Thanks for doing this.

The patches look sane from a quick scan, and it's definitely the right
thing to do. So ack on my part, but obviously testing the different
architectures would be a really good thing...

                Linus
