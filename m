Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918720842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFC6/C7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfCEUHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:07:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfCEUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/Mqtofyjx4mP4jWB0F6ZHFzKVZJiO58nvAjEc5wPM0=; b=QFC6/C7qt20wm9uPeNjErRhww
        A3d0F7p7ZAYMscHplimT++bjBzm7wqu9vdm8DigCCBmmFgJWSWeyZmHvLZ5T5KGpZzEmbby+0WSon
        Jzu9qB40e6TaqcjXFH6BbyW+ImOc9CbqbizNlj0xf0oi/Jg7niaE0lVOzv+ESaPUjMghNoszxN2AI
        56xawhqVwNR0fWo7caOHfZOWSqhmuFKkWM49QF2BQdbc/6u900yeT9pv7RHqjIc4usEhk7FUdnYoM
        c6bRVUSGyVlKxrBXC3MqywsUk5Q+DwJbDjTUEj3Aqz+r9KqSk5ymII5xa49CEy3Aita0nn1PhCkJz
        fZVkfWbAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1GLV-0001qp-Oe; Tue, 05 Mar 2019 20:07:25 +0000
Date:   Tue, 5 Mar 2019 12:07:25 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Louis Taylor <louis@kragniz.eu>,
        Jonathan Corbet <corbet@lwn.net>, pmladek@suse.com,
        geert+renesas@glider.be, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
Message-ID: <20190305200725.GG13380@bombadil.infradead.org>
References: <20190303123647.22020-1-louis@kragniz.eu>
 <20190303201016.GO9224@smile.fi.intel.com>
 <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
 <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:59:30AM -0800, Joe Perches wrote:
> Many of the -Wformat warnings are bogus too.
> 
> There's nothing wrong with using %x for a unsigned int
> of less than long size. (u8/u16)

I believe you to be incorrect.

6.5.2.2 Function calls

7 If the expression that denotes the called function has a type that does
  include a prototype, the arguments are implicitly converted, as if by
  assignment, to the types of the corresponding parameters, taking the
  type of each parameter to be the unqualified version of its declared
  type. The ellipsis notation in a function prototype declarator causes
  argument type conversion to stop after the last declared parameter. The
  default argument promotions are performed on trailing arguments.

I could define a calling convention for my CPU which says to pack u8s
and u16s as tightly as possible in registers (or on the stack), rather
than the prevailing calling convention of having each argument take up
at least one register-sized slot.

