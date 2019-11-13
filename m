Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51808C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE0F206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc0/f4Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKMTfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:35:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47454 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbfKMTfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573673706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=txS1khq9ZKNA0GR2yPgniZL1Ij4hIU/9SqdOMLLoMc8=;
        b=dc0/f4PgdTHbkuEFCD0ORZ9jbXjyFx9MTL0ogjc2KXc1977xpPLn3jkgwIJQPNIgpPbKdY
        hcX/VRljpKDuYQ57LiPPW166qoOYhwPLDyHvDQqat3aJnH1lMBCeOw0H3EVkwSPM7AX7u9
        1Ww/J0QugbyOaiTVwkY/VtkBxKJ7EXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-lC8gbxsdMjGnpukZrfE3Dw-1; Wed, 13 Nov 2019 14:35:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AE638029AF;
        Wed, 13 Nov 2019 19:35:03 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2FE426E48;
        Wed, 13 Nov 2019 19:34:58 +0000 (UTC)
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
Subject: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
Date:   Wed, 13 Nov 2019 14:33:50 -0500
Message-Id: <20191113193350.24511-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lC8gbxsdMjGnpukZrfE3Dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MDS vulnerable processors with TSX support, enabling either MDS
or TAA mitigations will enable the use of VERW to flush internal
processor buffers at the right code path. IOW, they are either both
mitigated or both not mitigated. However, if the command line options
are inconsistent, the vulnerabilites sysfs files may not report the
mitigation status correctly.

For example, with only the "mds=3Doff" option:

  vulnerabilities/mds:Vulnerable; SMT vulnerable
  vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT vulner=
able

The mds vulnerabilities file has wrong status in this case.

Change taa_select_mitigation() to sync up the two mitigation status
and have them turned off if both "mds=3Doff" and "tsx_async_abort=3Doff"
are present.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/cpu/bugs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4c7b0fa15a19..418d41c1fd0d 100644
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

