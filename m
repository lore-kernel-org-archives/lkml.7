Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61211C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF7F21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554770693;
	bh=KGKrDAl+sXCd83F3Y+GRPj3kIiurlVSBpH5lz8ahofw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ddpBnKf+PVvn23z5MWhqcMCFdumS7hXyn40jPCKZcaS5EklEcEGKdNLEQVPP/8OcO
	 AyJegXDpJHlQXl4un19cZoM24EqC+O+TdkD9x8ZIwFWot/7kK1uN4VpogNE+/23zye
	 H22hWqTbCcYrVE+u7IhZZvD4ks58wa+hbsKqNgo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDIAor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:44:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55977 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfDIAom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:44:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1429123641;
        Mon,  8 Apr 2019 20:44:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Apr 2019 20:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=P0zNKeCy2JQLXV9pyaFfhRTUVfbqD8BKB8VBdzTrxlY=; b=nHQmV9T9
        GvTflNrcDKvm//OVkUZnOh0ey6ul8029Beep8Q/xRABkfr+f77r7fXZwzzib5D1J
        eiGAp8RQJI0w76tfGAOtFW030LTrHKaF+9OsVcuJpQ7g9+BlpA7vkbERszA5DSim
        UMS4YqVlM3evX64QZcaGHwe03dzlVFPXXHLmR3Jj25HWNyJQrVqSwsZ+nIuNz5X+
        DiajorjAuc72wygBrHIfefRmcTSlkq6Wkf/xHQr2EDI3ACbGsECGFxH1Y3iA86uN
        TuXAcjKzY9cME2GV5m7RCTAqZ0XyaeG9PdN7x5QXTRLjXfTMmQBDUk3J1YKIHmHi
        kG1D3t5Pouqi+Q==
X-ME-Sender: <xms:-OqrXC35dRhb9kaA5heRLqx2OYPv2WWmcRXxH4vboEWmvLVcO4vYeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvudejrdehtdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:-OqrXDt6RZQtzF-5JTUaO_ksNqPnopDRtMTo8q1Bs9zvK5W0vq4F5g>
    <xmx:-OqrXKichKrTONQhJzC6kvrfiucrX72S4n3nyPcI_EvvI_D3ulmSZA>
    <xmx:-OqrXKAEn1pN48tjkxJ0gD4niGkr6PJ8kP61WxheIF1XBM5noKRURA>
    <xmx:-eqrXKmlOd_zzNIW3a9G2WzOSwNhBYV2W2N2kP2dgX1eKOo43OTz8A>
Received: from eros.localdomain (ppp121-44-217-50.bras1.syd2.internode.on.net [121.44.217.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5BF6E4482;
        Mon,  8 Apr 2019 20:44:38 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] docs: Remove unnecessary reference link title
Date:   Tue,  9 Apr 2019 10:43:58 +1000
Message-Id: <20190409004359.29668-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409004359.29668-1-tobin@kernel.org>
References: <20190409004359.29668-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Labels that precede a heading use the heading as the link title.
Explicitly adding the link title is redundant and  makes the reference
slightly less maintainable.

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

