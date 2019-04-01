Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D05C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB312070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="S3b9JyR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfDAAVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:21:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34444 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbfDAAVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 20:21:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id x14so6645083eds.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ugy64g5lxShNCgeI0XnKEHlsnAUFZXdH1UZzqRa7A5o=;
        b=S3b9JyR01XiCMlwAd/iDyqOU89cpGBuJrSVP78dj4/kzgPtB+jCFmHME8GMjb5ohWC
         X5v0ovtfFrh61KSo+WSohRcRv3K79/NdbDAtJQe4Uk/Dfn6VYQ2+nS6Y5L1G1sgF6i+z
         yIhULSPqkEO+C5QoGfuzFilePizaLghasLX7cNZFUuCvvnUw3UmFGrUtPZd8Zv/CUd1Y
         v08zjaY3AM4AkofEEHp+yEBBeU+uSq4lxLulgT1EWESky97N7eGSPHtx4ZJGCYfM3fH1
         Zql2pmKPu5eQfYb9WOWb8staxub25Imd45S5YCCUS89jiPI9U7s/DZdvrK6wQwiw9b/p
         8VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ugy64g5lxShNCgeI0XnKEHlsnAUFZXdH1UZzqRa7A5o=;
        b=N9Dy8g9Zb0+QAfxIRzl5ypRHcGeZ/yXl3bZbvj6Ud0F5NqxOl8zexL2M+abBdAlKVh
         YALc4SocOoFXtTF9FaebqmFFeqhPUsSLy5MNvuQR7LUnijTRLNbu8e0Yyz9pPOcNtoqW
         mgamCSv5jTYsnjn03FzNOe/5aYpakvOwouv7Apfv+W8k+lyYQSjnv94iQSjST5RNfPMD
         An11L67aCuUlTXPoi6k3v2zrW22HoB/EOvVFA6SZnTmpc0cRU2bfqg4kqFz18PXqrmgi
         rKNn1fTIZ0Q81Iv9hP86hF4uHJJQ1s0hEABNkj0Guoq2MQiVfJ3mlHLiFwTthoO/V6h2
         6vFw==
X-Gm-Message-State: APjAAAUqGSCRYEbGsh2nwVCHZ5puhQLf4WkRVJ8E/jLYEbHPjiHEkwvt
        UEQIRovim54edaqee8G+GPZTaQ==
X-Google-Smtp-Source: APXvYqyaixGGfy0IvIE7xH9dvsH10HLg4bfpSpPQ8gmy5djY1R2ZdtWoeVz+eP4T2A8XYcu7yqsOxw==
X-Received: by 2002:aa7:d146:: with SMTP id r6mr40068006edo.235.1554078111993;
        Sun, 31 Mar 2019 17:21:51 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id x54sm2716027edd.35.2019.03.31.17.21.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 17:21:51 -0700 (PDT)
Date:   Mon, 1 Apr 2019 02:21:49 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190401002147.vv23md5spi34uyjz@brauner.io>
References: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io>
 <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
 <CAHk-=whw1cnWPSWw1tHXT5xTMbnJFbCtx9_re6U1RZ_7LE9gXA@mail.gmail.com>
 <20190401000937.GG2217@ZenIV.linux.org.uk>
 <CAHk-=wi39-Ozq5zb22s7ZB4J_Nd6nTwE_9A3+qjp5nCY4iTSEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi39-Ozq5zb22s7ZB4J_Nd6nTwE_9A3+qjp5nCY4iTSEg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 05:18:10PM -0700, Linus Torvalds wrote:
> On Sun, Mar 31, 2019 at 5:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Ugh...  Which vfsmount would you have to go with it?
> 
> I'd literally just do a lookup of "/proc" in the current root
> directory in the lookup() function for that special pseudo-dentry.
> 
> If it's not mounted, or not a /proc filesystem, screw it.
> 
> > Except that we never let unattached _directory_ dentries out - if
> > we can't reattach them to the tree, open-by-handle will tell you to
> > take a hike.
> 
> Absolutely. Which is why I said it's _conceptually_ similar to the alias lookup.
> 
> And I suspect we can even use some of the same practical logic, but
> it's definitely not _exactly_ the same. This thing very much involves
> magic hooking into the lookup() function (but we then have to look up
> the alias not for the path we're looking up, but for the _parent_
> we're looking that path up in, which is very different from the normal
> case).
> 
> > It's more than a tiny bit too clever for mine...
> 
> Fair enough. The whole "just do the whole lookup at pidfd creation
> time" is certainly a whole lot simpler.

Even just from a pure maintenance perspective this sounds a better to me.
