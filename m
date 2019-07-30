Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66701C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4017D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CE2ybIhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfG3SIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:08:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34151 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3SIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:08:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so29223448plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UiyIYqXSI6n8BvwhN7+LjSI4Y/g+Sy0AddtIzNX1Okc=;
        b=CE2ybIhq+DHqTSzNEuPWsQl9INxAbJjWW+X54Ku6XG6LT1afZKNHBxq82foLw1BWvZ
         8NL8ea1l7oLUTUU3hn2l+iwfsmRIlHQ5zSDph3UwbcfFWCnnm2LNjX5GpGftd01P8Vye
         R3EFG4W2GkYR/iTAjgtyxcvFBIwmlPtTE4nxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UiyIYqXSI6n8BvwhN7+LjSI4Y/g+Sy0AddtIzNX1Okc=;
        b=DgvDGthqZQBzo5+8l67+hjpXZsqpOVtfPHtQ6Y4KYckQ6NeHFZKDcLm02KE6HeOlh0
         JZWzwQxk3JxipTxTBh23QjQMRpWLpztIm2mboKastZmmcOhz3VNVHNaMiSN75E0EawYj
         upFGkkG5IpsSQayXyVOTAhxefFT45Fazy7fbOW0TL6JcDA5kWWy/X+e6CSIXTc6qyVT+
         AKPuaAEIs3QQVpd8lOwTbf9A/qoxvno01xjTN1kUG8zcA/+oSp1RSjpkGzTyPiza4v31
         gk566RajD8GUQAhyWMreKef2+Pfm80CjqdG0aJqnQYDG6BrmpPJTN9+QZypy7/vOJNnv
         +h3A==
X-Gm-Message-State: APjAAAXb17PONEUe3m9rCfWaZyyoHpMs1I8On9CX0ktSPplo/CgHg8+j
        /5XvV58cR+VbjSE7mDgaah6/sg==
X-Google-Smtp-Source: APXvYqwJUJxHb4lnVwTVUxR9cVdjvtI62uHrKVppYv1MdwT1BahcYU/I99f7pcnI+EMLo7i+5vP47g==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr31359048plb.52.1564510079444;
        Tue, 30 Jul 2019 11:07:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y11sm68541316pfb.119.2019.07.30.11.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 11:07:58 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:07:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <201907301102.9339710C6@keescook>
References: <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook>
 <20190512080245.GA7827@gmail.com>
 <201905120705.4F27DF3244@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4CA8DBF@IRSMSX102.ger.corp.intel.com>
 <20190528133347.GD19149@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4CABA56@IRSMSX102.ger.corp.intel.com>
 <201905291136.FD61FF42@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4D4BFCA@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4D4BFCA@IRSMSX102.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:41:11AM +0000, Reshetova, Elena wrote:
> I want to summarize here the data (including the performance numbers)
> and reasoning for the in-stack randomization feature. I have organized
> it in a simple set of Q&A below.

Thanks for these!

> The in-stack randomization is really a very small change both code wise and
> logic wise.
> It does not affect real workloads and does not require enablement of other
> features (such as GCC plugins).
> So, I think we should really reconsider its inclusion.

I'd agree: the code is tiny and while the benefit can't point to a
specific issue, it does point to the general weakness of the stack
offset being predictable which has been a core observation for many
stack-based attacks.

If we're going to save state between syscalls (like the 4096 random
bytes pool), how about instead we just use a single per-CPU long mixed
with rdtsc saved at syscall exit. That should be a reasonable balance
between all the considerations and make it trivial for the feature to
be a boot flag without the extra page of storage, etc.

-- 
Kees Cook
