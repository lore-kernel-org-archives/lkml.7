Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9301C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEDD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfC0J0J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:26:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC0J0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:26:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so17653843wrp.0;
        Wed, 27 Mar 2019 02:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=yBMLoHOl082TnS8zsdQPe5JQB1/9lZ/UzvMcb+XEpbw=;
        b=YAcWCArHR2bs+ZsaMrv7MB7Md+1+9EU0hMJfixKVbykN6YyLnbM/1t0bfBP6nnmEpR
         Rr7cCQw4Dli9/RQTJGkb00jgqKGKVqHHHAs/3rJ5lmbxOaUOJLz/0/wrIQYeX6xfIWJk
         6r2WPG6LNmAaqi4mDjmAjg82O8m7kWtp5CnN4n15/geHiktS5LhMGqMGtI7rKUpv14xL
         zI6+y6VccjYqn9u36TFLMwf+39MMedSAtevo1VP/gJvt2ZOnmzP0BmaCFG/yZ25EFJxy
         NjW+PS4FyXnGVPK3QTX0olZxzXVkAZ173VKjnB0HBhRIpqNJEVAYZO3F5/WfuFI9zB8J
         MJcA==
X-Gm-Message-State: APjAAAULDwJfKKXhMIK/xsqRnA6mh7oujpChv/QerLehrzwj/+YZACM2
        7k99H3mov51D6ORnC6oWWIbt0Y5A
X-Google-Smtp-Source: APXvYqzvB8qsZ/VyiUEoQ79bLzoR6jSope5lHBP7wy+9FlwXkiTgn5yA5VU1FbEQzvhG95uOfNK+ZA==
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr21632728wrw.312.1553678764312;
        Wed, 27 Mar 2019 02:26:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:f419:6f00:b00c:66c8:99df:336])
        by smtp.gmail.com with ESMTPSA id a10sm29674089wrs.19.2019.03.27.02.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 02:26:03 -0700 (PDT)
Message-ID: <df699947253913a7e572fd1252b99e594431e261.camel@debian.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
From:   Luca Boccassi <bluca@debian.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Mar 2019 09:26:02 +0000
In-Reply-To: <20190327015623.ur46t5gdmraagi2q@ast-mbp>
References: <20190327091437.68ec6903@canb.auug.org.au>
         <20190327015623.ur46t5gdmraagi2q@ast-mbp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 18:56 -0700, Alexei Starovoitov wrote:
> On Wed, Mar 27, 2019 at 09:14:37AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the bpf-next tree got a conflict in:
> > 
> >   tools/lib/bpf/Makefile
> > 
> > between commit:
> > 
> >   1d382264d911 ("bpf, libbpf: fix version info and add it to shared
> > object")
> > 
> > from the net tree and commit:
> > 
> >   60e4786e229d ("tools/bpf: generate pkg-config file for libbpf")
> > 
> > from the bpf-next tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree
> > is submitted for merging.  You may also want to consider
> > cooperating
> > with the maintainer of the conflicting tree to minimise any
> > particularly
> > complex conflicts.
> 
> argh. that's a heavy conflict.
> Since that patch was at the top of the bpf-next I removed it for now
> and will re-apply when bpf-next gets merged cleanly into net-next and
> we bring back net changes into bpf-next. Sorry Luca.

No worries - for the next time, should I have based the patch on net-
next rather than bpf-next?

-- 
Kind regards,
Luca Boccassi
