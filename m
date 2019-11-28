Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DACC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5DC21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5QygCir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1UYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 15:24:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbfK1UYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 15:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574972645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/y8p7TWJ4+9dx0qZYntYI0vqqca78jHSFlqFEn+6Y9I=;
        b=U5QygCirj36G/oqHsvBG9TtGy23xi8kkhfKEtFl9Kv/deTdY4Ws+T2kBSy4PqefM98vEmo
        BFIa7FDFBVTY7SAbQGIRpnuyygsM5TkwLulaHhssbRsFosMss6aL+ewQdfHq4YHabFRL5D
        lovJ3ivXwOSXV2nhGAdqaOK0fpmopzs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-46JDEDlPNPaG_8AyXo45oQ-1; Thu, 28 Nov 2019 15:24:03 -0500
Received: by mail-pj1-f72.google.com with SMTP id b10so660086pju.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 12:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7Q1sNAJK7KGCeC1/osi4u/yd8LMbojW2DcAg7eyhwk=;
        b=qQwXvQ6UjvaojZ8S42TgkdRwYIF5BYTEPv+S5G1F+AIEOT3FV4YkhnYhakOFoT0YBy
         jfJmNikzN4onD19MRNajYC90zTgAxkFNOT9djYbUHEmCgl7Aqrlv02cBKDIhb2xHaZuw
         6bJFdK2gsOparFOjUwEs+96HPWxJ3Myy11Pt8P8MMFJWL+BCG59OWppy8g+cux8p083M
         4i10ybutFCIPSchek503V0Ns3By2/tlM4/cTW0QMSTPFIiIzMDiiJ6ZGH7JB9Y5rlnGl
         gmiYXe/LjjhAvYHwfh7c069ODKlGLoq4WlprOthAhUzrn6H94EtVyK3r6Yq+8Sbow5CC
         PL+Q==
X-Gm-Message-State: APjAAAVT+iTulPjsAFFKINEyesya7viecLB4C8V8cfmAwxbSEgvC6Fls
        2EoiMiG1oXA38lWjn5nyCUGWmzqG+WU57xZ57ingHBIoxP4RkVoPZfGu74Yymd3nk5ZnHpbXIa4
        q/Vpqh7MiR+NDjj0HI5bihTeR
X-Received: by 2002:a17:90a:3663:: with SMTP id s90mr14556244pjb.1.1574972639261;
        Thu, 28 Nov 2019 12:23:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEBnny8bOGZ2sOhQL9nLkTVF0UqIXllrctdH9WVSgwdhpBSy3J7AMOGgxRJJki+CNRMtBZ+Q==
X-Received: by 2002:a17:90a:3663:: with SMTP id s90mr14556206pjb.1.1574972638976;
        Thu, 28 Nov 2019 12:23:58 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id s66sm22322578pfb.38.2019.11.28.12.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 12:23:58 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH v5 1/5] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date:   Fri, 29 Nov 2019 01:53:37 +0530
Message-Id: <1574972621-25750-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: 46JDEDlPNPaG_8AyXo45oQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now user-space tools like 'makedumpfile' and 'crash' need to rely
on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
supported by underlying kernel.

This value is used in user-space code to calculate the bit-space
required to store a section for SPARESMEM (similar to the existing
calculation method used in the kernel implementation):

  #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

Now, regressions have been reported in user-space utilities
like 'makedumpfile' and 'crash' on arm64, with the recently added
kernel support for 52-bit physical address space, as there is
no clear method of determining this value in user-space
(other than reading kernel CONFIG flags).

As per suggestion from makedumpfile maintainer (Kazu), it makes more
sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
rather than in arch-specific code, so that the user-space code for other
archs can also benefit from this addition to the vmcoreinfo and use it
as a standard way of determining 'SECTIONS_SHIFT' value in user-land.

A reference 'makedumpfile' implementation which reads the
'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
is available here:

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-me=
m-bit-v1/arch/ppc64.c#L471

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b98468..18175687133a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -413,6 +413,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 =09VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 =09VMCOREINFO_STRUCT_SIZE(mem_section);
 =09VMCOREINFO_OFFSET(mem_section, section_mem_map);
+=09VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 #endif
 =09VMCOREINFO_STRUCT_SIZE(page);
 =09VMCOREINFO_STRUCT_SIZE(pglist_data);
--=20
2.7.4

