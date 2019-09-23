Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A0AC11FF5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179F0207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3cLe2tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfIWUfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:35:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41180 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502800AbfIWUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:35:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so11174529lfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QWJtYqntFBw0xMyVPOvjVwD764B7OiYsnP6PokDpdpM=;
        b=V3cLe2tNDpGkS9IpLEp9EE7cJS0+jF8E1gfu4RYHzDyom2kDmEc2VbKnz1fSRkwy5x
         wZSjB+VISMY51zwFOEtrtEBx4WF/WhjNx0syihVn4gR1DjmsncmNBeMbbQmigzmcgzX9
         Iq2RABnY0aUQjJBvZWXK1ua6Y0i4Qol/0MgdOlTfqo+LFI5meZin6ap2u3obUMs0kRU7
         S07ObwvQsIJG1ZtTycZBp0GomDHYrlAyCCRd9nboMs3lfBjK1ssNa8TZiWRkE3pTiflu
         1WVw8oPi58FGCJ1A1CKot+yaOjbAh2+oNxwrtuQH+MvEmLapO0iwiDmRbAgOWHUo/tAl
         wNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QWJtYqntFBw0xMyVPOvjVwD764B7OiYsnP6PokDpdpM=;
        b=E37J9iDUF+cw2aZPfGqTCZlqvfKeN6Op/vdyGeT75qoIlXFIX9cH7oBfz3YgCHAE2h
         4KBwsrIprEnT69aYOIMpk2YW0TVrWB2iTt3X3we/Jth+38PtaZ/of6bD4TxZOn/nCm/C
         b7h1gsYBNbe+/dzpP1FADfubxohNAIPsRvwjQxleRB9kfveTblkLvLsuSlL5R3rg1z16
         FmkA8XpwTYZLNf2BCU+KJQtA/UC3BM6M0HTHQzl1+wfautLs5L+g4ycqa5NH3cmUKvuw
         6qIM78eTMjuON2/iNMOzAY5v82O1ORUYso9QcBczY76BPnqmroyE9+V7p/CxRX3QZVpa
         0ICg==
X-Gm-Message-State: APjAAAVgx5vMzCRjnVtfQvfp/bKQnEtC73amDD6Jz6IPYHxjWt3NOFdP
        XINHkNrbE/ERSBIfU04IifckJNe+FrmzA6j4vA==
X-Google-Smtp-Source: APXvYqyqYnGgnW3+ZUYtKnhNCDg1f5e28pt6x3tHN7zkoeiGR3F2eMfRT063nzJdvQ5CqbJEE+WxCHy8IgBIPmt7YjE=
X-Received: by 2002:a19:2c1:: with SMTP id 184mr858442lfc.100.1569270916944;
 Mon, 23 Sep 2019 13:35:16 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 23 Sep 2019 22:34:46 +0200
Message-ID: <CAEJqkggb9ozmLtqkdm40NTXw=YAo-VZwrxPk+43YC-zkV__=Vw@mail.gmail.com>
Subject: [amdgpu] backlight mismatch
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on my new Acer Nitro 5 (AN515-43-R8BF) backlight and actual_backlight value
in sysfs mismatch. When backlight is 0 actual_backlight is still 5140.

root@nitro5:/sys/class/backlight/amdgpu_bl1# cat brightness
255
root@nitro5:/sys/class/backlight/amdgpu_bl1# cat actual_brightness
65535
root@nitro5:/sys/class/backlight/amdgpu_bl1# echo 0 >brightness
root@nitro5:/sys/class/backlight/amdgpu_bl1# cat actual_brightness
5140

The laptop has a hybrid setup Picasso+Polaris11.

01:00.0 Display controller [0380]: Advanced Micro Devices, Inc.
[AMD/ATI] Baffin [Radeon RX 460/560D / Pro
450/455/460/555/555X/560/560X] [1002:67ef] (rev c0)
05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Picasso [1002:15d8] (rev c1)

[    4.594694] [drm] initializing kernel modesetting (POLARIS11
0x1002:0x67EF 0x1025:0x1367 0xC0).
[    4.866696] [drm] initializing kernel modesetting (RAVEN
0x1002:0x15D8 0x1025:0x1366 0xC1).

Please let me know what other informations you may need.

Best Regards,

Gabriel C.
