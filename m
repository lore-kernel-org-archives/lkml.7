Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B9C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DE220867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUoJROOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfJGNUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:20:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35030 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:20:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so12509690qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ArSSEDv4lyQP/OrcqpZe2TGjCZz/1L6jU4R7IDnkjN4=;
        b=vUoJROOXR19pSID9iYGsZr3aJ/iSaMwyg/gFITja6apByae1ikYHQKJuWx8A7bc2Pj
         IoerTaClvbhv/fpepH3FYMo8152KwzdV1JdJjZcVfrFCsCIGl24RXV/fN3gd7wVqsv3+
         49a95qM8o0gRX2QCTAtqQOpM57SCxdhoPa/Fsxpt6qPe7vOytyM1jxL8CSu5hxmvrQbS
         O/6M2xKVmMKGAi4Vq9CK0LsfPBxm8cONiVlQxHWXmrmSKyG7qJxCZ6pPi/7htwkfaC9z
         Ci4IPJGg48EBMFOwAHlV8GUfOVYZcTDj8iTPZ13+gLjvwIXFXEvFnoBZ9iRjZUUPujn9
         0eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ArSSEDv4lyQP/OrcqpZe2TGjCZz/1L6jU4R7IDnkjN4=;
        b=l4Q+U06ookwDyZDyoeV9dZFQN0EMyhfcY21pJ1BFlfv90Gs5dAVEoGNCdse10OzOZZ
         2YWzcpQhfXwUsn4Ces+w6LwG6/p8vjfI7LNrFff/26K7M1U90MRFm9WjIk8dmWSYG4Xp
         iIgP/4Dn248uvAhi+s/AAPBHSMM5EQ3NcpLhEFuRNUOaCCOf9vPzNvn1AqlAl+s2UczY
         cr9ITJwZWSo8wnJbJ0qzZZ341jl8sUfInOeT5hIsvtzYwCi7iC3mwpsXrx7kfVEnRm3s
         RQtWxKzqSbmi/ZGLQLHvYMeGJte3ymur0EjgY0pBCLJLx0hV7HGEkJ3M1MJCttuBkfOZ
         XbGg==
X-Gm-Message-State: APjAAAV27abzxAtR33tQY9YceUPYvRPc7WsUspVsVGj0xnOBCG/YEeju
        C+8YSaA2SNvfiPn8MMjMtkEGIBSF/Q4IUA==
X-Google-Smtp-Source: APXvYqzDSPt08JpD5QPknfdK3l9KH6ZrcHwFvrb/PsrgFIgP7sBltjOrH4oXjVUK+/EOy23ti5yQ/w==
X-Received: by 2002:ae9:eb51:: with SMTP id b78mr23951361qkg.452.1570454407344;
        Mon, 07 Oct 2019 06:20:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t19sm6850145qto.55.2019.10.07.06.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 06:20:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 09:20:05 -0400
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
Message-ID: <20191007132005.GB269842@rani.riverdale.lan>
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
 <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:10:18AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-10-2019 10:50, Hans de Goede wrote:
> > Hi,
> > 
> > On 07-10-2019 05:09, Arvind Sankar wrote:
> >> Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
> >> memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
> >> sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
> >> according to git bisect.
> > 
> > Hmm, it (obviously) does build for me and using kexec still also works
> > for me.
> > 
> > But it seems that you are right and that this should not build, weird.
> 
> Ok, I understand now, it seems that the kernel will happily build with
> undefined symbols in the purgatory and my kexec testing did not hit
> the sha256 check path (*) so it did not crash. I can reproduce this before my patch:

Yes -- this should really be fixed. purgatory build should fail if there
are undefined symbols, in fact the Makefile apparently is trying to do
something to catch undefined references?

LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib

This doesn't seem to actually do anything though. Anyone know of a way
to force ld to error if the resulting object would have undefined
symbols?

> 
> [hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
> ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
> 
> And I can confirm that it is gone after my patch:
> 
> [hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
> ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
> 
> Regards,
> 
> Hans
> 
> 
> *) I tried with a Fedora signed kernel, dunno how to trigger this if that does not
> trigger it
> 

It triggers an error for me when loading the new image, i.e. when doing
# kexec -s -l new_image

Not sure what the difference is, mine is a custom configuration built
using mainline sources.
