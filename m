Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ECF207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUE00weo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfIHNZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:25:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45395 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfIHNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:25:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so10084437lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0pJMSMx0/d8zIh8Oh5GZUgCsGzEusgNLOjCEDIOzKU=;
        b=ZUE00weoHdspk3OzLSljMlkhdcXPkEMeiZJcUky0WTfIjaBcYv5UZpTn8pSFqVmX+X
         4ZhFsWtbEZWe4ABflAVlH3etHG7SGXdtNfW30psYGsIT818mhxnsdBAWgMcSF9bWoMIV
         11EVxFGRHhI1NG0C2IHwVCCOY4fKvBZ0jAmn591H5Jc/vB0QYWgxmmxw4ahanjKI/8xL
         2egUIqfjyhQFct+vvqe9VkbmgfkTZrhCeTKRsDgZc5h5t4ILX0wWArKyj983ThP0WW/D
         ++5Nyamv/iVEsqAVfwGakS9HPEFSlfGPU+s3Q6FsIo9gRYK2tAzMLpWsQKou6Q8pZho9
         cUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0pJMSMx0/d8zIh8Oh5GZUgCsGzEusgNLOjCEDIOzKU=;
        b=LbaeJlkzYs5/NsvNZUJ7RlB/OQJWuVtU0bm949l0wlBsB0JxADj24N83N2rbOAKuPU
         h7eY5KyCHzuzhtHC4GTMEG+F4rFtlyziutdwbYU7J2m7mCHyNF2WE3WhvffGdn3iWN7n
         z90tT4Isw8RmpCGpceeELvKMpkt7Rq6ib62c9spkXDLEragQcoxKCTOHTR75QCmXhNvy
         qCFSgFthQKChhqrYM47aQxnPX9kr9wuEyS6//Vm6Fldeugnd3r4+Px2F1CfNlx+8HcoN
         SrfB6/bPq5GIhwvxd97qNYFhftjxptQTETlrRk1/+TY6pWf1n0EvAdR5M6j5f5L4Orfg
         fg9g==
X-Gm-Message-State: APjAAAUq+Ouewi77qesSa0Sp0zs3RYPUxeKbqkeN/e3HK+oh+y7P0V/L
        XUxYtmf0GEd8Yh0PsqJmw+JD6/nlHAdYeCN9oB8=
X-Google-Smtp-Source: APXvYqwpLKvWsSnWGqstRkknjiQROKHsnJiF1kfXNaPx/OQKu8Rh62rHGD5njfgQjKsGMWYGN/JP5JBp3+Q/clBMx0M=
X-Received: by 2002:a2e:87d6:: with SMTP id v22mr11576067ljj.195.1567949105376;
 Sun, 08 Sep 2019 06:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190908131902.GA21291@gmail.com>
In-Reply-To: <20190908131902.GA21291@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Sep 2019 15:24:54 +0200
Message-ID: <CANiq72=N+fpDp4Xf9WSN-OzwY7Zxse=ko0=rR14hGUZvZTnKBw@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 3:19 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>   https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8

Typo in the tag name, you can also use the tag:

    https://github.com/ojeda/linux.git
tags/compiler-attributes-for-linus-v5.3-rc8

Cheers,
Miguel
