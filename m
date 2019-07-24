Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB82C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDCF21855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GGWhlUW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfGXWB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:01:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfGXWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:01:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so43105132wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BV6dM8lKRM4nhvSMMWnOBjohuWI0KYuThYPBtqqjlnQ=;
        b=GGWhlUW9ryx7EWI6z+Z45cz9XopIiSQe38PSDmjbvfqKkCIK9IsRQA6UGQhDZvq2+R
         O+VjLW5fkETWlc1kwbnBUbDG2yWjXwDEkjayqYbBzC1iSjXW2970Zfi4k3sjaulApZUj
         bAxJFgeHZywTFhfAzsV/6ClZUQl61976hHv5hRI9Qdm6oS9OmyJ6miEjgTAi8d7IT0Gn
         dgy6su7/zbVTAGjZPkurkiwRS95wmd3jQfCj6u19AmiyHJ7BmSSoilQUFhSKg5sTCsRS
         RrHGmsIgPIRzycfeVF9HGAHn3+mZm6AQTwUcwIC+ylTsqqsGUdj2Q0ggbNmpuEjpns9g
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BV6dM8lKRM4nhvSMMWnOBjohuWI0KYuThYPBtqqjlnQ=;
        b=YArqjMEjWmDInkNqkCfmqFHztZmNM+a+ahMVbchbc8PzcvABucF2dcj8i9Z+E+JQ+3
         1YY6SRbVLr86WgCeYyZI1qpRBLHeSP2uYPKXypWBZS7m6C8u9MeSh9CF+500Or2RT7Ia
         aPv9heR06TR2zrRyI9aI3RL+ZIsOKLIeTJz9Q4VoaNQZ9z1yLiOMr/MSTZhrr6rIgXy9
         OHREQuBsANfHNCiwAh9/W90NzaN3yPaAyeA4fheTSAXIdAh48ADPbf+7oKuAGDK8WXwX
         h8LTmQnavFpJ6Z9YhWTqBylJHTZwNpNwNR9lAOsH2Fgsd5oDUHZJHvGgNNF2kFKR4kgp
         HCIQ==
X-Gm-Message-State: APjAAAX51JrC9AFkQtcU8RwEPxc5FPuUmRrwpw7i26R4wCb8WbDzuS10
        7JZOXZp0TSj7FiSsPqU9qB8=
X-Google-Smtp-Source: APXvYqySOYd3c3d4JXXMTvCMWHsjoNUFQ7SXwW5WVzu7QUVTwB7MEiaam7YDisfWhLmsNK25WASSNA==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr75496324wmf.115.1564005685476;
        Wed, 24 Jul 2019 15:01:25 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id u1sm43447538wml.14.2019.07.24.15.01.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 15:01:24 -0700 (PDT)
Date:   Thu, 25 Jul 2019 00:01:23 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RFC][PATCH 1/5] exit: kill struct waitid_info
Message-ID: <20190724220122.ngf6arhl7gqcnwzf@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-2-christian@brauner.io>
 <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOLjnZdZBSDwNbaWp3uGLGQkgxe-2HmNG5gE4TLbED_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:37:34AM -0700, Linus Torvalds wrote:
> On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > The code here uses a struct waitid_info to catch basic information about
> > process exit including the pid, uid, status, and signal that caused the
> > process to exit. This information is then stuffed into a struct siginfo
> > for the waitid() syscall. That seems like an odd thing to do. We can
> > just pass down a siginfo_t struct directly which let's us cleanup and
> > simplify the whole code quite a bit.
> 
> Ack. Except I'd like the commit message to explain where this comes
> from instead of that "That seems like an odd thing to do".

I'll respin and will add an explanation based on the info you gave
below. Thanks for providing the background on that!

Christian

> 
> The _original_ reason for "struct waitid_info" was that "siginfo_t" is
> huge because of all the insane padding that various architectures do.
> 
> So it was introduced by commit 67d7ddded322 ("waitid(2): leave copyout
> of siginfo to syscall itself") very much to avoid stack usage issues.
> And I quote:
> 
>     collect the information needed for siginfo into
>     a small structure (waitid_info)
> 
> simply because "sigset_t" was big.
> 
> But that size came from the explicit "pad it out to 128 bytes for
> future expansion that will never happen", and the kernel using the
> same exact sigset_t that was exposed to user space.
> 
> Then in commit 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in
> the kernel") we got rid of the insane padding for in-kernel use,
> exactly because it causes issues like this.
> 
> End result: that "struct waitid_info" no longer makes sense. It's not
> appreciably smaller than kernel_siginfo_t is today, but it made sense
> at the time.
> 
>                  Linus
