Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F599C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C892077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu5CCvEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfKOQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:16:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727614AbfKOQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573834584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZccMmQV2I9Usjc9z4oHVV3rqIYYfGXlFFrANJErSVXI=;
        b=iu5CCvEeodH6OgcJxCQpMAZXfxsowQhGGvxmj1jZKtL5YaCns8JEgvQ1P6W8WISJ22j5+v
        mqoiDY+rm4VvyNF0WGgjkYd47B6tfgv0bk76a8Rngwb62qrnpUPSdnfOb0mlK+Uwi1t56T
        0COQfuX7qvK0/WFkaRgxNJ7Be5I9q1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-wGZQGWnkO3aWB0jmJXbWdA-1; Fri, 15 Nov 2019 11:16:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929C980268B;
        Fri, 15 Nov 2019 16:16:19 +0000 (UTC)
Received: from llong.com (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2913E9D54;
        Fri, 15 Nov 2019 16:16:15 +0000 (UTC)
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
Subject: [PATCH v2 0/2] x86/speculation: Fix incorrect MDS/TAA mitigation status
Date:   Fri, 15 Nov 2019 11:14:43 -0500
Message-Id: <20191115161445.30809-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wGZQGWnkO3aWB0jmJXbWdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Update the documentation files accordingly
  - Add an optional second patch to defer printing of MDS mitigation.

As MDS and TAA mitigations can be inter-related, setting command
line option for one without a matching other may cause one of their
vulnerabilities files to report their status incorrectly. This patch
makes sure that both vulnerabilities files will report consistent
status correctly.

Waiman Long (2):
  x86/speculation: Fix incorrect MDS/TAA mitigation status
  x86/speculation: Fix redundant MDS mitigation message

 Documentation/admin-guide/hw-vuln/mds.rst     |  6 ++++-
 .../admin-guide/hw-vuln/tsx_async_abort.rst   |  5 +++-
 arch/x86/kernel/cpu/bugs.c                    | 27 +++++++++++++++++--
 3 files changed, 34 insertions(+), 4 deletions(-)

--=20
2.18.1

