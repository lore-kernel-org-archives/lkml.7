Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2AAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B9E2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rB6Ae8Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfI0V2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:28:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35682 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0V2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:28:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so9123824qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSzYm24kMm+3qsYyi0PMA9ARrI4D/MfOEwhnPkS6YeA=;
        b=rB6Ae8GsgMKyXP2kIYlZdVkMQw5z5AgLQJ2JqQdEYq6qXHOG3NWtz3nhkxhP3Eq3Ah
         DSwDFvsXL8szTF0jsaA1qBVp/X6Lr1RfD0mFJYkQDd2S6sXz6BVDRB06kySbFyh365z+
         Ogzn+eX3gQqdXZZxxbdj41XasaOfqyp/leQkZlAwnUrfs7uRHkkedxTCCrexo4Cnd67v
         zKXOkUjrEy+MZsg4YNJa0Ova2ssP7aAfIbEcTGdMv/g5vfS7Htk//ie7vX6zCO+USuuX
         kQUCxeDVZgr4KxJy4i7t9Ntu6eBel9ktGtdZw1eKKK3vGGhOeYivJsVxNrJmIUKTb4fj
         ZfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSzYm24kMm+3qsYyi0PMA9ARrI4D/MfOEwhnPkS6YeA=;
        b=NHBNXTuK6Wfb4grgOZAW9a5u6wxlcydCJj2E01P3bOZVaWvz14q8XburHmfb07TFrO
         FczpUVze4HigKKiFzDUWR2bkmMRDYY+mrlYXyPpwC6LejueLmKtNpETzulQxeKRgeVUp
         unqcxrRJy/N4SA01nl+nxB3WpWgVNy9XIBHqgThVbnUI8B9oT/+sgTQUE39qKLaYtrU1
         GzNZhr8NFim71ptlnm8TwiAGY1/tucauzbsE1uWBcMlfDBwR8JXhVBSM9vpPMGdShFEH
         VYXuU8aNwyMMbEFbcJ+/IdtvM20C71vC3z3poOIa0cx5xcjGFBgz9TGNFnyegasFLIcd
         /YGQ==
X-Gm-Message-State: APjAAAV3SUoxMJSa65KMX2e36HFsCWjF46qSsdLYE3QXM6EkEzvoqho+
        XM0HnDsek/GsY07WLrSXer15Wg==
X-Google-Smtp-Source: APXvYqwufZybaXtm0KCuPg3uZ3BPhqW+oT1dBLOwS6HEHY04KEDFQUFlFH14fTnbK7+h1k4NFQvDvQ==
X-Received: by 2002:ac8:301b:: with SMTP id f27mr11837429qte.83.1569619688095;
        Fri, 27 Sep 2019 14:28:08 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m14sm1636640qki.27.2019.09.27.14.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 14:28:07 -0700 (PDT)
Message-ID: <1569619686.5576.242.camel@lca.pw>
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
From:   Qian Cai <cai@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Sep 2019 17:28:06 -0400
In-Reply-To: <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
         <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-27 at 14:02 -0700, Andrew Morton wrote:
> On Fri, 27 Sep 2019 15:47:03 -0400 Qian Cai <cai@lca.pw> wrote:
> 
> > On architectures like s390, arch_free_page() could mark the page unused
> > (set_page_unused()) and any access later would trigger a kernel panic.
> > Fix it by moving arch_free_page() after all possible accessing calls.
> > 
> >  Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> >  Krnl PSW : 0404e00180000000 0000000026c2b96e
> > (__free_pages_ok+0x34e/0x5d8)
> >             R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> >  Krnl GPRS: 0000000088d43af7 0000000000484000 000000000000007c
> >  000000000000000f
> >             000003d080012100 000003d080013fc0 0000000000000000
> >  0000000000100000
> >             00000000275cca48 0000000000000100 0000000000000008
> >  000003d080010000
> >             00000000000001d0 000003d000000000 0000000026c2b78a
> >  000000002717fdb0
> >  Krnl Code: 0000000026c2b95c: ec1100b30659 risbgn %r1,%r1,0,179,6
> >             0000000026c2b962: e32014000036 pfd 2,1024(%r1)
> >            #0000000026c2b968: d7ff10001000 xc 0(256,%r1),0(%r1)
> >            >0000000026c2b96e: 41101100  la %r1,256(%r1)
> >             0000000026c2b972: a737fff8  brctg %r3,26c2b962
> >             0000000026c2b976: d7ff10001000 xc 0(256,%r1),0(%r1)
> >             0000000026c2b97c: e31003400004 lg %r1,832
> >             0000000026c2b982: ebff1430016a asi 5168(%r1),-1
> >  Call Trace:
> >  __free_pages_ok+0x16a/0x5d8)
> >  memblock_free_all+0x206/0x290
> >  mem_init+0x58/0x120
> >  start_kernel+0x2b0/0x570
> >  startup_continue+0x6a/0xc0
> >  INFO: lockdep is turned off.
> >  Last Breaking-Event-Address:
> >  __free_pages_ok+0x372/0x5d8
> >  Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 00: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000
> > 26A2379C
> > 
> > ...
> > 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1175,11 +1175,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >  		debug_check_no_obj_freed(page_address(page),
> >  					   PAGE_SIZE << order);
> >  	}
> > -	arch_free_page(page, order);
> >  	if (want_init_on_free())
> >  		kernel_init_free_pages(page, 1 << order);
> >  
> >  	kernel_poison_pages(page, 1 << order, 0);
> > +	arch_free_page(page, order);
> >  	if (debug_pagealloc_enabled())
> >  		kernel_map_pages(page, 1 << order, 0);
> 
> AFAICT the meticulously undocumented s390 set_page_unused() will cause
> there to be a fault if anyone tries to access the page contents, yes?

Yes.

> 
> So I think you've moved the arch_free_page() to be after the final
> thing which can access page contents, yes?  If so, we should have a
> comment in free_pages_prepare() to attmept to prevent this problem from
> reoccurring as the code evolves?

Right, something like this above arch_free_page() there?

/*
 * It needs to be just above kernel_map_pages(), as s390 could mark those
 * pages unused and then trigger a fault when accessing.
 */
