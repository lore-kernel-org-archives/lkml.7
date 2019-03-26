Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D19A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2pmnjJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfCZRFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:05:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40326 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfCZRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:05:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so8359617pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=ktOQ/tyLu68SW7AEyELHJA2CTC+i4Py410izLIuc0B8=;
        b=g2pmnjJkyR9pNDE2XNSd92oQqcIjvFz3Yq0BJpN28uBvF2bRVjt6tQabZiJgH0n4Cu
         LeF62VihkNX8sGurgmV/IkqLfijlwqnEWj4pljYg2rt+Y+INHmHfcCcWrmixNf3D4k8c
         2Z5hgX+BTNolCeg7o1ru5Wa/2ykbYhjNihdco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=ktOQ/tyLu68SW7AEyELHJA2CTC+i4Py410izLIuc0B8=;
        b=C8UAqug04qm7YhldLXRbZzJHbxApYBitSWYU5FvsThc+vhYc09xf4/1QbrPTd0c+oe
         IMoUE9f6BHYgp8T9Vgyv+S1N8KvgHDMso2faE3lM3InUlTqxXXgVufJAeUVuFeMufv7d
         Bq+2cGVYnLbU1r+2zZJCnIEROZUu1sYWoHJJcFVlfUjEamrXb9B5KjIj3/KKr1gyvOmv
         PuoU0Fn4Ufh3tiu1AY4IbOwXE/gPqMkRfD9NeyZfL1O2I5jpPKh6aKx4RXkxeMIOWAI9
         dBC2yRfY2aQ6M4tQHnEBe//gwFjMHg0g1F/2/poRgPERjxX8WVVFZFEDHq1NmVbgjbOs
         LHtg==
X-Gm-Message-State: APjAAAXqlahiklw85rQ7bWRIOLbRpcCjm4SfRrkRBOvg/JuGI2t+kNLe
        P11X8iqyT/ftTrXQngtR3ci+oUHhxAF2Jw==
X-Google-Smtp-Source: APXvYqyqIKp5OOHOOX7Z1QTe/y60ci77rkMYm/K2sbCXGKLD+0xF2K1ykPupxrK6AWoPvIAaZWZryw==
X-Received: by 2002:a65:538b:: with SMTP id x11mr29294441pgq.35.1553619937602;
        Tue, 26 Mar 2019 10:05:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 125sm29309655pfw.139.2019.03.26.10.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 10:05:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <227f1a1f-d8dd-72f4-4eb9-43bba714d52a@kernel.org>
References: <20190325184522.260535-1-swboyd@chromium.org> <20190325184522.260535-4-swboyd@chromium.org> <227f1a1f-d8dd-72f4-4eb9-43bba714d52a@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 3/4] scripts/gdb: Add rb tree iterating utilities
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kieran Bingham <kbingham@kernel.org>
Message-ID: <155361993610.20095.762425616683725063@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 26 Mar 2019 10:05:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kieran Bingham (2019-03-26 01:52:10)
> Hi Stephen,
>=20
> On 25/03/2019 18:45, Stephen Boyd wrote:
> > Implement gdb functions for rb_first(), rb_last(), rb_next(), and
> > rb_prev(). These can be useful to iterate through the kernel's red-black
> > trees.
>=20
> I definitely approve of getting data-structure helpers into scripts/gdb,
> as it will greatly assist debug options but my last attempt to do this
> was with the radix-tree which I had to give up on as the internals were
> changing rapidly and caused continuous breakage to the helpers.

Thanks for the background on radix-tree. I haven't looked at that yet,
but I suppose I'll want to have that too at some point.

>=20
> Do you foresee any similar issue here? Or is the corresponding RB code
> in the kernel fairly 'stable'?
>=20
>=20
> Please could we make sure whomever maintains the RBTree code is aware of
> the python implementation?
>=20
> That said, MAINTAINERS doesn't actually seem to list any ownership over
> the rb-tree code, and get_maintainers.pl [0] seems to be pointing at
> Andrew as the probable route in for that code so perhaps that's already
> in place :D

I don't think that the rb tree implementation is going to change. It
feels similar to the list API. I suppose this problem of keeping things
in sync is a more general problem than just data-structures changing.
The only solution I can offer is to have more testing and usage of these
scripts. Unless gdb can "simulate" or run arbitrary code for us then I
think we're stuck reimplementing kernel internal code in gdb scripts so
that we can get debug info out.

