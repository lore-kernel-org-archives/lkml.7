Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCFCA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5189B2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHdqzfGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442072AbfJRFrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:47:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37213 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfJRFrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:47:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so4776031wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNM5D576B8sHjDG8vnn5qQZ6lZD1oQyLwfmGZHpyHPs=;
        b=mHdqzfGmHn9g4etrFlilXztklbz9uHDHVpn+164bm1WLeyNevDemg0bZ8UtczJnv+A
         s8er2ZT93AwmxS1DhyLPD3TAvl7mQi+i+Wzw1JjSx/BVxnxbOnnqGh6Ot1mOJziIlgbS
         Py6YbVVB0AYOnik+vbDql3Q99kPboJcz6iYZakULtV+iTvdWu+fsd2FNQBBmLbz7S3N+
         F4wHbPP0vT7+OfXYXLQ0mcd/ZhWoif/bv67w6RJpu1JxIQWXH4amxZUoJ1wP3yj5TmuN
         WCBPMt49ZRqX/xqxPC3hKmE2JC1OZoLeKbi7rNMHeUaxJE9FESgPwqOJqCBgX6fxMZ5U
         ooyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNM5D576B8sHjDG8vnn5qQZ6lZD1oQyLwfmGZHpyHPs=;
        b=Idxydod3aaeAoEZg3gXKBFAVbrCNrDdyPJdCLVRrVqLEJm5x5vOGy8rd9tu7DGANor
         IMEZSIK72ChNSCm82NDGoFIkfjnaiwH5/KRoq/wN7bbbVkwMWkj7X85PI/XsPpzyUyvL
         XvKMvefGsFaL1iKI1P0qbCeZcO8EIEi6zrW/6qzp/vtX48/77rGhip9TS7JUcpXUMZ9H
         Z48qOIIRy/4Pp96BoFeeZEa1R4Smuecsg1onsEUAv0Rl/r08zV4k7lnI/WEfNB9WQxgn
         5+LhVMUJhqa4ShxiF+lsaGw7nvFqGyLZGIhNaN+opMQIHeO8/qTAjB7mYPgPn1kZY+y/
         M1dA==
X-Gm-Message-State: APjAAAXUP293rFCOh1zeqbAOqeRNN/4GGZ0g/BXbQEnaj1XoXigab8cf
        S8J9uoaFKiTeWalpB12zs0k=
X-Google-Smtp-Source: APXvYqwR8H2jkoCVw9n7Q0P3ui61wTiaipA0OOuDWW7lRQbHDtfXWDt6M7VgRRngOICnsY4tGBmQww==
X-Received: by 2002:a1c:a784:: with SMTP id q126mr5676273wme.59.1571377624365;
        Thu, 17 Oct 2019 22:47:04 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:f882:d2a3:f943:89a4])
        by smtp.gmail.com with ESMTPSA id r7sm4244973wrt.28.2019.10.17.22.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:47:03 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:47:02 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: init: merge split string literals in
 preprocessor directive
Message-ID: <20191018054701.sjueyb3agoaopnla@ltop.local>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
 <20191018004929.3445-4-paul.walmsley@sifive.com>
 <20191018040237.3eyrfrty72r63pkz@ltop.local>
 <alpine.DEB.2.21.9999.1910172127220.3026@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910172127220.3026@viisi.sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:38:18PM -0700, Paul Walmsley wrote:
> On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:
> 
> > On Thu, Oct 17, 2019 at 05:49:24PM -0700, Paul Walmsley wrote:
> > > sparse complains loudly when string literals associated with
> > > preprocessor directives are split into multiple, separately quoted
> > > strings across different lines:
> > 
> > ...
> >  
> > >  #ifndef __riscv_cmodel_medany
> > > -#error "setup_vm() is called from head.S before relocate so it should "
> > > -	"not use absolute addressing."
> > > +#error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
> > >  #endif

...
 
> On the other hand, gcc seems to support the non-backslashed syntax.  So if 
> the intention is for sparse to follow the gcc practice, and to be used 
> beyond the kernel, maybe it's worth aligning sparse to gcc?  Only if 
> you're bored, I suppose...

I quickly checked and gcc also complain about the second line:
	$ cat y.c 
#ifndef __riscv_cmodel_medany
#error "setup_vm() is called from head.S before relocate so it should "
       "not use absolute addressing."
#endif

	$ gcc -c y.c
y.c:2:2: error: #error "setup_vm() is called from head.S before relocate so it should "
 #error "setup_vm() is called from head.S before relocate so it should "
  ^~~~~
y.c:3:8: error: expected identifier or '(' before string constant
        "not use absolute addressing."
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So it seems that gcc doesn't join these lines.
Fell free to add my:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
