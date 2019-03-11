Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59451C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2103720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552322756;
	bh=OsN6ywD2yRXxc/xFL6Cr32d+xB5lpNyVEbyRMIiY1q0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sj3vK6qeMJ4VFMRc2VjmP7rVF588jBtdic99xK2P+2QwflhieoMtxxbaAfVAWvkXg
	 EWgnswB/X2XBjP+c8eCiD4NjDML/JKoHpce5Sbju22FwhEPBX58OcVxst3onV40B03
	 Mnnqx9ltYhqk9WIF6JRlbua8qOYlCZxcrToVr438=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCKQpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:45:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38616 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCKQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:45:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id x13so263747ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IWZhUvFcYTHDJsxw40ZzY7zosT2pLDUL9BX7h8YRIBE=;
        b=hHb1D9hYqFFijqa8C6MJegPdRB6ZPGUbFmJJTfNgDp2xmClbwLCVnz5TgVr/ffSPT3
         Rp1Ds/E8S67I/6q4xLNBfqr5tILsqAXs2fK8bgo0HxhL0ao6JQpAORRb9H/FNewD5H1g
         RBW+Nn0CFchDRDFiKnu8WiIGpf6rDpE2SOtsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IWZhUvFcYTHDJsxw40ZzY7zosT2pLDUL9BX7h8YRIBE=;
        b=aJjOiWxTyYmvH2B3KAGsz3B4GEWJY/8c+U3FcdjOq0TrXcEdzFS2MnNztXk+9jMejR
         qUmvf9ZLXNTl/0WuigLUs6NJdIbEMqib95leXbDpDMroSD76e4atEWMNFXF39fO5pDFR
         +GsC3IxwbXJ7q5fse/5ftQyDLE/A3341EkW+joio12+wcBOaHLAcSx+c8Ls++FS5rDQX
         JwS2LymzXbPkrbeT0bNFCQKZg1Loj9ai8dse/gj6xscicZ80YEsZ7cV7DDB440uxkfe0
         ElkAewvdRDeD51f6eQrmPQJ0Y1PK1JagwsSgPZMVllGA8UTyEuuz3HLBNAl3I8qQd6cC
         ilrQ==
X-Gm-Message-State: APjAAAUDx43j9zCGWPwpOUIQQk09eH2+CtqmcD45eruiLi2KujJPt8QF
        RKhirwVdat3dkl+f4qFOi+D+r9+ojew=
X-Google-Smtp-Source: APXvYqy5Atii9VAUKXRddGjVFSX00lDrESobIAYcgQyYhg6dPfpsmpWEUq1U7xxRs3NSouw6LFGAiA==
X-Received: by 2002:a2e:968d:: with SMTP id q13mr17561077lji.189.1552322751578;
        Mon, 11 Mar 2019 09:45:51 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q26sm332993lfd.27.2019.03.11.09.45.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:45:49 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id w6so4693889ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:45:49 -0700 (PDT)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr17126833lji.125.1552322748684;
 Mon, 11 Mar 2019 09:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com> <yw1xa7i14btw.fsf@mansr.com>
In-Reply-To: <yw1xa7i14btw.fsf@mansr.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 09:45:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
Message-ID: <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Matt Turner <mattst88@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:26 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wr=
ote:
>
> Anyone running an Alpha machine likely also has some old OSF/1 binaries
> they may wish to use.  It would be a shame to remove this feature, IMO.

If that's the case then we'd have to keep a.out alive for alpha, since
that's the OSF/1 binary format (at least the only one we support - I'm
not sure if later versions of OSF/1 ended up getting ELF).

Which I guess we could do, but the question is whether people really
do have OSF/1 binaries. It was really useful early on as a source of
known-good binaries to test with, but I'm not convinced it's still in
use.

It's not like there were OSF/1 binaries that we didn't havce access to
natively (well, there _were_ special ones that didn't have open source
versions, but most of them required more system-side support than
Linux ever implemented, afaik).

                           Linus
