Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96CBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B28320726
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIJI0YDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKTUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:42:14 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34292 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKTUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:42:14 -0500
Received: by mail-ot1-f43.google.com with SMTP id w11so875054ote.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nyBLSCTTtt5n7mjKsup/aXNQTrJFGc26pyfB3rOzBFI=;
        b=DIJI0YDcTBbtPiapkFOz+3nFkau+pm+nxGbAkxLDHTJFEJWnDdq4XYezJ8cQcHi6+h
         SzVFskoXIMo63JsPXrxCMuOw6uiDvt3qgxc+/ssH9HM3sGL71xRYDwZvYqiX7nq4E6HO
         g42+jM3qGbxaS3ds4x4I3uApeJW10PGu0/kdhAoeu5k2qljZGIh/AfAU/hr4WhFVWS3E
         GlnTAgbMa1PT3fkwFriF6Pl2NZWmAsp0uNdpn3pbhLYJPHWT9zzyleE6GFxaJrddoDGl
         8OBDCT1975mKzY3ysrj/xGLFVcujbeuc2CvE6lByGMXHz6Ey+4Zzj0Jw6ZyOFxozNfj3
         bPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nyBLSCTTtt5n7mjKsup/aXNQTrJFGc26pyfB3rOzBFI=;
        b=JU+V4c2Y67WsrcRhSRl4PrLBr1Ls5W5iCpj4rd+BpsJ2eJuD7XzohHXRopRJsdIFWh
         koVxCZdd0YIppFQos+UsAbEkCXG2ZJlyPlNXvAyD6uphYiNL7Y3OCK/LY5gQ4wOu12uP
         ySISLIgdedQFR1Ww6ea964dJLpeB4MOp09VO5jQ0eZYtrn/xD2DMGxZgTiawv8dvXV1H
         WhTbUx7ibUb3p2UUCFjGrS59Hmbl8KBqA5UkALm9VNYb+mC4WiUuqVuUNpqsX0ZnesPm
         3LAHb2Nlag/cEY0AwoQqxLjR58oL/oPkk+48ExYlUo8XsC59XZJm7/ZZFc0Dyhc/XiBQ
         eLHA==
X-Gm-Message-State: APjAAAW57Cw16SaW0Re2oRb1fmlYahr48gPoscyN4VVsIzigNJGa2brz
        8qCcqnX7Jtao4LWsatFUXEvoPSqK4fK84rlGeEXECAbt
X-Google-Smtp-Source: APXvYqx+Tn68q5/9743pjhOpKVzwrQR40mjevZSSh1j3ORMt41qb673mt5Bgys9rlg0nzHYrvMgi0tu4UHiavMnfw+A=
X-Received: by 2002:a9d:2c25:: with SMTP id f34mr3408794otb.27.1574282532878;
 Wed, 20 Nov 2019 12:42:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Wed, 20 Nov 2019 12:42:12 -0800 (PST)
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 20 Nov 2019 21:42:12 +0100
Message-ID: <CAKR_QVLJZPDfjbQ4CBDv62ok0qG4jq_M_Baq6eaot6GzrKMMwA@mail.gmail.com>
Subject: [RFC] why do sensors break CPU scaling
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Recently I've needed to set lowest CPU scaling profile, running ubuntu
16.04.06 I used standard approach - echoing powersave to
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor.
This did not work as the
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq kept returning
max scaling freq.

During testing of ubuntu 19.10 I've found that the above approach
actually does work, but as long as there are no xsensors (or just
sensors from cli) being run.
cpuinfo_cur_freq in this case was returning variable values +- 1% of
around 1.4GHz.
As soon as I issue sensors command cpuinfo_cur_freq jumps to 3.5GHz
for a fraction of second and returns back to 1.4GHz afterwards. If
running xsensors it keeps bouncing between 1.4 and 3.5GHz all the
time.

Rebooted back to 16.04.6 and was able to set lowest CPU scaling freq
as well, but issuing sensors command here once just breaks CPU scaling
that now remains at about 3.5GHz.
It can be set to lowest scaling freq again without rebooting but it
needs to change scaling_governor for all cores to something else and
then back to powersave.

Why is this happening, shouldn't sensors command just read temp/fan
values without writing to any of the CPU control registers?
