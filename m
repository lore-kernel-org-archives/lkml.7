Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DE9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663CA2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJIAYLW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfECAlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:41:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43260 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfECAlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:41:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id j9so2470547oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/LGIUMFfkHhxCSDT3fm51UOA28cPrGRFTawiLz9qdU=;
        b=FJIAYLW9LNf9oanARKl7TfF4hN+5D95QZaw548QJynu0CjT8BCwlpKeraO6t9YYkOs
         GtNX3/gAG5EXPOJwbqEw8XIrwSSwlKCrob0M1UGIcbcgu72bFgtpR14EttoAsQY2aDgu
         R3g2UNQXhcb3FGDMQxi+sYsTRkYHs3qzvEqqHMGSEtbYKM2QA4nxdIkJahuLnsBoO2+c
         TGr8njZSgd2pD66c4pynpYDwYtRx3F05qDNXkbRYRi3lANeuXFpYdvOTMjhMHRrrhF8P
         3i1MCfzjUMz11YJpZRIR9WsEPFVnmwGmtj8MUe4JYxQcAMMsvhz5BhNLX+0hNU5ukE4d
         83hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/LGIUMFfkHhxCSDT3fm51UOA28cPrGRFTawiLz9qdU=;
        b=XWz99adP7/xg5nu0HECDWYysiSB8MR411oWznaa6+vFFKzi3livhcxyQVCWjWhNp5o
         mcMRH/WrWYER892LBYNHD+NP4K7JZumjOth4tqAuahq9Lcu2kIiM1ml7AVgcxxI9+I+d
         V30T4tWcpyBYMLd6ctCPnPIoUqSDNk9ThqYpKBYmknq3Ub9eNOh+SBME5YbIcd6Cqc6N
         CaY0nkgGM1VZq7rzPn17eIbqJfLtte1b9aMn4elZUpsYqnnZg1f3nOMcMnPQ+AvdfTzM
         LqAXclpprgKgq4Uqimuab43/+TbFzYu+qqX1l5NPRyVVPfiKh/js8WfG1URjBEyGWAyQ
         MbKA==
X-Gm-Message-State: APjAAAVUFTwbgEATBiV43HXvpjeAccg2GajrCx8/nbBRetAYQyacsklK
        DQKgMDnaUSbLXpD0hPZ8OeLEAHspWc9BaUrxIPlI0Q==
X-Google-Smtp-Source: APXvYqx+IeNo/M2uU5es7ZAJsOSGR6b01vZ0dEQaWTEj9cNFRVwEHLuSMfXDE/OIHXARFXXWqbF1LQIlh8BGLZyE6Eo=
X-Received: by 2002:aca:4586:: with SMTP id s128mr4126147oia.148.1556844080319;
 Thu, 02 May 2019 17:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190502105053.GA12416@kroah.com> <20190502110513.GF12416@kroah.com>
In-Reply-To: <20190502110513.GF12416@kroah.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 17:41:08 -0700
Message-ID: <CAFd5g46RyQ+jaV3bDejBaeca4Yv3G9ppT5JxdKqZw6PSbiSDYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 4:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 02, 2019 at 12:50:53PM +0200, Greg KH wrote:
> > On Wed, May 01, 2019 at 04:01:09PM -0700, Brendan Higgins wrote:
> > > ## TLDR
> > >
> > > I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> > > 5.2.
> >
> > That might be rushing it, normally trees are already closed now for
> > 5.2-rc1 if 5.1-final comes out this Sunday.
> >
> > > Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> > > we would merge through your tree when the time came? Am I remembering
> > > correctly?
> >
> > No objection from me.
> >
> > Let me go review the latest round of patches now.
>
> Overall, looks good to me, and provides a framework we can build on.
> I'm a bit annoyed at the reliance on uml at the moment, but we can work
> on that in the future :)

Eh, I mostly fixed that.

I removed the KUnit framework's reliance on UML i.e. the actual tests
now run on any architecture.

The only UML dependent bit is the KUnit wrapper scripts, which could
be made to work to support other architectures pretty trivially. The
only limitation here is that it would be dependent on the actual
workflow you are using.

In anycase, if you are comfortable reading the results in the kernel
logs, then there is no dependence on UML. (I should probably provide
some documentation on that...)

>
> Thanks for sticking with this, now the real work begins...

I don't doubt it.

>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Does this cover all the patches in this set?

Thanks!
