Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CB8C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080CE208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoZyw62D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF0LDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:03:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40704 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0LDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:03:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so1915820qtn.7;
        Thu, 27 Jun 2019 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gk3rjcJt6XXWFQZunDpF0ijEbS8Fw6hpWgbRfLD/Qxg=;
        b=SoZyw62DKtJdsURVCR9dNz86hTp16nKnqInqHoLUIgZjn44OTmzpWxOyP3/mRw/zYi
         pjMfGAxwyH2RPFIMJ2gHECBGNzKcAHcqmuiGhBaZtu58Yl6z+C8LZxyDNhD3v35Cpd37
         VBij2TWq+5C7EFYlx8y4ik3VzTrl+QPMbe3RsWdn6GOPxAd3tR2qNpgkRpot3K7nlQSx
         5achQ2ty1CTNT1k3YTu9ft9wSxkDrMpVa/StpK1B/LDoQFCebSRb0ee/6JbrZ9B4FlqV
         ioo0KXbHfl5JUv3M2vAQFXgVtLNeWU1JDIIr2bUazY+eWffGz4unwL1/godDnmiFMaWX
         7LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gk3rjcJt6XXWFQZunDpF0ijEbS8Fw6hpWgbRfLD/Qxg=;
        b=Mlhem+U+OkIvYGpxbG6lgsKQV7GPJ+EVZoqYT/8ngWsTYefGhHuTSm7esNawoDXUC5
         WQ8mgwVtSCdjThtH8rUCn467anSl4BEbVDPZNCmr3lDjVLYFbCiyLCUhqdVW7WxZugtN
         E/jDOJ5DIzHC8V2GRF2/dWKgZlfUF3HnJFU/gz8nsgzbKfSiD4HW0QoBs+CwP/s6jQKJ
         kjT2U7a5XbCMWrlSjfT3Elthcc0gJdFmJfIwQjYXo7inmrSY8zmS+BxnWvZsGCOD8SRS
         7pOnqw9w4q3UMzWCyoV8cmq6kTQhz4cPjThlgnV9rUYlhZjhSaTaxDPgoxK19eygot3T
         R67g==
X-Gm-Message-State: APjAAAX1b5yAzmtJdS6S8dVhH7XzWhbgkR99jjfa57fOsNnTwBWQanqM
        n+yVsuycp3uHdmg3ms2bvbr6JNch
X-Google-Smtp-Source: APXvYqzOjmEwNVwNJ62aefD48cZAruAwQrjcI0rClxU03aNnYJQs8w4xX9mAMLw2JHDlcysNfSc5Aw==
X-Received: by 2002:aed:3961:: with SMTP id l88mr2557530qte.246.1561633418859;
        Thu, 27 Jun 2019 04:03:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-133-106.3g.claro.net.br. [179.240.133.106])
        by smtp.gmail.com with ESMTPSA id 79sm702958qkf.110.2019.06.27.04.03.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 04:03:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E79841153; Thu, 27 Jun 2019 08:03:34 -0300 (-03)
Date:   Thu, 27 Jun 2019 08:03:34 -0300
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: pahole v1.14 (Bug fixes)
Message-ID: <20190627110334.GC9599@kernel.org>
References: <20190626211613.GE3902@kernel.org>
 <20190627014906.GA6181@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627014906.GA6181@mit.edu>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 26, 2019 at 09:49:06PM -0400, Theodore Ts'o escreveu:
> On Wed, Jun 26, 2019 at 06:16:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > 	The v1.14 release of pahole and its friends is out, available at
> > the usual places
> 
> Looks like you forgot to update the version number.

Sigh, I tested 'pahole --version' locally, but forgot to commit it,
stupid mistake, thanks for pointing it out.

I bumped the version to v1.15 and pushed it out, should be ok now:

[acme@quaco pahole]$ git remote update origin
Fetching origin
From git://git.kernel.org/pub/scm/devel/pahole/pahole
   7005757fd573..529903571037  master     -> origin/master
[acme@quaco pahole]$ git log --oneline -5
529903571037 (HEAD -> master, tag: v1.15, origin/master, origin/HEAD, github/master, acme.korg/master) v1.15: New release
3ed9a67967cf (tag: v1.14) fprintf: Avoid null dereference with NULL configs
568dae4bd498 printf: Fixup printing "const" early with "const void"
68f261d8dfff fprintf: Fix recursively printing named structs in --expand_types
139a3b337381 ostra: Initial python3 conversion
[acme@quaco pahole]$
[acme@quaco pahole]$ rpm -q dwarves
dwarves-1.15-1.fc29.x86_64
[acme@quaco pahole]$ rpm -qf /usr/bin/pahole
dwarves-1.15-1.fc29.x86_64
[acme@quaco pahole]$ /usr/bin/pahole --version
v1.15
[acme@quaco pahole]$

- Arnaldo
