Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3781E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993156;
	bh=zujU5fYXV+gjmHGybhIXUolVWDUY+sSFZNFEunm/D9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xiYV2L4ZYdqlrLR+m7x7zVSM03i4g2djAxDCiANOzgev8O1ToNacQG+aRkidu/vwF
	 ZCvtmPD8YSptNjeS1iIL2WWbHhM6o+LTDBkN8s+cHGkicnrYUeYvv0mO4z3Wn3ySBY
	 X5rdQgEwOKVJo/GmXKjqwguS2dxbO/F+axMC+Mn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCGVMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:12:35 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56667 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfCGVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A49923026;
        Thu,  7 Mar 2019 16:12:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YZGcEdzI6yFT9z5i+ij7BvlkOK4yLoKhr9sL8DhOvvM=; b=zP387wsQ
        iwB2Pj5oNg4P6RbCtq6r2w3NDmqeULhnnolFNcYtIWP22H+68MFMErEqoAzOhQfe
        PU3ZdOBcUKlcTMvUSrbGn0ajR83uGSGq9Pg+XlpazZ5CctYqDzA/rqPiONMg4gi+
        DvXhH4rcbFr7u2VN/WSqKOl+VcpoQtVaaz8Iw1d70KjyB84rQ9WYU0t2lP8S+q0b
        4KBVRBNauzx/JSwYzOZv5uJ/Lz0uQC3kHnpEuRI6L/GiXyX6A1nHJyiLd3jSD27w
        aP76+1I5KyPOB760UbCXNonfUEpqDkEWt6Iqv9JbviVzDj2XzQwrd62rix+rXg2V
        rKWSqAGUhcDUNw==
X-ME-Sender: <xms:PYmBXBFhPuCrzCMwXbGZteFZWegAOd3RXVMls0WRaMEIRYyUlyHqrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:PYmBXP-m0D-XZyOkDc56yxfNzModXOe8ExFymCxCnfwlFX3CBtR9Lw>
    <xmx:PYmBXPxhdRqI-wPYcYu6w6V72ml7-ZTDYi77pqA4CVVu1KophXGrAQ>
    <xmx:PYmBXHuYZbWSLZYIhwUX4q6d86AhK5-Mpa1ahlwzF31zgOxcAadaAQ>
    <xmx:PYmBXAAxC7XOLToOYXp0bJGXr7aItOFh0NfzUugHplvSFog7N2graw>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F77E10331;
        Thu,  7 Mar 2019 16:12:26 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] docs: Remove unnecessary reference link title
Date:   Fri,  8 Mar 2019 08:11:47 +1100
Message-Id: <20190307211153.28400-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
References: <20190307211153.28400-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Labels that precede a heading use the heading as the link title.
Explicitly adding the link title defeats the purpose of this feature
i.e. makes the reference less maintainable.

Remove unnecessary reference link title.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/admin-guide/mm/numa_memory_policy.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index d78c5b315f72..1ef0146eaa4d 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -20,8 +20,7 @@ which is an administrative mechanism for restricting the nodes from which
 memory may be allocated by a set of processes. Memory policies are a
 programming interface that a NUMA-aware application can take advantage of.  When
 both cpusets and policies are applied to a task, the restrictions of the cpuset
-takes priority.  See :ref:`Memory Policies and cpusets <mem_pol_and_cpusets>`
-below for more details.
+takes priority.  See :ref:`mem_pol_and_cpusets` below for more details.
 
 Memory Policy Concepts
 ======================
@@ -56,7 +55,7 @@ Task/Process Policy
 	[clone() w/o the CLONE_VM flag] and exec*().  This allows a parent task
 	to establish the task policy for a child task exec()'d from an
 	executable image that has no awareness of memory policy.  See the
-	:ref:`Memory Policy APIs <memory_policy_apis>` section,
+	:ref:`memory_policy_apis` section,
 	below, for an overview of the system call
 	that a task may use to set/change its task/process policy.
 
@@ -77,7 +76,7 @@ VMA Policy
 	A "VMA" or "Virtual Memory Area" refers to a range of a task's
 	virtual address space.  A task may define a specific policy for a range
 	of its virtual address space.   See the
-	:ref:`Memory Policy APIs <memory_policy_apis>` section,
+	:ref:`memory_policy_apis` section,
 	below, for an overview of the mbind() system call used to set a VMA
 	policy.
 
@@ -142,7 +141,7 @@ Shared Policy
 	Although hugetlbfs segments now support lazy allocation, their support
 	for shared policy has not been completed.
 
-	As mentioned above in :ref:`VMA policies <vma_policy>` section,
+	As mentioned above in :ref:`vma_policy` section,
 	allocations of page cache pages for regular files mmap()ed
 	with MAP_SHARED ignore any VMA policy installed on the virtual
 	address range backed by the shared file mapping.  Rather,
-- 
2.21.0

