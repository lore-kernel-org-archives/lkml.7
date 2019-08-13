Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCF5206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svgoSdNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHMFDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 01:03:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34585 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMFDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:03:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so48812305plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 22:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKOfFTV6VGP5BNUB1Vnarc/F0DL+26vq0829FAbZrqo=;
        b=svgoSdNRxSLsCnnIOc7xbQg9GgF9oKMJ1Zy9kd11vWwaKXoOnKpb4m3E5VD5iVlgYD
         +Q8GW61vmO7pSODND/EU3ySpZFU6zBm/nnzXrEdbXjYeyp0z5HZ4MlPGEFDVamV7AnNt
         YxSzN7MGuqE5YtmeQLv8pM8cwjVoHM11Q7HgFuNs7NBSHTrEDEHtBfVlPMX1tM122Zoh
         /lJWbiyvCy294xIaxGNy1x0QeVRdkekMXrwW6vrlb0zY+yiiNnJIqQVHv78TipzeF0fL
         lbgrIbrBSmtQjgptdFMq0Sq8pSiArBm+sF/Wu+BeNyqHXo/vQXv7UP+JqfWMmgemFjSH
         IU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKOfFTV6VGP5BNUB1Vnarc/F0DL+26vq0829FAbZrqo=;
        b=LnDTmb41FoKBOJ9Fp3XFvGeVqFqRmxFS2AvFghDE3I2GOgLrXJ/F1mPKHtfoaMEhsf
         urqbTP2r8ZinoLnwNucHQd2atfebwhN9FADCu0q0jYVxEegc91/vLPPrOAZoneb4e3ld
         qxE4MNSRejISWYTnCSn9XiFEl+3Yle1J7EendCdWlGKeNMHGXP3EhdCXB61RPlzSfjqF
         Tf1otQFgAdQFF52DwZkCcla0sIWjb8w5U1+Y+Tx07SVx4FWECkC66BrZafvX78nwibog
         d5EbyJH+N5dNFasBX8MtB7q7G2knMvbcfuCI6SKvzNl3SCuwNet3/H8fMtlcmzyzTyOC
         x72A==
X-Gm-Message-State: APjAAAUmECOvsebvG3jt6NEoRxaK4an6IvXCk9jxkEJogv86KBKtL8vw
        7JnDDn5k3bFjvB6oLVMsQyv3RIA/0yR7P3270l1Rvg==
X-Google-Smtp-Source: APXvYqwgOw9EQ70Umy0oEnQ5G5LCL6qyMyWjnNbSVpHRs20m04I8HxLTnoiIjpuTiP19er8DvO/pyE/cwQSXqDyWk+Y=
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr26758654pli.232.1565672634067;
 Mon, 12 Aug 2019 22:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-5-brendanhiggins@google.com> <20190812234644.E054D20679@mail.kernel.org>
 <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com>
 <CAFd5g44GxE-p+Jk_46GYA-WWVHLW7w=yE+K_tbbdiniDfrk-2w@mail.gmail.com> <20190813045747.3AF0A206C2@mail.kernel.org>
In-Reply-To: <20190813045747.3AF0A206C2@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 22:03:42 -0700
Message-ID: <CAFd5g47OUymztYcWngDUd10WswVOrO-PTmX+KNF_T=cg_OcJNg@mail.gmail.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
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

On Mon, Aug 12, 2019 at 9:57 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 21:27:05)
> > On Mon, Aug 12, 2019 at 4:56 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Aug 12, 2019 at 4:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-08-12 11:24:07)
> > > > > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> > > > > +               .assert = KUNIT_INIT_ASSERT_STRUCT(test,                       \
> > > > > +                                                  type,                       \
> > > > > +                                                  kunit_fail_assert_format)   \
> > > >
> > > > This one got indented one too many times?
> > >
> > > Not unless I have been using the wrong formatting for multiline
> > > macros. You can see this commit applied here:
> > > https://kunit.googlesource.com/linux/+/870964da2990920030990dd1ffb647ef408e52df/include/kunit/assert.h#59
> > >
> > > I have test, type, and kunit_fail_assert_format all column aligned (it
> > > just doesn't render nicely in the patch format).
> >
> > Disregard that last comment. I just looked at the line immediately
> > above your comment and thought it looked correct. Sorry about that
> > (you were pointing out that the .assert line looked wrong, correct?).
>
> Yes. .assert is double tabbed?

Yes it is. Sorry about the confusion. Will fix.
