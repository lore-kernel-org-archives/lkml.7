Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AFBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00C02070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ul+mcer0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCRIq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:46:26 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48378 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRIqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:46:25 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x2I8kNhJ012649;
        Mon, 18 Mar 2019 17:46:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x2I8kNhJ012649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552898783;
        bh=4aJXQpfl5m7EvV+6vGuVHXG5iYnhuCzBqVEkWn3iFtM=;
        h=From:Date:Subject:To:Cc:From;
        b=Ul+mcer0WjQBNXCU8O/gqs7TKf0ZRTMkw0Y8rN3P91My3iVCO7yNn9qm67RyG4xUT
         1xdN2EeGZxF/lCf/H/gdX4TOd4K30LMg6e/2Bdv3Vc1vCTBiq/26dWnkQV8FeWnPf6
         QXLse530kToWwMeea9FNFnBLYuu1WYpZ+zagR7inh/o5+Z3sDyVyILUZo4eLR+uATE
         VZDE78QmOUsjccpbjdvSewDzKmefnnDnyL/h/uu4yVESRSM+OvFYKmdHt1EbY/B8xJ
         FZ3R7drB0CPdKtFyduNj1TWRTMtz64L2aUgfWIVeugB28Z5a+0kEQLxy+MpViXvz2D
         QmYjbMy8dMdGA==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id d4so5029851uap.5;
        Mon, 18 Mar 2019 01:46:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXjMjQHyeU4z3bQfCtgs7dMpB05YPemwpvk8TotnFpkKMosa0hb
        3yDy6uQNwylBvoSJWOPqmpLrDKwvHQS5uVG+jr8=
X-Google-Smtp-Source: APXvYqykN7a5OssXfWYlpsPdwRkY1elTLUFvvoJG6P0QmIjjVwUtzeNa+KanyAbcu7KaVzccSaDvFYQ2ezHtVQjlGhA=
X-Received: by 2002:ab0:2b16:: with SMTP id e22mr5384895uar.113.1552898782442;
 Mon, 18 Mar 2019 01:46:22 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Mar 2019 17:45:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5-e6QcJqSg_c2NBS=11ZZ-KFWLqDZYxWTu0wPFHg=cQ@mail.gmail.com>
Message-ID: <CAK7LNAS5-e6QcJqSg_c2NBS=11ZZ-KFWLqDZYxWTu0wPFHg=cQ@mail.gmail.com>
Subject: Enabling -Wint-in-bool-context
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I saw several commits from you
fixing -Wint-in-bool-context warnings.
Thanks!


I guess we are almost ready to remove

KBUILD_CFLAGS   += $(call cc-disable-warning, int-in-bool-context)


In there any concern about re-enabling
this warning?


When I asked 0-day bot to test it some days ago,
I just got a report
for drivers/net/ethernet/mellanox/mlxsw/.

Perhaps, you may have better test coverage
and have noticed more warnings, though.

--
Best Regards
Masahiro Yamada
