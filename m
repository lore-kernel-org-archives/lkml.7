Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A09C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKfXIEYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEIRrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:47:17 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43780 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:47:16 -0400
Received: by mail-qt1-f176.google.com with SMTP id r3so3470468qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tA05HRZCF60ea3fW06mOHmT2RqHh/kCSr16jqtr2SHs=;
        b=bKfXIEYbaxGjS84fHazG8O2fGgOEDU1/ko0gFiH+fSWNVYGkb5O/ElwZHzfsKgBgoX
         h59o7Nh54Kht6BEK7DBnosokyAfoGw7hK/UQgpPHVesDMZ1mrZ5lH4gRwXbpYPmGy3J9
         SjIm927O6N+hjeYy83K8cSdKjDA+PAjVAJ/uHwICBfPmVKEoQYcoLW4ws52wvpwuS2Mj
         DA0VzXaFXgGPBC5wIJd/ZAhet5pwAmYd8l8I8uSF8TkEFo5HlFDk9ZKbfDaawGsHQqJ/
         nRtSsyskF6cKTutJlytwHpkdaOsfBQjPtsObnhtJ61GqrmCgCi9B7X9jvyjB1s5pgTgZ
         w1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tA05HRZCF60ea3fW06mOHmT2RqHh/kCSr16jqtr2SHs=;
        b=sNyjk4oaVrMf91hZtEx3CZjJk+tg8lP3nTcwMvnBc/5AhcAj03+AwpTv/VOXjV6U3M
         WdOz9AQ4HS+K7yJgM5VGms+RV3NiKhSrdgr+W9dHaq/V1hGB6PDBUjCqR5LFe/ykxjpT
         BhJ4sLb9WSB9Z16jDBeezJ/4JTOtHy367P6pkM6OkT8w7FLFDZgUKeVnGQgCMZtq14Oc
         qByMm8tViBOCuKadr2Dpe4XwfTLMovM/xPfVZQK0TcEF8ZSKH7AZAQ60Et1gzdGw4KuU
         U5EE82T8aGF0OX14JIADF9ec4VY48j8OjIUGWK56PsIvUAXSu/0pabe61YFOYC/JH7rr
         hKOQ==
X-Gm-Message-State: APjAAAVWeDNPKoIyHDwzemhZiNroO642PFmtkyxT2DBpP0U3NS1SR/Zx
        NWfsiiolfUpuZOFm8XPBxA==
X-Google-Smtp-Source: APXvYqzc/0yr/F8ySmiaaNdIxxvNCPBOalYcDSXPmeUqGVgijBsUtXMTkvQzVkL0/xGfmbWv1DwlCQ==
X-Received: by 2002:aed:2a06:: with SMTP id c6mr5100129qtd.146.1557424032170;
        Thu, 09 May 2019 10:47:12 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z11sm1262953qki.95.2019.05.09.10.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:47:11 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] ktest: support for Boot Loader Specification
Date:   Thu,  9 May 2019 13:46:25 -0400
Message-Id: <20190509174630.26713-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Fedora 30 introduces Boot Loader Specification (BLS) [1],
it changes around grub entry configuration.

This patchset deals with the new configuration.

- Add grub2bls option as REBOOT_TYPE to deal with BLS.
- Some cleanup around getting kernel entries.

[1] https://fedoraproject.org/wiki/Changes/BootLoaderSpecByDefault

Masayoshi Mizuma (5):
  ktest: introduce _get_grub_index
  ktest: cleanup get_grub_index
  ktest: introduce grub2bls REBOOT_TYPE option
  ktest: remove get_grub2_index
  ktest: update sample.conf for grub2bls

 tools/testing/ktest/ktest.pl    | 86 +++++++++++++++------------------
 tools/testing/ktest/sample.conf | 10 +++-
 2 files changed, 48 insertions(+), 48 deletions(-)

-- 
2.20.1

