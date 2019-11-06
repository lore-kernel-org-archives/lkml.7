Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA8EC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1FB214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9Lle0Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfKFMGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:06:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33111 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfKFMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:06:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id w30so2743864wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 04:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hbMBIvBvZ32LNNu+KvWneSx0Eevf4k95+VeOqx6lZcc=;
        b=J9Lle0Vg8eqXZJPloxdmIenCWWY5XbG47gFr7l5/VCbUI+gVPjXbSR0X9B0nbx/EXs
         IwJEwgq8t+1ZNJfRp1Sh6EO3+K29exZJItm0IHB3ORPN56U/Jp2z9oIIBYGRpgPHxEAM
         KEQ1MIWvL9IbRuj08XboAoBFqiw1A32OEYA+gKOUFqDqXueDO3yVN31oTVrZXjmL2xAe
         vH5bw6pBNbIvxaJ6ZzuJKarAoVHao+q6GinO3yHAGRIH9Z7gQdTRyp3G9K5AbkNIQu5x
         OveLMazGm5rI5MzzaLO3+Kaga9zGekml9puOXC9pSLfTsNDm55ggI304v9t/N2KHCJ7V
         slMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hbMBIvBvZ32LNNu+KvWneSx0Eevf4k95+VeOqx6lZcc=;
        b=OnlgL7SeKFyfxtmei6BoXpfoZ5h2iCNvVc5m6xWK18N5PKnMI3AJHLzOMFhsgs9rBD
         ITn0ycAS0eFXw0RZmriotGqwx4SD+JZQLI/J1ctuV9YkjyLQWdf9+HNa2WUMszA5Rh1t
         N/ZNfEsvonTUgkYCzwCjAjtu5IRQBD/yWLODMbNqeUMv/OIj28jDc58oM3r6T7yp/xQc
         k4nuAeRq6IgB5aq6/vsSif+FNfjIUeIdAZKQgm9aNvXY+DEA0sUPK1fnmmuaRmhDgLJE
         JEeu0ZjPuXBqU46svO8UYom0vAojYsk0fXFnL3Xi/RE0lobCH+wmSyvi1K3uM/mnAZN5
         wzUQ==
X-Gm-Message-State: APjAAAVlMQtz8NBCMcXDV4VfoHX9NmcomIDqAVs9V+uWCdk1IZ71Jku1
        FAYVppHif8lEX/qcCVHPTu+UwKqubzE=
X-Google-Smtp-Source: APXvYqwgTz6DtI0/S8rkL/tXlnbbOfkvTaQ7EfPy417RbVspJIy5TiNaYikpj3YyHBd24DOygx8WGA==
X-Received: by 2002:a05:6000:350:: with SMTP id e16mr2541228wre.276.1573042001027;
        Wed, 06 Nov 2019 04:06:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a58:8166:7500:885d:9dcb:243a:788b])
        by smtp.gmail.com with ESMTPSA id t133sm2702040wmb.1.2019.11.06.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 04:06:40 -0800 (PST)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH V2] x86/boot: explicitly place .eh_frame after .rodata
Date:   Wed,  6 Nov 2019 14:06:28 +0200
Message-Id: <20191106120629.28423-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
References: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using GCC as compiler and LLVM's lld as linker, linking
setup.elf fails:
      LD      arch/x86/boot/setup.elf
    ld.lld: error: init sections too big!

This happens because ld.lld has different rules for placing
orphan sections (i.e. sections not mentioned in a linker script)
compared to ld.bfd.

Particularly, in this case, the merged .eh_frame section is
placed before __end_init, which triggers an assert in the script.

Explicitly place this section after .rodata, in accordance with
ld.bfd's behavior.

Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/760
---

Changes in V2:
 * removed wildcard for input sections (.eh_frame* -> .eh_frame)

 arch/x86/boot/setup.ld | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 0149e41d42c2..30ce52635cd0 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -25,6 +25,7 @@ SECTIONS
 
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
+	.eh_frame	: { *(.eh_frame) }
 
 	.videocards	: {
 		video_cards = .;
-- 
2.17.1

