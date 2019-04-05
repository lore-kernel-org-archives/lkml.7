Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0064CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4372171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429607;
	bh=SAmv2NnXI1V5L4Q0IiC5/NfcRrnqdn5GcCjwPt+LdZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PodQeozFqQa5WtVgWgSDYzKNu7C7Nc4MO+TVjnzG8357+SbB1QurDaX7ZCPd2lMCx
	 QgKQdklJ2f8WCoqhdq4Otsz9njKolIQLkOOai+OSK+kmKpfD+rBhlC4YPChGzNdErt
	 USlAmqOyignaoHjEgvZWUy5R8OnaCZRYa8mSb6Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfDECAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:00:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43325 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDECAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:00:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4509A24871;
        Thu,  4 Apr 2019 22:00:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2019 22:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=uj7Wo7EQ8QDwMHCHewBhT1GfVoM2doEKh5tgq9M2gRI=; b=ChmtDHfB
        PMc1J8MZoxmyl8C8i77NVZsdIhAzdysyhZGk/UdejpAR8X6GO/DKM02Hz5fBu5SQ
        DoPnWt31oHTCBWVIv4mP2sy9KCbyTc5NuN19l43mo9KVH8kEUSWZ3xNdKXNbPvaC
        /i1aClre/Ksl3tdhaqswggFHoivG3O3p5k/NX9CCe+mjDSKyoEq7VVfUePf1s6j2
        jOgbphyaFOuh80G9YuuKJ3tUYhomcBpIps8Z9fygn8fT6I+3qG+NnPpzv4GzclaW
        UNpf5SoI6dQof69CG4BS0YDBLE6AYwRKvGpARwIB8rjee7GpiyYLWwFRsDhEGny1
        EUASyzsrpdldag==
X-ME-Sender: <xms:pbamXEmpSwMSzunTvgfRn7TWz7na2ansYZLSnjn4Z88KD1lduOK5XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigdehtdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudegledruddugedrkeeinecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedt
X-ME-Proxy: <xmx:pbamXLMgo8wI9e9ShWMCRIqxgsvmqE1y3a0_2WkFu3EKK50e0jnrgg>
    <xmx:pbamXIPCpw5t9qAsByH8BoQj_Zt0l4DxwHA0JF7g0UjzGeLSagueqA>
    <xmx:pbamXMhfN8wipxwUFZUcJkXJfpP8JhJyWVnF3LfKQS5GAdN6MP_YwQ>
    <xmx:pbamXE1TbABv7eJwpEYsXU3CRtcEgKCLx96FXjMEw0bVylORGwjHsg>
Received: from eros.localdomain (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 40DA5100E5;
        Thu,  4 Apr 2019 21:59:57 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v4 1/6] lib/test_printf: Add empty module_exit function
Date:   Fri,  5 Apr 2019 12:58:54 +1100
Message-Id: <20190405015859.32755-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
References: <20190405015859.32755-1-tobin@kernel.org>
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

Acked-by: Kees Cook <keescook@chromium.org>
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
2.21.0

