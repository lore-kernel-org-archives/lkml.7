Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D47CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490352073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckvv12my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfKOPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:36:15 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36102 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfKOPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:36:12 -0500
Received: by mail-oi1-f170.google.com with SMTP id j7so8961142oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VgLYzg5CElzBv1IKrsDM9XMeRJsLCqC62h1yunu/L3M=;
        b=Ckvv12mynkWN97Iv9bAk7pTBrsFkxgn9ILkmLaRJKRit6tp1vI6ReqhwH2aiwzUN/8
         xJ4dPqy+yEu9ntBTfj6DF/08NBoycbclOrKwCUVSQ0SE38TS00o3HzOaXgO8+/EPp2wv
         e7dZ8/h5f5z3rIDCGR+UZirDKPkTj+wp6EURMkBdxDEwdf/MfApwR+8OftcbXiuviJ70
         t+8gZ0pEfmkS0yp8dPZV+CCZxbmbx3SPRQ3Zs3b6QPN2wSCs7WWtJyrSViUMokj4wszG
         +L/x+PYr9JmfRFiE31n/QnxPVo5GL+9NUROnOxB7FE+xgewoZD4/CKbm4iPfCzp5+9E0
         10kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VgLYzg5CElzBv1IKrsDM9XMeRJsLCqC62h1yunu/L3M=;
        b=Ctint0l581YJRWokE1GPn82qJwoHKXMi2hc4KJX+syiociVOwm/Yx2F7VXTERzZ9mb
         P5x+LxeTVZNjcfFUSyD95Pii96zr7QHybF0KLHVYntloFLlTRMCFn6b3fHOxYwwNff2V
         /btxkeiQW7TlRYxUXY/uOyQaFZBnOfBerYswSLF3b8YV/5kUFcQABu/JoZaLEkZCpQpL
         d8Sx4M7LQ6a5r4Nu11x1h45f/PzYwEaIt+UlMlHPHApYhrPsjh0oUS1gQ4dBSXRhUNoj
         +Ha6QY01YXGlE9pASVQaonak1zaBtZzQXRMkH2ITDBxjKSb6BtuPn3avLdu6dCnTYlqa
         pLjw==
X-Gm-Message-State: APjAAAXN9XcawyMT3MmKSBAszFYDZYgOhhcV6IMv1pfV4FTdk7m3VYIG
        un5hZp9VSgJ8VoYD9LYT/SuNZBbfr4YXhfFhy/mXTy5WLRM=
X-Google-Smtp-Source: APXvYqylgrm3DX1fc8G+XxKSPByo3X8bXs0oPgJFyga0t6e15SAcul8OjUzgfH0degqcF3gehkviA8BggXYxUQdBidE=
X-Received: by 2002:aca:da85:: with SMTP id r127mr3544375oig.128.1573832171444;
 Fri, 15 Nov 2019 07:36:11 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 15 Nov 2019 21:05:58 +0530
Message-ID: <CAHhAz+iRpMZskxctvxLz=BtTnq6zsFCrenf_73b6tBwbaZfsHg@mail.gmail.com>
Subject: NMI injection
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can someone clarify me what is =E2=80=9CNMI injection=E2=80=9D means? Does =
it helps
when system is frozen? If so how to do this for Intel Atom processor
machines?

I configured my system to respond for SysRq key press, but I see when
system is frozen then SysRq key press has no effect.

I=E2=80=99ve read that when kernel is locked up it won=E2=80=99t respond fo=
r SysRq key
press actions.

What is the definition for =E2=80=9Ckernel locked up=E2=80=9D means? And ho=
w to solve this?

--
Thanks,
Sekhar
