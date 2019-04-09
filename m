Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C824C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B66021874
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554770693;
	bh=DmOiyGQaDUGZGtfRVExAqG0qOh5YnPHUyVXUy/dbXxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POtrbgx2q97ZIfb4Zvuj5KOiuMuXt9qsA8hirD9M+EwfmvbQdOAndiQtc9TKAYoUO
	 qqjpuEwUQZ+T5iDT1qSPGH8CFyggULeTxZMCYE1K5gGj26Ub6mSyz8eow3Mx9jTMyK
	 C2ePyO1Fn/2ccEnI7QoBkcZb0MCiYK5sWNdQXxo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDIAov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:44:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41783 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfDIAoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:44:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A65312201F;
        Mon,  8 Apr 2019 20:44:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Apr 2019 20:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=w2fXLe4ZgTkW2x4QyojPjWlfikwMYKP+enATmuiNyAs=; b=NFfBWv3F
        1BQRUX621YRv37Q/2dGAmI3pzFb2yPP09l6ttAjbam6cMrt0iujPX5gaZipUcKKF
        1gzcURy86L8Jhqx/mO50dYcKUcokXHQETU+tt+Gql4rUVOrucfUPsSk9k4svARtQ
        DjKO4E2MCrxq7QxdbSGCqkLYxR7S9d6hYUUuLYAku1hOMggcbRcE1BXmZi1XnTMy
        61TMB+pcHtDRsZIot0AnGYf45fOSqa7e/t8NIYuWqHeK57MMDx1w2AXEE6fowwhj
        6Wm2i0/9R9nKB/xlUFOePmJ2kA0epeiy/T7Vu0HZpeg1WzxaDc80nte6pI9cMT3g
        i1sxyxgjjKiObA==
X-ME-Sender: <xms:--qrXFk103e4GHxCJRJJQTpRsH-ZUgv9DfLpFdqKBQ0oNhD_uJ8SLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvudejrdehtdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:--qrXBQgklb2Uxtja2umsZrBh5el3ZqYMGCByh2hZaEkhTTIvlLFLA>
    <xmx:--qrXLYQXXAIbXFM8UvM2b7CMo881ZOjkeVvfJ4IFsly2oiz9TKiYg>
    <xmx:--qrXB9x_QZVo5-WpLsXMNwBLaQhPhNR53sIYBaK2ikHCqwmja1kVg>
    <xmx:--qrXHWPim3kcN-zss1uXaCRbd7YmiXeWaOubI-icHVO960ct9RcoQ>
Received: from eros.localdomain (ppp121-44-217-50.bras1.syd2.internode.on.net [121.44.217.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 901D7E42C9;
        Mon,  8 Apr 2019 20:44:41 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] docs: Use reference to link to rst file
Date:   Tue,  9 Apr 2019 10:43:59 +1000
Message-Id: <20190409004359.29668-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409004359.29668-1-tobin@kernel.org>
References: <20190409004359.29668-1-tobin@kernel.org>
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

