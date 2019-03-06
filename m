Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7866820657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdO6ois1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCFUti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:49:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46271 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:49:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id i5so7673226qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WVeg1aZd3ymhaUnAk067l4PYGxtt96WuEwv9u0W0cKc=;
        b=jdO6ois1FjCKVwGli9+MFaR28imW1+K/Ggw+julLICO1IUqEsUIZqGCadRg1K/KG7L
         1U2sRh6ZvaFxAsWhPR3ql2wbizu031t9zFPl8oA8GPsbcWLSgEBobP9CxQX/wBA5JDhT
         zd8HA8v9E3yVpCfOPV0kcpAleqApLEcUSVvAG3uI4Itni+h6CtBqqKwYozKqHf0sFo4n
         TjCR9v2q2L1TxXHe79cUI/UHk/ArsIQQ5gOFxZab/MSIw8280p6s+Gp8DnbfKUJ3v2Rt
         cwb2Mc5gntqd7lso7r5faiufYLDfWoP4whYhEzofd/7aHU+fb6b6G6zO/KKb3J5/0Do+
         /4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVeg1aZd3ymhaUnAk067l4PYGxtt96WuEwv9u0W0cKc=;
        b=ijYkG4KixSuFmDOMVW/DuiY9RYwJjFFREmlVbIcdgEzHvJGLuwUCcSzjIysy4+QRBk
         F4bBo08ChGL8IDVZxd2r7FXxu/NSBwcHHcChrRDCIwdgf/OuA/9yGh/rsQfEKeq+uTZf
         lGSJp41I15a7zO37tCHs4Txt+Hsn8BjiRe6aXcS/h8F97HsR9ynI32yRokzW+AHvgpf1
         3G6+32LE19iAav8uIhTtasabhimlQADEFB6ObbkPTHhiBzyqav+yv8xFMPtMKwzIkm+m
         p90JhAboDFcrIBYOXjhYKIlk6N5cDuT4JsXAa17RaNM8+JQBSEfQeouK40DM63LEU6ib
         6Djw==
X-Gm-Message-State: APjAAAVQYneAPnrWq6hXUrBSmkbq/RlirE83LcKG6rYy/6OaNRcCaHGO
        P/VE2Vb47ry7IkYHFI5011/ETK4=
X-Google-Smtp-Source: APXvYqyOy/vhBhmCc4pxXuiRwYEWbc9GvpOpfG/hzI7XqTsLmy/5cqOlPgKwoc8UTikKdYKN57lxrQ==
X-Received: by 2002:a37:491:: with SMTP id 139mr7213154qke.345.1551905376348;
        Wed, 06 Mar 2019 12:49:36 -0800 (PST)
Received: from mwhitehe.remote.csb (pool-98-116-99-216.nycmny.fios.verizon.net. [98.116.99.216])
        by smtp.gmail.com with ESMTPSA id b66sm1642627qkj.57.2019.03.06.12.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:49:35 -0800 (PST)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 0/2] x86/CPU: Use correct Cyrix-specific macros
Date:   Wed,  6 Mar 2019 15:49:25 -0500
Message-Id: <1551905367-26931-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the incorrect Cyrix-specific macro calls with the correct
setCx86() and getCx86() calls. Also remove the unused setCx86_old(),
getCx86_old() and their related comments in the code.

Matthew Whitehead (2):
  x86/CPU: Use correct macros for Cyrix calls on Geode processors
  x86/CPU: Remove {get,set}Cx86_old macros used for Cyrix processors

 arch/x86/include/asm/processor-cyrix.h | 21 ---------------------
 arch/x86/kernel/cpu/cyrix.c            | 14 +++++++-------
 2 files changed, 7 insertions(+), 28 deletions(-)

-- 
1.8.3.1

