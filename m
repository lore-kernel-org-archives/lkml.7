Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C35C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F5E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2RQr0Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfDPPq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:46:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46349 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:46:27 -0400
Received: by mail-yw1-f68.google.com with SMTP id v127so7458369ywe.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PMY/1MQM2MS3/ywqbNOzsE5mcCaPgtitZAkH08psa60=;
        b=N2RQr0Tg1Zir17Zu0EREHeWqdbmrBwW/4OtFubKrMRr1z4KgLtxQ8OP4Jjit6qkfQv
         K9htk2SfTlPJ+QO0Plci+o2IuOyF1KN759hzSZFSf+cEApmfIkEZ3Cr4/i5phXOj7dh7
         a0EICiVzw0/Vvw9b3GyyeY0xJWsq0s+Y827uTiRdbz28/UTQ6Vnvol7zEi6YNKBUYAGK
         IZCuslHKDv0hW7U3QKzwgxpTagqw/9j/4Wd2cJIJbaPK1caGKFuvgxrLnH9VTNX2lyrI
         urkDzNUGLY5Hvcsn/wKfZTNtyhvYO3qhfK8z423J8FQ/vY5p5a2wLJkDOk6H08bB4M0g
         sN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PMY/1MQM2MS3/ywqbNOzsE5mcCaPgtitZAkH08psa60=;
        b=hjuNNxjmW1zBWzRXgpWNBl0F4nYKU/HDSTCD39brw9cdSwSnD/a9MAyeZ1+xopYkne
         HXAvnpoEl2+mLcwe/DaLFQHptK6HpWyLItVTFE9qQZlmcc/C+nvWLPaMsTdCEr+LBa4/
         S44uGKwUfl/ibfpB2Q5jdWkCb3Rhnr0SAHr43v7QAAMy/TkNg/gRe3N/01XTBahDcAyV
         le1OvS6lpTK+Jj1NFzBjpJUxXx8KvaCFNPuCuq0sqynSksJqqYImL9JpJLWIye6DNDfJ
         yXSwiExwjvHyxGiVEnfnUmdIad6HwjmwU18OaCB8hxj9C6R+vBNcT7f4fOImKPYQFkld
         DduA==
X-Gm-Message-State: APjAAAXMOqkWuaBnD7FtbsxvZ5kXu7fCyX8rDlHcLdzdNCO0Qao7lXvz
        kOm8Zq976HtdNcbxJmq/oqE=
X-Google-Smtp-Source: APXvYqyqyLd3pAksQDQWGrxX73V2KLOTIDtjaPe2RoXDlaD7afJTvR82HLvP2JP1diBXuPcRw79mSA==
X-Received: by 2002:a81:3146:: with SMTP id x67mr64088185ywx.392.1555429586893;
        Tue, 16 Apr 2019 08:46:26 -0700 (PDT)
Received: from nishad ([2406:7400:54:eb3:d9be:857a:cd1e:eb7f])
        by smtp.gmail.com with ESMTPSA id 129sm24968407ywv.38.2019.04.16.08.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:46:26 -0700 (PDT)
Date:   Tue, 16 Apr 2019 21:16:14 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] x86: Use the correct style for SPDX License Identifier
Message-ID: <697848ff866ade29e78e872525d7a3067642fd37.1555427420.git.nishadkamdar@gmail.com>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555427418.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in the x86 Hardware Architecture related files.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/x86/include/asm/cpu_entry_area.h | 2 +-
 arch/x86/include/asm/pti.h            | 2 +-
 arch/x86/kernel/process.h             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 29c706415443..84006ca0f17a 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _ASM_X86_CPU_ENTRY_AREA_H
 #define _ASM_X86_CPU_ENTRY_AREA_H
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 5df09a0b80b8..07375b476c4f 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 320ab978fb1f..1d0797b2338a 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Code shared between 32 and 64 bit
 
-- 
2.17.1

