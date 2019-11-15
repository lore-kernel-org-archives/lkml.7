Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D90120672
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUzj1a1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKOQQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:16:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49804 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727614AbfKOQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573834586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMxHxPFJyzxeXWtiGq2WT/trFatvxU9EXaoFETC1z+I=;
        b=UUzj1a1TItNNyDzaFG9ZNzZK80rZEhJAtP7eMq5mYJSwpe0TQto42jaIJXQxumjc5OmZwF
        VKYn6CzJB7IqJKqFPu2eO8Ue5w6OOoYcpoVd7do1bqWD71vPpV0riMn/MBEyOoeqqEh0rf
        sjA57Y96Qv2zFD7T5Ytr5Vg68UMgtFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-RDXgSLyTPKWd1aLUQ5R-jQ-1; Fri, 15 Nov 2019 11:16:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E8DC80268E;
        Fri, 15 Nov 2019 16:16:21 +0000 (UTC)
Received: from llong.com (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC69D9D54;
        Fri, 15 Nov 2019 16:16:19 +0000 (UTC)
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
Subject: [PATCH v2 1/2] x86/speculation: Fix incorrect MDS/TAA mitigation status
Date:   Fri, 15 Nov 2019 11:14:44 -0500
Message-Id: <20191115161445.30809-2-longman@redhat.com>
In-Reply-To: <20191115161445.30809-1-longman@redhat.com>
References: <20191115161445.30809-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RDXgSLyTPKWd1aLUQ5R-jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MDS vulnerable processors with TSX support, enabling either MDS or
TAA mitigations will enable the use of VERW to flush internal processor
buffers at the right code path. IOW, they are either both mitigated
or both not. However, if the command line options are inconsistent,
the vulnerabilites sysfs files may not report the mitigation status
correctly.

For example, with only the "mds=3Doff" option:

  vulnerabilities/mds:Vulnerable; SMT vulnerable
  vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT vulner=
able

The mds vulnerabilities file has wrong status in this case. Similarly,
the taa vulnerability file will be wrong with mds mitigation on, but
taa off.

Change taa_select_mitigation() to sync up the two mitigation status
and have them turned off if both "mds=3Doff" and "tsx_async_abort=3Doff"
are present.

Both hw-vuln/mds.rst and hw-vuln/tsx_async_abort.rst are updated
to emphasize the fact that both "mds=3Doff" and "tsx_async_abort=3Doff"
have to be specified together for processors that are affected by both
TAA and MDS to be effective. As kernel-parameter.txt references both
documents above, it is not necessary to update it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/hw-vuln/mds.rst       |  6 +++++-
 .../admin-guide/hw-vuln/tsx_async_abort.rst     |  5 ++++-
 arch/x86/kernel/cpu/bugs.c                      | 17 +++++++++++++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admi=
n-guide/hw-vuln/mds.rst
index e3a796c0d3a2..8e5212fedac3 100644
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -265,7 +265,11 @@ time with the option "mds=3D". The valid arguments for=
 this option are:
=20
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Not specifying this option is equivalent to "mds=3Dfull".
+Not specifying this option is equivalent to "mds=3Dfull". For
+processors that are affected by both TAA (TSX Asynchronous Abort)
+and MDS, specifying just "mds=3Doff" without an accompanying
+"tsx_async_abort=3Doff" will have no effect as the same mitigation is
+used for both vulnerabilities.
=20
=20
 Mitigation selection guide
diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Docume=
ntation/admin-guide/hw-vuln/tsx_async_abort.rst
index fddbd7579c53..af6865b822d2 100644
--- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
+++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
@@ -174,7 +174,10 @@ the option "tsx_async_abort=3D". The valid arguments f=
or this option are:
                 CPU is not vulnerable to cross-thread TAA attacks.
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Not specifying this option is equivalent to "tsx_async_abort=3Dfull".
+Not specifying this option is equivalent to "tsx_async_abort=3Dfull". For
+processors that are affected by both TAA and MDS, specifying just
+"tsx_async_abort=3Doff" without an accompanying "mds=3Doff" will have no
+effect as the same mitigation is used for both vulnerabilities.
=20
 The kernel command line also allows to control the TSX feature using the
 parameter "tsx=3D" on CPUs which support TSX control. MSR_IA32_TSX_CTRL is=
 used
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4c7b0fa15a19..cb513eaa0df1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -304,8 +304,12 @@ static void __init taa_select_mitigation(void)
 =09=09return;
 =09}
=20
-=09/* TAA mitigation is turned off on the cmdline (tsx_async_abort=3Doff) =
*/
-=09if (taa_mitigation =3D=3D TAA_MITIGATION_OFF)
+=09/*
+=09 * TAA mitigation via VERW is turned off if both
+=09 * tsx_async_abort=3Doff and mds=3Doff are specified.
+=09 */
+=09if (taa_mitigation =3D=3D TAA_MITIGATION_OFF &&
+=09    mds_mitigation =3D=3D MDS_MITIGATION_OFF)
 =09=09goto out;
=20
 =09if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
@@ -339,6 +343,15 @@ static void __init taa_select_mitigation(void)
 =09if (taa_nosmt || cpu_mitigations_auto_nosmt())
 =09=09cpu_smt_disable(false);
=20
+=09/*
+=09 * Update MDS mitigation, if necessary, as the mds_user_clear is
+=09 * now enabled for TAA mitigation.
+=09 */
+=09if (mds_mitigation =3D=3D MDS_MITIGATION_OFF &&
+=09    boot_cpu_has_bug(X86_BUG_MDS)) {
+=09=09mds_mitigation =3D MDS_MITIGATION_FULL;
+=09=09mds_select_mitigation();
+=09}
 out:
 =09pr_info("%s\n", taa_strings[taa_mitigation]);
 }
--=20
2.18.1

