Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DF420663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908598;
	bh=cCtknt6ZFTVlcyeLBUxxmrg0mJ1MAnJgmn6hwOeEDYo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nt8CgrU3mTF3d8/6b4ssi6L5MC8MpJJFBy9t8G0R4ybackXMWHd67ta0hIDzUGutb
	 NPAJlJgHY1GkGBBenlAq1YSZhi6gfemfLubV8nVKCxRfX27cqFsAEUEfQDZawg9Xmy
	 prhE+fOmT63xhjeU+hDGfxHfttHmPu0yJO0vYqpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCFVnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47167 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfCFVnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A30222AB6;
        Wed,  6 Mar 2019 16:43:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 16:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zrjsZN/tQaUBfGIam
        X0028jOepi1+b2fBzSv1f+ywzc=; b=A87pgnHdfZXUgxMO6i4tyYFxMjqzIHhUa
        WPdF8e7NjX5bC4Po8+k7LLTWWByzaHhpxS0zRlntNH0KhwWSwIVT7Z09OE0rCMuL
        DR4ac/Dd5N0EGe543FJPdnGSP05bAKW52tjVU5ZkY9sCMp3VcY5YHJLqyK5Ja/So
        uxqBF+QYP2K3yfp3RjnHpneK+qiKUvKvy41BzKSJQ8gNZIffqGIow5RsmGulH1Ov
        JuyMEGR5qQ2TuZdrtEKk6EAyj+PfdCJxu3B6gFyqPvq1u99s02++6v5uFWBr0/4R
        DpAANHoyY0ACQXEgpAQ3vT4/sYMGW2oKpV7VANIrgX+ltlSXrnH4w==
X-ME-Sender: <xms:8D6AXENVLel8b-jVQnp6NLNzSN9wwNA5yZZh9Ye3MjomR4924Yuufw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinhes
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8D6AXAySBPy_nIdUCH1epAvjFQHX9twqeNhrwX4To4gCqt3xOxoaeg>
    <xmx:8D6AXAkxubvfl2k9s-VjKppUsmHYK5yqrQ_CLsKnxmuR5C9nGgd7Tw>
    <xmx:8D6AXHA8DxU3yZiRE3zU-np4siQRppNgG6_HOEYMosAynPfHf_MqgA>
    <xmx:8z6AXPvd3JbZbz4P1z6ouZdem_aoMXC-2iKJoXfeUHFkbqyQvCy-ZA>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24849E4619;
        Wed,  6 Mar 2019 16:43:06 -0500 (EST)
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
Subject: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
Date:   Thu,  7 Mar 2019 08:42:19 +1100
Message-Id: <20190306214226.14598-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

strscpy_pad() patch set now with added test shenanigans. 

This version adds 5 initial patches to the set and splits the single
patch from v2 into two separate patches (6 and 7).

While doing the testing for strscpy_pad() it was noticed that there is
duplication in how test modules are being fed to kselftest and also in
the test modules themselves.

This set makes an attempt at adding a framework to kselftest for writing
kernel test modules.  It also adds a script for use in creating script
test runners for kselftest.  My macro-foo is not great, all criticism
and suggestions very much appreciated.  The design is based on test
modules lib/test_printf.c, lib/test_bitmap.c, lib/test_xarray.c. 

Shua, I'm by no means a kselftest expert, if this approach does not fit
in with your general direction please say so.

Kees, I put the strscpy_pad() addition patch separate so if this goes in
through Shua's tree (and if it goes in at all) its a single patch to
grab if we want to start playing around with strscpy_pad().

 
Patch 1 fixes module unload for lib/test_printf in preparation for the
        rest of the series.

Patch 2 Adds a shell script that can be used to create shell script test
        runners. 

Patch 3 Converts current shell script runners in
        tools/testing/selftests/lib/ to use the script introduced in
        patch 2.

Patch 4 Adds the test framework by way of a header file (inc. documentation)

Patch 5 Converts a couple of current test modules to make some use of
        the newly added test framework.

Patch 6 Adds strscpy_pad()

Patch 7 Adds test module for strscpy_pad() using the new framework and script.


If you are a testing geek and you would like to play with this; if you
are already running a kernel built recently from your tree you may
want to just apply the first 5 patches then you don't need to build/boot
a new kernel, just config and build the lib/ test modules (test_printf
etc.) and then:

	sudo make TARGETS=lib kselftest

Late in the development of this I found that a bunch of boiler plate had
to be added to the script to handle running tests with:

	make O=/path/to/kout kselftest

The reason is that during the build we are in the output directory but
the script is in the source directory.  I get the feeling that a better
understanding of how the kernel build process works would provide a
better solution to this.  The current solution is disappointing since
removing duplication and boiler plate was the point of the whole
exercise.  I'd love a better way to solve this?

One final interesting note: there are 36 test modules in lib/ only 3 of
them are run by kselftest from tools/testing/selfests/lib?


Thanks for looking at this,
Tobin.



Tobin C. Harding (7):
  lib/test_printf: Add empty module_exit function
  kselftest: Add test runner creation script
  kselftest/lib: Use new shell runner to define tests
  kselftest: Add test module framework header
  lib: Use new kselftest header
  lib/string: Add strscpy_pad() function
  lib: Add test module for strscpy_pad

 Documentation/dev-tools/kselftest.rst        | 108 ++++++++++++-
 include/linux/string.h                       |   4 +
 lib/Kconfig.debug                            |   3 +
 lib/Makefile                                 |   1 +
 lib/string.c                                 |  47 +++++-
 lib/test_bitmap.c                            |  20 +--
 lib/test_printf.c                            |  17 +--
 lib/test_strscpy.c                           | 150 +++++++++++++++++++
 tools/testing/selftests/kselftest_module.h   |  48 ++++++
 tools/testing/selftests/kselftest_module.sh  |  75 ++++++++++
 tools/testing/selftests/lib/Makefile         |   2 +-
 tools/testing/selftests/lib/bitmap.sh        |  25 ++--
 tools/testing/selftests/lib/config           |   1 +
 tools/testing/selftests/lib/prime_numbers.sh |  23 ++-
 tools/testing/selftests/lib/printf.sh        |  25 ++--
 tools/testing/selftests/lib/strscpy.sh       |  17 +++
 16 files changed, 490 insertions(+), 76 deletions(-)
 create mode 100644 lib/test_strscpy.c
 create mode 100644 tools/testing/selftests/kselftest_module.h
 create mode 100755 tools/testing/selftests/kselftest_module.sh
 create mode 100755 tools/testing/selftests/lib/strscpy.sh

-- 
2.20.1

