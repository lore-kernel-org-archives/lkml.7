Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A127C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C87218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etf/CEY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfDOSCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:02:54 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36822 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfDOSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:02:54 -0400
Received: by mail-it1-f195.google.com with SMTP id y10so28184937itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CVyL7VHVlcU3RjfkBRhMdYo1FFpfeTAVtBc0iXy+vEQ=;
        b=etf/CEY9XKkLxVbGn4hLDcgjIL5SSFiDk99+05RGko99KrMPwS8ayVCIOp6WX/unzz
         0SWrJFnp/1hkGVv2L1l90GkUOM0Mx41SBxVlyEvzJL8L95HkUX4g9akoOpywchHtq0HA
         Iq1azHReh+ILOmY9dRpB8n56jC8mqdN6Ricu8YGF59UiBw5Yb2YU3DGsaO/I2QSB+C5C
         70Bu7Z5QaQPhl/dAiygv5AQCMmEPkQVIqSg5wld0IgWTdWn6d2pUm/zxDScNYUzyw+sY
         8g+K/StNOlSxhxhNWbV+smQMljD8aC1wN17jIA809JYKeCXkL2wgeKiXcnGg75d2uxD0
         y/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CVyL7VHVlcU3RjfkBRhMdYo1FFpfeTAVtBc0iXy+vEQ=;
        b=ikcCqUP9XXTOb4hB0ZgmrSbTDhxZNp0wD2xMyGPFI/LNgqNRDeaSDNL7KhvdbzIouv
         rH+5TdkMy5kYSAgFcBTLY9HTVdlbG5k4MyJj6y3EAnFEzGSah2BGaMnhVZJSN03HZ5rQ
         u9LuZTm89FBiEcA8hc5oGvFINH2awdYR7mvkyWNP1kx8mEtencvuDNY7o0JtDp3Zv6CQ
         u4usWUf2TmuehCBrZb4A8si9r1qXo3FpbYDOvxU7bbmgmEiUuOZllR2kmSNJJ6Xyys5f
         08+XuauqpVzpn61Gr3OBH2vzctFjOWFEC4bFoOErgpZsaFWthElDDjJVEKTnpJMjRi82
         Xuiw==
X-Gm-Message-State: APjAAAWe5Aj47c85Xj7TNwtkBwtFg2foGbKFqHvC/eXHePHvUKBturc3
        go1gQg4AMV/YcCswIHABNA0ijziuRz8decACec0NKYrsQHQ=
X-Google-Smtp-Source: APXvYqzY27tO8obahM9OVTvjvfCykVcZIsqCrc8nJjz2yChTBmDC2iZ/6a4orDblOolr9/7ujniFewgmFYisLedt5Ag=
X-Received: by 2002:a24:4614:: with SMTP id j20mr27366539itb.72.1555351373078;
 Mon, 15 Apr 2019 11:02:53 -0700 (PDT)
MIME-Version: 1.0
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Mon, 15 Apr 2019 11:02:42 -0700
Message-ID: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
Subject: Strange issues with epoll since 5.0
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I=E2=80=99m still trying to piece together a reproducible test that trigger=
s
this, but I wanted to post in case someone goes =E2=80=9Chmmm... change X
might have done this=E2=80=9D.

Basically, something=E2=80=99s broken (or at least, has changed enough to
cause problems in user space) in epoll since 5.0. It=E2=80=99s still broken=
 in
5.1-rc5.

It doesn=E2=80=99t happen 100% of the time. It=E2=80=99s sort of hard to pi=
n down but
I=E2=80=99ve observed the following:

* nginx not accepting connections under load
* A java app which uses netty / NIO having strange writability
semantics on channels, which confuses netty / java enough to not
properly flush written data on the socket.

I went and tested these Linux kernels:

4.20.17
4.19.32
4.14.111

And the issue(s) do not show up there.

I=E2=80=99m still actively chasing this up, and will report back =E2=80=94 =
I haven=E2=80=99t
touched kernel code in 15 years so I=E2=80=99m a little rusty. :)

Regards,
Omar
