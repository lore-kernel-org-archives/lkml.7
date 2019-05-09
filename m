Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4288AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8B2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMwxESp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:05:27 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36235 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEIIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:05:27 -0400
Received: by mail-pl1-f182.google.com with SMTP id d21so760070plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 01:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Bwh25SiApSrnNmLtkLA64oi8/UcYamxmhoKIuiVxBes=;
        b=PMwxESp2iDhjczdBMGYrWyBX5vNqebvXU5IatfoVn1v91VFUacQMLJeO90ehTZfotu
         fhEndbBiVs5NRVt23c9ZS8qFBWPROQtKvd6ALM8AGQ5FKE3iih3gVt5Hd4inK0sGDq2n
         a//QImKJAc0M9EFXzsUmKvO/Wvae0VYiMWXCOXUgGKqyumN99jLtcReB7qmrSpFr1Vrc
         B5TUD3mU5OKU6AyRA4LC01t4Uyd1h2uug89/hcA9nOiDVbJ+xO7KLooJ6xYCi55au4ki
         CTljyjRG+DW1so6NgAlG6pMf2EQ53MKFrI4N4tmuw0ZfiRrmRy56+X9w2WqotzRsChMN
         4NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Bwh25SiApSrnNmLtkLA64oi8/UcYamxmhoKIuiVxBes=;
        b=BXHydORMFreKQy7CNy09VwNsSjDs5YycVqn5F7EI3DykG9iE8fpN/5asO4eRo9A/1c
         uGOnrxv9zCmW07hVGoRNsSj/nkbBVjNee6c/xc1lSUUUb6iCJZYOPXyW0UGu+nUzIuux
         S0tZTZDixo2BI1cYmO9NeJdLzZ8UA4t7yVlJdF3Qw3d6POjQvfIfaVQ2+tgaG7ConPX4
         77Hrm0rsN+0D8bjYi1GaE5Z2+DBXeBw9OlRdVVdFoarniQ9Xym7oYuLlLcm1i7esSW5d
         26HEftBhgjio7OrH8WYvUnSeKpl8SzNfeClk/HUOHGuAUM/KXkMU7nDPSEzQBt9ikdu4
         yZYA==
X-Gm-Message-State: APjAAAUQn5xbwLtwVvjrB9F6Gai/CuUjMXOUbMlCg/fs60pbtuzN5K1f
        HXtRu4yV71ix5wY7y99rMXCI8uUClPJG6bGNtoq1pVGL
X-Google-Smtp-Source: APXvYqwSVSS8oo9bIbNv37P+rZfexA26pQ3/NJSk1xVEufoD7ux2qo3/XU9OcT8lnvTkcx3+97f3VXTOwbqQSw6ahYQ=
X-Received: by 2002:a17:902:8343:: with SMTP id z3mr3273777pln.240.1557389126477;
 Thu, 09 May 2019 01:05:26 -0700 (PDT)
MIME-Version: 1.0
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Thu, 9 May 2019 10:05:15 +0200
Message-ID: <CAMJ=MEdS4+5Un77MU7dPxkOjA7-yAv-1tbt0vbUaZ8n4R_rrBQ@mail.gmail.com>
Subject: fs/pstore question
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm using the pstore feature to log kernel crashes.

What I observe is that after reboot, always 2 entries are present in the pstore:

ls -l /mnt/pstore
total 0
-r--r--r--    1 root     root         16372 Jan  1 00:00 dmesg-ramoops-0
-r--r--r--    1 root     root         16372 Jan  1 00:00 dmesg-ramoops-1

If I do not delete the entries and force a new crash, only 2 new
entries are available
after the system is online again and the older entries are overwritten.

The reason for this is that the write index is always initialized to 0
during init.
Is this intentional? I would expect that existing entries are kept
until they are explicitly
deleted or the storage is full. In the latter case the oldest entries
can be replaced.

Best regards,
Ronny
