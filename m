Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0E120656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="o37iHXGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgAIVzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:55:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39839 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAIVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id m1so69976pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7GVSKV4F6bNHQbtnn1xWNA8+a7ZmcRqqi6Z4aNgeGA=;
        b=o37iHXGp65Rk0F0pK1xFqFPpnQd/WKN5KY466a+wyzlHSoLBCsdZxrfPvUUQSLOlT8
         rHhH3A+iDPu6V11/cmz+hyZ8RRAChafIntBfQm7i0/fNDXHeGI98GV+O2S93KYmpCDrG
         N4gJf3oYaJlKnwlSb7UsfkgcXGoK/W4wx/Pyn7uLtj00Ms5Foa4pGAqa9nJfg1kVwApW
         qPA49nyCy8y05IRz2dMCAelP4+0HTNB2qykTRdVa8tzMf6tQDMYeKYAfsp/m4wKqUX95
         LFxXoOV4qxPkXN5Mvn16Qq2zeVY4wc87USuITxzTan5jrZrwZrd9z3Nvgb4JmEXRoGw9
         V2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7GVSKV4F6bNHQbtnn1xWNA8+a7ZmcRqqi6Z4aNgeGA=;
        b=iz3CLwG0HvGxfuXTSAl+e3ZehUxffXjJtiVu+3Imc1xO3311PUy5qU1gHPMTQRlU3E
         H1wQ1vmkexW2FMFNa0x+8ulAbUNlE05Zg5tJ5+IN4efvNNHUHwELVdkNQRtvw3O9CaZT
         gR77YBN0bFM6znUiGmPTcQmU7VQo0vRgDdXJvdPPDHrzQlS7IcTv+MEMwTQzz0cSJ/Tc
         VU45TzzI11yKfcpnJEjLuWD419NF2AOCU5nM+2ltzUmV7RCXJP8cTWRELwv5zpvFqc8+
         0QbJxkvwhRRlmVnJZ/fs5cnNV60MtE89vXLxrUEfCgU0FHmxPw0UqImpcaIAVIZ/Bh2o
         VfTw==
X-Gm-Message-State: APjAAAVlFFFwAYR4jcsAJ1xyNiya5F1s0Bo79SpvK4splet2BASQaJfI
        qSRBq1F8uyxZ5D5jhath6xzm2D4VSgM=
X-Google-Smtp-Source: APXvYqzay0u4UiA0c3NMCDCn2cO+dnn7O2PaiaVMcZodtNNHJIDvBJOVl2BTM9pOsCj6E9bkX3PJEw==
X-Received: by 2002:a17:902:7102:: with SMTP id a2mr99621pll.301.1578606901747;
        Thu, 09 Jan 2020 13:55:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20sm8711536pgu.89.2020.01.09.13.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:55:00 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH-next 0/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Thu,  9 Jan 2020 21:54:41 +0000
Message-Id: <20200109215444.95995-1-dima@arista.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Magic sysrq has proven for Arista usecases to be useful for debugging
issues in field, over serial line when the switch is in such bad state
that it can't accept network connections anymore.

Unfortunately, having sysrq always enabled doesn't work for some
embedded boards that tend to generate garbage on serial line (including
BREAKs). Since commit 732dbf3a6104 ("serial: do not accept sysrq
characters via serial port"), it's possible to keep sysrq enabled, but
over serial line.

Add a way to enable sysrq on a uart, where currently it can be
constantly either on or off (CONFIG_MAGIC_SYSRQ_SERIAL).
While doing so, cleanup __sysrq_enabled and serial_core header file.

Sending against -next tree as it's based on removing SUPPORT_SYSRQ
ifdeffery [1].

[1]: https://lkml.kernel.org/r/20191213000657.931618-1-dima@arista.com

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-serial@vger.kernel.org

Thanks,
             Dmitry

Dmitry Safonov (3):
  serial_core: Move sysrq functions from header file
  sysctl/sysrq: Remove __sysrq_enabled copy
  serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE

 drivers/tty/serial/serial_core.c | 123 +++++++++++++++++++++++++++++++
 drivers/tty/sysrq.c              |   7 ++
 include/linux/serial_core.h      |  86 ++-------------------
 include/linux/sysrq.h            |   1 +
 kernel/sysctl.c                  |  41 ++++++-----
 lib/Kconfig.debug                |   8 ++
 6 files changed, 167 insertions(+), 99 deletions(-)

-- 
2.24.1

