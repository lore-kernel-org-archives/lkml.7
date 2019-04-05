Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6E9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCA72171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429603;
	bh=Uh5nSvn2kq9bB/o0uN6ytDNKpdy9WFw8pigRjfCPvoM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W62Z5DHW4QCTJkvs2DIho0x/Bx3dwgtYoAwFk0ZzVc5YomyME+kLhoywkZTNciXv1
	 4R2rk/XdH6f431gSG2DeIyfgx2MTMtLygHESlS6SKGNAMsKua8qJFThNpRLGK8m4eo
	 3IVk2hHDuIJhhf8c+Q9eEvhWkrRaJSQj+9Gb45zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfDECAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:00:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51669 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDECAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:00:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E57A124781;
        Thu,  4 Apr 2019 21:59:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2019 21:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2zdBP90w4tuKd8VM+
        G6tRXalJHeRUsFGyaSNoC1dgB0=; b=uV4yrsyulUkNVigisHJbvUhD+yBeTFNSi
        Cj5HRiT8EVyX0rEmCveqsbJnYhriVfTq86VIQf6a1xSk44zI8x/DZCCAZUEKX2W1
        /L6FypTD9qrfZ2h2/0EDULTRg9/+zU2owsve1NysDiL7WYkVUO6wz6ScwFOPPLIj
        hDzlODTLQlr2wrnY3kDjjNDyQzUqXSRTNQvOzyW4EgK1TUX59NzsHcK6LaVhP8Xp
        BbAUKx9kej+iHyDAwcpCbHzxSRsM4i9ZxCvMIjKzOgnlFReJBOGw/vUHDaSg3rN8
        KtLf6w3Y8Z45VbV0eySdS661WyZ6YkVSv4hmVJ9uRHpsoWpJ6QFRg==
X-ME-Sender: <xms:nbamXKenm1JLFp5yyl8JOwVtM17yCcyMv97QURQI6ZG6yFnhgdrF6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigdehtdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfh
    rhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvg
    hlrdhorhhgqeenucfkphepuddvgedrudegledruddugedrkeeinecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:nbamXKpuQnQc89avuyvRIhbmySgDvaGn06xabf1vYmyX-fdd8MC4rQ>
    <xmx:nbamXEURnW6GyMMVyxevaOr5LYhUAxgKBihxAkZ5tX57z6zz8m7oOQ>
    <xmx:nbamXHNMsGj0UcpQ6ChVeHouMX7dKYOGPI7stGvQ53fPB70C2LalVw>
    <xmx:n7amXJ737o79ENThZmHtxdMFOlbshr8YHZdXpXq4rdwZz8a2lxHJEA>
Received: from eros.localdomain (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE7DF10310;
        Thu,  4 Apr 2019 21:59:51 -0400 (EDT)
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
Subject: [PATCH v4 0/6] lib/string: Add strscpy_pad() function
Date:   Fri,  5 Apr 2019 12:58:53 +1100
Message-Id: <20190405015859.32755-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shua,

Here is the set with cleanup as suggested by Kees on v3.

Configured, built, and tested all modules loaded by
tools/testing/selftests/lib/*.sh

From previous cover letters ...

While doing the testing for strscpy_pad() it was noticed that there is
duplication in how test modules are being fed to kselftest and also in
the test modules themselves.

This set makes an attempt at adding a framework to kselftest for writing
kernel test modules.  It also adds a script for use in creating script
test runners for kselftest.  My macro-foo is not great, all criticism
and suggestions very much appreciated.  The design is based on test
modules lib/test_printf.c, lib/test_bitmap.c, lib/test_xarray.c.

Changes since last version:

 - Remove dependency on Bash (thanks Kees)
 - Use oneliner to implement kselftest test runners (thanks Kees)
 - Squash patch that adds kselftest script creator script with patch
   that uses it. 
 - Fix typos (thanks Randy)
 - Add Kees' Acked-by tags to all patches

thanks,
Tobin.


Tobin C. Harding (6):
  lib/test_printf: Add empty module_exit function
  kselftest: Add test runner creation script
  kselftest: Add test module framework header
  lib: Use new kselftest header
  lib/string: Add strscpy_pad() function
  lib: Add test module for strscpy_pad

 Documentation/dev-tools/kselftest.rst        |  94 +++++++++++-
 include/linux/string.h                       |   4 +
 lib/Kconfig.debug                            |   3 +
 lib/Makefile                                 |   1 +
 lib/string.c                                 |  47 +++++-
 lib/test_bitmap.c                            |  20 +--
 lib/test_printf.c                            |  17 +--
 lib/test_strscpy.c                           | 150 +++++++++++++++++++
 tools/testing/selftests/kselftest_module.h   |  48 ++++++
 tools/testing/selftests/kselftest_module.sh  |  84 +++++++++++
 tools/testing/selftests/lib/Makefile         |   2 +-
 tools/testing/selftests/lib/bitmap.sh        |  18 +--
 tools/testing/selftests/lib/config           |   1 +
 tools/testing/selftests/lib/prime_numbers.sh |  17 +--
 tools/testing/selftests/lib/printf.sh        |  19 +--
 tools/testing/selftests/lib/strscpy.sh       |   3 +
 16 files changed, 440 insertions(+), 88 deletions(-)
 create mode 100644 lib/test_strscpy.c
 create mode 100644 tools/testing/selftests/kselftest_module.h
 create mode 100755 tools/testing/selftests/kselftest_module.sh
 create mode 100755 tools/testing/selftests/lib/strscpy.sh

-- 
2.21.0

