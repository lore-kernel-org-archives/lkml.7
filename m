Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166BC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F42067C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax0I3NXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfLOT3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:29:48 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35856 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:29:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so2024197pjc.3;
        Sun, 15 Dec 2019 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HoMMPCdLOZLF0eqO1H5diaV9yobUZ/ZeC4H7k68GGpg=;
        b=ax0I3NXhjNpin09PdGGuLZwnubhJuloc3nSizijAemsm26v/pvqdleTl5QigMSLs0l
         oFSxnqkzRzFxCxrQbcpmBw5sRk6Hx3huoevxs74dCCOo5Zm/H6oXnnM7FRx/AdAo68yU
         nHETATpHmAl2621IWZ7Mpyxx03gbr6oYaWDG4tfohd9KlztV2CKEOpon5qlmtHz3yjBN
         y2CXlHnWL+vmDMD/EY1U9cDPPd/SGIWwx2saXm37wknTxD2+OshZk8e6W2jsVWnuIn+Q
         6rUGxMA3tUSdDtsW086ladXY8dghsg1H+4s2w018BoNboUGzj2DvkWMr/lmezZBOe6lf
         4Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HoMMPCdLOZLF0eqO1H5diaV9yobUZ/ZeC4H7k68GGpg=;
        b=ZHA7KdjjIC16VJdc4LCL9YXfoBLR4OE6t2ItR24hCF1qlTt2FtKPYPt8LF6v9XTbUT
         qQVHOOPTNsVkZvYVXLvKIMtyGvLuQqUVqtsVL61QVwPqpzhCqWnHLrvlqlZMZDP1al0Y
         h5vCmyyOI3KsgdF+budPD7E0ckaJANUtZuVgZlddIyRkLkyiejsR/F0WZo0W8rviZ/lj
         SnErO09ow7bLNPBJnuYtvO0+5F6q04LSuGuKi6uUuSe1bQ5SBw4DXs5EFX6sCUlFNfLW
         /DhjBaTs8r3fRwysIFHFCL3KoTKgNXQHYW3gZ+VucuCPSlmx0bCQ+M+j/BnqVYBm9rqr
         rnMQ==
X-Gm-Message-State: APjAAAXNHjQfnT422rOn6SqEeXcfIbxdo/3g3E6jAiU1zdBFlAPhfRkB
        G/6oXcjatMrUSF0z9dyKzh283W4zoNaFrqtguR4=
X-Google-Smtp-Source: APXvYqyL1629k9Gf2vUv17mg+/XDTDnJX0RqHP0d2AldF8Ek0DkPcT7zqg7mI4hwunuPJNt22E9ON7xvC0yvGP4Sbl4=
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr13487646pjb.90.1576438187712;
 Sun, 15 Dec 2019 11:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20191213224646.GH2889@paulmck-ThinkPad-P72> <CAA6354A-C747-4BE0-8EDC-C06E3C1D7D08@lca.pw>
 <20191214064048.GI2889@paulmck-ThinkPad-P72> <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
In-Reply-To: <CAA42JLbBFkpYHXRVvyveYO76DnbkE3gyRW-=qmBGZcJTAiB6Uw@mail.gmail.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Sun, 15 Dec 2019 11:29:36 -0800
Message-ID: <CAA42JLY12Hk6UXREmyRss=DiCZ4MgK8ShB6s6Fv_KwDiuVDniA@mail.gmail.com>
Subject: Re: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
To:     paulmck@kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lili Deng <Lili.Deng@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Baihua Lu <Baihua.Lu@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 11:18 AM Dexuan-Linux Cui
<dexuan.linux@gmail.com> wrote:
>
> Hi,
> We're seeing the same hang issue with a recent Linux next-20191213
> kernel.  If we revert the same commit 82150cb53dcb ("rcu: React to
> callback overload by aggressively seeking quiescent states=E2=80=9D), the
> issue will go away.
>
> Note: we're running the x86-64 Linux VM Hyper-V, and the the torture
> test is not used:
Sorry for missing a "on" after the word "VM" (and typing 1 more "the") .
