Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C37C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6D9205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055408;
	bh=c43FvKQyIGggJWe3cFvt6aywY7QSwZwhDAgmHHoL9gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAUbUjdsBf4x0JoigsIS6iRVR6QP+apxKf+Mchv8OoGl6QyQHB9BL+0Sz9h2KTMEZ
	 Y8umGjjUGJlGylUubvzYLdIjBYNFEKhdnQ6dFnaji8B6/FhpCkQPenZwo6xCUZxVOU
	 mbXIruzC2Py0eh/s3NemCcsREV55eq2jwlqLgGlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfGBIDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfGBID1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:03:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF2321479;
        Tue,  2 Jul 2019 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054606;
        bh=c43FvKQyIGggJWe3cFvt6aywY7QSwZwhDAgmHHoL9gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3kFQ6YW2UK8ffvRLSVQrJZc+ZPqceCtVy3nJDqRfWwJ8jt/OfSspdxofDw+Vvy3A
         DVbOqrsDCz/0zjZHSO0KziXm+bZMJzTLU9uSV0Nrn1lmDoqukErgNbmnE2lRTXvg+w
         zkEpahrU9jUk/nZhfHIXFvoKmF+bU7CfjTFnjAwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.1 27/55] cpu/speculation: Warn on unsupported mitigations= parameter
Date:   Tue,  2 Jul 2019 10:01:35 +0200
Message-Id: <20190702080125.502302944@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit 1bf72720281770162c87990697eae1ba2f1d917a upstream.

Currently, if the user specifies an unsupported mitigation strategy on the
kernel command line, it will be ignored silently.  The code will fall back
to the default strategy, possibly leaving the system more vulnerable than
expected.

This may happen due to e.g. a simple typo, or, for a stable kernel release,
because not all mitigation strategies have been backported.

Inform the user by printing a message.

Fixes: 98af8452945c5565 ("cpu/speculation: Add 'mitigations=' cmdline option")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190516070935.22546-1-geert@linux-m68k.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cpu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2315,6 +2315,9 @@ static int __init mitigations_parse_cmdl
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
 	else if (!strcmp(arg, "auto,nosmt"))
 		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
+	else
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
+			arg);
 
 	return 0;
 }


