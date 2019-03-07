Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EBA20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993187;
	bh=DmOiyGQaDUGZGtfRVExAqG0qOh5YnPHUyVXUy/dbXxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KpoYtsDUyl0gfaMB94xJA48RfQN0fnsvJ7fhq1pelZHOfquPu7pg1mqb7ng3NpYC1
	 iaOpkSZo1Vx4XG6Tnv50yGBc7cElDidBwP1/ADPGEWskRf/TDIfolnesoSRXJtudDa
	 urPDPpKhoaw33eYW2IFH0sWL8mr1PtepGF9hZV0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCGVNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:13:06 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41321 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbfCGVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 335483556;
        Thu,  7 Mar 2019 16:12:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=w2fXLe4ZgTkW2x4QyojPjWlfikwMYKP+enATmuiNyAs=; b=Cv+/mBIl
        6AJ2oPpwVUFnwz8xlfOR0Z6dsrSFVdMQ4hcVLTKE5nZL/uMA737r2K9u06JcORnu
        qh6+oqpRAwRHPp5VAnAzZ/LUCNX5flbGSnWX1r7RFoCW0e0sLCh46dvs4EIgBh7J
        URcer0MeBN9VPbJq9L2DjpgEqWdaRJu1SdivJPCP2tBw9Vcdf4PTfXj1J/l24UIF
        jHx5ddRydrR6aWKRqP+AAYsG2vf6p6U8NsPHAD5LxbdWXYSAPRuxFki9oTMgEYVw
        HV66GTNqG1ztWtqpiDZK/eCxRUfCu0F6yWUg8l2i2cy60NCEJd26qcySJcYGXW6A
        Yaft0lveWAXsKQ==
X-ME-Sender: <xms:P4mBXGPrOz88WQCW0xk6Q1DQc2ruB7dw-zP0QZT8j2gHXNZr3_Zrng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:P4mBXH_n6dImpnc4YAhqSUsbarQjmU-3MVT2Pj82fkTmguzT2KCcYA>
    <xmx:P4mBXP0PgJi13C5M_xbaSo30rvpU6OVheJ9_cPy-SDIljbZmWLLJSQ>
    <xmx:P4mBXBKQ1Y0N-4IDDhxXQ6cWKh2cCaGd2m3DO2EPzFlYL3oAprsblw>
    <xmx:P4mBXE6LL2rRvWS_AJAM10dF0jk3_i-IBMyH2PUFH0amMnWUpNJ5oA>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79AA510344;
        Thu,  7 Mar 2019 16:12:29 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] docs: Use reference to link to rst file
Date:   Fri,  8 Mar 2019 08:11:48 +1100
Message-Id: <20190307211153.28400-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
References: <20190307211153.28400-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current document includes the path to an RST doc file.  Since this is an
RST file we can make this a link.  Keeps the path as the link title
since that what the original author wrote.

Use reference to link to rst file.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/vm/numa.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/numa.rst b/Documentation/vm/numa.rst
index 185d8a568168..5cae13e9a08b 100644
--- a/Documentation/vm/numa.rst
+++ b/Documentation/vm/numa.rst
@@ -109,8 +109,8 @@ System administrators and application designers can restrict a task's migration
 to improve NUMA locality using various CPU affinity command line interfaces,
 such as taskset(1) and numactl(1), and program interfaces such as
 sched_setaffinity(2).  Further, one can modify the kernel's default local
-allocation behavior using Linux NUMA memory policy.
-[see Documentation/admin-guide/mm/numa_memory_policy.rst.]
+allocation behavior using Linux NUMA memory policy. [see
+:ref:`Documentation/admin-guide/mm/numa_memory_policy.rst <numa_memory_policy>`].
 
 System administrators can restrict the CPUs and nodes' memories that a non-
 privileged user can specify in the scheduling or NUMA commands and functions
-- 
2.21.0

