Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07943C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6D218C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIJFiZqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDFJhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:37:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfDFJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:37:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so4395642pgf.2;
        Sat, 06 Apr 2019 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JKzbLmOuB4i3/2ABSBaH37wRSZE0CAEFilVfjVxKb38=;
        b=hIJFiZqbvevS6d1JoUU8VKl2CXE1a6ZLoide/pR2SMp8oLmtT9Q3kphs2Z0Sp+82Ug
         7qgkQYIz3TqdvgCyN+REoWyLXyNZtyIQuaSqCq/B59jJ+tbCgJ+rGF67SwhH/HbjqvRi
         xZnMPerCjWh+hhXOjR8+t2FSaqXf6Ew0MZfyB+DahHaIgDvOmZKwS7/doABtVNrwYThW
         FLeDxXRe26MkSWp9mXhjydiOJwmRozEjeZBL07Meqtn4OT6kLojkKqHdUd0WQpklE2MU
         qdnYZI1Phv5m7lJUYLu7I2o1xuqdPJayZoRVqeqNA6Ee7AYzkF4zzW3A14v5pwFxTD2a
         WreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JKzbLmOuB4i3/2ABSBaH37wRSZE0CAEFilVfjVxKb38=;
        b=dVVi61bERa9GrSJ9HRZXRgBuKQ4ROA+HsKg/Ib3ovLaTv7GUUyNYzNA7JBLDFk5EdJ
         XfO67AOLxbZ/hZrtWIOudWSKQLjA6n1qlZzTQKBgRX9GEGgR6i/02YCHQP/le7pjtZH3
         /+1K3nqmadK2zehHMy8RVqz1L6cQJhuqIyNTE1QLF1GEuqB5vugBv4E4kJuuZZUUBWz6
         qG221ljliy3QA0aluZMGQI0uftN+mqmzFTV+1SZD8JbbQAc8SvNjKNZp+4FChdLKFBiw
         N86IsTnhn8OpH5LQHBXgnzoY9fccYhb9nvxckhoWBaxQ7laGcONnp8hRf+c/vHTBagAT
         SAEQ==
X-Gm-Message-State: APjAAAVi8ikedLg/wWPdgg8p6Z7umT4whl0u50bPMm38xiNJ+xeSzx95
        9o91elAd5/W4u40r2SiOWGo=
X-Google-Smtp-Source: APXvYqwU9ymM34Ta6kvmmyTEqzqmoEP4+uCZlVg/X+/LgX9hnlsCLncMJZ4SBAlY6vxoOpfcq1U2yw==
X-Received: by 2002:a62:6587:: with SMTP id z129mr17970133pfb.88.1554543424717;
        Sat, 06 Apr 2019 02:37:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id f63sm33033054pfc.180.2019.04.06.02.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 02:37:04 -0700 (PDT)
Date:   Sat, 6 Apr 2019 15:06:58 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: fix warning Using plain integer as NULL pointer
Message-ID: <20190406093658.GA7438@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed passing argument as "0 to NULL" which resolves below sparse warning

arch/x86/kvm/x86.c:3096:61: warning: Using plain integer as NULL pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 099b851..39034ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3093,7 +3093,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NESTED_STATE:
 		r = kvm_x86_ops->get_nested_state ?
-			kvm_x86_ops->get_nested_state(NULL, 0, 0) : 0;
+			kvm_x86_ops->get_nested_state(NULL, NULL, 0) : 0;
 		break;
 	default:
 		break;
-- 
2.7.4

