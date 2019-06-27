Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE94C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A086A20815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1r7b0eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfF0AXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:23:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38707 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF0AXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:23:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id g4so246635plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c34/FfI7PALcZVh0MK4YlFiWvnY7m44Qb8oCZcTiVbU=;
        b=a1r7b0eQqi65SnqqxyoyNoD4dz3PJJz11oTPJDYx1ctiFPDiwwrUHcLazOdtvx2h+b
         BJ557GOrC/erbl4AklySqzJS15SQHRCyi1pl5V+Ls9UzeK+ybM4aUzx/S+y9D7ra9gXL
         ud7lUYI/Zqb2M3pihkmgYamKJ46DHL/UUeQ91qNrgnYGOngk+Ky+30mJQ2BAC1N4CLmf
         9YUjsBmnOgUwCj1x8uLgqFqywqoB2YH5RUIgldau68pKxTutIfleZKg6l9x3MWTSKJaB
         ouNqg9FBjBvdFyIKXW5If/Gp0dxolKfdIn0hpcE+lOOFMC9WXHkJlNZBl9+xdWTdckpr
         zuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c34/FfI7PALcZVh0MK4YlFiWvnY7m44Qb8oCZcTiVbU=;
        b=bifbDGRQhKKSeuPgjpXfB4Ut94icMsDyge1fO2MesBkaVCyVjtcoPdT9o4RY6IrlRg
         /5+ZZRW7DFiml/QQtsGPK+3C3E7MwOHOsh3vz1GPt2BnMuYO7tILp3m6vxkImRu6kQi+
         CQO8ikfIllaIIyWBuTZ57z2eg6nFPSHBy2OHuGtTl0snMTXtyp/XmxO9A45mbvU2hjq8
         99XWw31zfCnJbAG1gYgO7juj2Td/eqc/OPO6JdeKKf2U6W19L4pv01QWZBHEhuZchlC2
         JzmJUNy914X+Fh5MP+tkhKdq4a5voaHqWkiFZkacRq2lPLdDNwhg9aocBm9fVmcHD9bP
         paVA==
X-Gm-Message-State: APjAAAX0dWv7N9qEkLYeOQ6lU8bbIQK1stvLjWg1BbrDW+ob9f8nR5BO
        bfoMbAukUznEmGCI1KwunQsSWIzrWj11qNxgVzUPqw==
X-Google-Smtp-Source: APXvYqz8ozeAzYHPHzqs1rNqRCdggL5+4sDGi+NHmPQJCmuSKDQDwiM3UtGQ8HWyljDXcSyRIYd62W6XpQAlC3xYRPM=
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr950785plb.297.1561595003889;
 Wed, 26 Jun 2019 17:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-14-brendanhiggins@google.com> <20190626000150.GT19023@42.do-not-panic.com>
 <CAFd5g44kkepB2hZcpYL-NB5ZHYE5tP7W-0yducGCX7Khd9gd9w@mail.gmail.com> <20190626220350.GA19023@42.do-not-panic.com>
In-Reply-To: <20190626220350.GA19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jun 2019 17:23:12 -0700
Message-ID: <CAFd5g44ZbVCM3rksF44z_diiejS+Xc+qcXm120L+t+FHwuGyrA@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 3:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jun 26, 2019 at 01:02:55AM -0700, Brendan Higgins wrote:
> > On Tue, Jun 25, 2019 at 5:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 01:26:08AM -0700, Brendan Higgins wrote:
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
> > > >  create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig
> > >
> > > Why are these being added upstream? The commit log does not explain
> > > this.
> >
> > Oh sorry, those are for testing purposes. I thought that was clear
> > from being in the test_data directory. I will reference it in the
> > commit log in the next revision.
>
> Still, I don't get it. They seem to be results from a prior run. Why do
> we need them for testing purposes?

Those logs are the raw output from UML with KUnit installed. They are
for testing kunit_tool, the Python scripts added in this commit. One
of the things that kunit_tool does is parses the results output by
UML, extracts the KUnit data, and presents it in a user friendly
manner.

I added these logs so I could test that kunit_tool parses certain
kinds of output correctly. For example, I want to know that it parses
a test failure correctly and includes the appropriate context. So I
have a log from a unit test that failed, and I have a test (a Python
test that is also in this commit) that tests whether kunit_tool can
parse the log correctly.

Does that make sense?
