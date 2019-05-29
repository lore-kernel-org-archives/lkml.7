Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA89DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF43C218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJnvsiZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfE2ShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:37:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38458 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2ShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:37:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so403936pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SxLHP6OsBSFBHfXsjyle6HK6OxP8uorD2s0mT+kaxlI=;
        b=ZJnvsiZfD896d8Ck9n1bdw3mump/AlALJB5fwIzPOA+C33mqxnYVAfEZ5o+whJAwIm
         1GBP1aRsHCuezNBr49RvOw7cvjJSq1VBTBHhkaQN5w+KT7ghtAX+lR9xmMb8fa/yXXXy
         bp9CUbT7rz8KKjzE0NgMCBXs4Hgri8+6rXxZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SxLHP6OsBSFBHfXsjyle6HK6OxP8uorD2s0mT+kaxlI=;
        b=Nyr+xbnXsKU6CqxTr+yA88KVk4LDMDDn4ujrzEWYIAR2yXExdBUkLiQ1qm8+IwfkbP
         vvG7ASuJP2Z67AjwWSpOq6fLeosyWLtQJD9RNMDOPpCxDu7Mnczm0qCU0hdDCYpFzIVD
         528FRF4jmc2zYyLfKG2nmVzqJVIwUHgbIeiPsRbaIza5/aMxTrFekRdUvadebeSX94DG
         oij9fBtbeoBonSelp+yR3bcF1DTdL7Z89zXH0AnJHrn47hLpFGTg9WboSiUIaJJi8Jjl
         4+0r5YJPFOx3F6PKdTh+Uolq+wtJRyIMRdlAsZ4s9XNqKPwxISiL6w92mmqlL2u6CpdG
         5EFQ==
X-Gm-Message-State: APjAAAUCuZOB4N0DFZjrexTPbPeDA9UQNN4OL/G8HH86wHK1mnQc143M
        4ECGHQw2GfnNal/CC9dY6oCKFg==
X-Google-Smtp-Source: APXvYqwy5lBhcAUW8t02TCyQUB8BoXv9KBqAwvEAH9L9D1mvgGjG2UAFgsqFr5o8/VNlHt3zFLQLHw==
X-Received: by 2002:a63:5c4c:: with SMTP id n12mr142269302pgm.111.1559155040001;
        Wed, 29 May 2019 11:37:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm363961pfr.146.2019.05.29.11.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 11:37:18 -0700 (PDT)
Date:   Wed, 29 May 2019 11:37:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <201905291136.FD61FF42@keescook>
References: <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook>
 <20190512080245.GA7827@gmail.com>
 <201905120705.4F27DF3244@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4CA8DBF@IRSMSX102.ger.corp.intel.com>
 <20190528133347.GD19149@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4CABA56@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4CABA56@IRSMSX102.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:13:43AM +0000, Reshetova, Elena wrote:
> On related note: the current prng we have in kernel (prandom) is based on a
> *very old* style of prngs, which is basically 4 linear LFSRs xored together. 
> Nowadays, we have much more powerful prngs that show much better
> statistical and even security properties (not cryptographically secure, but still
> not so linear like the one above). 
> What is the reason why we still use a prng that is couple of decades away from the
> state of art in the area? It is actively used, especially by network stack,
> should we update it to smth that is more appropriate (speed would be comparable)?
> 
> I am mostly talking about PCG-based generators:
> http://www.pcg-random.org/
> 
> If people are interested, I could put together a PoC and we have an expert here we can
> consult for providing calculations for min-entropy, HILL entropy and whatever 
> is requested. 

If we get better generators with no speed loss, I can't imagine anyone
objecting. :)

-- 
Kees Cook
