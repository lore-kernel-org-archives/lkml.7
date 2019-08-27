Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BAAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A12189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566924930;
	bh=+WIJPbfFFTsfVxryuS8WGF4tFzXr57zHZ6u1GKWYES4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uLuJWC7dQMIotP3IANuTd/gyoSnvpwxV5eb+16aJdHuixWqK2Aj++NaXU+gGY62/o
	 nE1dght7id7WeIkgxlcjUgiI95wzqgcl9afRJo5kq+7vaRuQuyrdGgGwvv3WvcIq1w
	 4Je+hNoB5tHb2mQtCJlOQwlh4wi6AT7UxLeTkFMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfH0Qz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:55:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43411 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfH0Qz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:55:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id h15so19131269ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqY+b9Dj3iVCGtyE7FtE8JXdh5S7pY2HNshV0ecODy4=;
        b=P19yO01iWJmn4l3JSh2MgFqZQN9aqxepv/FKXJ1IM0JIRAUBZicN4AWFB7erUdyhCS
         jq8RQmnDuo0D6n/K7ILwZn79DnkgPwyauOs0tOWvc43XTU/+s/Cojex9dO+1dsfVq7MS
         xkUl+CQDfut07dcs7YEObghowK+KJGIAkv0Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqY+b9Dj3iVCGtyE7FtE8JXdh5S7pY2HNshV0ecODy4=;
        b=Liwr5QIV/VxsFigwDJdYsj++LPV0VoNx5FjdlJgJxm04WS7pR8PptS9J8I2pktHc/g
         u+oGZa129NqbzAi7PtuAvOcbzPLM5GiYUqDPLeIHt/IFTDi9anRY2Otiqufo1QD/neTy
         tB01OS5mrxK8pFfzKaBMfoNG92Ur9xPD8NTxMMNyzkNt1y9ELJXPlsxQe+iMmDQErt6x
         eIMo0Ow0axjy+X1h+6yRh3KwVuV8ByFbdRRSmHKT8iV6EE2sFryZZ/WiFIJHt4oGnAxg
         RvYryRN/38aP+K7RxMIO/PWxsC2KrI3xHyF7bvOrP7VwImaulcU0KZ+x/YzgViLbjI0F
         mVeg==
X-Gm-Message-State: APjAAAU93FA5qCN/4iauWW1S/sPUZGcliidkmk0HFpKclNWZ+DJjcotA
        +CS/k5ZhekHmqwpdsscVaWdts8UN90Y=
X-Google-Smtp-Source: APXvYqxW+z7y7KapvGsDlAWZ7P/WR8i6cC0AOvGJecFgB1oMRym4Jn+krvDHvEREtuswORsc9vMNnw==
X-Received: by 2002:a05:651c:158:: with SMTP id c24mr14684418ljd.66.1566924926004;
        Tue, 27 Aug 2019 09:55:26 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b27sm2585911ljb.11.2019.08.27.09.55.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:55:25 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u13so5852217lfm.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:55:24 -0700 (PDT)
X-Received: by 2002:ac2:428d:: with SMTP id m13mr14759557lfh.52.1566924924456;
 Tue, 27 Aug 2019 09:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic> <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic> <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic> <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic> <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
 <20190825201723.GG20639@zn.tnic> <20190826125342.GC28610@zn.tnic>
In-Reply-To: <20190826125342.GC28610@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Aug 2019 09:55:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com>
Message-ID: <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 5:53 AM Borislav Petkov <bp@suse.de> wrote:
>
> +       if (!changed) {
> +               pr_emerg(
> +"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
> +               WARN_ON_ONCE(1);
> +       }

Side note: I'd suggest

        if (WARN_ON_ONCE(!changed))
                pr_emerg("RDRAND gives funky smelling output, might
consider not using it by booting with \"nordrand\"");

instead.

Note that WARN_ON_ONCE() will only _warn_ once, but it always returns
the conditional.

So it's equivalent to your version ("always print, warn once") except for:

 (a) smaller
 (b) different order of warning and pr_emerg()
 (c) the WARN_ON_ONCE() also contains the proper "unlikely()", so it
generates better code

and I just try to encourage people to use that "if (WARN_ON())" format
for these kinds of "shouldn't happen, so warn and then do something".

Although usually the "do something" is just "return and refuse to do
anything further" rather than the additional printk.

               Linus
