Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E431C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1824027
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YyD6uuq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfE2Sfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:35:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37179 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Sfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:35:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so2195571pff.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v1brlopRODFYIOi3P9DZDOil1yY2RDrp+jg+VGWZC8A=;
        b=YyD6uuq6pD5bXcJVpcO4CLkcCDDeuU9UhKxI+9lMQvf0FpBqWgQgdE/s3bdezUB8Ax
         Q5AztHb/Xh7JVv35VfmtkGp9NK96mN9JQWakRhySHq3dthHjxfXyCCSl+s5ZleF6e4Cx
         GxXk6HyUHF5aCEmHHePRd05mQwg0yfdg0wdwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1brlopRODFYIOi3P9DZDOil1yY2RDrp+jg+VGWZC8A=;
        b=ZbkM553lz+VElRCo9+pIgj6nQCcKM1H7VHpSv6YEkHmneIyVNiqVxwpwA+tDLLp9fb
         UMUMCnmvc+QHqZaZ8miTIE3QPq2rNnnOxe16T1LTuXU/tZuR0vfUiveyCfH4d7whViFV
         1aGgG7dA/5hOdm9J29skldLbg85o7Ng4qTdvsapvTF7Wp0Nn71Zl0rj1fxBoFGk1+G0Y
         weq/JC30tx1oaVdo7sbL/I8I9So6/etd9lbRzYISpFofV5HUfCATEovdWguPqo26IXWI
         wQ5qeSRp761uO4hRqIl7tuFEcCCeACRFvBYXIu3SOEFna/vDgUMuwVagUUItBjCmv8N3
         CZNw==
X-Gm-Message-State: APjAAAXyzzWhZlGG2ToCt1vycXKrmLxqDYzHYeTQ7LUUD2lIFet1ueAR
        6L9I0dtaGfPEnW0tKj2GmT0IGA==
X-Google-Smtp-Source: APXvYqxWJBxqQ4l7exwmKOaYqIl91Y/eKWO/xI41ra6RoAUec3LGVnGOhwowvzBENhKEQxkl0g5s9g==
X-Received: by 2002:a63:ed09:: with SMTP id d9mr24044102pgi.419.1559154947660;
        Wed, 29 May 2019 11:35:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2sm112146pgp.27.2019.05.29.11.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 11:35:46 -0700 (PDT)
Date:   Wed, 29 May 2019 11:35:45 -0700
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
Message-ID: <201905291134.3D40F13@keescook>
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
> Not sure about ideal params for the whole combination here since security
> and performance are basically conflicting with each other (as usual). 
> So, that's why I was trying to propose to have two version of this:
> - one with tilt towards performance (rdtsc based)
> - one with tilt towards security (CRNG-based)
> And then let users choose what matters more for their workload. 
> For normal things like dektops, etc. CRNG based version won't provide
> any noticeable overhead. It might only matter for syscall sensitive workloads,
> which btw, most likely not enable quite a bunch of other security protections, 

I think people that care about this would prefer the CRNG, and will be
much less interested in the performance issues. But giving people the
option to choose it at runtime seems sensible. Though really, for any
"real" workloads, it's totally lost in the noise, even with the CRNG.

> so I would say that for them to have even rdtsc() version is actually an 
> improvement in their defenses for stack (and basically no impact on performance).

Yeah, I think a static-key based version of this would be very nice and
would stay out of anyone's way that didn't want it.

-- 
Kees Cook
