Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD35C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEF72173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZsWbcteA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfEVUyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:54:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39210 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbfEVUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:54:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so1638224plm.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wb2xYG/vaqBuTYr8EC9pKNFA50F+MaGFUq5jU06hCpI=;
        b=ZsWbcteAcKvqlbL0XchkDzsiNFbre5iRTaBErI2NbAVs8jKRHtRARU/OqojtisS531
         GtdpDIRrtuYX0nWZXcY/9wTvm3k1T1dZRPFRdEODpKDr6ZAvgekbDN04nBo/ftMYfmTs
         I7EN0j163Jn6QCRWL+EkKxp9pFFGyV/rSz/xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wb2xYG/vaqBuTYr8EC9pKNFA50F+MaGFUq5jU06hCpI=;
        b=TpE9V22fCYd/Xc0cIEjddcl8FeVTdSGcVimoCjw6gZ7fPPpj5FmUioCPlIHrQdA9BV
         EwVia6ZsrKnTdrmQHDMqaLteoJOGXXOH8CsZIP+Fz9OQKYoNiud+OC+BfO8FsKOIIa8b
         XblXVWuy8hMGFSLNb8psaGSpi5UhZ3D6O+ulaq0xdVFrwrEvDButKJzH/vn5/ER28ZmW
         j0FmpETwmO/0ooH+XS+Id0WwNirKerqAKocKCUQEcQCAg5uFy1wOMKAjqqd7DOHsuZJ8
         OcI7fnJJb+s2WKIf6gOF7ZWQ0okozzq4nI7YeICCGWJTUdQGocnRsxKbcVTTwBatbN/O
         Qh+w==
X-Gm-Message-State: APjAAAXQrbySWHSgVICDUPFizpbdRC85HLGsyEweCEP8lq99GjUx7wJ2
        rn4w8qj0UDSBneaqWD045jfNKA==
X-Google-Smtp-Source: APXvYqwCkqu4EwdbWLMiMIXdPYdHE1XCksUDu28n26koT6oQ8HijpNqU3ghco+dpV8j7IrT9IT15mw==
X-Received: by 2002:a17:902:e583:: with SMTP id cl3mr93651928plb.35.1558558490033;
        Wed, 22 May 2019 13:54:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm28698723pfi.87.2019.05.22.13.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 13:54:48 -0700 (PDT)
Date:   Wed, 22 May 2019 13:54:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <201905221353.AD8E585E6D@keescook>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522015055.GC4093@zhanggen-UX430UQ>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 09:50:55AM +0800, Gen Zhang wrote:
> On Tue, May 21, 2019 at 01:44:33PM -0700, Kees Cook wrote:
> > This doesn't look safe to me: p->uni_pgdir[n] will still have a handle
> > to the freed memory, won't it?
> > 
> Thanks for your reply, Kees!
> I think you are right. Maybe we should do this:
> 	kfree(p1);
> 	p->uni_pgdir[n] = NULL;
> Is this correct?

That's what I'm not sure about. I *think* so, from reading the code, but
I'd love to have Greg (or someone more familiar with the code) to
double-check this.

Otherwise, yeah, this looks right. Please send a v2 and we can debate
the correctness there, if it turns out to be wrong. :)

-- 
Kees Cook
