Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DC7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A602171F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MerkcBq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfGaTgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:36:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbfGaTfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnU6IvA3KdW0SFxdpQmn9A16T5orF4xfoYuarMx2Vu0=; b=MerkcBq6fNC8YU006LyRsNhey
        fOfZ20Clanrtet/ujAe1kIB29nLezFepLkb65Jd8OMlhcrJhgKQ4iCoSvVD+3loE3p5mkRmPgHpoQ
        Ri/uUWJBs2ng24IYY5xG/JHwnmvjXmgqMrwQ/OOJ9L3DscnD1TiqxjWxeVOIy4LQcWzEzsBDGeU8j
        BupwY0n3dTIRwtrbfUxsEKu3nDO9nSbC4xRxstKYzb5HX/a7yIw7HzB0i7zi2Mt7xxam3iRYOm7Mf
        9n97kWf/xV3wd/HnN4hzk7R92oZfTQOoH+bsKo87PoxIF/p+hrfhAUZz15pHpmO3gkhVhTgTbuL3M
        2WW1LhTSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsuNR-0000M0-9O; Wed, 31 Jul 2019 19:35:09 +0000
Date:   Wed, 31 Jul 2019 12:35:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Potapenko <glider@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: slub: Fix slab walking for init_on_free
Message-ID: <20190731193509.GG4700@bombadil.infradead.org>
References: <CAG_fn=VBGE=YvkZX0C45qu29zqfvLMP10w_owj4vfFxPcK5iow@mail.gmail.com>
 <20190731193240.29477-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731193240.29477-1-labbott@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:32:40PM -0400, Laura Abbott wrote:
> Fix this by ensuring the value we set with set_freepointer is either NULL
> or another value in the chain.
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")

