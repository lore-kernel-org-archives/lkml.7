Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC213C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81272218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TenY/nIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbfISVTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:19:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37030 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389222AbfISVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:19:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so3118212pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UC6QOlPtFT4L7gAheGuvmlsU7X18QM5xfLgyP/nfovU=;
        b=TenY/nIF7r7AdT+DbY/MGs07XLbBYbYB48QaTr8BR5xkPDPdFERhf51rjGe3hCmhsS
         b8Lj5e/Uq+1231XB+btSn0lJ8ydUKyHp5gXzFJ167/FMVN2NcDdzlvLpekeY1+73P9R+
         ZdwDUdLaVeSZ+JxQTu1Ano0gST3u/0h/mEasM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UC6QOlPtFT4L7gAheGuvmlsU7X18QM5xfLgyP/nfovU=;
        b=ERfOeMw5L7Mc78bZNO2Nisp7ak3YR8bFKzGHvIEEFFItRu0tGT0d9ZT0kCuckXnAtN
         PsxL9T08VlwEua3GBHtWzYBW2uPCpkRIv8JeKNcDpomYKw9wesNAzQFqG89W6YF4S8Zc
         Mwu9U9bkD47Mi2c5cPYFlyJTVzbldyoasId4eftzIxts5H9cL/0qM4YXGYe8Tkh0chwp
         emzvzmqoEWL3jS/UZ7+AOrCYC8nsIgUvXq+/Ug2RuTX1iZgQ3N9Pi610H75thqC1H5Y3
         Ua7YmRnmtRjfCHdQsINlyVtaTja1SB4xYjFbZ85rVwbDoNPR/wJBS5SUpBDiIbrdrV7L
         MkAw==
X-Gm-Message-State: APjAAAVakVoCpZ8bC9AfwLQdHmIrOaVR4vQROBVoOjt2Y/pGndasUh4H
        KWPE6ReQtu94Tu8X3cbiOWnOlA==
X-Google-Smtp-Source: APXvYqyivzuDow60MKYUgF2hsOkA5SUuSL3Vyv4HlcnvRX2I63cnPL2BPFkFJNZYyVKJygjTqr2CCQ==
X-Received: by 2002:a17:90a:310:: with SMTP id 16mr125647pje.100.1568927946393;
        Thu, 19 Sep 2019 14:19:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm5933542pjn.19.2019.09.19.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:19:05 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:19:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Use make invocation's -j argument for parallelism
Message-ID: <201909191417.6E59C942@keescook>
References: <201909191116.192A096C68@keescook>
 <20190919162549.5ccdab62@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919162549.5ccdab62@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:25:49PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 19 Sep 2019 11:18:52 -0700
> Kees Cook <keescook@chromium.org> escreveu:
> > [...]
> > +# Fetch the make environment options.
> > +flags = os.environ.get('MAKEFLAGS', None)
> > +if flags == None:
> > +	print("1")
> > +	sys.exit(0)
> > +
> > +# Look for "--jobserver=R,W"
> > +opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> > +if len(opts) != 1:
> > +	print("1")
> > +	sys.exit(0)
> 
> Using "1" as default if -j is not specified doesn't sound a good idea. I
> mean, Sphinx is very slow without any parallelism. I would keep "auto" as
> default here, if version >= 1.7 (and if there's no explicit SPHINXOPTS).

Okay, that's fair. This does introduce a behavioral regression from that
perspective. Let me spin a v2 that'll DTRT.

-- 
Kees Cook
