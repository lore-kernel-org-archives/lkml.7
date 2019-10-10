Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DA720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570745591;
	bh=IqedBOsL9l3pTZCmfirxcleZS9cMxUK8tUQMLfnpjXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O1qqU/Wxaif986NZ+hr7ixf4WQ/d+N8F8MiF/xsMByNtet7WxwPDUhixANvRLiGFT
	 a87A+pJD5H7H6w2P5ktD6L+KR4a64sjBVBdlqgMgxLNmcvJa1yj/3Zg0y3i3ScmYlP
	 QctWmVXo24w60PH4/30up2bkMt0/QrKY2Qfeacno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJJWNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:13:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44887 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfJJWNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:13:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so7761223ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vF7vVvcx7X2Y4bkz6NSFslpoAQ3GnfhWGvkOzcDGukk=;
        b=AePMDpuhTnjZhuA+/iTNCIk2Byoun7PsLjybqrf7awqwwp3sOrG6tM3PCboDKAch+d
         EhWYtOGQhvAGMcekGIWbotORBzlbwuFZcc8XQPO39gh+OplKN3UleWxt/iI7gTOIQILP
         MeBm7+0MuhDlPPspHH3U9j73Xa9+HDEGQFOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vF7vVvcx7X2Y4bkz6NSFslpoAQ3GnfhWGvkOzcDGukk=;
        b=UkMvkdJ/kagus37wVI4Kym6iFpFIbyxBFGaYNW8ZBtzzhgLROMjgA23VK2l6HPp76E
         TlZNKVbTZdnJ2mWy3rIwQflWaxvmTGCXKsydN+SGYpfeCpc+a9g4Gh09AFRGiVuYDS/3
         DIfHQnVkp30cSPH8YtpWn/uBuTRc2MnNsKJPCyvhF4WXRdIF8p4eIgbzd7ngFd+jwHbG
         WR7y8onzhnUpbKnLnpfwl5/DPRu0G6yqAJzrOCqsu9T50XfogijWhVNCMED0zhh8JGEi
         1vcm0Q3nqaLQslZxsVZci9FNyrfgKc/kOGnUP5NvVjn0jIR0ZGrwIrN4t71VVPA90970
         UY8Q==
X-Gm-Message-State: APjAAAUAC7zwO/SDRRbPS5JaYi9VaSy3B2+MJuuhrj4iFOhu1zwLG62C
        tKDBsty6OJuKeJm9xCcd0eAhuYQ+fUQ=
X-Google-Smtp-Source: APXvYqzh3YT3CQQn2pZlPRp3Gq7dEnauZ2uG2bvAlyg9456QZQrxs6Uh7aWFNI7Kwon0qrE+PdJVmQ==
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr7351202ljk.108.1570745586871;
        Thu, 10 Oct 2019 15:13:06 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g5sm1509467ljk.22.2019.10.10.15.13.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 15:13:05 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v24so7814501ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:13:05 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr7522218ljh.133.1570745585422;
 Thu, 10 Oct 2019 15:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com> <20191010195504.GI26530@ZenIV.linux.org.uk>
In-Reply-To: <20191010195504.GI26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Oct 2019 15:12:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
Message-ID: <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, another question you way: what do you think of try/catch approaches
> to __get_user() blocks, like e.g. restore_sigcontext() is doing?

I'd rather have them converted to our unsafe_get/put_user() instead.

We don't generate great code for the "get" case (because of how gcc
doesn't allow us to mix "asm goto" and outputs), but I really despise
the x86-specific "{get,put}_user_ex()" machinery. It's not actually
doing a real try/catch at all, and will just keep taking faults if one
happens.

But I've not gotten around to rewriting those disgusting sequences to
the unsafe_get/put_user() model. I did look at it, and it requires
some changes exactly *because* the _ex() functions are broken and
continue, but also because the current code ends up also doing other
things inside the try/catch region that you're not supposed to do in a
user_access_begin/end() region .

> Should that be available outside of arch/*?  For that matter, would
> it be a good idea to convert get_user_ex() users in arch/x86 to
> unsafe_get_user()?

See above: yes, it would be a good idea to convert to
unsafe_get/put_user(), and no, we don't want to expose the horrid
*_ex() model to other architectures.

          Linus
