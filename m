Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A81320672
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrFKFjgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfKOQQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:16:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727700AbfKOQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573834588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkpOzaHuUb6phZ8PlQrh1XGmuCXgq4ilnADtFE4rutU=;
        b=YrFKFjgrxn4pyq0DVnH/2mGt7AcDNrJZj4ujvyt07d542uhyNq99L8GYrF5kbP3Csnuj5A
        xuUAGZ9iDBlQ6rR4PH+a9KzVbsrNfI57OhxI4eiRwEzRlE7IXeFEEJmNClXV2998iuubZp
        R58EPEXT/Nquzu0nuNd+VHhIq3grujc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-c9Vxz79sNrqwvD0tmxnkSg-1; Fri, 15 Nov 2019 11:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA9931005510;
        Fri, 15 Nov 2019 16:16:22 +0000 (UTC)
Received: from llong.com (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 668B49D54;
        Fri, 15 Nov 2019 16:16:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] x86/speculation: Fix redundant MDS mitigation message
Date:   Fri, 15 Nov 2019 11:14:45 -0500
Message-Id: <20191115161445.30809-3-longman@redhat.com>
In-Reply-To: <20191115161445.30809-1-longman@redhat.com>
References: <20191115161445.30809-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: c9Vxz79sNrqwvD0tmxnkSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MDS and TAA mitigations are inter-related for processors that are
affected by both vulnerabilities, the followiing confusing messages can
be printed in the kernel log:

  MDS: Vulnerable
  MDS: Mitigation: Clear CPU buffers

To avoid the first incorrect message, the printing of MDS mitigation
is now deferred after the TAA mitigation selection has been done.
However, that has the side effect of printing TAA mitigation first
before MDS mitigation.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cb513eaa0df1..5966a52b359f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -39,6 +39,7 @@ static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
+static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
=20
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
@@ -108,6 +109,12 @@ void __init check_bugs(void)
 =09mds_select_mitigation();
 =09taa_select_mitigation();
=20
+=09/*
+=09 * As MDS and TAA mitigations are inter-related, defer printing MDS
+=09 * mitigation until after TAA mitigation selection is done.
+=09 */
+=09mds_print_mitigation();
+
 =09arch_smt_update();
=20
 #ifdef CONFIG_X86_32
@@ -245,7 +252,10 @@ static void __init mds_select_mitigation(void)
 =09=09    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 =09=09=09cpu_smt_disable(false);
 =09}
+}
=20
+static void __init mds_print_mitigation(void)
+{
 =09pr_info("%s\n", mds_strings[mds_mitigation]);
 }
=20
--=20
2.18.1

