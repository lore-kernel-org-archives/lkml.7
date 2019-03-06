Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99380C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676F320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908602;
	bh=FFqzu9oyPEQrWG5HAruiMbkDHzqfwR4C0o5K3ly5oC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sV2OQd8kiTzKVr1y0tv8iuYRqjC14j45Ayrg0GLU0Cet71ZHDEizoH6bBz9UpvJyn
	 ZCqx5nqe41+/V1+3pJqcGPVmICrUFsI8yEHvRdnj9MtaOn41Ge6jb7sMYtPie15Tg/
	 yKKPL3DMViBDIglngr8vkhMpsvDDHVdSkfxinq+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCFVnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:21 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37247 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfCFVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DEC3B22AB8;
        Wed,  6 Mar 2019 16:43:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 16:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wNlCf5dMH57FKr9jfVwyRVZjALA+qIA1AkqZ6IYcvFE=; b=ZbwGNln8
        ocLbn9Mb9cmbgqnyNTKbHBrONnIBOzvBHKPv25tn/pW7+/9pk6U40pZaNNz307XY
        jDWL5Wiv83SNaioUEqzLpcjOKva/XYGsAulHPIeMrNPNfgWDv9Q2B0WgRnz/XzlH
        Kms4pPDjrj1QBzGmIg9cYGl6jdENVYVTVgPVzA9h9ydndMIH7r/mVCNSd0E9mrc1
        f/WwWth30r9MEZWsgJEpvPLDB15yLiuVEmBX6jjL/hTWKX3XxMPyVqwVzKw/qqft
        JICQF2/yi2T7/khDqFZ+3jiQI46qjnNmM5cpW2LKStK44TWPQ2oP7/0sXM5Alx7e
        xs3zb48u18wnZg==
X-ME-Sender: <xms:9j6AXMjUV0Na7g2hFhxfkAOcb9CDWoQGIUgGKKD1lIQeKdEKfp-vCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:9j6AXMS1yu8QOFFHeIDnNi0f9zEFDJmJGD5o1OXV4uEFprdehBxFyA>
    <xmx:9j6AXDlBre3oPG4aq47W1Kp4zpfot48H9La-W7NYq8XVBckT8uJ8vg>
    <xmx:9j6AXGaDS3aer3zyHGuz3qfT0vsunolc6y4E_vYjtb2Bcb9paA2rvQ>
    <xmx:9j6AXL5MIYREmPrSirdslORp8AQLvP3yQi49RiYR6xFayZcRDAUvpA>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65ED0E4548;
        Wed,  6 Mar 2019 16:43:13 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] lib/test_printf: Add empty module_exit function
Date:   Thu,  7 Mar 2019 08:42:20 +1100
Message-Id: <20190306214226.14598-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the test_printf module does not have an exit function, this
prevents the module from being unloaded.  If we cannot unload the
module we cannot run the tests a second time.

Add an empty exit function.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/test_printf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 659b6cc0d483..601e8519319a 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -615,5 +615,11 @@ test_printf_init(void)
 
 module_init(test_printf_init);
 
+static void __exit test_printf_exit(void)
+{
+}
+
+module_exit(test_printf_exit);
+
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_LICENSE("GPL");
-- 
2.20.1

