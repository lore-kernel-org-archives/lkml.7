Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0C21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570459469;
	bh=8Fw8p1yee2GgFTTiNJhgrm6pVCZh7BCq6S+vv5SZCFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fF2z1AZEa8z4Sdr3IwSc4rAOUflS9/WHHirCs4b8yP6PXpurjqWx2b85XGaO9EA2g
	 ewlTJft5Rd5BAfEXyQjAeoPptmmayeh9SjwEaWuxr7h2DpoALUVVynSVv/VZX9qbWV
	 bOIayGs19jgnTwotKMmba3FoDQIsLDqNwiulTU3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfJGOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:44:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:44:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so15607335wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PpPxy8fAMLPn9IHnNNOb8/HlXzEm8SFbpPhsOWCIm70=;
        b=mDDOhpkJKustOCnU2QXHxhnAUHg5CU3ynsH42eutOYAhbsg5954jl8uZ5c71QNALza
         1VZE3Tpw99uE6Fm4UFOFAN/ZWyMr3QuP4gttX//k8MgsrU41rUG5MVqbE73a0gv/1rRZ
         e4uh581uCdy7f3i1dafvkUcxa1DP54dPjynokCQB6NHkgWiGL4CIYUkptnSns0Mft4SZ
         cdPMpkm5nqvQcRH85EMPAFaNrBny5bnB8fBXUD/8tDPXYN0gWq5FpVZPe/gJSUnZzXJd
         pa9Wzj6+s44n/vh+emOacm3K6djFZfz5UyzqV5iLO+hPzRMW0tY+ZUg8VoeB2CiOMCNo
         Wszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PpPxy8fAMLPn9IHnNNOb8/HlXzEm8SFbpPhsOWCIm70=;
        b=Wh4roxXfBuw0un37Q0giGjuPJ/gmp5CxlTn0bcn4B+mVMaSGJo2ay5ZVXIl2rEgYYi
         OpPbX1dK6fcHoJ/lr/+pqTq1ZXDOQbOwJdLbzeGVF9+RR+HzSfccD4ldJ/+0iNdiWSrF
         tmsI/rcq85Y9pwaKsHQwtnWhp3DVogscTIDiVcoCILq89l5TntdD13X3kcLio/cnEM36
         XZ3C9YlWbRe8SHO5+NhTl9KP+EUnoM6uakkORNI3tAsGjLuQpfVlcvbZ19Z9fKX7wfaK
         xUsTMu0sKAZu1NaSsE8HaIhS9VdSrqxZKbmFkq9WrLdZQUzhUNBS6m+tu+5IkHrCfumz
         /nMg==
X-Gm-Message-State: APjAAAX6R53gMVM/7W/MB0rnggcNauLZ2axhIuKOi0ZLH5/SqZ8tqJxF
        dw/jaA5qW+eags8EWFFDp5I=
X-Google-Smtp-Source: APXvYqyzPYWHywzbxwpXat1qpMUOe3+ve7Y5BFxOXEHwIjK1HkkAOJeRfbDFTIkXeSjC6akt8eOs3Q==
X-Received: by 2002:adf:f9c2:: with SMTP id w2mr2357241wrr.41.1570459465831;
        Mon, 07 Oct 2019 07:44:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q124sm26926115wma.5.2019.10.07.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 07:44:25 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:44:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: determine whether the fault address is canonical
Message-ID: <20191007144423.GA25181@gmail.com>
References: <20191004134501.30651-1-changbin.du@gmail.com>
 <8b2c8164-d7ae-20b7-ff48-32eab9ec9760@intel.com>
 <20191004153115.GA19503@linux.intel.com>
 <20191007143255.GA59713@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007143255.GA59713@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > All the other reasons would require a fairly egregious kernel bug, hence
> > the speculation that the #GP is due to a non-canonical address.  Something
> > like the following would be more precise, though highly unlikely to ever
> > be exercised, e.g. KVM had a fatal bug related to injecting a non-zero
> > error code that went unnoticed for years.
> > 
> > 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. %s?\n",
> > 		  (IS_ENABLED(CONFIG_X86_64) && !error_code) ? "Non-canonical address" :
> > 		  					       "Segmentation bug");
> 
> Instead of trying to guess the reason of the #GPF (which guess might be 
> wrong), please just state it as the reason if we are sure that the cause 
> is a non-canonical address - and provide a best-guess if it's not but 
> clearly signal that it's a guess.
> 
> I.e. if I understood all the cases correctly we'd have three types of 
> messages generated:
> 
>  !error_code:
> 	"General protection fault in user access, due to non-canonical address."
> 
>  error_code && !is_canonical_addr(fault_addr):
> 	"General protection fault in user access. Non-canonical address?"
> 
>  error_code && is_canonical_addr(fault_addr):
> 	"General protection fault in user access. Segmentation bug?"

Now that I've read the rest of the thread, since fault_addr is always 0 
we can ignore most of this I suspect ...

Thanks,

	Ingo
