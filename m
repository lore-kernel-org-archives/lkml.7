Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A89C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81252054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257326;
	bh=rLlyClE3k+8KDwmLyzc/9MOSbKiCr/NZy72U3v9eJNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xv+mulWciUq37c63iW3SeBvNZwy0Z+WYDnf7dc+Q+u/g2rMdlgwPkQeCs7bKyRsez
	 DIwbCmGEAK4MATBG5fg6yx3miJSNT1FFITh5kuxYyH1mmF1OfRkQ2soKp+bvF+gfNT
	 k9OnVT4ZMWReGaPynKN6O2JVO0K0IBA65/JZAY00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbfCVMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390457AbfCVMWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7AA218A1;
        Fri, 22 Mar 2019 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257319;
        bh=rLlyClE3k+8KDwmLyzc/9MOSbKiCr/NZy72U3v9eJNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDHMsMz8AIt9v2xYsZsz7wgWsqUxZxfHC8It3Fr3ezts4iknWqRf/LBOs8kj0tt1u
         lA153VDSEw39Oet3iifW/a/ifhKMg5fme73nkOuOJ77d93r/PQrZE7+Ns2m8JOelw3
         xOdtbh4jbhEG4FaJrabDC84oepbelK/LAb57YKdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 164/238] powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
Date:   Fri, 22 Mar 2019 12:16:23 +0100
Message-Id: <20190322111307.977949313@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit ca6d5149d2ad0a8d2f9c28cbe379802260a0a5e0 upstream.

GCC 8 warns about the logic in vr_get/set(), which with -Werror breaks
the build:

  In function ‘user_regset_copyin’,
      inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:628:9:
  include/linux/regset.h:295:4: error: ‘memcpy’ offset [-527, -529] is
  out of the bounds [0, 16] of object ‘vrsave’ with type ‘union
  <anonymous>’ [-Werror=array-bounds]
  arch/powerpc/kernel/ptrace.c: In function ‘vr_set’:
  arch/powerpc/kernel/ptrace.c:623:5: note: ‘vrsave’ declared here
     } vrsave;

This has been identified as a regression in GCC, see GCC bug 88273.

However we can avoid the warning and also simplify the logic and make
it more robust.

Currently we pass -1 as end_pos to user_regset_copyout(). This says
"copy up to the end of the regset".

The definition of the regset is:
	[REGSET_VMX] = {
		.core_note_type = NT_PPC_VMX, .n = 34,
		.size = sizeof(vector128), .align = sizeof(vector128),
		.active = vr_active, .get = vr_get, .set = vr_set
	},

The end is calculated as (n * size), ie. 34 * sizeof(vector128).

In vr_get/set() we pass start_pos as 33 * sizeof(vector128), meaning
we can copy up to sizeof(vector128) into/out-of vrsave.

The on-stack vrsave is defined as:
  union {
	  elf_vrreg_t reg;
	  u32 word;
  } vrsave;

And elf_vrreg_t is:
  typedef __vector128 elf_vrreg_t;

So there is no bug, but we rely on all those sizes lining up,
otherwise we would have a kernel stack exposure/overwrite on our
hands.

Rather than relying on that we can pass an explict end_pos based on
the sizeof(vrsave). The result should be exactly the same but it's
more obviously not over-reading/writing the stack and it avoids the
compiler warning.

Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: Mathieu Malaterre <malat@debian.org>
Cc: stable@vger.kernel.org
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/ptrace.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -561,6 +561,7 @@ static int vr_get(struct task_struct *ta
 		/*
 		 * Copy out only the low-order word of vrsave.
 		 */
+		int start, end;
 		union {
 			elf_vrreg_t reg;
 			u32 word;
@@ -569,8 +570,10 @@ static int vr_get(struct task_struct *ta
 
 		vrsave.word = target->thread.vrsave;
 
+		start = 33 * sizeof(vector128);
+		end = start + sizeof(vrsave);
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
-					  33 * sizeof(vector128), -1);
+					  start, end);
 	}
 
 	return ret;
@@ -608,6 +611,7 @@ static int vr_set(struct task_struct *ta
 		/*
 		 * We use only the first word of vrsave.
 		 */
+		int start, end;
 		union {
 			elf_vrreg_t reg;
 			u32 word;
@@ -616,8 +620,10 @@ static int vr_set(struct task_struct *ta
 
 		vrsave.word = target->thread.vrsave;
 
+		start = 33 * sizeof(vector128);
+		end = start + sizeof(vrsave);
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
-					 33 * sizeof(vector128), -1);
+					 start, end);
 		if (!ret)
 			target->thread.vrsave = vrsave.word;
 	}


