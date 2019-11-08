Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D689FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BD6207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWm3B5ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfKHJBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:01:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728513AbfKHJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573203674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcMCl02DtgAodZc1y0NYd9at6CosXJepzGQl98OpFNI=;
        b=iWm3B5acdFvtqt5EfRGjE4g529mRBRC2qKHNgNlgj8CXgTYIsvonZz4s3I91YP2wIVuEBo
        71IOX2VLM4zpCeZeWuQd4eJ77QvgKYptJqaNEAQbV1sLzYgvJyssDOo7PXSz6eEQr/DDOW
        q0mwOWj6bXMNNWqo6RObQUAGsHjnvB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-yCeEA3aXM7mippN68agMJw-1; Fri, 08 Nov 2019 04:01:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FE0800054;
        Fri,  8 Nov 2019 09:01:08 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68AA85D6A5;
        Fri,  8 Nov 2019 09:00:58 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed declaration of struct kimage
Date:   Fri,  8 Nov 2019 17:00:27 +0800
Message-Id: <20191108090027.11082-4-lijiang@redhat.com>
In-Reply-To: <20191108090027.11082-1-lijiang@redhat.com>
References: <20191108090027.11082-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yCeEA3aXM7mippN68agMJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild test robot reported some build warnings as follow:

arch/x86/include/asm/crash.h:5:32: warning: 'struct kimage' declared
inside parameter list will not be visible outside of this definition
or declaration
    int crash_load_segments(struct kimage *image);
                                   ^~~~~~
    int crash_copy_backup_region(struct kimage *image);
                                        ^~~~~~
    int crash_setup_memmap_entries(struct kimage *image,
                                          ^~~~~~
The 'struct kimage' is defined in the header file include/linux/kexec.h,
before using it, need to include its header file or make a declaration.
Otherwise the above warnings may be triggered.

Add a declaration of struct kimage to the file arch/x86/include/asm/
crash.h, that will solve these compile warnings.

Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system ca=
ll")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Link: https://lkml.kernel.org/r/201910310233.EJRtTMWP%25lkp@intel.com
---
 arch/x86/include/asm/crash.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 3dff55f4ed9d..88eadd08ad70 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_CRASH_H
 #define _ASM_X86_CRASH_H
=20
+struct kimage;
+
 int crash_load_segments(struct kimage *image);
 int crash_copy_backup_region(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
--=20
2.17.1

