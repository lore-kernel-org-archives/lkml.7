Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F66C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A630C2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IR8gpax6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfGPRv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:51:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37069 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:51:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so9807152pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxEnHLXatCKhmQ8tqkHkTC9RIIficSilWz6s4BKeyXQ=;
        b=IR8gpax66RigZJS8zzOEEHslcoRtMBTJQr+BwYoG5krQI/IrW7RBJJOb1HnDxCU/yV
         QgfV9zvBkZxiaRdpVQ5UvleUCuWprZ5drSQYCn+Y2SQ0WJBxkU9y96Vg0A/X9/w6puUy
         wJPZSB5OIH+Fs7UZF2sgnWroJ6gzdmui3EJVbxSAUEw1zlnflSZQkCP2CyGkcZhrQ2Ik
         nTu4JglIMF5h/vJexddFclKM2bow42WXkycOAGCzBHj4V7nlFfCvnoPh2kZ9tat4r+lR
         ldeIM3HQ86qC69oeN4VGJIE3aUlKeqjYM8fm2x0XfJ1yNou0BI3BeFip69rcKSz9jBAN
         0rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxEnHLXatCKhmQ8tqkHkTC9RIIficSilWz6s4BKeyXQ=;
        b=p0k6AdGFnNmYKtxFQQEkOCV8pEedOr16n6gcb+Umnvg3zcKsAaODkZMasPhAlhe3lV
         9JfaEMpGJzOogG8qE3KXqlsV6g2K1Dgo7fLVW5ZISDItuH3BK1+xUpN+snQtwBiEe+EA
         34Q1kmAE00eyH1AzdUqH+i+eePtclqfsTiX4yMqkqxL+nL3kVykxSw9+4cG+ZaJj6ETD
         2zW7Mr3H3lFEWiou4s7a/ie370Octezm2koJY2lMSCl+ost+QY2fNps3EHmwb90W+Uzc
         qia4ZA1uj53hOBnqEn72PoBvl/8ZCylenQpnknSXXa9u5QiqWVCPj0HwStsNHx037HGq
         0/gA==
X-Gm-Message-State: APjAAAUNU6ruxnKO1PKFr1/BG2N/V9JDsXP1XZT0XHEVha0e+ITlfcZx
        Pt4uWb8mvJpzojUt96fwE1ptiTvTOOSvp7GaJs+zWA==
X-Google-Smtp-Source: APXvYqyaJ18vLD4kzF4vse9+yxk+DvjTEGfbRhJU4ABRtN/S/Q3OhUTQ5bxT7G2cnasvpqzT1qZSk1Dd9UfyhosJ/h0=
X-Received: by 2002:a63:b919:: with SMTP id z25mr35314546pge.201.1563299516676;
 Tue, 16 Jul 2019 10:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com> <20190716153002.49E292054F@mail.kernel.org>
In-Reply-To: <20190716153002.49E292054F@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jul 2019 10:51:45 -0700
Message-ID: <CAFd5g44jruCZLunpQuDPnQS995x0F+Gxp99z4BoP_pLt=Hr1BQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
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

On Tue, Jul 16, 2019 at 8:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-16 01:37:34)
> > On Tue, Jul 16, 2019 at 12:57 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 3:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-07-12 01:17:30)
> > > > > diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
> > > > > new file mode 100644
> > > > > index 0000000000000..a7b53eabf6be4
> > > > > --- /dev/null
> > > > > +++ b/include/kunit/kunit-stream.h
> > > > > +/**
> > > > > + * struct kunit_stream - a std::stream style string builder.
> > > > > + *
> > > > > + * A std::stream style string builder. Allows messages to be built up and
> > > > > + * printed all at once.
> > > > > + */
> > > > > +struct kunit_stream {
> > > > > +       /* private: internal use only. */
> > > > > +       struct kunit *test;
> > > > > +       const char *level;
> > > >
> > > > Is the level changed? See my comment below, but I wonder if this whole
> > > > struct can go away and the wrappers can just operate on 'struct
> > > > string_stream' instead.
> > >
> > > I was inclined to agree with you when I first read your comment, but
> > > then I thought about the case that someone wants to add in a debug
> > > message (of which I currently have none). I think under most
> > > circumstances a user of kunit_stream would likely want to pick a
> > > default verbosity that maybe I should provide, but may still want
> > > different verbosity levels.
> > >
> > > The main reason I want to keep the types separate, string_stream vs.
> > > kunit_stream, is that they are intended to be used differently.
> > > string_stream is just a generic string builder. If you are using that,
> > > you are expecting to see someone building the string at some point and
> > > then doing something interesting with it. kunit_stream really tells
> > > you specifically that KUnit is putting together a message to
> > > communicate something to a user of KUnit. It is really used in a very
> > > specific way, and I wouldn't want to generalize its usage beyond how
> > > it is currently used. I think in order to preserve the author's
> > > intention it adds clarity to keep the types separate regardless of how
> > > similar they might be in reality.
>
> You may want to add some of these reasons to the commit text.

Will do.

> > > > > +
> > > > > +       if (!string_stream_is_empty(stream->internal_stream)) {
> > > > > +               kunit_err(stream->test,
> > > > > +                         "End of test case reached with uncommitted stream entries\n");
> > > > > +               kunit_stream_commit(stream);
> > > > > +       }
> > > > > +}
> > > > > +
> > > >
> > > > Nitpick: Drop this extra newline.
> > >
> > > Oops, nice catch.
> >
> > Not super important, but I don't want you to think that I am ignoring
> > you. I think you must have unintentionally deleted the last function
> > in this file, or maybe you are referring to something that I am just
> > not seeing, but I don't see the extra newline here.
>
> No worries. Sorry for the noise.
>
> > > property of the input, it may or may not be enough information on its
> > > own for the expectation to fail, but we want to share the result of
> > > the property check with the user regardless, BUT only if the
> > > expectation as a whole fails.
> > >
> > > Hence, we can have multiple `struct kunit_stream`s associated with a
> > > `struct kunit` active at any given time.
>
> Makes sense. I wasn't sure if there were more than one stream associated
> with a test. Sounds like there are many to one so it can't just be a
> member of the test. This could be documented somewhere so this question
> doesn't come up again.

Sounds good. Will do.

Thanks!
