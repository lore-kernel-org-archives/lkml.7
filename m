Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E95DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3F62070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu3nsp3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfHEWX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 18:23:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:23:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so85932297wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bUVYPxPP09P8ppfnqPZLUiZLPE23j1PKZ0KMt6pCCrI=;
        b=iu3nsp3mUlGMZ3eM1tXp4Ae9tXcVVcDgu7LLswx0fD16Bx7Eg1GHcdsPzCmChOBG06
         YkCFiN+DFOfmFrwpkgyZ2eqbQrfvhRBuCbQuSFm7lLw2Wqlp+j3GDSX4pcMND7/Fg8Ry
         zulaU//IiyZzgCELyNBqgowfLLJ2SMARGpOa++3+V2lxeSImov5+HiVx5C9inx/9w0qn
         BKmsb7W6AYohVuLkxoydYlBMW6vNScKYGdPbF34Gpll6lMeQbDb4kiTjbkOyqfw5NKT/
         +LtyFM4KipFx8/mK/azi2GY8MU454TefAmU4B2un5hXy6tP7OdaIzZCKmaYa+cBM3lAd
         7s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bUVYPxPP09P8ppfnqPZLUiZLPE23j1PKZ0KMt6pCCrI=;
        b=LyzFb/kUJPTLbUvTYsCUCWz6d1SYFMBs/38LqgJqfo6e4cAzAWPq8/MJ90d5Jt0G7l
         L1bvchhBiNAIG+1XMyub9rUM0NlV8GFyCpueQaODfkqfc5uDcLznUqtyIJDhYp/Np7SI
         7MBtTDYkAmUbkNqPvMWvECSlxsebKHlJuzcQgXhAfZiRNMMiL3EnkasWG2kGJzKS2Di3
         mhuBmc88kqUme/6O7m+WTyWuDxBWDlXseW+eJPKY2Jm67/MxugWWhmJtE0FMwz8WKHU6
         NHfeQRXk9rgO1WbaowLbOGrj5nXAevEfZrtNY4m3OF+aIWomGi0VxYTh4PCmLh7uza/K
         FW0A==
X-Gm-Message-State: APjAAAVeH29xeGubXjsgqyHx93ixX4f7oR696W1G5mOz7XVZ/6HLZ4+f
        9lWryU0Us4MUpompwan6OfhKQgHIBm4=
X-Google-Smtp-Source: APXvYqzu51/J6eDKXRotiVFBFPGfAhDLolWJCgPtJolexKKCzsmawMS+ntoN3w2j3E3JrMcmh4FvUQ==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr232194wrt.336.1565043834692;
        Mon, 05 Aug 2019 15:23:54 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id z25sm89979646wmf.38.2019.08.05.15.23.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 15:23:54 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:23:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
Message-ID: <20190805222352.GA37700@archlinux-threadripper>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 03:11:15PM -0700, Joe Perches wrote:
> A compilation -Wimplicit-fallthrough warning was enabled by
> commit a035d552a93b ("Makefile: Globally enable fall-through warning")
> 
> Even though clang 10.0.0 does not currently support this warning
> without a patch, clang currently does not support a value for this
> option.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=39382
> 
> The gcc default for this warning is 3 so removing the =3 has no
> effect for gcc and enables the warning for patched versions of clang.
> 
> Also remove the =3 from an existing use in a parisc Makefile:
> arch/parisc/math-emu/Makefile
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Looks good to me. I can see this warning get added to the command line
even if it does nothing right now.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
