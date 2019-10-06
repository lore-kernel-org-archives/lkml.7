Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D2ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEBE2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382768;
	bh=GgYWA7qaSXBEzwDAqMRbYTM4YhmvkMNZCj6QzTkCgts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jLxujhSgWAZ8PVANqGbfiDffsoK48qwg1tGjh3q8F5ms6t/X3QK4bu4flz9DrS7cG
	 N9PWCdvzDCqg+uWAJeSlmLLKWht6GxqEvJegLhzxkjuFau2t2DGRXswHlTO5KUOTyn
	 gO2meTZencsVGla8sl2nghT1OFQZASDvMMUxaprw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfJFR0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:26:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46993 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfJFRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:25:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so11197871ljl.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqhtcbRfDvEQJJkAJFzv4RBTuiXKftvmCXLEi1f3srQ=;
        b=RFX9iEr5oOWgtzp3IBXT04OndQR1DU0EDSHmP2z8P81qc5WnlH3q3z+H6Fn+Q2bRDQ
         H0mj8t0g+mmdm8jwf4l9ysW9y9jx14fPTmNboT3xsSFw9Hg+XXFMXj7P26RjheVyaX4i
         ysqZhaJqY2V93IZXO8nKnxagXIV7guXuOEkKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqhtcbRfDvEQJJkAJFzv4RBTuiXKftvmCXLEi1f3srQ=;
        b=KDkq4dXVfcQAmh3CxOXiGrUz+y7Z/dwsNFT42lbYESyKbpfwYfnkMzweIsUByTLJnq
         BMSYRqj4VkN+a6//ODZsrLSuaT6blHCMbAhVFSRtazgMwc2LrO1ZPkdQCHahHm4YfZVP
         W/c9AeCvcHwFwb8a5Oq9XezUEgMRbyrvGpkoZXZI4cWYSYj9pUYEDe07Yv9jafDjFChE
         NB6fOQ+X4iwho5mBkTu9Jom6LvSuOEQccVwV7fkVJ2r3uaZPhpjOVhXny3KTV6USWARh
         mOcMDOOYFymNZIBVUirCmRKij3K33qIFLIgJfu0x53niRdhu/Or7P10XFSr9Dm/pWoSy
         0ciA==
X-Gm-Message-State: APjAAAV4bk9ywIhLjm9cxtCRR2r7YJ6HUK9B0x4prjNHRWBoVBEUxrb9
        GVTXAlwNOSePHD26xv/cblCaq7EivnA=
X-Google-Smtp-Source: APXvYqyAnrFodHfkM8l4Eg7mw1G8tK3kI1Os9G/St1/DCnh/0cBbQ1Ig/ViDhTbzCFNJnmqr+KeKgQ==
X-Received: by 2002:a2e:8789:: with SMTP id n9mr15842634lji.52.1570382754121;
        Sun, 06 Oct 2019 10:25:54 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e29sm2561636ljb.105.2019.10.06.10.25.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 10:25:53 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x80so7654791lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 10:25:53 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr14509292lfe.79.1570382307072;
 Sun, 06 Oct 2019 10:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org> <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org> <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu>
In-Reply-To: <20191006165436.GA29585@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 10:18:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
Message-ID: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Well, one thing we *can* do is if (a) if we can create a kselftest
> branch which we know is stable and won't change, and (b) we can get
> assurances that Linus *will* accept that branch during the next merge
> window, those subsystems which want to use kself test can simply pull
> it into their tree.

Yes.

At the same time, I don't think it needs to be even that fancy. Even
if it's not a stable branch that gets shared between different
developers, it would be good to just have people do a "let's try this"
throw-away branch to use the kunit functionality and verify that
"yeah, this is fairly convenient for ext4".

It doesn't have to be merged in that form, but just confirmation that
the infrastructure is helpful before it gets merged would be good.

               Linus
