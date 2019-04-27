Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B034420823
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556409464;
	bh=ZCQ1hTox58ut8MRHX7+unOwJW6Fw0bz4fBqk7pBD8r0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KuTLT04EzQXi/QnS01jNQ/vl4JHm82J63fWnC7BAzCfLU0AK8wT18kOh6TlapxBiA
	 bp0nQcoZzH5Oc9fNiMt//iF/vv7N5zdzjid2VyDvITgN+B+BCU+jFqq3kK94qdaULc
	 ouJsOO5oJezIyXGquUdbNQChb3mqAu7PD/fDVqd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfD0X5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 19:57:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47177 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfD0X5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 19:57:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FACF207FD;
        Sat, 27 Apr 2019 19:57:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 27 Apr 2019 19:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zF+eIwUTS8rm1zZoX
        1pBtDSbLkSK93vBu5X3HfByFs0=; b=XUeAqhthJp0Epip6uXpZINIbgy0NRe7ET
        oJLPUrIs5g7pg/AAMB6rncNqp55sUMv4cLFJztP6kin/MCgpwQd+5uZuTtWwlLrL
        OK1jvVlY8wQmZbOSW8DeB8PgwWC64/pZB7NKE2elzPQ7Pa8Zgg/MPd6BsrWerlqQ
        AeTD9F2u39F/FCH2Vdiui77t7vOXdAdYng91lzeEmAWIn84+Yg9ddTE1ciGN6G0T
        EIBoQRC92XuMW7i2HrKV4TfyKL+Lj2DAdfB2BGykX7jbuDwnlvfxb5YP6q5W3cdw
        LTDKlXchT8/gHKlFe2Jzp/xwc3Dx5tZb/wgu3ZpEYg2nq7cvrZlug==
X-ME-Sender: <xms:dezEXFe-Vn7IKjwKsJ6Pn-xZfVprO_ebI4akmyqcJP9UOK-hYYib9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheelgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dukedrvdduuddrvddttddrudeileenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:dezEXHcqSkVvYikUgvpx0wOcXkhyYpfbbRMrwo_2y1cBCWySMlcU5Q>
    <xmx:dezEXJjrGTz24AexPxuq_E5XgUvRCLEbBB51TrBuJDHsgdqHF3oNQw>
    <xmx:dezEXDTp0u8BK0bqCCxz2y_gm8mjq5I7Yeong5YUnnbvfydGAFhwYA>
    <xmx:duzEXNUE9YIdausQFT1wDzCw0kSS7w1obqgvOYRhs3Mw0XJuPQ0hCg>
Received: from eros.localdomain (ppp118-211-200-169.bras1.syd2.internode.on.net [118.211.200.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84B07E4176;
        Sat, 27 Apr 2019 19:57:39 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: Improve doc clarity kobject_init_and_add()
Date:   Sun, 28 Apr 2019 09:56:52 +1000
Message-Id: <20190427235652.3799-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function kobject_init_and_add() is currently misused in a number of
places in the kernel.  On error return kobject_put() must be called but
is at times not.

Make the function documentation more explicit about calling
kobject_put() in the error path.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/kobject.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index aa89edcd2b63..58d1d7a64203 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -437,9 +437,12 @@ EXPORT_SYMBOL(kobject_add);
  * @parent: pointer to the parent of this kobject.
  * @fmt: the name of the kobject.
  *
- * This function combines the call to kobject_init() and
- * kobject_add().  The same type of error handling after a call to
- * kobject_add() and kobject lifetime rules are the same here.
+ * This function combines the call to kobject_init() and kobject_add().
+ *
+ * If this function returns an error, kobject_put() must be called to
+ * properly clean up the memory associated with the object.  This is the
+ * same type of error handling after a call to kobject_add() and kobject
+ * lifetime rules are the same here.
  */
 int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
 			 struct kobject *parent, const char *fmt, ...)
-- 
2.21.0

