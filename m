Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C672EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4720693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371045;
	bh=iCC2c2TnpMmrHOv7WxKjcmPeorV1/9+mSTjlYmYwPIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n35ElMfr2yC0C+2gOKxFVbTWUUC+PAJeo9NFozJnL2jQuTO20yTrOBei+NunUNfer
	 RngnD7CNfHr+V2hxyyz9ISk29Rf2HialTC4aiMOHBpgbRXI4AIy8FbR2IUm5F9a4UV
	 jijW9itbmDZAe+xUHyc7srly7RXxCpCSLSCyXd+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfDDJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfDDJAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:00:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5112147C;
        Thu,  4 Apr 2019 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368412;
        bh=iCC2c2TnpMmrHOv7WxKjcmPeorV1/9+mSTjlYmYwPIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iy5lQk87Okk+NZBfakyXlYBBVDNKSC7xfua8vLnLixDUnJGusSKxIc9f1+s9zjDrj
         6SLWOdnV00qVN2aDZdY+xqBPDYuxn/M18HKvw+Jxz9UekAS8ObKVrhEwS02h/vfaMs
         xygHaa0k15fxQgN78KZDF51+KJ200t7GdTkzpTvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Joel Fernandes <joelaf@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/187] mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!
Date:   Thu,  4 Apr 2019 10:46:07 +0200
Message-Id: <20190404084604.490478147@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit afd07389d3f4933c7f7817a92fb5e053d59a3182 ]

One of the vmalloc stress test case triggers the kernel BUG():

  <snip>
  [60.562151] ------------[ cut here ]------------
  [60.562154] kernel BUG at mm/vmalloc.c:512!
  [60.562206] invalid opcode: 0000 [#1] PREEMPT SMP PTI
  [60.562247] CPU: 0 PID: 430 Comm: vmalloc_test/0 Not tainted 4.20.0+ #161
  [60.562293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  [60.562351] RIP: 0010:alloc_vmap_area+0x36f/0x390
  <snip>

it can happen due to big align request resulting in overflowing of
calculated address, i.e.  it becomes 0 after ALIGN()'s fixup.

Fix it by checking if calculated address is within vstart/vend range.

Link: http://lkml.kernel.org/r/20190124115648.9433-2-urezki@gmail.com
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 91a789a46b12..a46ec261a44e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -498,7 +498,11 @@ nocache:
 	}
 
 found:
-	if (addr + size > vend)
+	/*
+	 * Check also calculated address against the vstart,
+	 * because it can be 0 because of big align request.
+	 */
+	if (addr + size > vend || addr < vstart)
 		goto overflow;
 
 	va->va_start = addr;
-- 
2.19.1



