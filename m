Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1437220823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsJk3AQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfCXQxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:53:05 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34301 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfCXQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:53:05 -0400
Received: by mail-lj1-f170.google.com with SMTP id j89so5792460ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=JvyoEdaiShfZWg2hQYxf7VGf1ji99iV50qrYNWntl5E=;
        b=gsJk3AQLL0kN+tN7k2FQIaYfAK36tWoOjoVq9SCfGi855J/t/0WYEyH+FZCAnfcLYM
         /Sxh2Ty64e3zINNGCCZVzWOqwkZD4WzSQ+jvvRj7gKRG1gccB+m7M7Grq1J7G3m4x7bd
         zeERmy6RI1YcQqsv/X1CCG8mSPIehjb1C1YWfxI1y5XCfEb9TtfcNhAA9tCD1tW0vs1S
         O7yzuh+C2F1dlJyE1kQAde8+QUbOZxApx4AY5ViMSnWEx9VRFd8moKrhevwWTph7sMj7
         whIT/4ud6kv2EFEMaZKAJ3edO1202eqtZdO7R5XZzZ14O9yuUAEhpMrcEx903I2Wktid
         GgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=JvyoEdaiShfZWg2hQYxf7VGf1ji99iV50qrYNWntl5E=;
        b=Co6xg7oHs1NEQJm1QsgOSpN82h8jPIbeJgCK+7RNMzw6lZRe8twnE+/e8U1pkdPfxT
         FflaXf5x2Q2fcc0WJ1nVRUkvSmhMLQme/KbyYvFkCKWxJZ5+8DX147hHBY1RPj0ygsET
         ifWKSkaaYlrUMFwOPMbI0/axN6OcKZLq7oFu2Qm/iGzremG/0SI2oWlSzv0KsYvkm76b
         qt2dpULWGV2fbBt276wT+Ke15UmJZAkVkX4Vhd9j0QSz4XGImhU3d2EwuBnTkbF82k+K
         6+eiF6FgF1GdH2OXi4Kux7ZAIwa1hPZ5L0k1ErS+2U4pr+eQh2JnlHzfqU6ntFe4oG4u
         ybrg==
X-Gm-Message-State: APjAAAW/F3gYMY8ltXY4mtmcUrOVzzl+8ujEAHw67Bz5WBC6mlLfrSt7
        f753W9fJ+J63n0qPRICAVVUwAAH9
X-Google-Smtp-Source: APXvYqwDXbj8ClsSggnG7ThxncNESgunZ80Toi9S4Q1SqXGl8JPl762/g9pZ7nIH44/W/fhhM/9gvA==
X-Received: by 2002:a2e:219:: with SMTP id 25mr7207240ljc.34.1553446382646;
        Sun, 24 Mar 2019 09:53:02 -0700 (PDT)
Received: from apple-mbp.net (85-76-48-99-nat.elisa-mobile.fi. [85.76.48.99])
        by smtp.gmail.com with ESMTPSA id f16sm2964445lfa.91.2019.03.24.09.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:53:02 -0700 (PDT)
From:   SHANNAN Syrjala <unixlezshannan@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: UNIX(TM) with D2LD0s UX 
Message-Id: <188CC042-FD8D-4512-BBB8-5538A3D4F8C0@gmail.com>
Date:   Sun, 24 Mar 2019 18:53:00 +0200
Cc:     Shannan Syrjala <unixlezshannan@gmail.com>
To:     Linux dev <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Heh, here's a funny script with "my first java app=E2=80=9D script =
kiddie attitude ;) This should be the last crap then we are done! I=E2=80=99=
ll promise something if it helps me: =E2=80=9CREALLY SOON NOW!=E2=80=9D =
;) ;) ;) ;)

Luckily I have had Mint because of our UNIX(TM) not being available down =
here for me for security reasons, looking forward to meet that. And of =
course, thank you all for the kernel for UNIX(TM) with D2LD0s UX =
already! Really soon now the World OS and Lez OS will run on top of =
that!!! :D :D :D :D=20

https://pastebin.com/BqyKrJdF

https://pastebin.com/2vTZiHce


