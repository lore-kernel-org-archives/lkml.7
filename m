Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A14EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D180820665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9dOYm8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfHLXdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:33:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41712 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfHLXdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:33:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so3319672pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTfhhIMEVWBJ1fQ8dSU/yBqkpCSWczjteIKFZOpbLX8=;
        b=c9dOYm8jUrYmRfI5dEYJE2Wdnda5vlKFp8TRu/bv1paeS5Nb3I93x9HcYZ5ednOIno
         wGUiE4FUkpp0oe3pnvKv6pG5E0pSyHTSelc+rec86VL0eKpaX1nLvJb20gWSbR51tasf
         pgzzqgph/ELjX9q8SLyXYbEtVD5OMe2Bv9/Yd1k25uiMzejzz4xG8apO6djfJpMz8vcn
         XxJ7D8O/Gc8sfv/yWGdO+KIi2sqttmFcaUq9dKaYH8/xsyQWTJSFN1Jmxc4txyx4aB+z
         WGBS3gigW8iS9W0dFVg6j9MrUrNTENxkLxw6lLoD3AWXnMP8qmgG1uCcjQTNKLdPM7ys
         zaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTfhhIMEVWBJ1fQ8dSU/yBqkpCSWczjteIKFZOpbLX8=;
        b=kxNLUUGtQnTsFrPIPh+RikTXp7IQBDriOW1n/wX4wPSoc5ssq8v3El4OCnD3Wimadp
         kMGFlm+UkMeHM/U6IqGAe3HaNZimanM2/uOTRfvhWY56o2mcZDKXFVbEDVVs3x3w0vSL
         NCd6+rcVLJHZEBP/iAd/phtIDvIUQQ4XrpC/ZiOkkJqnuCmv6B5nzgxTcQ9Blxwmbis5
         Oa3/ZUbgGPFMVBp3Uqzg1Wa4MudjzTO4qZFzbXN8WvwPT99MAcwqQ86N4XpjhKqLh7Gz
         njXWrIrEIMNQk4hYczul80V3Geh/e7OJ7acNh4nX2o80kdKTf1jZV0LJGpWKFsBqjSk0
         k0Og==
X-Gm-Message-State: APjAAAV/epyU6uZI9wj96D1bS4b3z9thkOFJ/QwF1I0gh7qZKQNqbU56
        FHO31M93ICXY5c46TrrrBY8YxA==
X-Google-Smtp-Source: APXvYqxcDoap4N3EkfxGt7+4TrFgEHcuwub7I5n6cGzvsvHggQpTuDBEDm80K9tY5UT8aKNLpSv+9A==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr31927403pgq.415.1565652822096;
        Mon, 12 Aug 2019 16:33:42 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id j187sm13658683pfg.178.2019.08.12.16.33.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:33:41 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:33:36 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
Message-ID: <20190812233336.GA224410@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812225520.5A67C206A2@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-08-12 11:24:06)
> > +void string_stream_clear(struct string_stream *stream)
> > +{
> > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > +
> > +       spin_lock(&stream->lock);
> > +       list_for_each_entry_safe(frag_container,
> > +                                frag_container_safe,
> > +                                &stream->fragments,
> > +                                node) {
> > +               list_del(&frag_container->node);
> 
> Shouldn't we free the allocation here? Otherwise, if some test is going
> to add, add, clear, add, it's going to leak until the test is over?

So basically this means I should add a kunit_kfree and
kunit_resource_destroy (respective equivalents to devm_kfree, and
devres_destroy) and use kunit_kfree here?

> > +       }
> > +       stream->length = 0;
> > +       spin_unlock(&stream->lock);
> > +}
> > +
