Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19B020851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eGmMPxZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCGXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:12:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40719 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:12:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so10135152qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3bALdIkkTXR5Cl9wrkQz8PrR1SUO0MiBjS3cu5nIVU=;
        b=eGmMPxZPHYxgib0WVlf0KAJZUvJqIszcB29lMR3bfoCY4qGVJz61Qh7LzWV8NUYgDQ
         g/+xaKYjl90EiSgfmwzNZEuiGh+Xpdp9q8dZf1owvGS91v+ac4/YDN4Hk2ya0UUAjXeW
         3O6O9EcZVmW5I1WQFqEBiDVE3BNOMAp0UHwUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3bALdIkkTXR5Cl9wrkQz8PrR1SUO0MiBjS3cu5nIVU=;
        b=kpidGNeX1jFEqw27dW80x/Ge7NDQhID8heoPyANuq7VU9Y1FjRNMVXdjz8ZwtmSBmx
         suKX4+/10TXJ4ok6RkLq/Zu5UmvgfBPB2Rso5JqmuxY431vXZGnw15R77Jg/y0KYdJCc
         Uy8JSCGF3v7RGk6uGHQ5ueL6NtV/Nnde+/G/XtOqoDwDL+YxY3dE2mbnZzeGxUWAM3GS
         WdIRg/T3FYzMz4CoBXBGiVk6c2JeBffxrbyG/HFGpdyV0aJyV/0ozPrmhJA8zsMLOzeC
         wKXw4KqVVDvrNbgAu0P4lz16t6kfLu0tSW4oQ7PxNw1WqfUCg1WS4WtcIEp/cUXvm99H
         XCKQ==
X-Gm-Message-State: APjAAAUJ8ysB4qCJwfn7ObIH+YzL4+/UKPhArspAw95aDzR26Y6kSdx2
        K3lk64weflPUK+VPR6q+v/fqXg==
X-Google-Smtp-Source: APXvYqxWVObFtxc8k9qGwgpv8swA9U5M/tTW2j1JQwAybhEyWe7eCOqUCuBW7F0561tKaDSiK3xe6g==
X-Received: by 2002:a37:6d41:: with SMTP id i62mr241170qkc.209.1552000329639;
        Thu, 07 Mar 2019 15:12:09 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id b66sm3600500qkj.57.2019.03.07.15.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:12:08 -0800 (PST)
Date:   Thu, 7 Mar 2019 18:12:07 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190307231207.GA51897@google.com>
References: <20190120155838.GA23827@google.com>
 <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
 <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
 <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
 <0c46ab5f-8bd6-6916-fc4a-b6f00d456011@metux.net>
 <CAKOZuevksKGAPif_pUYVzFpbuBCxOZ5WzT6ukLCYm4TzyLUTMw@mail.gmail.com>
 <5ebec282-57b0-6ebe-0876-ce0dd7b0c11c@metux.net>
 <20190307205505.GB30028@kroah.com>
 <5e558126-9038-1ca5-4519-7b5864ca9fa1@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e558126-9038-1ca5-4519-7b5864ca9fa1@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico,

On Thu, Mar 07, 2019 at 11:11:22PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 07.03.19 21:55, Greg KH wrote:
> 
> > Ick, no, no more squashfs please, let's just kill that mess once and for
> > all :)
> 
> okay, then: s/squashfs/whatever_fs_image_or_archive_you_like/;
> 
> > Again, putting this in a simple compressed tar image allows anyone to do
> > whatever they need to with this.  If they want a full filesystem,
> > uncompress it and use it there.  If they just want it in-memory where
> > they can uncompress it and then discard it, that works too.
> 
> And let me stress the point: doesn't need any kernel changes at all,
> when it's just a file in the same place where the .ko's live.

Yes, but you're missing the point that some people would also opt to build it
into the kernel during their development/debugging (Config=y). For such
folks, they don't want to update the FS with anything during debug runs
either. Your "whole same place where the .ko lives" doesn't address Daniel's
usecase. You may say "initrd", but this is a much cleaner solution to that
IMO. There is no initrd needed and the path to the header files will be at a
standard location that is already pre-decided by the kernel.

As Greg said, you are welcome to keep it disabled for yourself if you don't
want it. This doesn't affect anyone else who doesn't use it.


