Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC26C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6C220862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558804073;
	bh=1NOG9vvuSugzbmEHIFTbaXcD4xyXPjqW8u8Apo5aY6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cxrmjVTmzqiloANxLA2N2Pi85LMO8Qyq042LDNyrhXA9kJuexcs2s5gUa4BVLaalE
	 EJJL+EIVIPruWU1wql2nsOsk3T8hzHsdycBZ/+eitN7o4UWD1Dd7GPKMLpVf90pi+N
	 yUCFdXUs85qn25kCw23K9LxsRQfNEic8rdqw8U3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfEYRHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:07:52 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:39842 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfEYRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:07:52 -0400
Received: by mail-lf1-f42.google.com with SMTP id f1so9263739lfl.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5ktK9kr4E0UpbbeaHLRBxZcSjVJhVPG4g8QF69sVmY=;
        b=blWPgG96+VVQqIzaWJtzwSPl1QZ1S0Z04iNWgu72UYrrEMJjAjb0uL1VklvosGRad1
         QjwqdkB2pvLto1OJmIjJxoAO0TOZpQ+qmzwwgKrs9zICCkP//YwaeBtPKJ0BOb1W3+mo
         iEJkOggeA90YvBtGTsZFgAObtE+OMxPecZ/Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5ktK9kr4E0UpbbeaHLRBxZcSjVJhVPG4g8QF69sVmY=;
        b=OTi2oOQcQjpvK8AD3IMTMJ++zDBFJ8lZwhhm2OFb3PRVnTtDi1jr14wv4cKMifC4NL
         Kz4P4jFWKOGDVSRZZxM0dH0DxKdeAMUmFR9e1UErtRGLdCytc70+VwOPf6z8XSX3JQxb
         CCmxU2bxRow1N40siZZ1agx9qGNQMuULLH/66aARRKXTyDp0TtIXT+vXwuI1/wCPpl4S
         8L5iQTPXAqPPQ54o5KTO1OtzR/Ehnq1+gm1LMB1/xuLnPJQxiCYydeLIrIJ2IYCwRETz
         ApAVj46u1PoQw0W6DNC+BglgDEAdLh6NZpumh7QPPzC75dmRpeJs95rk/ckC3sZf1HkO
         pJug==
X-Gm-Message-State: APjAAAVt/YMnB/VquPRjprWVulZbI2X//gaqUfPAwZoNiLmHuzGE8UYX
        IyEFxw+8eL5mf0zOGodWEO99BcoTD/8=
X-Google-Smtp-Source: APXvYqypU5CkD+xvY2xsivuV+v6m7tA2+qRdfK+MpzCTCC1hh0EwBftJMesiJXKn9L/eDlSRTmlgwA==
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr2153497lfl.159.1558804069762;
        Sat, 25 May 2019 10:07:49 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id g15sm1163526ljk.83.2019.05.25.10.07.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:07:49 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c17so9295803lfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:07:48 -0700 (PDT)
X-Received: by 2002:a19:be17:: with SMTP id o23mr28987773lff.170.1558804068519;
 Sat, 25 May 2019 10:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190525133203.25853-1-hch@lst.de>
In-Reply-To: <20190525133203.25853-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 May 2019 10:07:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7=yxWUwao10GfUvE1aecidtHm8TGTPAUnvg0kbH8fpA@mail.gmail.com>
Message-ID: <CAHk-=wi7=yxWUwao10GfUvE1aecidtHm8TGTPAUnvg0kbH8fpA@mail.gmail.com>
Subject: Re: RFC: switch the remaining architectures to use generic GUP
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me apart from the question about sparc64 (that you also
raised) and requesting that interface to be re-named if it is really
needed.

Let's just do it (but presumably for 5.3), and any architecture that
doesn't react to this and gets broken because it wasn't tested can get
fixed up later when/if they notice.

              Linus
