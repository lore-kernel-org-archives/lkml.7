Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E74C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949B7206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7B7HhtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfL3LyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:54:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39665 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3LyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:54:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so11590558plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 03:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mwGLfXIphyD7phRk7lEEjBgr1Dix57gKwz3I4i+jkF4=;
        b=P7B7HhtFgmHeFrNyqTqrTnThBQZxfb2GNCMQ/4ecLOVc7DPk2eoU1YfvZswojacSrV
         fWPs9OfIIBvQQS7U0U4kmbgZTZgP6d77qKfTp49ZdPBfrR5YO+2BG74SAAs0WcXtr4UL
         Sk8rLSqK990JPTr3Z6lIjJMaUvIz9E9pIj7yglsUQkqJesp7Qs4pbgR0hMwWzoZXb+Px
         0ffDqa3uzayU8RSvVxzpbgqZ9t6Lo6xs3BX2kpzLvBk4VmIVJoVoMWjeK6Wm8eNnN0uY
         AB6lUvk30xg+QfKpD4KcHmF59E2ZCDwkGXt5GWlLC3PzgFNNvuRFrtXZ2pLhm0DfkoTK
         v3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mwGLfXIphyD7phRk7lEEjBgr1Dix57gKwz3I4i+jkF4=;
        b=mGaAUJRU3hzPxg5j3m4e1dw2glSQCT1dEqvDbNgTPA/UCCCzYNfGP/tsuOvBOyZtoj
         G4y+ZjiwoyvsJoyHzjDHS7fBHAoswRxb34X8LOG0K6EG8Yikg5sdT+nMP83TZDg2zGeM
         Mcf5hHTkfdNB5hA+EEMkjqYUWgA/ciEjE4cBCYKofqXf1thfe1Bo9UV6QlqjoanxYZz2
         97p7ERO0pdnSaPl/VJIx2OKdWepknFtowCKKO9gegh86LTA0J34Uk5bK7xohaT551+9p
         uw9D9AhKU03UcT98yVhA3Q1qjzubH5O3k4L71CesWoIaIPHSqA1LbyafCFpaBLNedbxE
         o1bQ==
X-Gm-Message-State: APjAAAUirKFTVp5hqymQTpkLY/qmNgnwzj6LbogY0aguQSDyXzTvadm5
        h8QVgBrAFYnSVH96kLvK95k=
X-Google-Smtp-Source: APXvYqxdH1nCcHK5bh5D+i4nvE9uZw4uLavnwDMLXtIoPWroXM53f2kWPGymJ5AnGjNQ55B6UlsC2g==
X-Received: by 2002:a17:902:74c5:: with SMTP id f5mr65114786plt.229.1577706844772;
        Mon, 30 Dec 2019 03:54:04 -0800 (PST)
Received: from localhost ([49.207.54.121])
        by smtp.gmail.com with ESMTPSA id t23sm53866525pfq.106.2019.12.30.03.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 03:54:04 -0800 (PST)
Date:   Mon, 30 Dec 2019 17:24:02 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [RFC PATCH 0/2] ARM: !MMU v7 Cortex-M preemption support
Message-ID: <cover.1577705829.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ cc'ing those who added long back !MMU support & Cortex-M support as
   well, though some not working anymore on these ]

An attempt to add preemption support to the !MMU, ARM Cortex-M platform.
With these changes, there is some effect, but not enough to make it
usable.

Though as of now i don't have much clue on what the issue could be, it
is being debugged. Meanwhile sending the series as RFC, to get feedback
on what could be missing or whether there is anything inherent in !MMU
and/or Cortex-M platforms that could prevent supporting preemption, etc.

Details on the problems, the way it was tested etc. are mentioned in
2/2. 1/2 is just a change made so as to have a clear diff for easy
review of the preemption support changes.

Regards
afzal

afzal mohammed (2):
  ARM: !MMU: v7-M: prepare preemption support
  ARM: !MMU: v7-M: preemption support

 arch/arm/kernel/entry-v7m.S | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)


base-commit: fd6988496e79a6a4bdb514a4655d2920209eb85d
-- 
2.24.1

