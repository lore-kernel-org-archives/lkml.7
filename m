Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599FEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293422082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663950;
	bh=zf6yppQcAxOJhOZ8yY6aRk8hw5wSjBX3lhR0vi3EGUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xa1rlVaYdDhbtBKYzje1OfxjDjJNpupJP4hneNU6voWKelxbe9Xgj4zEwsta7C8oO
	 A7loQhGeR0HveNzq86uzavsMCGhDAUmQsjV+1kqm3oIGsC/UUcl7qaOPis/RjU4bGR
	 DJneSHKircXL4AEcL0nfcQi9bBcm24v0zpeHSK4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfC0FTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35351 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EE8772213F;
        Wed, 27 Mar 2019 01:19:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=dkf1uGJvazmslVnhmQBuClixTP4sp6NmrGS8gDAF8sI=; b=ZoPOSEL9
        o+bq+RBq1QamY5Vd0cGGMuyRLnX4Q3to+JeGnmUgrP3C+pkIyqcLUa+smimm+Mi2
        Z2CK8tm2OxQgQm1FSEX+Q7Ob+5keKbDQ4fdobd7E6P3uF4DgBhrUids5ApNGWWQ7
        McyAgjYKX9l6g8o4HKUiWar4w0Wpt6P+SWeOT4qPcfxduDWvYiHNCH02Rn5JQCdd
        zGuyMGGWvByI1187edOx9FhlC7EqKNsBsXWVJhdW9xFazFkyjHDVydH7ZzTZIGW4
        NR1xppqArknj3DPMBs1wdKB6blLAAW2Fmwfx4ltXR+1AdVpyn7U3sTn70508SR+m
        JSen0uekFn6sdw==
X-ME-Sender: <xms:yAebXNwPooR9bIZZx3llgi-J0nZj9eW96MEmqGXIKLWq8D4cVuahew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeple
X-ME-Proxy: <xmx:yAebXJN-PfOCXWIcyLCReXTpYeJcxpRied63vbSC_yFWNJIlBl3eeQ>
    <xmx:yAebXKYT_JdyU8ujV_dOZs6sMv9WPan7WcdEhCv8fhCOLE7FTyWN6Q>
    <xmx:yAebXK4x03CnrgCNaX95B1TbIliDZQFUc5qXoekRHVBYMl1ZpapLUg>
    <xmx:yAebXHa2Dh-jpHUhRNE4tuadviG6OvfJHOK1RRzUxUE47Xs1M_xxdg>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59F68E415C;
        Wed, 27 Mar 2019 01:19:01 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/24] dcache: Fix e.g. usage in comment
Date:   Wed, 27 Mar 2019 16:17:03 +1100
Message-Id: <20190327051717.23225-11-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use e.g. when abbreviating 'for example'.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9fc13c574bfb..141ffe27e95a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2229,7 +2229,7 @@ EXPORT_SYMBOL(d_lookup);
  * false-negative result due to unrelated rename activity.
  *
  * __d_lookup is slightly faster by avoiding rename_lock read seqlock,
- * however it must be used carefully, eg. with a following d_lookup in
+ * however it must be used carefully, e.g. with a following d_lookup in
  * the case of failure.
  *
  * __d_lookup callers must be commented.
-- 
2.21.0

