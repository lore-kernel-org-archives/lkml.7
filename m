Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D93E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8htFQGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfC1UI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:08:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51099 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC1UIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:08:53 -0400
Received: by mail-it1-f193.google.com with SMTP id m137so279954ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXa4aw3Kp05X/TfkEO7Kz/YGOX0pHLxbS3qn41bra2I=;
        b=F8htFQGLOx8rOJ/PUrM899ncSK9ex/eqiOBDGKlu12kUTENuN9iQZ92nBpzaNk2zFp
         1RwoZGwVTs/DZuulS/L3/VaU/w3OMD4XYEsM0UqT7O2LC57mfI/WwHkV/WjVJTEKtSd3
         JGwmDreClRvFPz2t6deVlyPEnxBKwTgpEpQFgvacdJ1aeUvcgPPpLPb6iRmwPe3rA9Zg
         9qC+Q+a5s/OBcmk7RuFoanA+5YuXH3eev8evCg4fRar8g2dJ82u3Hupb5Txyqhoeq8i0
         FD3LoAQdNrwZJ61h0cQapbPCTB49qqtLi8ecc8qx72ySVzBiG3IqoHXopXAKCpL8K/XF
         QRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXa4aw3Kp05X/TfkEO7Kz/YGOX0pHLxbS3qn41bra2I=;
        b=ueC2ai+z/oiIbVGwryDe+Cd07n9ERTg0sZjFV2ah80XA4qQtvz0Lp6OOllbkEh/5yH
         hJndkvn25LENU0wil53KzZB+6dOLbNQqeX+5VlIpPm5Vjf2hJwSoEX6uzzz5j3LnhL6d
         hD7k/ExLVDuTOhYOQGNv1Mzlsj8W0vrDCX7IOWuTDaw+/Qiq+2tcq4sAU7M51VsKW/RV
         OA6pjkXalJQMJgLyPY8vgx4YZ9OXNwhTG9c3ykfHgEC2hjQY9fi3D0qxreQQz+fbcRRD
         uMY17kWS43rJ22hPh+YPyk9ztFdEC7WSEI8OkvGN6YPP6jU9vSRjrbqhqQQnQHIezwzT
         AuMg==
X-Gm-Message-State: APjAAAXwgpVqtbvYjp66zOAJOHuQ90vHlVJImCHP1JHcgwC3ZpSSErb6
        32FwUq9NbNXk6QQ+AZreOKBgKO5h0HoJnBwafxk68A==
X-Google-Smtp-Source: APXvYqyWywh2R8MMEKwy93JCRcDsRn2zKXc1oTE06EvJgHduUfwzKZnct0bX7he26MrdcD1D0gDrDBw9QuQOmc01mJ0=
X-Received: by 2002:a24:4e91:: with SMTP id r139mr1578477ita.118.1553803731483;
 Thu, 28 Mar 2019 13:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
 <alpine.LRH.2.21.1903270523240.5235@namei.org> <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
 <alpine.LRH.2.21.1903281403540.27561@namei.org> <CACdnJusbi1jB+G0wMcj43wNik9Fiv3QCc8v30ztrFWg5-P-0iQ@mail.gmail.com>
 <alpine.LRH.2.21.1903290621350.1769@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903290621350.1769@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Mar 2019 13:08:39 -0700
Message-ID: <CACdnJusN0XwKAFhCk-z2+u8Wn1OOzbSqQYYACFikcAtFqOA+WA@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:23 PM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 28 Mar 2019, Matthew Garrett wrote:
>
> > On Wed, Mar 27, 2019 at 8:15 PM James Morris <jmorris@namei.org> wrote:
> > > OTOH, this seems like a combination of mechanism and policy. The 3 modes
> > > are a help here, but I wonder if they may be too coarse grained still,
> > > e.g. if someone wants to allow a specific mechanism according to their own
> > > threat model and mitigations.
> >
> > In general the interfaces blocked by these patches could also be
> > blocked with an LSM, and I'd guess that people with more fine-grained
> > requirements would probably take that approach.
>
> So... I have to ask, why not use LSM for this in the first place?
>
> Either with an existing module or perhaps a lockdown LSM?

Some of it isn't really achievable that way - for instance, enforcing
module or kexec signatures. We have other mechanisms that can be used
to enable that which could be done at the more fine-grained level, but
a design goal was to make it possible to automatically enable a full
set of integrity protections under specified circumstances.
