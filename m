Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E083CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4982075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUu2/kvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKKIBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:01:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41413 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726978AbfKKIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573459307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/y8p7TWJ4+9dx0qZYntYI0vqqca78jHSFlqFEn+6Y9I=;
        b=DUu2/kvZEmOvof4/tNV1rY+CmIG+onkYRpmW/YoL5wM0wE/UHKoU4I2JIexa5kSXs6k3wI
        vohzwLE6eRERY21Evf5pbpSMuaScSHB6aECxKqgts17sps4gRUrch21sElvlTPxMEH/onZ
        I+MsxkWGBK6btT1yx2xWhd8Uly1hfQQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-hDHuI4ayN9uwvkCSqtPvPg-1; Mon, 11 Nov 2019 03:01:46 -0500
Received: by mail-pf1-f199.google.com with SMTP id j2so12040802pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7Q1sNAJK7KGCeC1/osi4u/yd8LMbojW2DcAg7eyhwk=;
        b=QBQpxemsr+wzaa7prbvECzSe9a7nk7vpAzo2OcwZyDH34c53OuQE6Yx1DAVtNORNEc
         QjtV0neCOBtKXFenKPLJZCajhgHr6Ve3lbvno+Jq2VUe2CLwy/y28PQiV4a0kWPa/aVx
         ZQCc/rpyWxTHQrZx4StgfwSnPaZnHiyBvvClnMgEz4w/2TB+OQZXS92gxNWdEHOPkGwW
         KRC/PgY7qKfxIduT2RakRm6QLK6KSbNYyAYv+7jPWtg+5BP2q7zxo6VQGfNj4/fijlK8
         UFKQGEP9QXBH8g9ivbFSbYdKmaQRtjGMKBvYt6aDLgDHLXKqYudjFKdLongAKxo5j5Cu
         rnAA==
X-Gm-Message-State: APjAAAWNYKg2l5KCRFk3XzDSMQmucwEx81uoJ3sDwNzysmmsdQ4gVyfb
        dwmWSWGrw69/rbhHswidkWXMXjnZv6qfsfLe+5FHXgb/NWy47Hk+oLrD+NlNuqME6SM+6kpxLW3
        djzC8UPLPW21gYdwW4NzGEOe1
X-Received: by 2002:a62:fcd2:: with SMTP id e201mr404509pfh.52.1573459301444;
        Mon, 11 Nov 2019 00:01:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/PM/uE1YEEDp1OQcYhDW64ur/c96jF9ficCBtta087Mx43bjXxmhjovhzV8sTDdZdS3kXpw==
X-Received: by 2002:a62:fcd2:: with SMTP id e201mr404459pfh.52.1573459301055;
        Mon, 11 Nov 2019 00:01:41 -0800 (PST)
Received: from localhost ([122.177.0.15])
        by smtp.gmail.com with ESMTPSA id r33sm12736180pjb.5.2019.11.11.00.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 00:01:39 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
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
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH v4 1/3] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date:   Mon, 11 Nov 2019 13:31:20 +0530
Message-Id: <1573459282-26989-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
X-MC-Unique: hDHuI4ayN9uwvkCSqtPvPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

