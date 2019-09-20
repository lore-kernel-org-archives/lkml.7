Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C76C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49F420882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568994076;
	bh=BV3+aQg6tGS7etPpu0P0Om+k9HKS5sc7lR2A5+6WVjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i9xyS83XB+QjfBy7oKIh97lB9NcsGadVtku9KRMy/Cbp1MgXdRADG7xnxM/W2rjg/
	 6L/vS3rq2ZLBVHMDhvsw6Av0BlY5j//2qbxmpatU76nVGpjOpDAPigqvTH5qI+JDp8
	 UIFSr+Z7pLs9TgXGI/6G735pp9G5mA/lqVJnVeFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393068AbfITPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:41:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42173 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbfITPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:41:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so7511033lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX7KNoBIJ8sruOeElrZxFbFSWZuAc4wcswq+ygSvynk=;
        b=b6rzDbXppCSe1wCvJxP52dfQX+c4KnauaRppVi1nRpe9elnfSAYO5604jCbITdEwAN
         2HbWvxq24OZNrktog+t/a3UyCQVQ4PnJQ+mD6dKMwDWq2bGJWtMOHz1z9lUd3jpdtCTw
         lSD5hpoRUEYS/pfu9ur9Npkp3L0I2ZFnC5S5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX7KNoBIJ8sruOeElrZxFbFSWZuAc4wcswq+ygSvynk=;
        b=EDWUFaOlMZkoTH+2B9rPIwXUdUUPx1yDg4D7c3LYxZjT2ldxSNpKCnMiIStKTLpjhM
         mLVYHTjutnOcFsQYfOK1sa6LVt74xIOnidA+XtWtyIJ08waK+D301av2ttIbBGNesfzc
         iNvAxLUYUppAIi2cRg/QtuDBKUZ0XUww3BgP9meJB96o9imfeZJjWImxXuK2k/cX8eRN
         fIA/BtEJMDtOISB20ksYxIO0N+/TiWosjijBFm8na24neuq91vrWYZK3OondwsNLnxGJ
         +ZP6lB5du1I2fzICrouyCkv7Zl6YhpFQwmpRdjdM5zwMSQdidujMRmV4XVke4dEBSE4E
         z/ow==
X-Gm-Message-State: APjAAAVtx9hCTe/miAbiKGiNk7qba2XpBS+M/mRgrMwc/N/rcj6zVzJf
        GurRfIgsSy8WYNOk5wB75pXcxWGm56A=
X-Google-Smtp-Source: APXvYqzI0iJj2NIwUlc/eGzjl8OyqgIDMFXrMM751qX8LvfjIcp65WIlGWd51Y+2+0mrGSyLU/T6ZA==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr9490809ljk.185.1568994072803;
        Fri, 20 Sep 2019 08:41:12 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id l16sm510391lja.34.2019.09.20.08.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:41:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y23so7510922lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:41:11 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr9484294lje.90.1568994071382;
 Fri, 20 Sep 2019 08:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARsoed86dY75b_HNXXkCXRAKdMUGaEWUUca4BuGaZCwcg@mail.gmail.com>
 <20190917150902.GA4116@linux-8ccs> <CAK7LNAR_8atC3M9gGQ=DBwzFG52PVuNaFVAzAr32TKxTwDCLug@mail.gmail.com>
 <20190917180136.GA10376@linux-8ccs> <20190917181636.7sngz5lrldx34rth@willie-the-truck>
 <20190917184844.GA15149@linux-8ccs> <CAK7LNARxmDwu4QmV3bRBtptu-jUaHum=hHaia11-vmOd2ZkeKw@mail.gmail.com>
 <CAHk-=wggsTOU44tvdHAXBP-mmH+UJMXbJAdZYTOYD0PzPJntkg@mail.gmail.com>
In-Reply-To: <CAHk-=wggsTOU44tvdHAXBP-mmH+UJMXbJAdZYTOYD0PzPJntkg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 08:40:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk=0KUP+Kkr=vRnUrL71j5q_SEQc0x5EPhq2ZJ-=sV1Q@mail.gmail.com>
Message-ID: <CAHk-=wjk=0KUP+Kkr=vRnUrL71j5q_SEQc0x5EPhq2ZJ-=sV1Q@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v5.4-rc1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Will Deacon <will@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 8:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No problem. I'm used to merges, and I appreciate the heads-up.

Heh. The Kbuild merge turns out to be painful for other trees too. I
suspect the module tree isn't going to be any worse than the
DEBUG_INFO_BTF conflict.

             Linus
