Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E75C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A620883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlNJ1dSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:17:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38274 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfDIORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:17:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so10335135qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xO3FtY0aim4c7fny/l/9QpHmG9fhgYzBcOTimZYlxN8=;
        b=MlNJ1dSrEb79ZY8VjiQuT1s53tfzloj8rlicKoWqwfb4VIWxybXQYh5Izd10a/l/fo
         IRhrB6h91/PBCHHvm4C03lxz59tbMKwVczRa+vBdRHDQNXLMwPe0Ytj0N2+aipSY12OC
         bONHKAyj1tGQ12Um05VFSuCCBhtWalqKBJSfm/j9r6sa5XKdQnJ9j6sH55sbsOJrascM
         ZpASYaxnesSf570cMrwOt7MjhinEC3h991A9ZKD/JRfQcsaFpIjPLQKbkmEANd5yFsQ3
         GkxX6dBANVarjV4F2iIVxEKxl1kM2TSG8d+WeNF57Gm7vf1Jy0O+R1lCz+2DiqzSVSQH
         7lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xO3FtY0aim4c7fny/l/9QpHmG9fhgYzBcOTimZYlxN8=;
        b=Om4i5RZBmuNWcHxs/sibr8Ho7MJrEDP13WLnCpB5aEsHvZXHasa+oyPA1COWAf3HbB
         HxWiUGZYvG9W3TjYC1y9/+0V+0SkJafTj8n+tTz6/u4QYFOLusWBYlT9QMtlKKOShX+S
         yes/3jYRsRVFddiO89+54uX67Q8R0PsZ0M0W6K0LlnHBHG3EDGF5znSbVBHwvi7Kszlo
         JYqiVpU45yRAPur0eH42UU85o1KGnTZu51yVKJ4EYakXsO0b55o2CSVekU5SffweTGCK
         lnOYvAw9y0ge7JHkC16/s627EQLm3lo0qhG0R5OgCsaEAzWUcUyin4Qs7+nUkbkTOzB6
         548g==
X-Gm-Message-State: APjAAAXYWXGvzk6w0mpiofWUVVQ6hV2hKEXHB9vaKdvuSyWKN/h/1uyj
        fAYvzZIWjBBP6Z9/Tuc6w9Fmkf54il/mG4P9iQ==
X-Google-Smtp-Source: APXvYqywSFnI0u+/gFCwvVG9Unie0Gjwx0wJ/1sHHfOOARVYK0ILMFSVSpveCqPNEhrng8e6RTznk4qYz+NGfksrf3k=
X-Received: by 2002:a05:620a:1266:: with SMTP id b6mr27802153qkl.83.1554819464905;
 Tue, 09 Apr 2019 07:17:44 -0700 (PDT)
MIME-Version: 1.0
From:   Jinyoung Park <gt.jypark@gmail.com>
Date:   Tue, 9 Apr 2019 23:17:09 +0900
Message-ID: <CAMfhKb8MO1-FV_ajVpgc0WmQqnHk4Hzrn13TFdtj4ZT4Eg=FuQ@mail.gmail.com>
Subject: [PATCH 0/1] Fixing lost and mess up of Kernel messages while
 restarting or shutting down
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Ketan Patil <ketanp@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is to fix lost and mess up of Kernel messages while restarting or
shutting down.
If the console lock is held by other CPU running while the system is restarting
or shutting down, the Kernel messages in the printk log buffer can not be
printed out to the console drivers. The Kernel messages can be lost or
messed up.
This change calls console_unlock after SMP stopped to flush the kernel messages
in the printk log buffer to the console drivers.

Jinyoung Park (1):
  arch: arm64: process: Unlock console after SMP stopped

 arch/arm64/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)
