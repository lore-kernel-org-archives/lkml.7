Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B972EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897F1218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfV1qSVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfIRP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:27:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32974 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbfIRP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:27:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so24147lfc.0;
        Wed, 18 Sep 2019 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFNPlzpgjhRtlSfLQHtm14uj7M2ySvaC2xD6si0VgWc=;
        b=PfV1qSVapcf6sXPeKLDV5QiHhc6OYu1uI0SCAOgHrdGiIZIHdHTjO4eQ5re/SoDGd+
         QZmkeI7lLuSJLyI3NdSeWxdoieYPyAJ2gi8DNR1zoP4FbYijvxEQWT9uB5+e490net52
         KNPJRiyG+CIRRL49+p3aXbqJZVt6j/xVQOq00PJj1RGgMDbLXH5+EtWUJX+fNkNF7A4t
         nzqiF1ej2MUAgEAn/xZudbpOubWqVdwWDtbaHrpxQzMFoNgPDuGQcKRGMrYDNR4rld8y
         p6dzcA+ny3p2tKCIPUhH1yO2UDHJ3x5juSY+gk2y1QZ8cMQgVeyX/d661FDQgXFq2Oop
         pX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFNPlzpgjhRtlSfLQHtm14uj7M2ySvaC2xD6si0VgWc=;
        b=WLGg0dLcUjGfU1W1UjM6Aq6CUnZqF5a/JGTbdQcUgm1kcUSHbPBwZPF39b/Cdizh/5
         KRmOdpcjs3l6DFd/tddirUJ1t6r1d01vvLgA4xX+OzFP8L1SQ27WT3u/O2lEf+3cElq4
         p/xkH7oLfbei90IZZ2evtYy4yJa8UMS+xbZ6P+0PJuemfBaStrYo8Fl9LC8LX6cmtRrQ
         qOV/tJB+Epm0M9CI+md0BWU90LF6hJlSPrT3j9DtzbZC+VFXG5nuyFeR3sw/NSGZj6vR
         zvlgoidFn0ipSkxjJlbC+ONCmo4ExkrwA9Xz/tz4QMVSNTitdIeeml5qeaee7h/ATCvd
         kw+A==
X-Gm-Message-State: APjAAAVZ83fa/0FT5ZMjuBh5WxQ/batQXDnwIDYcGgKMyRCSY8seAiHb
        Tp0IzJmGbdN0318IwX+FyWM=
X-Google-Smtp-Source: APXvYqx5xmH0+U6XHXr9kQrGWxhRo4jxZDO8Xn77XabDzbNu1kA7C4J6oMiPN27o30Wyj2VvHLp8sw==
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr2265651lfo.152.1568820426113;
        Wed, 18 Sep 2019 08:27:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-vpdn-93-125-15-224.telecom.by. [93.125.15.224])
        by smtp.gmail.com with ESMTPSA id t27sm1068142lfl.48.2019.09.18.08.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 08:27:05 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAbrG-0000rR-R9; Wed, 18 Sep 2019 18:27:06 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v3 0/1] intel_cht_int33fe: Split code to USB Micro-B and Type-C variants
Date:   Wed, 18 Sep 2019 18:27:04 +0300
Message-Id: <20190918152705.3267-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to support INT33FE ACPI pseudo-device on hardware with USB Micro-B
connector.

v3:
- Rename TypeB variant to Micro-B (we have only one such device for now and it
  has Micro-B connector)
- Rebase on current linus/master
- Remove empty lines and replace "TypeC" by "Type-C"

v2:
Instead of defining two separated modules with two separated config
options, compile {common,typeb,typec} sources into one .ko module.
Call needed variant-specific probe function based after of hardware type
detection in common code.

Yauhen Kharuzhy (1):
  platform/x86/intel_cht_int33fe: Split code to USB Micro-B and Type-C
    variants

 drivers/platform/x86/Kconfig                  |  12 +-
 drivers/platform/x86/Makefile                 |   4 +
 .../platform/x86/intel_cht_int33fe_common.c   | 147 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_common.h   |  41 +++++
 .../platform/x86/intel_cht_int33fe_microb.c   |  63 ++++++++
 ...ht_int33fe.c => intel_cht_int33fe_typec.c} |  78 +---------
 6 files changed, 272 insertions(+), 73 deletions(-)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_microb.c
 rename drivers/platform/x86/{intel_cht_int33fe.c => intel_cht_int33fe_typec.c} (82%)

-- 
2.23.0.rc1

