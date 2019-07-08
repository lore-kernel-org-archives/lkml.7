Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFAC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5172F2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vvu+7XyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGHXe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:34:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35214 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGHXe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:34:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so10334998wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 16:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0bgA4UqbyynY1WKuo34XLnfT2RL8oF6dGSsO++vmwI=;
        b=Vvu+7XyZ+bf18JzhxWs9WUla5B97kN6JNUGK09wQnbC1To+ikzJLjWemzYQ4bSdXem
         Lb4Ujrcwm/h5eSGI7UR+HmJu9labaWTTr2uGAMIQle4ZAoZT+/Rr04O/5fXMa+UDK/dI
         PiWmvqDOuBeRwnaNj0eFrE7zYpPFf5ZW5v1/snESkLUrZhzUeLNH4C7U1TAT94jY3ioz
         eEbjqFsIRgjTDidMp1LOdKzZIEzJRV4P4q40BE/P564YjPoiVk+St3f2/qGgJ0XbufeM
         E4LGboUMF+nD44IlGbVNDieKQG3KCLdUF/egpt+dZ1xlDy4X/3SK1jXeVQiIZHm6dFjh
         zhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0bgA4UqbyynY1WKuo34XLnfT2RL8oF6dGSsO++vmwI=;
        b=exlaq79zWBX56Mce9uwRSYZjAtR2pQEWggLLMUiifUXDByi1RQ4eNkAtX37uLlfvnb
         FtK3p2K43Y2DSOnTimPsMsKGGw1d3PrbOtpg1aEJ6HQzr2EDNTTDpNNq7lyZg+uOYoW0
         6W3JEMI2yerc9bPTxHay+R6AbJhEMu8dF8DpeSMhrtY1QbCSCmni+rjWiuAVFdaQ0zvG
         VFJSqps5J5xTXV5HfkHlHgBZV3I5kaTwgt/TGnNLJuOtxeqLNZHqT9sVsC2GxQRNkdis
         stE06ss+9iNsWyp0Xn36R8HLLLN61Tg392/kZ7pKlrsyg3f9kI/qNk7SWzIC0NRLdYRG
         OpXg==
X-Gm-Message-State: APjAAAUvufeVX45kahFyxQkUzFYnaXGYkIBL9sQccO1G1FpHl1ntAO/n
        oZuHFcSKJHUKGLo3pEmZ5gUaI2NoCZW8CE5UoytK
X-Google-Smtp-Source: APXvYqy2agX+h3NF02X+WujT1yk9yb+IABwJhy8IpnbR3/useLGvEwjfJj5ObeDsKZRewf4wva8AmF6fHX7xEyn/0ZQ=
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr19532947wrv.19.1562628896307;
 Mon, 08 Jul 2019 16:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-19-brendanhiggins@google.com> <20190705204810.GE19023@42.do-not-panic.com>
 <CAFd5g44j7ECQorYLnDQadAaj+yBki98kFjmjejn+3W4eHtqGDA@mail.gmail.com> <CAAXuY3q1==RvAiw+gw5kfFJmjdR9JEUnnxou4Sv0POd88aD41w@mail.gmail.com>
In-Reply-To: <CAAXuY3q1==RvAiw+gw5kfFJmjdR9JEUnnxou4Sv0POd88aD41w@mail.gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Mon, 8 Jul 2019 16:34:20 -0700
Message-ID: <CAAXuY3ov7s28BQ0VxzkfAHR6NZiBq-YfnJ_510VN22DMhEyCBg@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 8, 2019 at 4:16 PM Brendan Higgins <brendanhiggins@google.com> wrote:
>>
>> CC'ing Iurii Zaikin
>>
>> On Fri, Jul 5, 2019 at 1:48 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> >
>> > On Wed, Jul 03, 2019 at 05:36:15PM -0700, Brendan Higgins wrote:
>> > > Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
>> > >
>> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>> >
>> > Come to think of it, I'd welcome Iurii to be added as a maintainer,
>> > with the hope Iurii would be up to review only the kunit changes. Of
>> > course if Iurii would be up to also help review future proc changes,
>> > even better. 3 pair of eyeballs is better than 2 pairs.
>>
>> What do you think, Iurii?

I'm in.
