Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECDB2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXkmupl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK2T7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:59:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54053 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbfK2T7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575057580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/y8p7TWJ4+9dx0qZYntYI0vqqca78jHSFlqFEn+6Y9I=;
        b=YXkmupl3b6m/6g7V0RJKTlWyd3F3cWO5v4Z+4hft9LbjXJqGpxyDYIcTUw19KTCzUZBbQX
        9gTwJG5dlKSZ27iBWXQ20wwAyvnhA0gtWU4BNVGprkuBH5h4mEEBh4d2co3zoga1xxll1z
        3ee7Pd90ZJ/0evvupakme6jFkh6sMU8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-OSpe2VMAMbqDnecsklNsWA-1; Fri, 29 Nov 2019 14:59:38 -0500
Received: by mail-pf1-f199.google.com with SMTP id b17so18586118pfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 11:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7Q1sNAJK7KGCeC1/osi4u/yd8LMbojW2DcAg7eyhwk=;
        b=tUWxtv/4woHH1PCIgbXqOYIxgqOYrKa+1OSHoDJdQScYgDcgS+WxuX5ZunYCxXmHeu
         saWukriU41IGqIdiMX9mVGz55qP0u6XutEyFecKNLvpbyLei4GUkH4yqNWaMw+2RMFsa
         eK23n6Sm9aIirQG5R33mxILkeh3WaW29u2XCxMSAwvdpNyyJazquNngLyPyNSP1sUO5D
         cq/gviHInQV837GXa2W/BIVt8hDetAsSleztE7p/QhkOeJbP1QlRa5ZZqpN6S2sVUr9U
         EBWe2IshaGWDj15pyetPpobrvW5SJPWjMynSRor4sgWUL5P3LTlqE7hBMe2E/21DYPlH
         G9BA==
X-Gm-Message-State: APjAAAWaJue9ijh3TXCh+UFWV26htzjMzlLcPdCglm/FL8hXV+zlRvlt
        1MCx9tqrUlduklq/PuboOvwE7zts7kjIwjFEe1V5Aayy4PRROZx6oAreoZOuY+t5VIs58JggikW
        J47oPFgX3hBGlw31KH7NTuXgu
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr15574206pgc.374.1575057575545;
        Fri, 29 Nov 2019 11:59:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxfC5l5m0YoqdbJOwab9vDMWknIRaUJM6sjnSau+oJsA046vHWiBYg3wYv5hDxMjiI/P8T+w==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr15574178pgc.374.1575057575265;
        Fri, 29 Nov 2019 11:59:35 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id r28sm23294033pgk.75.2019.11.29.11.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 11:59:34 -0800 (PST)
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
Subject: [RESEND PATCH v5 1/5] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date:   Sat, 30 Nov 2019 01:29:15 +0530
Message-Id: <1575057559-25496-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: OSpe2VMAMbqDnecsklNsWA-1
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

