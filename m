Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD2721473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554770682;
	bh=utBoF+89EFso5A5TBvuBYLWWZzsCNsU7BClhEJQndrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXyLg14u3zUGrmR8SnOQB9aXnVeGGxGA8nLNSvJ/2ayKlvczMF+RVS2k2iPpwAZSQ
	 NdwePXvF0D/HZgXPZvV9NUz4IePDeGbt8RI246FEvmu6XOASAfAeswgJMRah+u6+Bg
	 E4tovJLYMqCe753Whkw867DWte9zSx9MR6yg60Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDIAoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:44:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34987 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfDIAog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:44:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D511D21A09;
        Mon,  8 Apr 2019 20:44:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Apr 2019 20:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=aAsp7+oXhr+abifccVP2wCs41rIaKSXx/ZrN4pfyzWs=; b=E9JMbepf
        d2C244YDcvrJzx73AKH7/pWEfjScLTER6aWZoyPXmO/vdLyNMhM0ltfQ5gnjzPNo
        ddQt40/0P+VajzkICZKeiC8wp12cGXTF6QFDlutAR48MkOTDLV7BW7xYwxYk6cIW
        Q/3kQi8PknE6dRYk6fgUidCUsvr07SbwxNfBuyDl62S8LXku/KHcPpzz16sY0P6D
        G2JOimRtVQH6Kuu43fYg66DjOHvMMtOjaHM4rRYuC5qH7F7QjDgGRucm4Q4sKdMd
        1CskdjGjdFSQ71UEvQs2QggN0zRByST4FMZ+iWo6QtNb8B5cyBYbeiOFNqFmtOQJ
        oJE9t+xEdGsUOg==
X-ME-Sender: <xms:8-qrXLTjkd90ao0iVWt7WRy5PNRAuqUCgcdlMn6RY7swh079JpEmGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffoh
    hmrghinhepshhpugigrdhorhhgnecukfhppeduvddurdeggedrvddujedrhedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedt
X-ME-Proxy: <xmx:8-qrXBChxubPQvDvMaErxcsgxQhr-0EE3b61ibL7d-NvFOsDGj11ug>
    <xmx:8-qrXL3gsdOZ0ujKrf2qyQMStGTrtjg8JcOoNXbTq31PfHFw99IgaA>
    <xmx:8-qrXPWH4RXARSnChyXw7u8o2c1FuQxakdguIW1YC-IX7m9V3oHDsw>
    <xmx:8-qrXB4InPUI51a8g2Fyd2UQiFwes1HDAvZwIaq2qGPA4JSZ396fpA>
Received: from eros.localdomain (ppp121-44-217-50.bras1.syd2.internode.on.net [121.44.217.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFD84E42C9;
        Mon,  8 Apr 2019 20:44:33 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] docs: Fix spelling mistake
Date:   Tue,  9 Apr 2019 10:43:56 +1000
Message-Id: <20190409004359.29668-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409004359.29668-1-tobin@kernel.org>
References: <20190409004359.29668-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation contains a spelling mistake / typo.

s/descibed/described/

Fix spelling mistake.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/process/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index ad2b6c852b95..6ab75c11d2c3 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -62,7 +62,7 @@ Legal Issues
 The Linux kernel source code is released under the GPL.  Please see the file
 COPYING in the main directory of the source tree. The Linux kernel licensing
 rules and how to use `SPDX <https://spdx.org/>`_ identifiers in source code are
-descibed in :ref:`Documentation/process/license-rules.rst <kernel_licensing>`.
+described in :ref:`Documentation/process/license-rules.rst <kernel_licensing>`.
 If you have further questions about the license, please contact a lawyer, and do
 not ask on the Linux kernel mailing list.  The people on the mailing lists are
 not lawyers, and you should not rely on their statements on legal matters.
-- 
2.21.0

