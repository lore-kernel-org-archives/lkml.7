Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39911C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1362820873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT1Qlvo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfFRMb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:31:57 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46997 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:31:57 -0400
Received: by mail-yw1-f65.google.com with SMTP id z197so6259822ywd.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zjjaR0MJ6NCbQ2tNDKmWvCG8E9amxT1DIK1jQtxlWw=;
        b=PT1Qlvo71aLKxUQwCTqmeZ4N6sNBlKRFpZv3vzbAfnR55ezeV9DkyI+37sHYq2F5+v
         ZI7hAXS9LNNDh7Qgo6PE+503R7wclSAotEkoeINPTfY+bJwjCaALF8kifRkod8xh5TIJ
         STBEIhy1kACDq8eJcufi+agQluKNKJVpns5JosCrupD8uj8K6FGdCY2D0LldV+3JW5VG
         khVDOHYzdZ06h4sGzxQa7XINy9I59z4lA4QbKrCW7TbYUwAdrHPqY7lXA0hk3jBa9Xg/
         2uhhRVYHp4x+15fUatdzO5CtTPGNlWvjC0h7dlZfEQ0PpdQ5mQ16GXimqBx6syysDT/o
         7C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zjjaR0MJ6NCbQ2tNDKmWvCG8E9amxT1DIK1jQtxlWw=;
        b=ldR1r6IQeRa0tG+5IZZZDBf8yfG1VPsMogyz23FuWy7iKmREGoCb4xzgNA9gxVoZnG
         8OWljmzfmvgdhc+MO5aikgIbTvMYw73vCWcHrU3HGmKcScke8UnHmMbIiuuMi/24kAVZ
         zkmPQpnme9oOHowQQH/vjWusNjhn6LbptE4VPHBPiqP5nKiI4QLc68G3WfDuDWXxTDML
         bThstm6vrwnnbiDnLIItWYBwlHP1lu+/mHnqK3EOYPL9W4Qlvp+np8xwXNkfaBUmvaHi
         QCiU4Yhkto92N0PsnNnx5OhX+a9MAJxEhJNZ8DIsqa6BWxjeQpid5HJYXHdW/HAB+hjP
         GiPA==
X-Gm-Message-State: APjAAAX4rh2UWuEUZjDbJcJvMfdNQGwdUTf6x/dltYZk3HWQyptMY1WY
        Judrxh0fOU5BTZmuVK62vpoH1NWE
X-Google-Smtp-Source: APXvYqzC4ePkUH+H7AUAqgoHeZ2YnLyvDJe9yvuMYkVKuqX7uotxWFsvD87NtxlkOw4rNce9RQjY9Q==
X-Received: by 2002:a0d:f786:: with SMTP id h128mr63435203ywf.511.1560861115876;
        Tue, 18 Jun 2019 05:31:55 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id h5sm4065905ywa.6.2019.06.18.05.31.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:31:54 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id c7so5965125ybs.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 05:31:54 -0700 (PDT)
X-Received: by 2002:a25:d9cc:: with SMTP id q195mr59718440ybg.390.1560861113644;
 Tue, 18 Jun 2019 05:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs2+-yeYcx7oe228oo9GfDgTuPL1=TemT3R20tzCmcjsw@mail.gmail.com>
In-Reply-To: <CA+G9fYs2+-yeYcx7oe228oo9GfDgTuPL1=TemT3R20tzCmcjsw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 18 Jun 2019 08:31:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfBFqRViKfG5crEv8xLMgAkp3cZ+yeuELK5TVv61xT=Yw@mail.gmail.com>
Message-ID: <CA+FuTSfBFqRViKfG5crEv8xLMgAkp3cZ+yeuELK5TVv61xT=Yw@mail.gmail.com>
Subject: Re: 4.19: udpgso_bench_tx: setsockopt zerocopy: Unknown error 524
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Fred Klassen <fklassen@appneta.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 7:27 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> selftests: net: udpgso_bench.sh failed on 4.19, 4.14, 4.9 and 4.4 branches.
> PASS on stable branch 5.1, mainline and next.
> This failure is started happening on 4.19 and older kernel branches after
> kselftest upgrade to version 5.1

Does version 5.1 here mean running tests from Linux 5.1, against older kernels?

> Is there any possibilities to backport ?
>
> Error:
> udpgso_bench_tx: setsockopt zerocopy: Unknown error 524

MSG_ZEROCOPY for UDP was added in commit b5947e5d1e71 ("udp:
msg_zerocopy") in Linux 5.0.

The selftest was expanded with this feature in commit db63e489c7aa
("selftests: extend zerocopy tests to udp"), also in Linux 5.0.

Those tests are not expected to pass on older kernels.
