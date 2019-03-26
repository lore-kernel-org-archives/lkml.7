Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE3420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcdhI71H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfCZUf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:35:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:35:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2483650pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=gi63ELTTQSbDapnC7zZ3BnYu89DdfPLQj5BIW9kV5Os=;
        b=fcdhI71Hgju44lnsVMRLXNp6wBklkX2/cRmnEGFUjijcqpXclhN+4Ed6FrfH93YxQ9
         g3WDRGrZoh3W7X3pWOuAaItGEwDQKLDVz6STvJ8uKlarkqRO7fG4WoGHr6kD0A9jfNLY
         z8YhZD6LD4Vn/w2am8MfoyYIA/sHi+VXaiQWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=gi63ELTTQSbDapnC7zZ3BnYu89DdfPLQj5BIW9kV5Os=;
        b=DFTinl9gD9I0C1B1BbmF/iwgM8zYt8Zq7KUlG74iFVmasO6k7+quLAHRof3EL93NUi
         OOSWQ8INTARGljIR9mDaDUf6FVDqH6UlH1YDunL385icTJ85ZO/h0c7Z2OydLsRsUxla
         5yIjyxhDesiWrRmQs2BSgxbU/au4zK36xSALMhdnEbtDirFRh0MyR2vVfYeBLCG4yqh8
         LYUHGDYbwpwKtE64T4AO49nRSgkrk6kP2yMptFHEZweeR1Pi631KEjKNVfhUHaRY6Fee
         si98HzF7nXWp2+vpn35UmhTDp5tx874SvwoGcZTEa2gYnfOl8eRs8Nfh6YFK0xCQqv0m
         FZmQ==
X-Gm-Message-State: APjAAAUh/X0aW03HBMZs2dWgat/bOgzcmxfDjfeYQ9VwpujycUHzxiPF
        k/bu+Abzc4p+aaXcbhXOI0gkZnOt2+6I2g==
X-Google-Smtp-Source: APXvYqxME5Pb6hM3pJ3AqkrYxjyt6q/eo2cUgDtYxlAY0NAXoNWd6HNTLajYsrQaRDDn4via66ghQA==
X-Received: by 2002:a65:62c2:: with SMTP id m2mr30221597pgv.348.1553632555855;
        Tue, 26 Mar 2019 13:35:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u62sm51957443pfa.124.2019.03.26.13.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:35:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0cb6bd11-b98e-2d76-f464-b06afab74e97@kernel.org>
References: <20190325184522.260535-1-swboyd@chromium.org> <0cb6bd11-b98e-2d76-f464-b06afab74e97@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 0/4] gdb script for kconfig and timer list
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kieran Bingham <kbingham@kernel.org>
Message-ID: <155363255431.20095.9223713398808071323@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 26 Mar 2019 13:35:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kieran Bingham (2019-03-26 01:39:43)
> Hi Stephen,
>=20
> Thank you for these patches,
>=20
> Could you check them through with PEP8 please?
>=20
> While we are not entirely "pep8 clean", Your series adds the following
> warnings:

Sure. I didn't know what was desired here because python in the kernel
is not checked by anything like checkpatch. I've fixed it all up and
things got a little shorter so it must be better! Now to test it out.

