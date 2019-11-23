Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D5C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B812070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574484423;
	bh=8cdvDIUWHe5eJPvdQt8k99q9Tt+knam5g44DE/B4rCM=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=OVtbjirBqj8Q+HkULD09C/K1Ln0+6dCPOVeYlh32izC+IE1JhY1XwGXLyHX3YS+6E
	 mWU0qpPjA5WIPkHQ4dPSbCp5xEkY3fGl/ZxBFvbmqDYwttrDO/py2RYL54hBE+a9d2
	 UGTGva0S+o9gUpFj4sPak3GjUc4bWNSzhHRz0LLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfKWErB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:47:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43369 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:47:01 -0500
Received: by mail-io1-f68.google.com with SMTP id p12so2999478iog.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 20:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=8BpcEnPeXXIWqXwclSuCYffJlVqjY/A/KFxd79S+CEU=;
        b=U0fXbR2C+gRHY4kV2LfQJ9vpg0PzMCdFtPMWD7JxK6KQCbI8gHVFzqoQ4rt2NPMZ4L
         FKj1MwTgtfTvhC6ijvfGxy5Op0BM8/jHd5Qu6dN8eyLw+ioRQo06aNLrJc7GEcrXE07i
         hF85dfYYGLb6Z5qyq6ZOnEgbLZ3QdHvXZVh/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=8BpcEnPeXXIWqXwclSuCYffJlVqjY/A/KFxd79S+CEU=;
        b=Bk8uQINHyfRIWmeE73xFCA6ICxPeIU/mbY9K+8q/WmYFZ5nBVvoX5Y//0D34/bHAcu
         x068wQeBb1/vu8ZualPGzgrcvvF1lqwhZpk4uKRrQ0NumEH/MwzxcSRNN8jwUfPFDu1T
         znkcP07LiRwce3cqOErdV6IfjiWJOU1YmJ+edwfHiG4yLd5s/nQ+aNZN6oSNQnR7f3eu
         sd6CkfDmZup6cb2aS4Wuc9irO9s+v1gOeQ2nc2/L/HnlkAMLHofnKXrKoqKLwfYeBlVu
         5fSk8UyoVMAyzfaNkv5qL9So1M1biW5WfN/ArhDrEMrtkoDC+YYQETOCYcsMvE8z5DPa
         mA+w==
X-Gm-Message-State: APjAAAUc+2gI+q0E0zXuyfxCYTgfWwaxzkMeQZUkQJiw4gf/SUGzlovz
        kQIUxL9eOirJ8unmiZoUXZyE0Ina12E=
X-Google-Smtp-Source: APXvYqzweKzQPmU9sH4vrnfumX2aXtWlZ5WBqNZz0QRS4Hw067NnTs7d1VNYtlr/RQva68cSr/+LIw==
X-Received: by 2002:a5e:8e4b:: with SMTP id r11mr8175136ioo.167.1574484413084;
        Fri, 22 Nov 2019 20:46:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h82sm3621647ild.1.2019.11.22.20.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 20:46:51 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest kunit update for Linux 5.5-rc1
Message-ID: <0d518aea-63f4-507d-af4b-30536c156479@linuxfoundation.org>
Date:   Fri, 22 Nov 2019 21:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DA782D0C8C02D2F8120121D4"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DA782D0C8C02D2F8120121D4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest kunit update for Linux 5.5-rc1

This kselftest update for Linux 5.5-rc1 adds KUnit, a lightweight unit
testing and mocking framework for the Linux kernel from Brendan Higgins.

KUnit is not an end-to-end testing framework. It is currently supported
on UML and sub-systems can write unit tests and run them in UML env.
KUnit documentation is included in this update.

In addition, this Kunit update adds 3 new kunit tests:

- kunit test for proc sysctl from Iurii Zaikin
- kunit test for the 'list' doubly linked list from David Gow
- ext4 kunit test for decoding extended timestamps from Iurii Zaikin

In the future KUnit will be linked to Kselftest framework to provide
a way to trigger KUnit tests from user-space.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.5-rc1-kunit

for you to fetch changes up to ea2dd7c0875ed31955cda7b1b20612c8337192e5:

   lib/list-test: add a test for the 'list' doubly linked list 
(2019-11-01 11:13:48 -0600)

----------------------------------------------------------------
linux-kselftest-5.5-rc1-kunit

This kselftest update for Linux 5.5-rc1 adds KUnit, a lightweight unit
testing and mocking framework for the Linux kernel from Brendan Higgins.

KUnit is not an end-to-end testing framework. It is currently supported
on UML and sub-systems can write unit tests and run them in UML env.
KUnit documentation is included in this update.

In addition, this Kunit update adds 3 new kunit tests:

- kunit test for proc sysctl from Iurii Zaikin
- kunit test for the 'list' doubly linked list from David Gow
- ext4 kunit test for decoding extended timestamps from Iurii Zaikin

In the future KUnit will be linked to Kselftest framework to provide
a way to trigger KUnit tests from user-space.

----------------------------------------------------------------
Avinash Kondareddy (1):
       kunit: test: add tests for KUnit managed resources

Brendan Higgins (16):
       kunit: test: add KUnit test runner core
       kunit: test: add test resource management API
       kunit: test: add string_stream a std::stream like string builder
       kunit: test: add assertion printing library
       kunit: test: add the concept of expectations
       lib: enable building KUnit in lib/
       kunit: test: add initial tests
       objtool: add kunit_try_catch_throw to the noreturn list
       kunit: test: add support for test abort
       kunit: test: add tests for kunit test abort
       kunit: test: add the concept of assertions
       kunit: defconfig: add defconfigs for building KUnit tests
       Documentation: kunit: add documentation for KUnit
       MAINTAINERS: add entry for KUnit the unit testing framework
       MAINTAINERS: add proc sysctl KUnit test to PROC SYSCTL section
       kunit: fix failure to build without printk

David Gow (1):
       lib/list-test: add a test for the 'list' doubly linked list

Felix Guo (1):
       kunit: tool: add Python wrappers for running KUnit tests

Iurii Zaikin (2):
       kernel/sysctl-test: Add null pointer test for 
sysctl.c:proc_dointvec()
       ext4: add kunit test for decoding extended timestamps

SeongJae Park (2):
       kunit: Fix '--build_dir' option
       Documentation: kunit: Fix verification command

  Documentation/dev-tools/index.rst                  |    1 +
  Documentation/dev-tools/kunit/api/index.rst        |   16 +
  Documentation/dev-tools/kunit/api/test.rst         |   11 +
  Documentation/dev-tools/kunit/faq.rst              |   62 +
  Documentation/dev-tools/kunit/index.rst            |   79 ++
  Documentation/dev-tools/kunit/start.rst            |  180 +++
  Documentation/dev-tools/kunit/usage.rst            |  576 ++++++++
  MAINTAINERS                                        |   20 +
  arch/um/configs/kunit_defconfig                    |    3 +
  fs/ext4/Kconfig                                    |   17 +
  fs/ext4/Makefile                                   |    1 +
  fs/ext4/inode-test.c                               |  272 ++++
  include/kunit/assert.h                             |  356 +++++
  include/kunit/string-stream.h                      |   51 +
  include/kunit/test.h                               | 1490 
++++++++++++++++++++
  include/kunit/try-catch.h                          |   75 +
  kernel/Makefile                                    |    2 +
  kernel/sysctl-test.c                               |  392 +++++
  lib/Kconfig.debug                                  |   31 +
  lib/Makefile                                       |    5 +
  lib/kunit/Kconfig                                  |   36 +
  lib/kunit/Makefile                                 |    9 +
  lib/kunit/assert.c                                 |  141 ++
  lib/kunit/example-test.c                           |   88 ++
  lib/kunit/string-stream-test.c                     |   52 +
  lib/kunit/string-stream.c                          |  217 +++
  lib/kunit/test-test.c                              |  331 +++++
  lib/kunit/test.c                                   |  478 +++++++
  lib/kunit/try-catch.c                              |  118 ++
  lib/list-test.c                                    |  746 ++++++++++
  tools/objtool/check.c                              |    1 +
  tools/testing/kunit/.gitignore                     |    3 +
  tools/testing/kunit/configs/all_tests.config       |    3 +
  tools/testing/kunit/kunit.py                       |  138 ++
  tools/testing/kunit/kunit_config.py                |   66 +
  tools/testing/kunit/kunit_kernel.py                |  149 ++
  tools/testing/kunit/kunit_parser.py                |  310 ++++
  tools/testing/kunit/kunit_tool_test.py             |  206 +++
  .../test_data/test_is_test_passed-all_passed.log   |   32 +
  .../kunit/test_data/test_is_test_passed-crash.log  |   69 +
  .../test_data/test_is_test_passed-failure.log      |   36 +
  .../test_data/test_is_test_passed-no_tests_run.log |   75 +
  .../test_data/test_output_isolated_correctly.log   |  106 ++
  .../kunit/test_data/test_read_from_file.kconfig    |   17 +
  44 files changed, 7067 insertions(+)
  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
  create mode 100644 Documentation/dev-tools/kunit/faq.rst
  create mode 100644 Documentation/dev-tools/kunit/index.rst
  create mode 100644 Documentation/dev-tools/kunit/start.rst
create mode 100644 Documentation/dev-tools/kunit/usage.rst
  create mode 100644 arch/um/configs/kunit_defconfig
  create mode 100644 fs/ext4/inode-test.c
  create mode 100644 include/kunit/assert.h
  create mode 100644 include/kunit/string-stream.h
  create mode 100644 include/kunit/test.h
  create mode 100644 include/kunit/try-catch.h
  create mode 100644 kernel/sysctl-test.c
  create mode 100644 lib/kunit/Kconfig
  create mode 100644 lib/kunit/Makefile
  create mode 100644 lib/kunit/assert.c
  create mode 100644 lib/kunit/example-test.c
  create mode 100644 lib/kunit/string-stream-test.c
  create mode 100644 lib/kunit/string-stream.c
  create mode 100644 lib/kunit/test-test.c
  create mode 100644 lib/kunit/test.c
  create mode 100644 lib/kunit/try-catch.c
  create mode 100644 lib/list-test.c
  create mode 100644 tools/testing/kunit/.gitignore
  create mode 100644 tools/testing/kunit/configs/all_tests.config
  create mode 100755 tools/testing/kunit/kunit.py
  create mode 100644 tools/testing/kunit/kunit_config.py
  create mode 100644 tools/testing/kunit/kunit_kernel.py
  create mode 100644 tools/testing/kunit/kunit_parser.py
  create mode 100755 tools/testing/kunit/kunit_tool_test.py
  create mode 100644 
tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
  create mode 100644 
tools/testing/kunit/test_data/test_is_test_passed-crash.log
  create mode 100644 
tools/testing/kunit/test_data/test_is_test_passed-failure.log
  create mode 100644 
tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
  create mode 100644 
tools/testing/kunit/test_data/test_output_isolated_correctly.log
  create mode 100644 
tools/testing/kunit/test_data/test_read_from_file.kconfig
----------------------------------------------------------------

--------------DA782D0C8C02D2F8120121D4
Content-Type: text/x-patch;
 name="linux-kselftest-5.5-rc1-kunit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.5-rc1-kunit.diff"

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index b0522a4dd107..09dee10d2592 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -24,6 +24,7 @@ whole; patches welcome!
    gdb-kernel-debugging
    kgdb
    kselftest
+   kunit/index
 
 
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
new file mode 100644
index 000000000000..9b9bffe5d41a
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+API Reference
+=============
+.. toctree::
+
+	test
+
+This section documents the KUnit kernel testing API. It is divided into the
+following sections:
+
+================================= ==============================================
+:doc:`test`                       documents all of the standard testing API
+                                  excluding mocking or mocking related features.
+================================= ==============================================
diff --git a/Documentation/dev-tools/kunit/api/test.rst b/Documentation/dev-tools/kunit/api/test.rst
new file mode 100644
index 000000000000..aaa97f17e5b3
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/test.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+Test API
+========
+
+This file documents all of the standard testing API excluding mocking or mocking
+related features.
+
+.. kernel-doc:: include/kunit/test.h
+   :internal:
diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
new file mode 100644
index 000000000000..bf2095112d89
--- /dev/null
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Frequently Asked Questions
+==========================
+
+How is this different from Autotest, kselftest, etc?
+====================================================
+KUnit is a unit testing framework. Autotest, kselftest (and some others) are
+not.
+
+A `unit test <https://martinfowler.com/bliki/UnitTest.html>`_ is supposed to
+test a single unit of code in isolation, hence the name. A unit test should be
+the finest granularity of testing and as such should allow all possible code
+paths to be tested in the code under test; this is only possible if the code
+under test is very small and does not have any external dependencies outside of
+the test's control like hardware.
+
+There are no testing frameworks currently available for the kernel that do not
+require installing the kernel on a test machine or in a VM and all require
+tests to be written in userspace and run on the kernel under test; this is true
+for Autotest, kselftest, and some others, disqualifying any of them from being
+considered unit testing frameworks.
+
+Does KUnit support running on architectures other than UML?
+===========================================================
+
+Yes, well, mostly.
+
+For the most part, the KUnit core framework (what you use to write the tests)
+can compile to any architecture; it compiles like just another part of the
+kernel and runs when the kernel boots. However, there is some infrastructure,
+like the KUnit Wrapper (``tools/testing/kunit/kunit.py``) that does not support
+other architectures.
+
+In short, this means that, yes, you can run KUnit on other architectures, but
+it might require more work than using KUnit on UML.
+
+For more information, see :ref:`kunit-on-non-uml`.
+
+What is the difference between a unit test and these other kinds of tests?
+==========================================================================
+Most existing tests for the Linux kernel would be categorized as an integration
+test, or an end-to-end test.
+
+- A unit test is supposed to test a single unit of code in isolation, hence the
+  name. A unit test should be the finest granularity of testing and as such
+  should allow all possible code paths to be tested in the code under test; this
+  is only possible if the code under test is very small and does not have any
+  external dependencies outside of the test's control like hardware.
+- An integration test tests the interaction between a minimal set of components,
+  usually just two or three. For example, someone might write an integration
+  test to test the interaction between a driver and a piece of hardware, or to
+  test the interaction between the userspace libraries the kernel provides and
+  the kernel itself; however, one of these tests would probably not test the
+  entire kernel along with hardware interactions and interactions with the
+  userspace.
+- An end-to-end test usually tests the entire system from the perspective of the
+  code under test. For example, someone might write an end-to-end test for the
+  kernel by installing a production configuration of the kernel on production
+  hardware with a production userspace and then trying to exercise some behavior
+  that depends on interactions between the hardware, the kernel, and userspace.
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
new file mode 100644
index 000000000000..26ffb46bdf99
--- /dev/null
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+KUnit - Unit Testing for the Linux Kernel
+=========================================
+
+.. toctree::
+	:maxdepth: 2
+
+	start
+	usage
+	api/index
+	faq
+
+What is KUnit?
+==============
+
+KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
+These tests are able to be run locally on a developer's workstation without a VM
+or special hardware.
+
+KUnit is heavily inspired by JUnit, Python's unittest.mock, and
+Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
+cases, grouping related test cases into test suites, providing common
+infrastructure for running tests, and much more.
+
+Get started now: :doc:`start`
+
+Why KUnit?
+==========
+
+A unit test is supposed to test a single unit of code in isolation, hence the
+name. A unit test should be the finest granularity of testing and as such should
+allow all possible code paths to be tested in the code under test; this is only
+possible if the code under test is very small and does not have any external
+dependencies outside of the test's control like hardware.
+
+Outside of KUnit, there are no testing frameworks currently
+available for the kernel that do not require installing the kernel on a test
+machine or in a VM and all require tests to be written in userspace running on
+the kernel; this is true for Autotest, and kselftest, disqualifying
+any of them from being considered unit testing frameworks.
+
+KUnit addresses the problem of being able to run tests without needing a virtual
+machine or actual hardware with User Mode Linux. User Mode Linux is a Linux
+architecture, like ARM or x86; however, unlike other architectures it compiles
+to a standalone program that can be run like any other program directly inside
+of a host operating system; to be clear, it does not require any virtualization
+support; it is just a regular program.
+
+KUnit is fast. Excluding build time, from invocation to completion KUnit can run
+several dozen tests in only 10 to 20 seconds; this might not sound like a big
+deal to some people, but having such fast and easy to run tests fundamentally
+changes the way you go about testing and even writing code in the first place.
+Linus himself said in his `git talk at Google
+<https://gist.github.com/lorn/1272686/revisions#diff-53c65572127855f1b003db4064a94573R874>`_:
+
+	"... a lot of people seem to think that performance is about doing the
+	same thing, just doing it faster, and that is not true. That is not what
+	performance is all about. If you can do something really fast, really
+	well, people will start using it differently."
+
+In this context Linus was talking about branching and merging,
+but this point also applies to testing. If your tests are slow, unreliable, are
+difficult to write, and require a special setup or special hardware to run,
+then you wait a lot longer to write tests, and you wait a lot longer to run
+tests; this means that tests are likely to break, unlikely to test a lot of
+things, and are unlikely to be rerun once they pass. If your tests are really
+fast, you run them all the time, every time you make a change, and every time
+someone sends you some code. Why trust that someone ran all their tests
+correctly on every change when you can just run them yourself in less time than
+it takes to read their test log?
+
+How do I use it?
+================
+
+*   :doc:`start` - for new users of KUnit
+*   :doc:`usage` - for a more detailed explanation of KUnit features
+*   :doc:`api/index` - for the list of KUnit APIs used for testing
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
new file mode 100644
index 000000000000..aeeddfafeea2
--- /dev/null
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Getting Started
+===============
+
+Installing dependencies
+=======================
+KUnit has the same dependencies as the Linux kernel. As long as you can build
+the kernel, you can run KUnit.
+
+KUnit Wrapper
+=============
+Included with KUnit is a simple Python wrapper that helps format the output to
+easily use and read KUnit output. It handles building and running the kernel, as
+well as formatting the output.
+
+The wrapper can be run with:
+
+.. code-block:: bash
+
+   ./tools/testing/kunit/kunit.py run
+
+Creating a kunitconfig
+======================
+The Python script is a thin wrapper around Kbuild as such, it needs to be
+configured with a ``kunitconfig`` file. This file essentially contains the
+regular Kernel config, with the specific test targets as well.
+
+.. code-block:: bash
+
+	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
+	cd $PATH_TO_LINUX_REPO
+	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
+
+You may want to add kunitconfig to your local gitignore.
+
+Verifying KUnit Works
+---------------------
+
+To make sure that everything is set up correctly, simply invoke the Python
+wrapper from your kernel repo:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run
+
+.. note::
+   You may want to run ``make mrproper`` first.
+
+If everything worked correctly, you should see the following:
+
+.. code-block:: bash
+
+	Generating .config ...
+	Building KUnit Kernel ...
+	Starting KUnit Kernel ...
+
+followed by a list of tests that are run. All of them should be passing.
+
+.. note::
+   Because it is building a lot of sources for the first time, the ``Building
+   kunit kernel`` step may take a while.
+
+Writing your first test
+=======================
+
+In your kernel repo let's add some code that we can test. Create a file
+``drivers/misc/example.h`` with the contents:
+
+.. code-block:: c
+
+	int misc_example_add(int left, int right);
+
+create a file ``drivers/misc/example.c``:
+
+.. code-block:: c
+
+	#include <linux/errno.h>
+
+	#include "example.h"
+
+	int misc_example_add(int left, int right)
+	{
+		return left + right;
+	}
+
+Now add the following lines to ``drivers/misc/Kconfig``:
+
+.. code-block:: kconfig
+
+	config MISC_EXAMPLE
+		bool "My example"
+
+and the following lines to ``drivers/misc/Makefile``:
+
+.. code-block:: make
+
+	obj-$(CONFIG_MISC_EXAMPLE) += example.o
+
+Now we are ready to write the test. The test will be in
+``drivers/misc/example-test.c``:
+
+.. code-block:: c
+
+	#include <kunit/test.h>
+	#include "example.h"
+
+	/* Define the test cases. */
+
+	static void misc_example_add_test_basic(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 1, misc_example_add(1, 0));
+		KUNIT_EXPECT_EQ(test, 2, misc_example_add(1, 1));
+		KUNIT_EXPECT_EQ(test, 0, misc_example_add(-1, 1));
+		KUNIT_EXPECT_EQ(test, INT_MAX, misc_example_add(0, INT_MAX));
+		KUNIT_EXPECT_EQ(test, -1, misc_example_add(INT_MAX, INT_MIN));
+	}
+
+	static void misc_example_test_failure(struct kunit *test)
+	{
+		KUNIT_FAIL(test, "This test never passes.");
+	}
+
+	static struct kunit_case misc_example_test_cases[] = {
+		KUNIT_CASE(misc_example_add_test_basic),
+		KUNIT_CASE(misc_example_test_failure),
+		{}
+	};
+
+	static struct kunit_suite misc_example_test_suite = {
+		.name = "misc-example",
+		.test_cases = misc_example_test_cases,
+	};
+	kunit_test_suite(misc_example_test_suite);
+
+Now add the following to ``drivers/misc/Kconfig``:
+
+.. code-block:: kconfig
+
+	config MISC_EXAMPLE_TEST
+		bool "Test for my example"
+		depends on MISC_EXAMPLE && KUNIT
+
+and the following to ``drivers/misc/Makefile``:
+
+.. code-block:: make
+
+	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
+
+Now add it to your ``kunitconfig``:
+
+.. code-block:: none
+
+	CONFIG_MISC_EXAMPLE=y
+	CONFIG_MISC_EXAMPLE_TEST=y
+
+Now you can run the test:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py
+
+You should see the following failure:
+
+.. code-block:: none
+
+	...
+	[16:08:57] [PASSED] misc-example:misc_example_add_test_basic
+	[16:08:57] [FAILED] misc-example:misc_example_test_failure
+	[16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
+	[16:08:57] 	This test never passes.
+	...
+
+Congrats! You just wrote your first KUnit test!
+
+Next Steps
+==========
+*   Check out the :doc:`usage` page for a more
+    in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
new file mode 100644
index 000000000000..c6e69634e274
--- /dev/null
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -0,0 +1,576 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Using KUnit
+===========
+
+The purpose of this document is to describe what KUnit is, how it works, how it
+is intended to be used, and all the concepts and terminology that are needed to
+understand it. This guide assumes a working knowledge of the Linux kernel and
+some basic knowledge of testing.
+
+For a high level introduction to KUnit, including setting up KUnit for your
+project, see :doc:`start`.
+
+Organization of this document
+=============================
+
+This document is organized into two main sections: Testing and Isolating
+Behavior. The first covers what a unit test is and how to use KUnit to write
+them. The second covers how to use KUnit to isolate code and make it possible
+to unit test code that was otherwise un-unit-testable.
+
+Testing
+=======
+
+What is KUnit?
+--------------
+
+"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
+Framework." KUnit is intended first and foremost for writing unit tests; it is
+general enough that it can be used to write integration tests; however, this is
+a secondary goal. KUnit has no ambition of being the only testing framework for
+the kernel; for example, it does not intend to be an end-to-end testing
+framework.
+
+What is Unit Testing?
+---------------------
+
+A `unit test <https://martinfowler.com/bliki/UnitTest.html>`_ is a test that
+tests code at the smallest possible scope, a *unit* of code. In the C
+programming language that's a function.
+
+Unit tests should be written for all the publicly exposed functions in a
+compilation unit; so that is all the functions that are exported in either a
+*class* (defined below) or all functions which are **not** static.
+
+Writing Tests
+-------------
+
+Test Cases
+~~~~~~~~~~
+
+The fundamental unit in KUnit is the test case. A test case is a function with
+the signature ``void (*)(struct kunit *test)``. It calls a function to be tested
+and then sets *expectations* for what should happen. For example:
+
+.. code-block:: c
+
+	void example_test_success(struct kunit *test)
+	{
+	}
+
+	void example_test_failure(struct kunit *test)
+	{
+		KUNIT_FAIL(test, "This test never passes.");
+	}
+
+In the above example ``example_test_success`` always passes because it does
+nothing; no expectations are set, so all expectations pass. On the other hand
+``example_test_failure`` always fails because it calls ``KUNIT_FAIL``, which is
+a special expectation that logs a message and causes the test case to fail.
+
+Expectations
+~~~~~~~~~~~~
+An *expectation* is a way to specify that you expect a piece of code to do
+something in a test. An expectation is called like a function. A test is made
+by setting expectations about the behavior of a piece of code under test; when
+one or more of the expectations fail, the test case fails and information about
+the failure is logged. For example:
+
+.. code-block:: c
+
+	void add_test_basic(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+	}
+
+In the above example ``add_test_basic`` makes a number of assertions about the
+behavior of a function called ``add``; the first parameter is always of type
+``struct kunit *``, which contains information about the current test context;
+the second parameter, in this case, is what the value is expected to be; the
+last value is what the value actually is. If ``add`` passes all of these
+expectations, the test case, ``add_test_basic`` will pass; if any one of these
+expectations fail, the test case will fail.
+
+It is important to understand that a test case *fails* when any expectation is
+violated; however, the test will continue running, potentially trying other
+expectations until the test case ends or is otherwise terminated. This is as
+opposed to *assertions* which are discussed later.
+
+To learn about more expectations supported by KUnit, see :doc:`api/test`.
+
+.. note::
+   A single test case should be pretty short, pretty easy to understand,
+   focused on a single behavior.
+
+For example, if we wanted to properly test the add function above, we would
+create additional tests cases which would each test a different property that an
+add function should have like this:
+
+.. code-block:: c
+
+	void add_test_basic(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+	}
+
+	void add_test_negative(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
+	}
+
+	void add_test_max(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+		KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+	}
+
+	void add_test_overflow(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, INT_MIN, add(INT_MAX, 1));
+	}
+
+Notice how it is immediately obvious what all the properties that we are testing
+for are.
+
+Assertions
+~~~~~~~~~~
+
+KUnit also has the concept of an *assertion*. An assertion is just like an
+expectation except the assertion immediately terminates the test case if it is
+not satisfied.
+
+For example:
+
+.. code-block:: c
+
+	static void mock_test_do_expect_default_return(struct kunit *test)
+	{
+		struct mock_test_context *ctx = test->priv;
+		struct mock *mock = ctx->mock;
+		int param0 = 5, param1 = -5;
+		const char *two_param_types[] = {"int", "int"};
+		const void *two_params[] = {&param0, &param1};
+		const void *ret;
+
+		ret = mock->do_expect(mock,
+				      "test_printk", test_printk,
+				      two_param_types, two_params,
+				      ARRAY_SIZE(two_params));
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+		KUNIT_EXPECT_EQ(test, -4, *((int *) ret));
+	}
+
+In this example, the method under test should return a pointer to a value, so
+if the pointer returned by the method is null or an errno, we don't want to
+bother continuing the test since the following expectation could crash the test
+case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if
+the appropriate conditions have not been satisfied to complete the test.
+
+Test Suites
+~~~~~~~~~~~
+
+Now obviously one unit test isn't very helpful; the power comes from having
+many test cases covering all of your behaviors. Consequently it is common to
+have many *similar* tests; in order to reduce duplication in these closely
+related tests most unit testing frameworks provide the concept of a *test
+suite*, in KUnit we call it a *test suite*; all it is is just a collection of
+test cases for a unit of code with a set up function that gets invoked before
+every test cases and then a tear down function that gets invoked after every
+test case completes.
+
+Example:
+
+.. code-block:: c
+
+	static struct kunit_case example_test_cases[] = {
+		KUNIT_CASE(example_test_foo),
+		KUNIT_CASE(example_test_bar),
+		KUNIT_CASE(example_test_baz),
+		{}
+	};
+
+	static struct kunit_suite example_test_suite = {
+		.name = "example",
+		.init = example_test_init,
+		.exit = example_test_exit,
+		.test_cases = example_test_cases,
+	};
+	kunit_test_suite(example_test_suite);
+
+In the above example the test suite, ``example_test_suite``, would run the test
+cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``,
+each would have ``example_test_init`` called immediately before it and would
+have ``example_test_exit`` called immediately after it.
+``kunit_test_suite(example_test_suite)`` registers the test suite with the
+KUnit test framework.
+
+.. note::
+   A test case will only be run if it is associated with a test suite.
+
+For a more information on these types of things see the :doc:`api/test`.
+
+Isolating Behavior
+==================
+
+The most important aspect of unit testing that other forms of testing do not
+provide is the ability to limit the amount of code under test to a single unit.
+In practice, this is only possible by being able to control what code gets run
+when the unit under test calls a function and this is usually accomplished
+through some sort of indirection where a function is exposed as part of an API
+such that the definition of that function can be changed without affecting the
+rest of the code base. In the kernel this primarily comes from two constructs,
+classes, structs that contain function pointers that are provided by the
+implementer, and architecture specific functions which have definitions selected
+at compile time.
+
+Classes
+-------
+
+Classes are not a construct that is built into the C programming language;
+however, it is an easily derived concept. Accordingly, pretty much every project
+that does not use a standardized object oriented library (like GNOME's GObject)
+has their own slightly different way of doing object oriented programming; the
+Linux kernel is no exception.
+
+The central concept in kernel object oriented programming is the class. In the
+kernel, a *class* is a struct that contains function pointers. This creates a
+contract between *implementers* and *users* since it forces them to use the
+same function signature without having to call the function directly. In order
+for it to truly be a class, the function pointers must specify that a pointer
+to the class, known as a *class handle*, be one of the parameters; this makes
+it possible for the member functions (also known as *methods*) to have access
+to member variables (more commonly known as *fields*) allowing the same
+implementation to have multiple *instances*.
+
+Typically a class can be *overridden* by *child classes* by embedding the
+*parent class* in the child class. Then when a method provided by the child
+class is called, the child implementation knows that the pointer passed to it is
+of a parent contained within the child; because of this, the child can compute
+the pointer to itself because the pointer to the parent is always a fixed offset
+from the pointer to the child; this offset is the offset of the parent contained
+in the child struct. For example:
+
+.. code-block:: c
+
+	struct shape {
+		int (*area)(struct shape *this);
+	};
+
+	struct rectangle {
+		struct shape parent;
+		int length;
+		int width;
+	};
+
+	int rectangle_area(struct shape *this)
+	{
+		struct rectangle *self = container_of(this, struct shape, parent);
+
+		return self->length * self->width;
+	};
+
+	void rectangle_new(struct rectangle *self, int length, int width)
+	{
+		self->parent.area = rectangle_area;
+		self->length = length;
+		self->width = width;
+	}
+
+In this example (as in most kernel code) the operation of computing the pointer
+to the child from the pointer to the parent is done by ``container_of``.
+
+Faking Classes
+~~~~~~~~~~~~~~
+
+In order to unit test a piece of code that calls a method in a class, the
+behavior of the method must be controllable, otherwise the test ceases to be a
+unit test and becomes an integration test.
+
+A fake just provides an implementation of a piece of code that is different than
+what runs in a production instance, but behaves identically from the standpoint
+of the callers; this is usually done to replace a dependency that is hard to
+deal with, or is slow.
+
+A good example for this might be implementing a fake EEPROM that just stores the
+"contents" in an internal buffer. For example, let's assume we have a class that
+represents an EEPROM:
+
+.. code-block:: c
+
+	struct eeprom {
+		ssize_t (*read)(struct eeprom *this, size_t offset, char *buffer, size_t count);
+		ssize_t (*write)(struct eeprom *this, size_t offset, const char *buffer, size_t count);
+	};
+
+And we want to test some code that buffers writes to the EEPROM:
+
+.. code-block:: c
+
+	struct eeprom_buffer {
+		ssize_t (*write)(struct eeprom_buffer *this, const char *buffer, size_t count);
+		int flush(struct eeprom_buffer *this);
+		size_t flush_count; /* Flushes when buffer exceeds flush_count. */
+	};
+
+	struct eeprom_buffer *new_eeprom_buffer(struct eeprom *eeprom);
+	void destroy_eeprom_buffer(struct eeprom *eeprom);
+
+We can easily test this code by *faking out* the underlying EEPROM:
+
+.. code-block:: c
+
+	struct fake_eeprom {
+		struct eeprom parent;
+		char contents[FAKE_EEPROM_CONTENTS_SIZE];
+	};
+
+	ssize_t fake_eeprom_read(struct eeprom *parent, size_t offset, char *buffer, size_t count)
+	{
+		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
+
+		count = min(count, FAKE_EEPROM_CONTENTS_SIZE - offset);
+		memcpy(buffer, this->contents + offset, count);
+
+		return count;
+	}
+
+	ssize_t fake_eeprom_write(struct eeprom *this, size_t offset, const char *buffer, size_t count)
+	{
+		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
+
+		count = min(count, FAKE_EEPROM_CONTENTS_SIZE - offset);
+		memcpy(this->contents + offset, buffer, count);
+
+		return count;
+	}
+
+	void fake_eeprom_init(struct fake_eeprom *this)
+	{
+		this->parent.read = fake_eeprom_read;
+		this->parent.write = fake_eeprom_write;
+		memset(this->contents, 0, FAKE_EEPROM_CONTENTS_SIZE);
+	}
+
+We can now use it to test ``struct eeprom_buffer``:
+
+.. code-block:: c
+
+	struct eeprom_buffer_test {
+		struct fake_eeprom *fake_eeprom;
+		struct eeprom_buffer *eeprom_buffer;
+	};
+
+	static void eeprom_buffer_test_does_not_write_until_flush(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff};
+
+		eeprom_buffer->flush_count = SIZE_MAX;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0);
+
+		eeprom_buffer->flush(eeprom_buffer);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+	}
+
+	static void eeprom_buffer_test_flushes_after_flush_count_met(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff};
+
+		eeprom_buffer->flush_count = 2;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+	}
+
+	static void eeprom_buffer_test_flushes_increments_of_flush_count(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff, 0xff};
+
+		eeprom_buffer->flush_count = 2;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 2);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+		/* Should have only flushed the first two bytes. */
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[2], 0);
+	}
+
+	static int eeprom_buffer_test_init(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx;
+
+		ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+		ctx->fake_eeprom = kunit_kzalloc(test, sizeof(*ctx->fake_eeprom), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->fake_eeprom);
+		fake_eeprom_init(ctx->fake_eeprom);
+
+		ctx->eeprom_buffer = new_eeprom_buffer(&ctx->fake_eeprom->parent);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->eeprom_buffer);
+
+		test->priv = ctx;
+
+		return 0;
+	}
+
+	static void eeprom_buffer_test_exit(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+
+		destroy_eeprom_buffer(ctx->eeprom_buffer);
+	}
+
+.. _kunit-on-non-uml:
+
+KUnit on non-UML architectures
+==============================
+
+By default KUnit uses UML as a way to provide dependencies for code under test.
+Under most circumstances KUnit's usage of UML should be treated as an
+implementation detail of how KUnit works under the hood. Nevertheless, there
+are instances where being able to run architecture specific code, or test
+against real hardware is desirable. For these reasons KUnit supports running on
+other architectures.
+
+Running existing KUnit tests on non-UML architectures
+-----------------------------------------------------
+
+There are some special considerations when running existing KUnit tests on
+non-UML architectures:
+
+*   Hardware may not be deterministic, so a test that always passes or fails
+    when run under UML may not always do so on real hardware.
+*   Hardware and VM environments may not be hermetic. KUnit tries its best to
+    provide a hermetic environment to run tests; however, it cannot manage state
+    that it doesn't know about outside of the kernel. Consequently, tests that
+    may be hermetic on UML may not be hermetic on other architectures.
+*   Some features and tooling may not be supported outside of UML.
+*   Hardware and VMs are slower than UML.
+
+None of these are reasons not to run your KUnit tests on real hardware; they are
+only things to be aware of when doing so.
+
+The biggest impediment will likely be that certain KUnit features and
+infrastructure may not support your target environment. For example, at this
+time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
+of UML. Unfortunately, there is no way around this. Using UML (or even just a
+particular architecture) allows us to make a lot of assumptions that make it
+possible to do things which might otherwise be impossible.
+
+Nevertheless, all core KUnit framework features are fully supported on all
+architectures, and using them is straightforward: all you need to do is to take
+your kunitconfig, your Kconfig options for the tests you would like to run, and
+merge them into whatever config your are using for your platform. That's it!
+
+For example, let's say you have the following kunitconfig:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
+
+If you wanted to run this test on an x86 VM, you might add the following config
+options to your ``.config``:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
+	CONFIG_SERIAL_8250=y
+	CONFIG_SERIAL_8250_CONSOLE=y
+
+All these new options do is enable support for a common serial console needed
+for logging.
+
+Next, you could build a kernel with these tests as follows:
+
+
+.. code-block:: bash
+
+	make ARCH=x86 olddefconfig
+	make ARCH=x86
+
+Once you have built a kernel, you could run it on QEMU as follows:
+
+.. code-block:: bash
+
+	qemu-system-x86_64 -enable-kvm \
+			   -m 1024 \
+			   -kernel arch/x86_64/boot/bzImage \
+			   -append 'console=ttyS0' \
+			   --nographic
+
+Interspersed in the kernel logs you might see the following:
+
+.. code-block:: none
+
+	TAP version 14
+		# Subtest: example
+		1..1
+		# example_simple_test: initializing
+		ok 1 - example_simple_test
+	ok 1 - example
+
+Congratulations, you just ran a KUnit test on the x86 architecture!
+
+Writing new tests for other architectures
+-----------------------------------------
+
+The first thing you must do is ask yourself whether it is necessary to write a
+KUnit test for a specific architecture, and then whether it is necessary to
+write that test for a particular piece of hardware. In general, writing a test
+that depends on having access to a particular piece of hardware or software (not
+included in the Linux source repo) should be avoided at all costs.
+
+Even if you only ever plan on running your KUnit test on your hardware
+configuration, other people may want to run your tests and may not have access
+to your hardware. If you write your test to run on UML, then anyone can run your
+tests without knowing anything about your particular setup, and you can still
+run your tests on your hardware setup just by compiling for your architecture.
+
+.. important::
+   Always prefer tests that run on UML to tests that only run under a particular
+   architecture, and always prefer tests that run under QEMU or another easy
+   (and monitarily free) to obtain software environment to a specific piece of
+   hardware.
+
+Nevertheless, there are still valid reasons to write an architecture or hardware
+specific test: for example, you might want to test some code that really belongs
+in ``arch/some-arch/*``. Even so, try your best to write the test so that it
+does not depend on physical hardware: if some of your test cases don't need the
+hardware, only require the hardware for tests that actually need it.
+
+Now that you have narrowed down exactly what bits are hardware specific, the
+actual procedure for writing and running the tests is pretty much the same as
+writing normal KUnit tests. One special caveat is that you have to reset
+hardware state in between test cases; if this is not possible, you may only be
+able to run one test case per invocation.
+
+.. TODO(brendanhiggins@google.com): Add an actual example of an architecture
+   dependent KUnit test.
diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..f3d0c6e42b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8918,6 +8918,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	lib/kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
@@ -9493,6 +9504,13 @@ F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
 F:	drivers/platform/x86/hp_accel.c
 
+LIST KUNIT TEST
+M:	David Gow <davidgow@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+S:	Maintained
+F:	lib/list-test.c
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
@@ -13121,12 +13139,14 @@ F:	Documentation/filesystems/proc.txt
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57..ef42ab040905 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -106,3 +106,20 @@ config EXT4_DEBUG
 	  If you select Y here, then you will be able to turn on debugging
 	  with a command such as:
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
+
+config EXT4_KUNIT_TESTS
+	bool "KUnit tests for ext4"
+	select EXT4_FS
+	depends on KUNIT
+	help
+	  This builds the ext4 KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a production
+	  build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index b17ddc229ac5..840b91d040f1 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
+ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
new file mode 100644
index 000000000000..92a9da1774aa
--- /dev/null
+++ b/fs/ext4/inode-test.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
+ * timestamps in ext4 inode structs are decoded correctly.
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+
+#include "ext4.h"
+
+/*
+ * For constructing the nonnegative timestamp lower bound value.
+ * binary: 00000000 00000000 00000000 00000000
+ */
+#define LOWER_MSB_0 0L
+/*
+ * For constructing the nonnegative timestamp upper bound value.
+ * binary: 01111111 11111111 11111111 11111111
+ *
+ */
+#define UPPER_MSB_0 0x7fffffffL
+/*
+ * For constructing the negative timestamp lower bound value.
+ * binary: 10000000 00000000 00000000 00000000
+ */
+#define LOWER_MSB_1 (-0x80000000L)
+/*
+ * For constructing the negative timestamp upper bound value.
+ * binary: 11111111 11111111 11111111 11111111
+ */
+#define UPPER_MSB_1 (-1L)
+/*
+ * Upper bound for nanoseconds value supported by the encoding.
+ * binary: 00111111 11111111 11111111 11111111
+ */
+#define MAX_NANOSECONDS ((1L << 30) - 1)
+
+#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
+
+#define LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE\
+	"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits"
+#define UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE\
+	"1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits"
+#define LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE\
+	"1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits"
+#define UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE\
+	"2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits"
+#define LOWER_BOUND_NEG_LO_1_CASE\
+	"2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on"
+#define UPPER_BOUND_NEG_LO_1_CASE\
+	"2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on"
+#define LOWER_BOUND_NONNEG_LO_1_CASE\
+	"2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on"
+#define UPPER_BOUND_NONNEG_LO_1_CASE\
+	"2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on"
+#define LOWER_BOUND_NEG_HI_1_CASE\
+	"2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on"
+#define UPPER_BOUND_NEG_HI_1_CASE\
+	"2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on"
+#define LOWER_BOUND_NONNEG_HI_1_CASE\
+	"2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on"
+#define UPPER_BOUND_NONNEG_HI_1_CASE\
+	"2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on"
+#define UPPER_BOUND_NONNEG_HI_1_NS_1_CASE\
+	"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns"
+#define LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE\
+	"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns"
+#define LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE\
+	"2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on"
+#define UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE\
+	"2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on"
+
+struct timestamp_expectation {
+	const char *test_case_name;
+	struct timespec64 expected;
+	u32 extra_bits;
+	bool msb_set;
+	bool lower_bound;
+};
+
+static time64_t get_32bit_time(const struct timestamp_expectation * const test)
+{
+	if (test->msb_set) {
+		if (test->lower_bound)
+			return LOWER_MSB_1;
+
+		return UPPER_MSB_1;
+	}
+
+	if (test->lower_bound)
+		return LOWER_MSB_0;
+	return UPPER_MSB_0;
+}
+
+
+/*
+ *  Test data is derived from the table in the Inode Timestamps section of
+ *  Documentation/filesystems/ext4/inodes.rst.
+ */
+static void inode_test_xtimestamp_decoding(struct kunit *test)
+{
+	const struct timestamp_expectation test_data[] = {
+		{
+			.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {0LL, 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits =  2,
+			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 6,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0xFFFFFFFF,
+			.expected = {.tv_sec = 0x300000000LL,
+				     .tv_nsec = MAX_NANOSECONDS},
+		},
+
+		{
+			.test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
+		}
+	};
+
+	struct timespec64 timestamp;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+		timestamp.tv_sec = get_32bit_time(&test_data[i]);
+		ext4_decode_extra_time(&timestamp,
+				       cpu_to_le32(test_data[i].extra_bits));
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    test_data[i].expected.tv_sec,
+				    timestamp.tv_sec,
+				    CASE_NAME_FORMAT,
+				    test_data[i].test_case_name,
+				    test_data[i].msb_set,
+				    test_data[i].lower_bound,
+				    test_data[i].extra_bits);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    test_data[i].expected.tv_nsec,
+				    timestamp.tv_nsec,
+				    CASE_NAME_FORMAT,
+				    test_data[i].test_case_name,
+				    test_data[i].msb_set,
+				    test_data[i].lower_bound,
+				    test_data[i].extra_bits);
+	}
+}
+
+static struct kunit_case ext4_inode_test_cases[] = {
+	KUNIT_CASE(inode_test_xtimestamp_decoding),
+	{}
+};
+
+static struct kunit_suite ext4_inode_test_suite = {
+	.name = "ext4_inode_test",
+	.test_cases = ext4_inode_test_cases,
+};
+
+kunit_test_suite(ext4_inode_test_suite);
diff --git a/include/kunit/assert.h b/include/kunit/assert.h
new file mode 100644
index 000000000000..db6a0fca09b4
--- /dev/null
+++ b/include/kunit/assert.h
@@ -0,0 +1,356 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_ASSERT_H
+#define _KUNIT_ASSERT_H
+
+#include <kunit/string-stream.h>
+#include <linux/err.h>
+
+struct kunit;
+
+/**
+ * enum kunit_assert_type - Type of expectation/assertion.
+ * @KUNIT_ASSERTION: Used to denote that a kunit_assert represents an assertion.
+ * @KUNIT_EXPECTATION: Denotes that a kunit_assert represents an expectation.
+ *
+ * Used in conjunction with a &struct kunit_assert to denote whether it
+ * represents an expectation or an assertion.
+ */
+enum kunit_assert_type {
+	KUNIT_ASSERTION,
+	KUNIT_EXPECTATION,
+};
+
+/**
+ * struct kunit_assert - Data for printing a failed assertion or expectation.
+ * @test: the test case this expectation/assertion is associated with.
+ * @type: the type (either an expectation or an assertion) of this kunit_assert.
+ * @line: the source code line number that the expectation/assertion is at.
+ * @file: the file path of the source file that the expectation/assertion is in.
+ * @message: an optional message to provide additional context.
+ * @format: a function which formats the data in this kunit_assert to a string.
+ *
+ * Represents a failed expectation/assertion. Contains all the data necessary to
+ * format a string to a user reporting the failure.
+ */
+struct kunit_assert {
+	struct kunit *test;
+	enum kunit_assert_type type;
+	int line;
+	const char *file;
+	struct va_format message;
+	void (*format)(const struct kunit_assert *assert,
+		       struct string_stream *stream);
+};
+
+/**
+ * KUNIT_INIT_VA_FMT_NULL - Default initializer for struct va_format.
+ *
+ * Used inside a struct initialization block to initialize struct va_format to
+ * default values where fmt and va are null.
+ */
+#define KUNIT_INIT_VA_FMT_NULL { .fmt = NULL, .va = NULL }
+
+/**
+ * KUNIT_INIT_ASSERT_STRUCT() - Initializer for a &struct kunit_assert.
+ * @kunit: The test case that this expectation/assertion is associated with.
+ * @assert_type: The type (assertion or expectation) of this kunit_assert.
+ * @fmt: The formatting function which builds a string out of this kunit_assert.
+ *
+ * The base initializer for a &struct kunit_assert.
+ */
+#define KUNIT_INIT_ASSERT_STRUCT(kunit, assert_type, fmt) {		       \
+	.test = kunit,							       \
+	.type = assert_type,						       \
+	.file = __FILE__,						       \
+	.line = __LINE__,						       \
+	.message = KUNIT_INIT_VA_FMT_NULL,				       \
+	.format = fmt							       \
+}
+
+void kunit_base_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream);
+
+void kunit_assert_print_msg(const struct kunit_assert *assert,
+			    struct string_stream *stream);
+
+/**
+ * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
+ * @assert: The parent of this type.
+ *
+ * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
+ */
+struct kunit_fail_assert {
+	struct kunit_assert assert;
+};
+
+void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_FAIL_ASSERT_STRUCT() - Initializer for &struct kunit_fail_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ *
+ * Initializes a &struct kunit_fail_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_fail_assert_format)	       \
+}
+
+/**
+ * struct kunit_unary_assert - Represents a KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
+ * @assert: The parent of this type.
+ * @condition: A string representation of a conditional expression.
+ * @expected_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
+ *
+ * Represents a simple expectation or assertion that simply asserts something is
+ * true or false. In other words, represents the expectations:
+ * KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
+ */
+struct kunit_unary_assert {
+	struct kunit_assert assert;
+	const char *condition;
+	bool expected_true;
+};
+
+void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @cond: A string representation of the expression asserted true or false.
+ * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
+ *
+ * Initializes a &struct kunit_unary_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_UNARY_ASSERT_STRUCT(test, type, cond, expect_true) {	       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_unary_assert_format),	       \
+	.condition = cond,						       \
+	.expected_true = expect_true					       \
+}
+
+/**
+ * struct kunit_ptr_not_err_assert - An expectation/assertion that a pointer is
+ *	not NULL and not a -errno.
+ * @assert: The parent of this type.
+ * @text: A string representation of the expression passed to the expectation.
+ * @value: The actual evaluated pointer value of the expression.
+ *
+ * Represents an expectation/assertion that a pointer is not null and is does
+ * not contain a -errno. (See IS_ERR_OR_NULL().)
+ */
+struct kunit_ptr_not_err_assert {
+	struct kunit_assert assert;
+	const char *text;
+	const void *value;
+};
+
+void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_ptr_not_err_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @txt: A string representation of the expression passed to the expectation.
+ * @val: The actual evaluated pointer value of the expression.
+ *
+ * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(test, type, txt, val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_ptr_not_err_assert_format),   \
+	.text = txt,							       \
+	.value = val							       \
+}
+
+/**
+ * struct kunit_binary_assert - An expectation/assertion that compares two
+ *	non-pointer values (for example, KUNIT_EXPECT_EQ(test, 1 + 1, 2)).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two non-pointer values. For
+ * example, to expect that 1 + 1 == 2, you can use the expectation
+ * KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+ */
+struct kunit_binary_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	long long left_value;
+	const char *right_text;
+	long long right_value;
+};
+
+void kunit_binary_assert_format(const struct kunit_assert *assert,
+				struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_ASSERT_STRUCT(test,				       \
+					type,				       \
+					op_str,				       \
+					left_str,			       \
+					left_val,			       \
+					right_str,			       \
+					right_val) {			       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_assert_format),	       \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+/**
+ * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
+ *	pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two pointer values. For
+ * example, to expect that foo and bar point to the same thing, you can use the
+ * expectation KUNIT_EXPECT_PTR_EQ(test, foo, bar);
+ */
+struct kunit_binary_ptr_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const void *left_value;
+	const char *right_text;
+	const void *right_value;
+};
+
+void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_ptr_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_ptr_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT(test,			       \
+					    type,			       \
+					    op_str,			       \
+					    left_str,			       \
+					    left_val,			       \
+					    right_str,			       \
+					    right_val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_ptr_assert_format),    \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+/**
+ * struct kunit_binary_str_assert - An expectation/assertion that compares two
+ *	string values (for example, KUNIT_EXPECT_STREQ(test, foo, "bar")).
+ * @assert: The parent of this type.
+ * @operation: A string representation of the comparison operator (e.g. "==").
+ * @left_text: A string representation of the expression in the left slot.
+ * @left_value: The actual evaluated value of the expression in the left slot.
+ * @right_text: A string representation of the expression in the right slot.
+ * @right_value: The actual evaluated value of the expression in the right slot.
+ *
+ * Represents an expectation/assertion that compares two string values. For
+ * example, to expect that the string in foo is equal to "bar", you can use the
+ * expectation KUNIT_EXPECT_STREQ(test, foo, "bar");
+ */
+struct kunit_binary_str_assert {
+	struct kunit_assert assert;
+	const char *operation;
+	const char *left_text;
+	const char *left_value;
+	const char *right_text;
+	const char *right_value;
+};
+
+void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream);
+
+/**
+ * KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() - Initializes a
+ *	&struct kunit_binary_str_assert.
+ * @test: The test case that this expectation/assertion is associated with.
+ * @type: The type (assertion or expectation) of this kunit_assert.
+ * @op_str: A string representation of the comparison operator (e.g. "==").
+ * @left_str: A string representation of the expression in the left slot.
+ * @left_val: The actual evaluated value of the expression in the left slot.
+ * @right_str: A string representation of the expression in the right slot.
+ * @right_val: The actual evaluated value of the expression in the right slot.
+ *
+ * Initializes a &struct kunit_binary_str_assert. Intended to be used in
+ * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
+ */
+#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,			       \
+					    type,			       \
+					    op_str,			       \
+					    left_str,			       \
+					    left_val,			       \
+					    right_str,			       \
+					    right_val) {		       \
+	.assert = KUNIT_INIT_ASSERT_STRUCT(test,			       \
+					   type,			       \
+					   kunit_binary_str_assert_format),    \
+	.operation = op_str,						       \
+	.left_text = left_str,						       \
+	.left_value = left_val,						       \
+	.right_text = right_str,					       \
+	.right_value = right_val					       \
+}
+
+#endif /*  _KUNIT_ASSERT_H */
diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 000000000000..fe98a00b75a9
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct kunit *test;
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+	struct kunit *test;
+	gfp_t gfp;
+};
+
+struct kunit;
+
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
+
+int __printf(2, 3) string_stream_add(struct string_stream *stream,
+				     const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *stream);
+
+int string_stream_append(struct string_stream *stream,
+			 struct string_stream *other);
+
+bool string_stream_is_empty(struct string_stream *stream);
+
+int string_stream_destroy(struct string_stream *stream);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
new file mode 100644
index 000000000000..dba48304b3bd
--- /dev/null
+++ b/include/kunit/test.h
@@ -0,0 +1,1490 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TEST_H
+#define _KUNIT_TEST_H
+
+#include <kunit/assert.h>
+#include <kunit/try-catch.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct kunit_resource;
+
+typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
+typedef void (*kunit_resource_free_t)(struct kunit_resource *);
+
+/**
+ * struct kunit_resource - represents a *test managed resource*
+ * @allocation: for the user to store arbitrary data.
+ * @free: a user supplied function to free the resource. Populated by
+ * kunit_alloc_resource().
+ *
+ * Represents a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	struct kunit_kmalloc_params {
+ *		size_t size;
+ *		gfp_t gfp;
+ *	};
+ *
+ *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+ *	{
+ *		struct kunit_kmalloc_params *params = context;
+ *		res->allocation = kmalloc(params->size, params->gfp);
+ *
+ *		if (!res->allocation)
+ *			return -ENOMEM;
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void kunit_kmalloc_free(struct kunit_resource *res)
+ *	{
+ *		kfree(res->allocation);
+ *	}
+ *
+ *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+ *	{
+ *		struct kunit_kmalloc_params params;
+ *		struct kunit_resource *res;
+ *
+ *		params.size = size;
+ *		params.gfp = gfp;
+ *
+ *		res = kunit_alloc_resource(test, kunit_kmalloc_init,
+ *			kunit_kmalloc_free, &params);
+ *		if (res)
+ *			return res->allocation;
+ *
+ *		return NULL;
+ *	}
+ */
+struct kunit_resource {
+	void *allocation;
+	kunit_resource_free_t free;
+
+	/* private: internal use only. */
+	struct list_head node;
+};
+
+struct kunit;
+
+/**
+ * struct kunit_case - represents an individual test case.
+ *
+ * @run_case: the function representing the actual test case.
+ * @name:     the name of the test case.
+ *
+ * A test case is a function with the signature,
+ * ``void (*)(struct kunit *)``
+ * that makes expectations and assertions (see KUNIT_EXPECT_TRUE() and
+ * KUNIT_ASSERT_TRUE()) about code under test. Each test case is associated
+ * with a &struct kunit_suite and will be run after the suite's init
+ * function and followed by the suite's exit function.
+ *
+ * A test case should be static and should only be created with the
+ * KUNIT_CASE() macro; additionally, every array of test cases should be
+ * terminated with an empty test case.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	void add_test_basic(struct kunit *test)
+ *	{
+ *		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+ *		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+ *		KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
+ *		KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+ *		KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+ *	}
+ *
+ *	static struct kunit_case example_test_cases[] = {
+ *		KUNIT_CASE(add_test_basic),
+ *		{}
+ *	};
+ *
+ */
+struct kunit_case {
+	void (*run_case)(struct kunit *test);
+	const char *name;
+
+	/* private: internal use only. */
+	bool success;
+};
+
+/**
+ * KUNIT_CASE - A helper for creating a &struct kunit_case
+ *
+ * @test_name: a reference to a test case function.
+ *
+ * Takes a symbol for a function representing a test case and creates a
+ * &struct kunit_case object from it. See the documentation for
+ * &struct kunit_case for an example on how to use it.
+ */
+#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+
+/**
+ * struct kunit_suite - describes a related collection of &struct kunit_case
+ *
+ * @name:	the name of the test. Purely informational.
+ * @init:	called before every test case.
+ * @exit:	called after every test case.
+ * @test_cases:	a null terminated array of test cases.
+ *
+ * A kunit_suite is a collection of related &struct kunit_case s, such that
+ * @init is called before every test case and @exit is called after every
+ * test case, similar to the notion of a *test fixture* or a *test class*
+ * in other unit testing frameworks like JUnit or Googletest.
+ *
+ * Every &struct kunit_case must be associated with a kunit_suite for KUnit
+ * to run it.
+ */
+struct kunit_suite {
+	const char name[256];
+	int (*init)(struct kunit *test);
+	void (*exit)(struct kunit *test);
+	struct kunit_case *test_cases;
+};
+
+/**
+ * struct kunit - represents a running instance of a test.
+ *
+ * @priv: for user to store arbitrary data. Commonly used to pass data
+ *	  created in the init function (see &struct kunit_suite).
+ *
+ * Used to store information about the current context under which the test
+ * is running. Most of this data is private and should only be accessed
+ * indirectly via public functions; the one exception is @priv which can be
+ * used by the test writer to store arbitrary data.
+ */
+struct kunit {
+	void *priv;
+
+	/* private: internal use only. */
+	const char *name; /* Read only after initialization! */
+	struct kunit_try_catch try_catch;
+	/*
+	 * success starts as true, and may only be set to false during a
+	 * test case; thus, it is safe to update this across multiple
+	 * threads using WRITE_ONCE; however, as a consequence, it may only
+	 * be read after the test case finishes once all threads associated
+	 * with the test case have terminated.
+	 */
+	bool success; /* Read only after test_case finishes! */
+	spinlock_t lock; /* Guards all mutable test state. */
+	/*
+	 * Because resources is a list that may be updated multiple times (with
+	 * new resources) from any thread associated with a test case, we must
+	 * protect it with some type of lock.
+	 */
+	struct list_head resources; /* Protected by lock. */
+};
+
+void kunit_init_test(struct kunit *test, const char *name);
+
+int kunit_run_tests(struct kunit_suite *suite);
+
+/**
+ * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
+ *
+ * @suite: a statically allocated &struct kunit_suite.
+ *
+ * Registers @suite with the test framework. See &struct kunit_suite for
+ * more information.
+ *
+ * NOTE: Currently KUnit tests are all run as late_initcalls; this means
+ * that they cannot test anything where tests must run at a different init
+ * phase. One significant restriction resulting from this is that KUnit
+ * cannot reliably test anything that is initialize in the late_init phase;
+ * another is that KUnit is useless to test things that need to be run in
+ * an earlier init phase.
+ *
+ * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
+ * late_initcalls.  I have some future work planned to dispatch all KUnit
+ * tests from the same place, and at the very least to do so after
+ * everything else is definitely initialized.
+ */
+#define kunit_test_suite(suite)						       \
+	static int kunit_suite_init##suite(void)			       \
+	{								       \
+		return kunit_run_tests(&suite);				       \
+	}								       \
+	late_initcall(kunit_suite_init##suite)
+
+/*
+ * Like kunit_alloc_resource() below, but returns the struct kunit_resource
+ * object that contains the allocation. This is mostly for testing purposes.
+ */
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *context);
+
+/**
+ * kunit_alloc_resource() - Allocates a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource.
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ *
+ * NOTE: KUnit needs to allocate memory for each kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the use context of your
+ * resource.
+ */
+static inline void *kunit_alloc_resource(struct kunit *test,
+					 kunit_resource_init_t init,
+					 kunit_resource_free_t free,
+					 gfp_t internal_gfp,
+					 void *context)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_and_get_resource(test, init, free, internal_gfp,
+					   context);
+
+	if (res)
+		return res->allocation;
+
+	return NULL;
+}
+
+typedef bool (*kunit_resource_match_t)(struct kunit *test,
+				       const void *res,
+				       void *match_data);
+
+/**
+ * kunit_resource_instance_match() - Match a resource with the same instance.
+ * @test: Test case to which the resource belongs.
+ * @res: The data stored in kunit_resource->allocation.
+ * @match_data: The resource pointer to match against.
+ *
+ * An instance of kunit_resource_match_t that matches a resource whose
+ * allocation matches @match_data.
+ */
+static inline bool kunit_resource_instance_match(struct kunit *test,
+						 const void *res,
+						 void *match_data)
+{
+	return res == match_data;
+}
+
+/**
+ * kunit_resource_destroy() - Find a kunit_resource and destroy it.
+ * @test: Test case to which the resource belongs.
+ * @match: Match function. Returns whether a given resource matches @match_data.
+ * @free: Must match free on the kunit_resource to free.
+ * @match_data: Data passed into @match.
+ *
+ * Free the latest kunit_resource of @test for which @free matches the
+ * kunit_resource_free_t associated with the resource and for which @match
+ * returns true.
+ *
+ * RETURNS:
+ * 0 if kunit_resource is found and freed, -ENOENT if not found.
+ */
+int kunit_resource_destroy(struct kunit *test,
+			   kunit_resource_match_t match,
+			   kunit_resource_free_t free,
+			   void *match_data);
+
+/**
+ * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * Just like `kmalloc(...)`, except the allocation is managed by the test case
+ * and is automatically cleaned up after the test case concludes. See &struct
+ * kunit_resource for more information.
+ */
+void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp);
+
+/**
+ * kunit_kfree() - Like kfree except for allocations managed by KUnit.
+ * @test: The test case to which the resource belongs.
+ * @ptr: The memory allocation to free.
+ */
+void kunit_kfree(struct kunit *test, const void *ptr);
+
+/**
+ * kunit_kzalloc() - Just like kunit_kmalloc(), but zeroes the allocation.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kzalloc() and kunit_kmalloc() for more information.
+ */
+static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
+{
+	return kunit_kmalloc(test, size, gfp | __GFP_ZERO);
+}
+
+void kunit_cleanup(struct kunit *test);
+
+#define kunit_printk(lvl, test, fmt, ...) \
+	printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
+
+/**
+ * kunit_info() - Prints an INFO level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints an info level message associated with the test suite being run.
+ * Takes a variable number of format parameters just like printk().
+ */
+#define kunit_info(test, fmt, ...) \
+	kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_warn() - Prints a WARN level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints a warning level message.
+ */
+#define kunit_warn(test, fmt, ...) \
+	kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
+
+/**
+ * kunit_err() - Prints an ERROR level message associated with @test.
+ *
+ * @test: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Prints an error level message.
+ */
+#define kunit_err(test, fmt, ...) \
+	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
+
+/**
+ * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
+ * @test: The test context object.
+ *
+ * The opposite of KUNIT_FAIL(), it is an expectation that cannot fail. In other
+ * words, it does nothing and only exists for code clarity. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_SUCCEED(test) do {} while (0)
+
+void kunit_do_assertion(struct kunit *test,
+			struct kunit_assert *assert,
+			bool pass,
+			const char *fmt, ...);
+
+#define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
+	struct assert_class __assertion = INITIALIZER;			       \
+	kunit_do_assertion(test,					       \
+			   &__assertion.assert,				       \
+			   pass,					       \
+			   fmt,						       \
+			   ##__VA_ARGS__);				       \
+} while (0)
+
+
+#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
+	KUNIT_ASSERTION(test,						       \
+			false,						       \
+			kunit_fail_assert,				       \
+			KUNIT_INIT_FAIL_ASSERT_STRUCT(test, assert_type),      \
+			fmt,						       \
+			##__VA_ARGS__)
+
+/**
+ * KUNIT_FAIL() - Always causes a test to fail when evaluated.
+ * @test: The test context object.
+ * @fmt: an informational message to be printed when the assertion is made.
+ * @...: string format arguments.
+ *
+ * The opposite of KUNIT_SUCCEED(), it is an expectation that always fails. In
+ * other words, it always results in a failed expectation, and consequently
+ * always causes the test case to fail when evaluated. See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_FAIL(test, fmt, ...)					       \
+	KUNIT_FAIL_ASSERTION(test,					       \
+			     KUNIT_EXPECTATION,				       \
+			     fmt,					       \
+			     ##__VA_ARGS__)
+
+#define KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      expected_true,				       \
+			      fmt,					       \
+			      ...)					       \
+	KUNIT_ASSERTION(test,						       \
+			!!(condition) == !!expected_true,		       \
+			kunit_unary_assert,				       \
+			KUNIT_INIT_UNARY_ASSERT_STRUCT(test,		       \
+						       assert_type,	       \
+						       #condition,	       \
+						       expected_true),	       \
+			fmt,						       \
+			##__VA_ARGS__)
+
+#define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
+	KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      true,					       \
+			      fmt,					       \
+			      ##__VA_ARGS__)
+
+#define KUNIT_TRUE_ASSERTION(test, assert_type, condition) \
+	KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+#define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
+	KUNIT_UNARY_ASSERTION(test,					       \
+			      assert_type,				       \
+			      condition,				       \
+			      false,					       \
+			      fmt,					       \
+			      ##__VA_ARGS__)
+
+#define KUNIT_FALSE_ASSERTION(test, assert_type, condition) \
+	KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
+
+/*
+ * A factory macro for defining the assertions and expectations for the basic
+ * comparisons defined for the built in types.
+ *
+ * Unfortunately, there is no common type that all types can be promoted to for
+ * which all the binary operators behave the same way as for the actual types
+ * (for example, there is no type that long long and unsigned long long can
+ * both be cast to where the comparison result is preserved for all values). So
+ * the best we can do is do the comparison in the original types and then coerce
+ * everything to long long for printing; this way, the comparison behaves
+ * correctly and the printed out value usually makes sense without
+ * interpretation, but can always be interpreted to figure out the actual
+ * value.
+ */
+#define KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    op,					       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	((void)__typecheck(__left, __right));				       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			__left op __right,				       \
+			assert_class,					       \
+			ASSERT_CLASS_INIT(test,				       \
+					  assert_type,			       \
+					  #op,				       \
+					  #left,			       \
+					  __left,			       \
+					  #right,			       \
+					  __right),			       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, ==, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, !=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, <, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, <=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, >, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ...)				       \
+	KUNIT_BASE_BINARY_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
+				    assert_type,			       \
+				    left, >=, right,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
+	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    kunit_binary_assert,		       \
+				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      assert_type,			       \
+				      left,				       \
+				      right,				       \
+				      NULL)
+
+#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
+				    kunit_binary_ptr_assert,		       \
+				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+				    assert_type,			       \
+				    left,				       \
+				    right,				       \
+				    fmt,				       \
+				    ##__VA_ARGS__)
+
+#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left,				       \
+				   op,					       \
+				   right,				       \
+				   fmt,					       \
+				   ...)					       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			strcmp(__left, __right) op 0,			       \
+			kunit_binary_str_assert,			       \
+			KUNIT_INIT_BINARY_ASSERT_STRUCT(test,		       \
+							assert_type,	       \
+							#op,		       \
+							#left,		       \
+							__left,		       \
+							#right,		       \
+							__right),	       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left, ==, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_EQ_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ...)				       \
+	KUNIT_BINARY_STR_ASSERTION(test,				       \
+				   assert_type,				       \
+				   left, !=, right,			       \
+				   fmt,					       \
+				   ##__VA_ARGS__)
+
+#define KUNIT_BINARY_STR_NE_ASSERTION(test, assert_type, left, right)	       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  assert_type,			       \
+					  left,				       \
+					  right,			       \
+					  NULL)
+
+#define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						assert_type,		       \
+						ptr,			       \
+						fmt,			       \
+						...)			       \
+do {									       \
+	typeof(ptr) __ptr = (ptr);					       \
+									       \
+	KUNIT_ASSERTION(test,						       \
+			!IS_ERR_OR_NULL(__ptr),				       \
+			kunit_ptr_not_err_assert,			       \
+			KUNIT_INIT_PTR_NOT_ERR_STRUCT(test,		       \
+						      assert_type,	       \
+						      #ptr,		       \
+						      __ptr),		       \
+			fmt,						       \
+			##__VA_ARGS__);					       \
+} while (0)
+
+#define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						assert_type,		       \
+						ptr,			       \
+						NULL)
+
+/**
+ * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to true.
+ *
+ * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
+ * to fail when the specified condition is not met; however, it will not prevent
+ * the test case from continuing to run; this is otherwise known as an
+ * *expectation failure*.
+ */
+#define KUNIT_EXPECT_TRUE(test, condition) \
+	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_TRUE_MSG_ASSERTION(test,					       \
+				 KUNIT_EXPECTATION,			       \
+				 condition,				       \
+				 fmt,					       \
+				 ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails when this does
+ * not evaluate to false.
+ *
+ * Sets an expectation that @condition evaluates to false. See
+ * KUNIT_EXPECT_TRUE() for more information.
+ */
+#define KUNIT_EXPECT_FALSE(test, condition) \
+	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
+
+#define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_FALSE_MSG_ASSERTION(test,					       \
+				  KUNIT_EXPECTATION,			       \
+				  condition,				       \
+				  fmt,					       \
+				  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_EQ(test, left, right) \
+	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right)
+
+#define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NE(test, left, right) \
+	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are not
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
+	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right)
+
+#define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LT(test, left, right) \
+	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. Semantically this is equivalent
+ * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_LE(test, left, right) \
+	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GT(test, left, right) \
+	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an expectation that the value that @left evaluates to is greater than
+ * the value that @right evaluates to. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_GE(test, left, right) \
+	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      KUNIT_EXPECTATION,		       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STREQ(test, left, right) \
+	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
+ * for more information.
+ */
+#define KUNIT_EXPECT_STRNEQ(test, left, right) \
+	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
+
+#define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_EXPECTATION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an expectation that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is semantically equivalent to
+ * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
+ * more information.
+ */
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
+	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
+
+#define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						KUNIT_EXPECTATION,	       \
+						ptr,			       \
+						fmt,			       \
+						##__VA_ARGS__)
+
+#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
+	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_TRUE() - Sets an assertion that @condition is true.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression. The test fails and aborts when
+ * this does not evaluate to true.
+ *
+ * This and assertions of the form `KUNIT_ASSERT_*` will cause the test case to
+ * fail *and immediately abort* when the specified condition is not met. Unlike
+ * an expectation failure, it will prevent the test case from continuing to run;
+ * this is otherwise known as an *assertion failure*.
+ */
+#define KUNIT_ASSERT_TRUE(test, condition) \
+	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
+
+#define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_TRUE_MSG_ASSERTION(test,					       \
+				 KUNIT_ASSERTION,			       \
+				 condition,				       \
+				 fmt,					       \
+				 ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_FALSE() - Sets an assertion that @condition is false.
+ * @test: The test context object.
+ * @condition: an arbitrary boolean expression.
+ *
+ * Sets an assertion that the value that @condition evaluates to is false. This
+ * is the same as KUNIT_EXPECT_FALSE(), except it causes an assertion failure
+ * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_FALSE(test, condition) \
+	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
+
+#define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
+	KUNIT_FALSE_MSG_ASSERTION(test,					       \
+				  KUNIT_ASSERTION,			       \
+				  condition,				       \
+				  fmt,					       \
+				  ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_EQ() - Sets an assertion that @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_EQ(test, left, right) \
+	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_PTR_EQ(test, left, right) \
+	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are not
+ * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NE(test, left, right) \
+	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
+ * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a pointer.
+ * @right: an arbitrary expression that evaluates to a pointer.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are not
+ * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
+ * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_PTR_NE(test, left, right) \
+	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is less than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_LT(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_LT(test, left, right) \
+	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+/**
+ * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is less than or
+ * equal to the value that @right evaluates to. This is the same as
+ * KUNIT_EXPECT_LE(), except it causes an assertion failure (see
+ * KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_LE(test, left, right) \
+	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is greater than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_GT(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_GT(test, left, right) \
+	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a primitive C type.
+ * @right: an arbitrary expression that evaluates to a primitive C type.
+ *
+ * Sets an assertion that the value that @left evaluates to is greater than the
+ * value that @right evaluates to. This is the same as KUNIT_EXPECT_GE(), except
+ * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
+ * is not met.
+ */
+#define KUNIT_ASSERT_GE(test, left, right) \
+	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
+				      KUNIT_ASSERTION,			       \
+				      left,				       \
+				      right,				       \
+				      fmt,				       \
+				      ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is the same as KUNIT_EXPECT_STREQ(), except it causes an
+ * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_STREQ(test, left, right) \
+	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
+ * @test: The test context object.
+ * @left: an arbitrary expression that evaluates to a null terminated string.
+ * @right: an arbitrary expression that evaluates to a null terminated string.
+ *
+ * Sets an expectation that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
+ * for more information.
+ */
+#define KUNIT_ASSERT_STRNEQ(test, left, right) \
+	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
+
+#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
+	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
+					  KUNIT_ASSERTION,		       \
+					  left,				       \
+					  right,			       \
+					  fmt,				       \
+					  ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
+ * @test: The test context object.
+ * @ptr: an arbitrary pointer.
+ *
+ * Sets an assertion that the value that @ptr evaluates to is not null and not
+ * an errno stored in a pointer. This is the same as
+ * KUNIT_EXPECT_NOT_ERR_OR_NULL(), except it causes an assertion failure (see
+ * KUNIT_ASSERT_TRUE()) when the assertion is not met.
+ */
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
+	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
+
+#define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
+	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
+						KUNIT_ASSERTION,	       \
+						ptr,			       \
+						fmt,			       \
+						##__VA_ARGS__)
+
+#endif /* _KUNIT_TEST_H */
diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
new file mode 100644
index 000000000000..404f336cbdc8
--- /dev/null
+++ b/include/kunit/try-catch.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TRY_CATCH_H
+#define _KUNIT_TRY_CATCH_H
+
+#include <linux/types.h>
+
+typedef void (*kunit_try_catch_func_t)(void *);
+
+struct completion;
+struct kunit;
+
+/**
+ * struct kunit_try_catch - provides a generic way to run code which might fail.
+ * @test: The test case that is currently being executed.
+ * @try_completion: Completion that the control thread waits on while test runs.
+ * @try_result: Contains any errno obtained while running test case.
+ * @try: The function, the test case, to attempt to run.
+ * @catch: The function called if @try bails out.
+ * @context: used to pass user data to the try and catch functions.
+ *
+ * kunit_try_catch provides a generic, architecture independent way to execute
+ * an arbitrary function of type kunit_try_catch_func_t which may bail out by
+ * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
+ * is stopped at the site of invocation and @catch is called.
+ *
+ * struct kunit_try_catch provides a generic interface for the functionality
+ * needed to implement kunit->abort() which in turn is needed for implementing
+ * assertions. Assertions allow stating a precondition for a test simplifying
+ * how test cases are written and presented.
+ *
+ * Assertions are like expectations, except they abort (call
+ * kunit_try_catch_throw()) when the specified condition is not met. This is
+ * useful when you look at a test case as a logical statement about some piece
+ * of code, where assertions are the premises for the test case, and the
+ * conclusion is a set of predicates, rather expectations, that must all be
+ * true. If your premises are violated, it does not makes sense to continue.
+ */
+struct kunit_try_catch {
+	/* private: internal use only. */
+	struct kunit *test;
+	struct completion *try_completion;
+	int try_result;
+	kunit_try_catch_func_t try;
+	kunit_try_catch_func_t catch;
+	void *context;
+};
+
+void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+			  struct kunit *test,
+			  kunit_try_catch_func_t try,
+			  kunit_try_catch_func_t catch);
+
+void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
+
+void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
+
+static inline int kunit_try_catch_get_result(struct kunit_try_catch *try_catch)
+{
+	return try_catch->try_result;
+}
+
+/*
+ * Exposed for testing only.
+ */
+void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
+
+#endif /* _KUNIT_TRY_CATCH_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index daad787fb795..f0902a7bd1b3 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -115,6 +115,8 @@ obj-$(CONFIG_TORTURE_TEST) += torture.o
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
+obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
+
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
new file mode 100644
index 000000000000..2a63241a8453
--- /dev/null
+++ b/kernel/sysctl-test.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of proc sysctl.
+ */
+
+#include <kunit/test.h>
+#include <linux/sysctl.h>
+
+#define KUNIT_PROC_READ 0
+#define KUNIT_PROC_WRITE 1
+
+static int i_zero;
+static int i_one_hundred = 100;
+
+/*
+ * Test that proc_dointvec will not try to use a NULL .data field even when the
+ * length is non-zero.
+ */
+static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
+{
+	struct ctl_table null_data_table = {
+		.procname = "foo",
+		/*
+		 * Here we are testing that proc_dointvec behaves correctly when
+		 * we give it a NULL .data field. Normally this would point to a
+		 * piece of memory where the value would be stored.
+		 */
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	/*
+	 * proc_dointvec expects a buffer in user space, so we allocate one. We
+	 * also need to cast it to __user so sparse doesn't get mad.
+	 */
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	/*
+	 * We don't care what the starting length is since proc_dointvec should
+	 * not try to read because .data is NULL.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
+					       KUNIT_PROC_READ, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	/*
+	 * See above.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
+					       KUNIT_PROC_WRITE, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Similar to the previous test, we create a struct ctrl_table that has a .data
+ * field that proc_dointvec cannot do anything with; however, this time it is
+ * because we tell proc_dointvec that the size is 0.
+ */
+static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table data_maxlen_unset_table = {
+		.procname = "foo",
+		.data		= &data,
+		/*
+		 * So .data is no longer NULL, but we tell proc_dointvec its
+		 * length is 0, so it still shouldn't try to use it.
+		 */
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	size_t len;
+	loff_t pos;
+
+	/*
+	 * As before, we don't care what buffer length is because proc_dointvec
+	 * cannot do anything because its internal .data buffer has zero length.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
+					       KUNIT_PROC_READ, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	/*
+	 * See previous comment.
+	 */
+	len = 1234;
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
+					       KUNIT_PROC_WRITE, buffer, &len,
+					       &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Here we provide a valid struct ctl_table, but we try to read and write from
+ * it using a buffer of zero length, so it should still fail in a similar way as
+ * before.
+ */
+static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	/*
+	 * However, now our read/write buffer has zero length.
+	 */
+	size_t len = 0;
+	loff_t pos;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Test that proc_dointvec refuses to read when the file position is non-zero.
+ */
+static void sysctl_test_api_dointvec_table_read_but_position_set(
+		struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	void __user *buffer = (void __user *)kunit_kzalloc(test, sizeof(int),
+							   GFP_USER);
+	/*
+	 * We don't care about our buffer length because we start off with a
+	 * non-zero file position.
+	 */
+	size_t len = 1234;
+	/*
+	 * proc_dointvec should refuse to read into the buffer since the file
+	 * pos is non-zero.
+	 */
+	loff_t pos = 1;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
+					       &len, &pos));
+	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+}
+
+/*
+ * Test that we can read a two digit number in a sufficiently size buffer.
+ * Nothing fancy.
+ */
+static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t len = 4;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	/* Store 13 in the data field. */
+	*((int *)table.data) = 13;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
+					       user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)3, len);
+	buffer[len] = '\0';
+	/* And we read 13 back out. */
+	KUNIT_EXPECT_STREQ(test, "13\n", buffer);
+}
+
+/*
+ * Same as previous test, just now with negative numbers.
+ */
+static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t len = 5;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	*((int *)table.data) = -16;
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
+					       user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, (size_t)4, len);
+	buffer[len] = '\0';
+	KUNIT_EXPECT_STREQ(test, "-16\n", (char *)buffer);
+}
+
+/*
+ * Test that a simple positive write works.
+ */
+static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
+{
+	int data = 0;
+	/* Good table. */
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[] = "9";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+
+	memcpy(buffer, input, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
+					       user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, 9, *((int *)table.data));
+}
+
+/*
+ * Same as previous test, but now with negative numbers.
+ */
+static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	char input[] = "-9";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+
+	memcpy(buffer, input, len);
+
+	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
+					       user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, -9, *((int *)table.data));
+}
+
+/*
+ * Test that writing a value smaller than the minimum possible value is not
+ * allowed.
+ */
+static void sysctl_test_api_dointvec_write_single_less_int_min(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
+					     - (INT_MAX + INT_MIN) + 1;
+
+	/*
+	 * We use this rigmarole to create a string that contains a value one
+	 * less than the minimum accepted value.
+	 */
+	KUNIT_ASSERT_LT(test,
+			(size_t)snprintf(buffer, max_len, "-%lu",
+					 abs_of_less_than_min),
+			max_len);
+
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
+						     user_buffer, &len, &pos));
+	KUNIT_EXPECT_EQ(test, max_len, len);
+	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
+}
+
+/*
+ * Test that writing the maximum possible value works.
+ */
+static void sysctl_test_api_dointvec_write_single_greater_int_max(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = {
+		.procname = "foo",
+		.data		= &data,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &i_zero,
+		.extra2         = &i_one_hundred,
+	};
+	size_t max_len = 32, len = max_len;
+	loff_t pos = 0;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
+
+	KUNIT_ASSERT_GT(test, greater_than_max, (unsigned long)INT_MAX);
+	KUNIT_ASSERT_LT(test, (size_t)snprintf(buffer, max_len, "%lu",
+					       greater_than_max),
+			max_len);
+	KUNIT_EXPECT_EQ(test, -EINVAL, proc_dointvec(&table, KUNIT_PROC_WRITE,
+						     user_buffer, &len, &pos));
+	KUNIT_ASSERT_EQ(test, max_len, len);
+	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
+}
+
+static struct kunit_case sysctl_test_cases[] = {
+	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_len_is_zero),
+	KUNIT_CASE(sysctl_test_api_dointvec_table_read_but_position_set),
+	KUNIT_CASE(sysctl_test_dointvec_read_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_read_happy_single_negative),
+	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_positive),
+	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	{}
+};
+
+static struct kunit_suite sysctl_test_suite = {
+	.name = "sysctl_test",
+	.test_cases = sysctl_test_cases,
+};
+
+kunit_test_suite(sysctl_test_suite);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b0157..6c1be6181e38 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1664,6 +1664,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
+source "lib/kunit/Kconfig"
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
@@ -1948,6 +1950,35 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config SYSCTL_KUNIT_TEST
+	bool "KUnit test for sysctl"
+	depends on KUNIT
+	help
+	  This builds the proc sysctl unit test, which runs on boot.
+	  Tests the API contract and implementation correctness of sysctl.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
+config LIST_KUNIT_TEST
+	bool "KUnit Test for Kernel Linked-list structures"
+	depends on KUNIT
+	help
+	  This builds the linked list KUnit test suite.
+	  It tests that the API and basic functionality of the list_head type
+	  and associated macros.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..890e581d00c4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -92,6 +92,8 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
+obj-$(CONFIG_KUNIT) += kunit/
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
@@ -290,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
 obj-$(CONFIG_OBJAGG) += objagg.o
+
+# KUnit tests
+obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
new file mode 100644
index 000000000000..af37016bfdd4
--- /dev/null
+++ b/lib/kunit/Kconfig
@@ -0,0 +1,36 @@
+#
+# KUnit base configuration
+#
+
+menuconfig KUNIT
+	bool "KUnit - Enable support for unit tests"
+	help
+	  Enables support for kernel unit tests (KUnit), a lightweight unit
+	  testing and mocking framework for the Linux kernel. These tests are
+	  able to be run locally on a developer's workstation without a VM or
+	  special hardware when using UML. Can also be used on most other
+	  architectures. For more information, please see
+	  Documentation/dev-tools/kunit/.
+
+if KUNIT
+
+config KUNIT_TEST
+	bool "KUnit test for KUnit"
+	help
+	  Enables the unit tests for the KUnit test framework. These tests test
+	  the KUnit test framework itself; the tests are both written using
+	  KUnit and test KUnit. This option should only be enabled for testing
+	  purposes by developers interested in testing that KUnit works as
+	  expected.
+
+config KUNIT_EXAMPLE_TEST
+	bool "Example test for KUnit"
+	help
+	  Enables an example unit test that illustrates some of the basic
+	  features of KUnit. This test only exists to help new users understand
+	  what KUnit is and how it is used. Please refer to the example test
+	  itself, lib/kunit/example-test.c, for more information. This option
+	  is intended for curious hackers who would like to understand how to
+	  use KUnit for kernel development.
+
+endif # KUNIT
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
new file mode 100644
index 000000000000..769d9402b5d3
--- /dev/null
+++ b/lib/kunit/Makefile
@@ -0,0 +1,9 @@
+obj-$(CONFIG_KUNIT) +=			test.o \
+					string-stream.o \
+					assert.o \
+					try-catch.o
+
+obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
+					string-stream-test.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
new file mode 100644
index 000000000000..86013d4cf891
--- /dev/null
+++ b/lib/kunit/assert.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Assertion and expectation serialization API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/assert.h>
+
+void kunit_base_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream)
+{
+	const char *expect_or_assert = NULL;
+
+	switch (assert->type) {
+	case KUNIT_EXPECTATION:
+		expect_or_assert = "EXPECTATION";
+		break;
+	case KUNIT_ASSERTION:
+		expect_or_assert = "ASSERTION";
+		break;
+	}
+
+	string_stream_add(stream, "%s FAILED at %s:%d\n",
+			 expect_or_assert, assert->file, assert->line);
+}
+
+void kunit_assert_print_msg(const struct kunit_assert *assert,
+			    struct string_stream *stream)
+{
+	if (assert->message.fmt)
+		string_stream_add(stream, "\n%pV", &assert->message);
+}
+
+void kunit_fail_assert_format(const struct kunit_assert *assert,
+			      struct string_stream *stream)
+{
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream, "%pV", &assert->message);
+}
+
+void kunit_unary_assert_format(const struct kunit_assert *assert,
+			       struct string_stream *stream)
+{
+	struct kunit_unary_assert *unary_assert = container_of(
+			assert, struct kunit_unary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (unary_assert->expected_true)
+		string_stream_add(stream,
+				 "\tExpected %s to be true, but is false\n",
+				 unary_assert->condition);
+	else
+		string_stream_add(stream,
+				 "\tExpected %s to be false, but is true\n",
+				 unary_assert->condition);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
+				     struct string_stream *stream)
+{
+	struct kunit_ptr_not_err_assert *ptr_assert = container_of(
+			assert, struct kunit_ptr_not_err_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	if (!ptr_assert->value) {
+		string_stream_add(stream,
+				 "\tExpected %s is not null, but is\n",
+				 ptr_assert->text);
+	} else if (IS_ERR(ptr_assert->value)) {
+		string_stream_add(stream,
+				 "\tExpected %s is not error, but is: %ld\n",
+				 ptr_assert->text,
+				 PTR_ERR(ptr_assert->value));
+	}
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_assert_format(const struct kunit_assert *assert,
+				struct string_stream *stream)
+{
+	struct kunit_binary_assert *binary_assert = container_of(
+			assert, struct kunit_binary_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %lld\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %lld",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream)
+{
+	struct kunit_binary_ptr_assert *binary_assert = container_of(
+			assert, struct kunit_binary_ptr_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %pK\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %pK",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
+
+void kunit_binary_str_assert_format(const struct kunit_assert *assert,
+				    struct string_stream *stream)
+{
+	struct kunit_binary_str_assert *binary_assert = container_of(
+			assert, struct kunit_binary_str_assert, assert);
+
+	kunit_base_assert_format(assert, stream);
+	string_stream_add(stream,
+			 "\tExpected %s %s %s, but\n",
+			 binary_assert->left_text,
+			 binary_assert->operation,
+			 binary_assert->right_text);
+	string_stream_add(stream, "\t\t%s == %s\n",
+			 binary_assert->left_text,
+			 binary_assert->left_value);
+	string_stream_add(stream, "\t\t%s == %s",
+			 binary_assert->right_text,
+			 binary_assert->right_value);
+	kunit_assert_print_msg(assert, stream);
+}
diff --git a/lib/kunit/example-test.c b/lib/kunit/example-test.c
new file mode 100644
index 000000000000..f64a829aa441
--- /dev/null
+++ b/lib/kunit/example-test.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test to show how to use KUnit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+
+/*
+ * This is the most fundamental element of KUnit, the test case. A test case
+ * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
+ * any expectations or assertions are not met, the test fails; otherwise, the
+ * test passes.
+ *
+ * In KUnit, a test case is just a function with the signature
+ * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
+ * information about the current test.
+ */
+static void example_simple_test(struct kunit *test)
+{
+	/*
+	 * This is an EXPECTATION; it is how KUnit tests things. When you want
+	 * to test a piece of code, you set some expectations about what the
+	 * code should do. KUnit then runs the test and verifies that the code's
+	 * behavior matched what was expected.
+	 */
+	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+}
+
+/*
+ * This is run once before each test case, see the comment on
+ * example_test_suite for more information.
+ */
+static int example_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing\n");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test suite
+ * below.
+ */
+static struct kunit_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test suite.
+	 */
+	KUNIT_CASE(example_simple_test),
+	{}
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `kunit_cases`.
+ *
+ * Often it is desirable to run some function which will set up things which
+ * will be used by every test; this is accomplished with an `init` function
+ * which runs before each test case is invoked. Similarly, an `exit` function
+ * may be specified which runs after every test case and can be used to for
+ * cleanup. For clarity, running tests in a test suite would behave as follows:
+ *
+ * suite.init(test);
+ * suite.test_case[0](test);
+ * suite.exit(test);
+ * suite.init(test);
+ * suite.test_case[1](test);
+ * suite.exit(test);
+ * ...;
+ */
+static struct kunit_suite example_test_suite = {
+	.name = "example",
+	.init = example_test_init,
+	.test_cases = example_test_cases,
+};
+
+/*
+ * This registers the above test suite telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+kunit_test_suite(example_test_suite);
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
new file mode 100644
index 000000000000..76cc05eb00ed
--- /dev/null
+++ b/lib/kunit/string-stream-test.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct string_stream.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/string-stream.h>
+#include <kunit/test.h>
+#include <linux/slab.h>
+
+static void string_stream_test_empty_on_creation(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_not_empty_after_add(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+
+	string_stream_add(stream, "Foo");
+
+	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_get_string(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	char *output;
+
+	string_stream_add(stream, "Foo");
+	string_stream_add(stream, " %s", "bar");
+
+	output = string_stream_get_string(stream);
+	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
+}
+
+static struct kunit_case string_stream_test_cases[] = {
+	KUNIT_CASE(string_stream_test_empty_on_creation),
+	KUNIT_CASE(string_stream_test_not_empty_after_add),
+	KUNIT_CASE(string_stream_test_get_string),
+	{}
+};
+
+static struct kunit_suite string_stream_test_suite = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+kunit_test_suite(string_stream_test_suite);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
new file mode 100644
index 000000000000..e6d17aacca30
--- /dev/null
+++ b/lib/kunit/string-stream.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/string-stream.h>
+#include <kunit/test.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+struct string_stream_fragment_alloc_context {
+	struct kunit *test;
+	int len;
+	gfp_t gfp;
+};
+
+static int string_stream_fragment_init(struct kunit_resource *res,
+				       void *context)
+{
+	struct string_stream_fragment_alloc_context *ctx = context;
+	struct string_stream_fragment *frag;
+
+	frag = kunit_kzalloc(ctx->test, sizeof(*frag), ctx->gfp);
+	if (!frag)
+		return -ENOMEM;
+
+	frag->test = ctx->test;
+	frag->fragment = kunit_kmalloc(ctx->test, ctx->len, ctx->gfp);
+	if (!frag->fragment)
+		return -ENOMEM;
+
+	res->allocation = frag;
+
+	return 0;
+}
+
+static void string_stream_fragment_free(struct kunit_resource *res)
+{
+	struct string_stream_fragment *frag = res->allocation;
+
+	list_del(&frag->node);
+	kunit_kfree(frag->test, frag->fragment);
+	kunit_kfree(frag->test, frag);
+}
+
+static struct string_stream_fragment *alloc_string_stream_fragment(
+		struct kunit *test, int len, gfp_t gfp)
+{
+	struct string_stream_fragment_alloc_context context = {
+		.test = test,
+		.len = len,
+		.gfp = gfp
+	};
+
+	return kunit_alloc_resource(test,
+				    string_stream_fragment_init,
+				    string_stream_fragment_free,
+				    gfp,
+				    &context);
+}
+
+static int string_stream_fragment_destroy(struct string_stream_fragment *frag)
+{
+	return kunit_resource_destroy(frag->test,
+				      kunit_resource_instance_match,
+				      string_stream_fragment_free,
+				      frag);
+}
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args)
+{
+	struct string_stream_fragment *frag_container;
+	int len;
+	va_list args_for_counting;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	frag_container = alloc_string_stream_fragment(stream->test,
+						      len,
+						      stream->gfp);
+	if (!frag_container)
+		return -ENOMEM;
+
+	len = vsnprintf(frag_container->fragment, len, fmt, args);
+	spin_lock(&stream->lock);
+	stream->length += len;
+	list_add_tail(&frag_container->node, &stream->fragments);
+	spin_unlock(&stream->lock);
+
+	return 0;
+}
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(stream, fmt, args);
+	va_end(args);
+
+	return result;
+}
+
+static void string_stream_clear(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container, *frag_container_safe;
+
+	spin_lock(&stream->lock);
+	list_for_each_entry_safe(frag_container,
+				 frag_container_safe,
+				 &stream->fragments,
+				 node) {
+		string_stream_fragment_destroy(frag_container);
+	}
+	stream->length = 0;
+	spin_unlock(&stream->lock);
+}
+
+char *string_stream_get_string(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container;
+	size_t buf_len = stream->length + 1; /* +1 for null byte. */
+	char *buf;
+
+	buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
+	if (!buf)
+		return NULL;
+
+	spin_lock(&stream->lock);
+	list_for_each_entry(frag_container, &stream->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock(&stream->lock);
+
+	return buf;
+}
+
+int string_stream_append(struct string_stream *stream,
+			 struct string_stream *other)
+{
+	const char *other_content;
+
+	other_content = string_stream_get_string(other);
+
+	if (!other_content)
+		return -ENOMEM;
+
+	return string_stream_add(stream, other_content);
+}
+
+bool string_stream_is_empty(struct string_stream *stream)
+{
+	return list_empty(&stream->fragments);
+}
+
+struct string_stream_alloc_context {
+	struct kunit *test;
+	gfp_t gfp;
+};
+
+static int string_stream_init(struct kunit_resource *res, void *context)
+{
+	struct string_stream *stream;
+	struct string_stream_alloc_context *ctx = context;
+
+	stream = kunit_kzalloc(ctx->test, sizeof(*stream), ctx->gfp);
+	if (!stream)
+		return -ENOMEM;
+
+	res->allocation = stream;
+	stream->gfp = ctx->gfp;
+	stream->test = ctx->test;
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+
+	return 0;
+}
+
+static void string_stream_free(struct kunit_resource *res)
+{
+	struct string_stream *stream = res->allocation;
+
+	string_stream_clear(stream);
+}
+
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
+{
+	struct string_stream_alloc_context context = {
+		.test = test,
+		.gfp = gfp
+	};
+
+	return kunit_alloc_resource(test,
+				    string_stream_init,
+				    string_stream_free,
+				    gfp,
+				    &context);
+}
+
+int string_stream_destroy(struct string_stream *stream)
+{
+	return kunit_resource_destroy(stream->test,
+				      kunit_resource_instance_match,
+				      string_stream_free,
+				      stream);
+}
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
new file mode 100644
index 000000000000..5ebe059d16e2
--- /dev/null
+++ b/lib/kunit/test-test.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+static void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+static void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	{}
+};
+
+static struct kunit_suite kunit_try_catch_test_suite = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+kunit_test_suite(kunit_try_catch_test_suite);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+	int allocate_order[2];
+	int free_order[2];
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_and_get_resource(&ctx->test,
+					   fake_resource_init,
+					   fake_resource_free,
+					   GFP_KERNEL,
+					   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized,
+			    (bool *) res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_destroy_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	KUNIT_ASSERT_FALSE(test,
+			   kunit_resource_destroy(&ctx->test,
+						  kunit_resource_instance_match,
+						  res->free,
+						  res->allocation));
+
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[5];
+
+	for (i = 0; i < ARRAY_SIZE(resources); i++) {
+		resources[i] = kunit_alloc_and_get_resource(&ctx->test,
+							    fake_resource_init,
+							    fake_resource_free,
+							    GFP_KERNEL,
+							    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_mark_order(int order_array[],
+					   size_t order_size,
+					   int key)
+{
+	int i;
+
+	for (i = 0; i < order_size && order_array[i]; i++)
+		;
+
+	order_array[i] = key;
+}
+
+#define KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, order_field, key)		       \
+		kunit_resource_test_mark_order(ctx->order_field,	       \
+					       ARRAY_SIZE(ctx->order_field),   \
+					       key)
+
+static int fake_resource_2_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_2_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
+}
+
+static int fake_resource_1_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_2_init,
+				     fake_resource_2_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_1_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
+}
+
+/*
+ * TODO(brendanhiggins@google.com): replace the arrays that keep track of the
+ * order of allocation and freeing with strict mocks using the IN_SEQUENCE macro
+ * to assert allocation and freeing order when the feature becomes available.
+ */
+static void kunit_resource_test_proper_free_ordering(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	/* fake_resource_1 allocates a fake_resource_2 in its init. */
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_1_init,
+				     fake_resource_1_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	/*
+	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
+	 * before returning to fake_resource_1_init, it should be the first to
+	 * put its key in the allocate_order array.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
+
+	kunit_cleanup(&ctx->test);
+
+	/*
+	 * Because fake_resource_2 finishes allocation before fake_resource_1,
+	 * fake_resource_1 should be freed first since it could depend on
+	 * fake_resource_2.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 1);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
+	{}
+};
+
+static struct kunit_suite kunit_resource_test_suite = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+kunit_test_suite(kunit_resource_test_suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
new file mode 100644
index 000000000000..c83c0fa59cbd
--- /dev/null
+++ b/lib/kunit/test.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/try-catch.h>
+#include <linux/kernel.h>
+#include <linux/sched/debug.h>
+
+static void kunit_set_failure(struct kunit *test)
+{
+	WRITE_ONCE(test->success, false);
+}
+
+static void kunit_print_tap_version(void)
+{
+	static bool kunit_has_printed_tap_version;
+
+	if (!kunit_has_printed_tap_version) {
+		pr_info("TAP version 14\n");
+		kunit_has_printed_tap_version = true;
+	}
+}
+
+static size_t kunit_test_cases_len(struct kunit_case *test_cases)
+{
+	struct kunit_case *test_case;
+	size_t len = 0;
+
+	for (test_case = test_cases; test_case->run_case; test_case++)
+		len++;
+
+	return len;
+}
+
+static void kunit_print_subtest_start(struct kunit_suite *suite)
+{
+	kunit_print_tap_version();
+	pr_info("\t# Subtest: %s\n", suite->name);
+	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
+}
+
+static void kunit_print_ok_not_ok(bool should_indent,
+				  bool is_ok,
+				  size_t test_number,
+				  const char *description)
+{
+	const char *indent, *ok_not_ok;
+
+	if (should_indent)
+		indent = "\t";
+	else
+		indent = "";
+
+	if (is_ok)
+		ok_not_ok = "ok";
+	else
+		ok_not_ok = "not ok";
+
+	pr_info("%s%s %zd - %s\n", indent, ok_not_ok, test_number, description);
+}
+
+static bool kunit_suite_has_succeeded(struct kunit_suite *suite)
+{
+	const struct kunit_case *test_case;
+
+	for (test_case = suite->test_cases; test_case->run_case; test_case++)
+		if (!test_case->success)
+			return false;
+
+	return true;
+}
+
+static void kunit_print_subtest_end(struct kunit_suite *suite)
+{
+	static size_t kunit_suite_counter = 1;
+
+	kunit_print_ok_not_ok(false,
+			      kunit_suite_has_succeeded(suite),
+			      kunit_suite_counter++,
+			      suite->name);
+}
+
+static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
+					    size_t test_number)
+{
+	kunit_print_ok_not_ok(true,
+			      test_case->success,
+			      test_number,
+			      test_case->name);
+}
+
+static void kunit_print_string_stream(struct kunit *test,
+				      struct string_stream *stream)
+{
+	struct string_stream_fragment *fragment;
+	char *buf;
+
+	buf = string_stream_get_string(stream);
+	if (!buf) {
+		kunit_err(test,
+			  "Could not allocate buffer, dumping stream:\n");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			kunit_err(test, "%s", fragment->fragment);
+		}
+		kunit_err(test, "\n");
+	} else {
+		kunit_err(test, "%s", buf);
+		kunit_kfree(test, buf);
+	}
+}
+
+static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
+{
+	struct string_stream *stream;
+
+	kunit_set_failure(test);
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	if (!stream) {
+		WARN(true,
+		     "Could not allocate stream to print failed assertion in %s:%d\n",
+		     assert->file,
+		     assert->line);
+		return;
+	}
+
+	assert->format(assert, stream);
+
+	kunit_print_string_stream(test, stream);
+
+	WARN_ON(string_stream_destroy(stream));
+}
+
+static void __noreturn kunit_abort(struct kunit *test)
+{
+	kunit_try_catch_throw(&test->try_catch); /* Does not return. */
+
+	/*
+	 * Throw could not abort from test.
+	 *
+	 * XXX: we should never reach this line! As kunit_try_catch_throw is
+	 * marked __noreturn.
+	 */
+	WARN_ONCE(true, "Throw could not abort from test!\n");
+}
+
+void kunit_do_assertion(struct kunit *test,
+			struct kunit_assert *assert,
+			bool pass,
+			const char *fmt, ...)
+{
+	va_list args;
+
+	if (pass)
+		return;
+
+	va_start(args, fmt);
+
+	assert->message.fmt = fmt;
+	assert->message.va = &args;
+
+	kunit_fail(test, assert);
+
+	va_end(args);
+
+	if (assert->type == KUNIT_ASSERTION)
+		kunit_abort(test);
+}
+
+void kunit_init_test(struct kunit *test, const char *name)
+{
+	spin_lock_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
+	test->name = name;
+	test->success = true;
+}
+
+/*
+ * Initializes and runs test case. Does not clean up or do post validations.
+ */
+static void kunit_run_case_internal(struct kunit *test,
+				    struct kunit_suite *suite,
+				    struct kunit_case *test_case)
+{
+	if (suite->init) {
+		int ret;
+
+		ret = suite->init(test);
+		if (ret) {
+			kunit_err(test, "failed to initialize: %d\n", ret);
+			kunit_set_failure(test);
+			return;
+		}
+	}
+
+	test_case->run_case(test);
+}
+
+static void kunit_case_internal_cleanup(struct kunit *test)
+{
+	kunit_cleanup(test);
+}
+
+/*
+ * Performs post validations and cleanup after a test case was run.
+ * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
+ */
+static void kunit_run_case_cleanup(struct kunit *test,
+				   struct kunit_suite *suite)
+{
+	if (suite->exit)
+		suite->exit(test);
+
+	kunit_case_internal_cleanup(test);
+}
+
+struct kunit_try_catch_context {
+	struct kunit *test;
+	struct kunit_suite *suite;
+	struct kunit_case *test_case;
+};
+
+static void kunit_try_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+	struct kunit_case *test_case = ctx->test_case;
+
+	/*
+	 * kunit_run_case_internal may encounter a fatal error; if it does,
+	 * abort will be called, this thread will exit, and finally the parent
+	 * thread will resume control and handle any necessary clean up.
+	 */
+	kunit_run_case_internal(test, suite, test_case);
+	/* This line may never be reached. */
+	kunit_run_case_cleanup(test, suite);
+}
+
+static void kunit_catch_run_case(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
+
+	if (try_exit_code) {
+		kunit_set_failure(test);
+		/*
+		 * Test case could not finish, we have no idea what state it is
+		 * in, so don't do clean up.
+		 */
+		if (try_exit_code == -ETIMEDOUT) {
+			kunit_err(test, "test case timed out\n");
+		/*
+		 * Unknown internal error occurred preventing test case from
+		 * running, so there is nothing to clean up.
+		 */
+		} else {
+			kunit_err(test, "internal error occurred preventing test case from running: %d\n",
+				  try_exit_code);
+		}
+		return;
+	}
+
+	/*
+	 * Test case was run, but aborted. It is the test case's business as to
+	 * whether it failed or not, we just need to clean up.
+	 */
+	kunit_run_case_cleanup(test, suite);
+}
+
+/*
+ * Performs all logic to run a test case. It also catches most errors that
+ * occur in a test case and reports them as failures.
+ */
+static void kunit_run_case_catch_errors(struct kunit_suite *suite,
+					struct kunit_case *test_case)
+{
+	struct kunit_try_catch_context context;
+	struct kunit_try_catch *try_catch;
+	struct kunit test;
+
+	kunit_init_test(&test, test_case->name);
+	try_catch = &test.try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     &test,
+			     kunit_try_run_case,
+			     kunit_catch_run_case);
+	context.test = &test;
+	context.suite = suite;
+	context.test_case = test_case;
+	kunit_try_catch_run(try_catch, &context);
+
+	test_case->success = test.success;
+}
+
+int kunit_run_tests(struct kunit_suite *suite)
+{
+	struct kunit_case *test_case;
+	size_t test_case_count = 1;
+
+	kunit_print_subtest_start(suite);
+
+	for (test_case = suite->test_cases; test_case->run_case; test_case++) {
+		kunit_run_case_catch_errors(suite, test_case);
+		kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
+	}
+
+	kunit_print_subtest_end(suite);
+
+	return 0;
+}
+
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *context)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	ret = init(res, context);
+	if (ret)
+		return NULL;
+
+	res->free = free;
+	spin_lock(&test->lock);
+	list_add_tail(&res->node, &test->resources);
+	spin_unlock(&test->lock);
+
+	return res;
+}
+
+static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
+{
+	res->free(res);
+	kfree(res);
+}
+
+static struct kunit_resource *kunit_resource_find(struct kunit *test,
+						  kunit_resource_match_t match,
+						  kunit_resource_free_t free,
+						  void *match_data)
+{
+	struct kunit_resource *resource;
+
+	lockdep_assert_held(&test->lock);
+
+	list_for_each_entry_reverse(resource, &test->resources, node) {
+		if (resource->free != free)
+			continue;
+		if (match(test, resource->allocation, match_data))
+			return resource;
+	}
+
+	return NULL;
+}
+
+static struct kunit_resource *kunit_resource_remove(
+		struct kunit *test,
+		kunit_resource_match_t match,
+		kunit_resource_free_t free,
+		void *match_data)
+{
+	struct kunit_resource *resource;
+
+	spin_lock(&test->lock);
+	resource = kunit_resource_find(test, match, free, match_data);
+	if (resource)
+		list_del(&resource->node);
+	spin_unlock(&test->lock);
+
+	return resource;
+}
+
+int kunit_resource_destroy(struct kunit *test,
+			   kunit_resource_match_t match,
+			   kunit_resource_free_t free,
+			   void *match_data)
+{
+	struct kunit_resource *resource;
+
+	resource = kunit_resource_remove(test, match, free, match_data);
+
+	if (!resource)
+		return -ENOENT;
+
+	kunit_resource_free(test, resource);
+	return 0;
+}
+
+struct kunit_kmalloc_params {
+	size_t size;
+	gfp_t gfp;
+};
+
+static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_kmalloc_params *params = context;
+
+	res->allocation = kmalloc(params->size, params->gfp);
+	if (!res->allocation)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void kunit_kmalloc_free(struct kunit_resource *res)
+{
+	kfree(res->allocation);
+}
+
+void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+{
+	struct kunit_kmalloc_params params = {
+		.size = size,
+		.gfp = gfp
+	};
+
+	return kunit_alloc_resource(test,
+				    kunit_kmalloc_init,
+				    kunit_kmalloc_free,
+				    gfp,
+				    &params);
+}
+
+void kunit_kfree(struct kunit *test, const void *ptr)
+{
+	int rc;
+
+	rc = kunit_resource_destroy(test,
+				    kunit_resource_instance_match,
+				    kunit_kmalloc_free,
+				    (void *)ptr);
+
+	WARN_ON(rc);
+}
+
+void kunit_cleanup(struct kunit *test)
+{
+	struct kunit_resource *resource;
+
+	/*
+	 * test->resources is a stack - each allocation must be freed in the
+	 * reverse order from which it was added since one resource may depend
+	 * on another for its entire lifetime.
+	 * Also, we cannot use the normal list_for_each constructs, even the
+	 * safe ones because *arbitrary* nodes may be deleted when
+	 * kunit_resource_free is called; the list_for_each_safe variants only
+	 * protect against the current node being deleted, not the next.
+	 */
+	while (true) {
+		spin_lock(&test->lock);
+		if (list_empty(&test->resources)) {
+			spin_unlock(&test->lock);
+			break;
+		}
+		resource = list_last_entry(&test->resources,
+					   struct kunit_resource,
+					   node);
+		list_del(&resource->node);
+		spin_unlock(&test->lock);
+
+		kunit_resource_free(test, resource);
+	}
+}
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
new file mode 100644
index 000000000000..55686839eb61
--- /dev/null
+++ b/lib/kunit/try-catch.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/try-catch.h>
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/sched/sysctl.h>
+
+void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
+{
+	try_catch->try_result = -EFAULT;
+	complete_and_exit(try_catch->try_completion, -EFAULT);
+}
+
+static int kunit_generic_run_threadfn_adapter(void *data)
+{
+	struct kunit_try_catch *try_catch = data;
+
+	try_catch->try(try_catch->context);
+
+	complete_and_exit(try_catch->try_completion, 0);
+}
+
+static unsigned long kunit_test_timeout(void)
+{
+	unsigned long timeout_msecs;
+
+	/*
+	 * TODO(brendanhiggins@google.com): We should probably have some type of
+	 * variable timeout here. The only question is what that timeout value
+	 * should be.
+	 *
+	 * The intention has always been, at some point, to be able to label
+	 * tests with some type of size bucket (unit/small, integration/medium,
+	 * large/system/end-to-end, etc), where each size bucket would get a
+	 * default timeout value kind of like what Bazel does:
+	 * https://docs.bazel.build/versions/master/be/common-definitions.html#test.size
+	 * There is still some debate to be had on exactly how we do this. (For
+	 * one, we probably want to have some sort of test runner level
+	 * timeout.)
+	 *
+	 * For more background on this topic, see:
+	 * https://mike-bland.com/2011/11/01/small-medium-large.html
+	 */
+	if (sysctl_hung_task_timeout_secs) {
+		/*
+		 * If sysctl_hung_task is active, just set the timeout to some
+		 * value less than that.
+		 *
+		 * In regards to the above TODO, if we decide on variable
+		 * timeouts, this logic will likely need to change.
+		 */
+		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
+				MSEC_PER_SEC;
+	} else {
+		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
+	}
+
+	return timeout_msecs;
+}
+
+void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
+{
+	DECLARE_COMPLETION_ONSTACK(try_completion);
+	struct kunit *test = try_catch->test;
+	struct task_struct *task_struct;
+	int exit_code, time_remaining;
+
+	try_catch->context = context;
+	try_catch->try_completion = &try_completion;
+	try_catch->try_result = 0;
+	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
+				  try_catch,
+				  "kunit_try_catch_thread");
+	if (IS_ERR(task_struct)) {
+		try_catch->catch(try_catch->context);
+		return;
+	}
+
+	time_remaining = wait_for_completion_timeout(&try_completion,
+						     kunit_test_timeout());
+	if (time_remaining == 0) {
+		kunit_err(test, "try timed out\n");
+		try_catch->try_result = -ETIMEDOUT;
+	}
+
+	exit_code = try_catch->try_result;
+
+	if (!exit_code)
+		return;
+
+	if (exit_code == -EFAULT)
+		try_catch->try_result = 0;
+	else if (exit_code == -EINTR)
+		kunit_err(test, "wake_up_process() was never called\n");
+	else if (exit_code)
+		kunit_err(test, "Unknown error: %d\n", exit_code);
+
+	try_catch->catch(try_catch->context);
+}
+
+void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+			  struct kunit *test,
+			  kunit_try_catch_func_t try,
+			  kunit_try_catch_func_t catch)
+{
+	try_catch->test = test;
+	try_catch->try = try;
+	try_catch->catch = catch;
+}
diff --git a/lib/list-test.c b/lib/list-test.c
new file mode 100644
index 000000000000..363c600491c3
--- /dev/null
+++ b/lib/list-test.c
@@ -0,0 +1,746 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the Kernel Linked-list structures.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+#include <kunit/test.h>
+
+#include <linux/list.h>
+
+struct list_test_struct {
+	int data;
+	struct list_head list;
+};
+
+static void list_test_list_init(struct kunit *test)
+{
+	/* Test the different ways of initialising a list. */
+	struct list_head list1 = LIST_HEAD_INIT(list1);
+	struct list_head list2;
+	LIST_HEAD(list3);
+	struct list_head *list4;
+	struct list_head *list5;
+
+	INIT_LIST_HEAD(&list2);
+
+	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	INIT_LIST_HEAD(list4);
+
+	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	memset(list5, 0xFF, sizeof(*list5));
+	INIT_LIST_HEAD(list5);
+
+	/* list_empty_careful() checks both next and prev. */
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list3));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(list4));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(list5));
+
+	kfree(list4);
+	kfree(list5);
+}
+
+static void list_test_list_add(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add(&a, &list);
+	list_add(&b, &list);
+
+	/* should be [list] -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
+}
+
+static void list_test_list_add_tail(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* should be [list] -> a -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &a);
+	KUNIT_EXPECT_PTR_EQ(test, a.prev, &list);
+	KUNIT_EXPECT_PTR_EQ(test, a.next, &b);
+}
+
+static void list_test_list_del(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del(&a);
+
+	/* now: [list] -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+}
+
+static void list_test_list_replace(struct kunit *test)
+{
+	struct list_head a_old, a_new, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a_old, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a_old -> b */
+	list_replace(&a_old, &a_new);
+
+	/* now: [list] -> a_new -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
+}
+
+static void list_test_list_replace_init(struct kunit *test)
+{
+	struct list_head a_old, a_new, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a_old, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a_old -> b */
+	list_replace_init(&a_old, &a_new);
+
+	/* now: [list] -> a_new -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
+
+	/* check a_old is empty (initialized) */
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a_old));
+}
+
+static void list_test_list_swap(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_swap(&a, &b);
+
+	/* after: [list] -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, &b, list.next);
+	KUNIT_EXPECT_PTR_EQ(test, &a, list.prev);
+
+	KUNIT_EXPECT_PTR_EQ(test, &a, b.next);
+	KUNIT_EXPECT_PTR_EQ(test, &list, b.prev);
+
+	KUNIT_EXPECT_PTR_EQ(test, &list, a.next);
+	KUNIT_EXPECT_PTR_EQ(test, &b, a.prev);
+}
+
+static void list_test_list_del_init(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del_init(&a);
+	/* after: [list] -> b, a initialised */
+
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
+}
+
+static void list_test_list_move(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+	list_add_tail(&b, &list2);
+
+	/* before: [list1] -> a, [list2] -> b */
+	list_move(&a, &list2);
+	/* after: [list1] empty, [list2] -> a -> b */
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&list1));
+
+	KUNIT_EXPECT_PTR_EQ(test, &a, list2.next);
+	KUNIT_EXPECT_PTR_EQ(test, &b, a.next);
+}
+
+static void list_test_list_move_tail(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+	list_add_tail(&b, &list2);
+
+	/* before: [list1] -> a, [list2] -> b */
+	list_move_tail(&a, &list2);
+	/* after: [list1] empty, [list2] -> b -> a */
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&list1));
+
+	KUNIT_EXPECT_PTR_EQ(test, &b, list2.next);
+	KUNIT_EXPECT_PTR_EQ(test, &a, b.next);
+}
+
+static void list_test_list_bulk_move_tail(struct kunit *test)
+{
+	struct list_head a, b, c, d, x, y;
+	struct list_head *list1_values[] = { &x, &b, &c, &y };
+	struct list_head *list2_values[] = { &a, &d };
+	struct list_head *ptr;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&x, &list1);
+	list_add_tail(&y, &list1);
+
+	list_add_tail(&a, &list2);
+	list_add_tail(&b, &list2);
+	list_add_tail(&c, &list2);
+	list_add_tail(&d, &list2);
+
+	/* before: [list1] -> x -> y, [list2] -> a -> b -> c -> d */
+	list_bulk_move_tail(&y, &b, &c);
+	/* after: [list1] -> x -> b -> c -> y, [list2] -> a -> d */
+
+	list_for_each(ptr, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, ptr, list1_values[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 4);
+	i = 0;
+	list_for_each(ptr, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, ptr, list2_values[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 2);
+}
+
+static void list_test_list_is_first(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	KUNIT_EXPECT_TRUE(test, list_is_first(&a, &list));
+	KUNIT_EXPECT_FALSE(test, list_is_first(&b, &list));
+}
+
+static void list_test_list_is_last(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	KUNIT_EXPECT_FALSE(test, list_is_last(&a, &list));
+	KUNIT_EXPECT_TRUE(test, list_is_last(&b, &list));
+}
+
+static void list_test_list_empty(struct kunit *test)
+{
+	struct list_head a;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+
+	KUNIT_EXPECT_FALSE(test, list_empty(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty(&list2));
+}
+
+static void list_test_list_empty_careful(struct kunit *test)
+{
+	/* This test doesn't check correctness under concurrent access */
+	struct list_head a;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+
+	KUNIT_EXPECT_FALSE(test, list_empty_careful(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+}
+
+static void list_test_list_rotate_left(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_rotate_left(&list);
+	/* after: [list] -> b -> a */
+
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
+}
+
+static void list_test_list_rotate_to_front(struct kunit *test)
+{
+	struct list_head a, b, c, d;
+	struct list_head *list_values[] = { &c, &d, &a, &b };
+	struct list_head *ptr;
+	LIST_HEAD(list);
+	int i = 0;
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+	list_add_tail(&c, &list);
+	list_add_tail(&d, &list);
+
+	/* before: [list] -> a -> b -> c -> d */
+	list_rotate_to_front(&c, &list);
+	/* after: [list] -> c -> d -> a -> b */
+
+	list_for_each(ptr, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, ptr, list_values[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 4);
+}
+
+static void list_test_list_is_singular(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	/* [list] empty */
+	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
+
+	list_add_tail(&a, &list);
+
+	/* [list] -> a */
+	KUNIT_EXPECT_TRUE(test, list_is_singular(&list));
+
+	list_add_tail(&b, &list);
+
+	/* [list] -> a -> b */
+	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
+}
+
+static void list_test_list_cut_position(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list1);
+
+	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
+	list_cut_position(&list2, &list1, &entries[1]);
+	/* after: [list2] -> entries[0] -> entries[1], [list1] -> entries[2] */
+
+	list_for_each(cur, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 2);
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+}
+
+static void list_test_list_cut_before(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list1);
+
+	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
+	list_cut_before(&list2, &list1, &entries[1]);
+	/* after: [list2] -> entries[0], [list1] -> entries[1] -> entries[2] */
+
+	list_for_each(cur, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 1);
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+}
+
+static void list_test_list_splice(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice(&list2, &entries[1]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] uninit */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void list_test_list_splice_tail(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice_tail(&list2, &entries[4]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] uninit */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void list_test_list_splice_init(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice_init(&list2, &entries[1]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] empty */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+}
+
+static void list_test_list_splice_tail_init(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice_tail_init(&list2, &entries[4]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] empty */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+}
+
+static void list_test_list_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list),
+				struct list_test_struct, list));
+}
+
+static void list_test_list_first_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list,
+				struct list_test_struct, list));
+}
+
+static void list_test_list_last_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_last_entry(&list,
+				struct list_test_struct, list));
+}
+
+static void list_test_list_first_entry_or_null(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	KUNIT_EXPECT_FALSE(test, list_first_entry_or_null(&list,
+				struct list_test_struct, list));
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1,
+			list_first_entry_or_null(&list,
+				struct list_test_struct, list));
+}
+
+static void list_test_list_next_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_next_entry(&test_struct1,
+				list));
+}
+
+static void list_test_list_prev_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_prev_entry(&test_struct2,
+				list));
+}
+
+static void list_test_list_for_each(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each(cur, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+}
+
+static void list_test_list_for_each_prev(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list);
+	int i = 2;
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each_prev(cur, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i--;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, -1);
+}
+
+static void list_test_list_for_each_safe(struct kunit *test)
+{
+	struct list_head entries[3], *cur, *n;
+	LIST_HEAD(list);
+	int i = 0;
+
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each_safe(cur, n, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		list_del(&entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+	KUNIT_EXPECT_TRUE(test, list_empty(&list));
+}
+
+static void list_test_list_for_each_prev_safe(struct kunit *test)
+{
+	struct list_head entries[3], *cur, *n;
+	LIST_HEAD(list);
+	int i = 2;
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each_prev_safe(cur, n, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		list_del(&entries[i]);
+		i--;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, -1);
+	KUNIT_EXPECT_TRUE(test, list_empty(&list));
+}
+
+static void list_test_list_for_each_entry(struct kunit *test)
+{
+	struct list_test_struct entries[5], *cur;
+	static LIST_HEAD(list);
+	int i = 0;
+
+	for (i = 0; i < 5; ++i) {
+		entries[i].data = i;
+		list_add_tail(&entries[i].list, &list);
+	}
+
+	i = 0;
+
+	list_for_each_entry(cur, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void list_test_list_for_each_entry_reverse(struct kunit *test)
+{
+	struct list_test_struct entries[5], *cur;
+	static LIST_HEAD(list);
+	int i = 0;
+
+	for (i = 0; i < 5; ++i) {
+		entries[i].data = i;
+		list_add_tail(&entries[i].list, &list);
+	}
+
+	i = 4;
+
+	list_for_each_entry_reverse(cur, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		i--;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, -1);
+}
+
+static struct kunit_case list_test_cases[] = {
+	KUNIT_CASE(list_test_list_init),
+	KUNIT_CASE(list_test_list_add),
+	KUNIT_CASE(list_test_list_add_tail),
+	KUNIT_CASE(list_test_list_del),
+	KUNIT_CASE(list_test_list_replace),
+	KUNIT_CASE(list_test_list_replace_init),
+	KUNIT_CASE(list_test_list_swap),
+	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_move),
+	KUNIT_CASE(list_test_list_move_tail),
+	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_first),
+	KUNIT_CASE(list_test_list_is_last),
+	KUNIT_CASE(list_test_list_empty),
+	KUNIT_CASE(list_test_list_empty_careful),
+	KUNIT_CASE(list_test_list_rotate_left),
+	KUNIT_CASE(list_test_list_rotate_to_front),
+	KUNIT_CASE(list_test_list_is_singular),
+	KUNIT_CASE(list_test_list_cut_position),
+	KUNIT_CASE(list_test_list_cut_before),
+	KUNIT_CASE(list_test_list_splice),
+	KUNIT_CASE(list_test_list_splice_tail),
+	KUNIT_CASE(list_test_list_splice_init),
+	KUNIT_CASE(list_test_list_splice_tail_init),
+	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_first_entry),
+	KUNIT_CASE(list_test_list_last_entry),
+	KUNIT_CASE(list_test_list_first_entry_or_null),
+	KUNIT_CASE(list_test_list_next_entry),
+	KUNIT_CASE(list_test_list_prev_entry),
+	KUNIT_CASE(list_test_list_for_each),
+	KUNIT_CASE(list_test_list_for_each_prev),
+	KUNIT_CASE(list_test_list_for_each_safe),
+	KUNIT_CASE(list_test_list_for_each_prev_safe),
+	KUNIT_CASE(list_test_list_for_each_entry),
+	KUNIT_CASE(list_test_list_for_each_entry_reverse),
+	{},
+};
+
+static struct kunit_suite list_test_module = {
+	.name = "list-kunit-test",
+	.test_cases = list_test_cases,
+};
+
+kunit_test_suite(list_test_module);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 044c9a3cb247..543c068096b1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -144,6 +144,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (!func)
diff --git a/tools/testing/kunit/.gitignore b/tools/testing/kunit/.gitignore
new file mode 100644
index 000000000000..c791ff59a37a
--- /dev/null
+++ b/tools/testing/kunit/.gitignore
@@ -0,0 +1,3 @@
+# Byte-compiled / optimized / DLL files
+__pycache__/
+*.py[cod]
\ No newline at end of file
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
new file mode 100755
index 000000000000..efe06d621983
--- /dev/null
+++ b/tools/testing/kunit/kunit.py
@@ -0,0 +1,138 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# A thin wrapper on top of the KUnit Kernel
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import argparse
+import sys
+import os
+import time
+import shutil
+
+from collections import namedtuple
+from enum import Enum, auto
+
+import kunit_config
+import kunit_kernel
+import kunit_parser
+
+KunitResult = namedtuple('KunitResult', ['status','result'])
+
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
+
+class KunitStatus(Enum):
+	SUCCESS = auto()
+	CONFIG_FAILURE = auto()
+	BUILD_FAILURE = auto()
+	TEST_FAILURE = auto()
+
+def create_default_kunitconfig():
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+		shutil.copyfile('arch/um/configs/kunit_defconfig',
+				kunit_kernel.KUNITCONFIG_PATH)
+
+def run_tests(linux: kunit_kernel.LinuxSourceTree,
+	      request: KunitRequest) -> KunitResult:
+	if request.defconfig:
+		create_default_kunitconfig()
+
+	config_start = time.time()
+	success = linux.build_reconfig(request.build_dir)
+	config_end = time.time()
+	if not success:
+		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
+
+	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+
+	build_start = time.time()
+	success = linux.build_um_kernel(request.jobs, request.build_dir)
+	build_end = time.time()
+	if not success:
+		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+
+	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
+	test_start = time.time()
+
+	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
+					      [],
+					      'Tests not Parsed.')
+	if request.raw_output:
+		kunit_parser.raw_output(
+			linux.run_kernel(timeout=request.timeout,
+					 build_dir=request.build_dir))
+	else:
+		kunit_output = linux.run_kernel(timeout=request.timeout,
+						build_dir=request.build_dir)
+		test_result = kunit_parser.parse_run_tests(kunit_output)
+	test_end = time.time()
+
+	kunit_parser.print_with_timestamp((
+		'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
+		'building, %.3fs running\n') % (
+				test_end - config_start,
+				config_end - config_start,
+				build_end - build_start,
+				test_end - test_start))
+
+	if test_result.status != kunit_parser.TestStatus.SUCCESS:
+		return KunitResult(KunitStatus.TEST_FAILURE, test_result)
+	else:
+		return KunitResult(KunitStatus.SUCCESS, test_result)
+
+def main(argv, linux=None):
+	parser = argparse.ArgumentParser(
+			description='Helps writing and running KUnit tests.')
+	subparser = parser.add_subparsers(dest='subcommand')
+
+	run_parser = subparser.add_parser('run', help='Runs KUnit tests.')
+	run_parser.add_argument('--raw_output', help='don\'t format output from kernel',
+				action='store_true')
+
+	run_parser.add_argument('--timeout',
+				help='maximum number of seconds to allow for all tests '
+				'to run. This does not include time taken to build the '
+				'tests.',
+				type=int,
+				default=300,
+				metavar='timeout')
+
+	run_parser.add_argument('--jobs',
+				help='As in the make command, "Specifies  the number of '
+				'jobs (commands) to run simultaneously."',
+				type=int, default=8, metavar='jobs')
+
+	run_parser.add_argument('--build_dir',
+				help='As in the make command, it specifies the build '
+				'directory.',
+				type=str, default=None, metavar='build_dir')
+
+	run_parser.add_argument('--defconfig',
+				help='Uses a default kunitconfig.',
+				action='store_true')
+
+	cli_args = parser.parse_args(argv)
+
+	if cli_args.subcommand == 'run':
+		if cli_args.defconfig:
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		request = KunitRequest(cli_args.raw_output,
+				       cli_args.timeout,
+				       cli_args.jobs,
+				       cli_args.build_dir,
+				       cli_args.defconfig)
+		result = run_tests(linux, request)
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	else:
+		parser.print_help()
+
+if __name__ == '__main__':
+	main(sys.argv[1:])
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
new file mode 100644
index 000000000000..ebf3942b23f5
--- /dev/null
+++ b/tools/testing/kunit/kunit_config.py
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Builds a .config from a kunitconfig.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import collections
+import re
+
+CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_\w+ is not set$'
+CONFIG_PATTERN = r'^CONFIG_\w+=\S+$'
+
+KconfigEntryBase = collections.namedtuple('KconfigEntry', ['raw_entry'])
+
+
+class KconfigEntry(KconfigEntryBase):
+
+	def __str__(self) -> str:
+		return self.raw_entry
+
+
+class KconfigParseError(Exception):
+	"""Error parsing Kconfig defconfig or .config."""
+
+
+class Kconfig(object):
+	"""Represents defconfig or .config specified using the Kconfig language."""
+
+	def __init__(self):
+		self._entries = []
+
+	def entries(self):
+		return set(self._entries)
+
+	def add_entry(self, entry: KconfigEntry) -> None:
+		self._entries.append(entry)
+
+	def is_subset_of(self, other: 'Kconfig') -> bool:
+		return self.entries().issubset(other.entries())
+
+	def write_to_file(self, path: str) -> None:
+		with open(path, 'w') as f:
+			for entry in self.entries():
+				f.write(str(entry) + '\n')
+
+	def parse_from_string(self, blob: str) -> None:
+		"""Parses a string containing KconfigEntrys and populates this Kconfig."""
+		self._entries = []
+		is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
+		config_matcher = re.compile(CONFIG_PATTERN)
+		for line in blob.split('\n'):
+			line = line.strip()
+			if not line:
+				continue
+			elif config_matcher.match(line) or is_not_set_matcher.match(line):
+				self._entries.append(KconfigEntry(line))
+			elif line[0] == '#':
+				continue
+			else:
+				raise KconfigParseError('Failed to parse: ' + line)
+
+	def read_from_file(self, path: str) -> None:
+		with open(path, 'r') as f:
+			self.parse_from_string(f.read())
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
new file mode 100644
index 000000000000..bf3876835331
--- /dev/null
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Runs UML kernel, collects output, and handles errors.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+
+import logging
+import subprocess
+import os
+
+import kunit_config
+
+KCONFIG_PATH = '.config'
+KUNITCONFIG_PATH = 'kunitconfig'
+
+class ConfigError(Exception):
+	"""Represents an error trying to configure the Linux kernel."""
+
+
+class BuildError(Exception):
+	"""Represents an error trying to build the Linux kernel."""
+
+
+class LinuxSourceTreeOperations(object):
+	"""An abstraction over command line operations performed on a source tree."""
+
+	def make_mrproper(self):
+		try:
+			subprocess.check_output(['make', 'mrproper'])
+		except OSError as e:
+			raise ConfigError('Could not call make command: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	def make_olddefconfig(self, build_dir):
+		command = ['make', 'ARCH=um', 'olddefconfig']
+		if build_dir:
+			command += ['O=' + build_dir]
+		try:
+			subprocess.check_output(command)
+		except OSError as e:
+			raise ConfigError('Could not call make command: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	def make(self, jobs, build_dir):
+		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		if build_dir:
+			command += ['O=' + build_dir]
+		try:
+			subprocess.check_output(command)
+		except OSError as e:
+			raise BuildError('Could not call execute make: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise BuildError(e.output)
+
+	def linux_bin(self, params, timeout, build_dir):
+		"""Runs the Linux UML binary. Must be named 'linux'."""
+		linux_bin = './linux'
+		if build_dir:
+			linux_bin = os.path.join(build_dir, 'linux')
+		process = subprocess.Popen(
+			[linux_bin] + params,
+			stdin=subprocess.PIPE,
+			stdout=subprocess.PIPE,
+			stderr=subprocess.PIPE)
+		process.wait(timeout=timeout)
+		return process
+
+
+def get_kconfig_path(build_dir):
+	kconfig_path = KCONFIG_PATH
+	if build_dir:
+		kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
+	return kconfig_path
+
+class LinuxSourceTree(object):
+	"""Represents a Linux kernel source tree with KUnit tests."""
+
+	def __init__(self):
+		self._kconfig = kunit_config.Kconfig()
+		self._kconfig.read_from_file(KUNITCONFIG_PATH)
+		self._ops = LinuxSourceTreeOperations()
+
+	def clean(self):
+		try:
+			self._ops.make_mrproper()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		return True
+
+	def build_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		if build_dir and not os.path.exists(build_dir):
+			os.mkdir(build_dir)
+		self._kconfig.write_to_file(kconfig_path)
+		try:
+			self._ops.make_olddefconfig(build_dir)
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			logging.error('Provided Kconfig is not contained in validated .config!')
+			return False
+		return True
+
+	def build_reconfig(self, build_dir):
+		"""Creates a new .config if it is not a subset of the kunitconfig."""
+		kconfig_path = get_kconfig_path(build_dir)
+		if os.path.exists(kconfig_path):
+			existing_kconfig = kunit_config.Kconfig()
+			existing_kconfig.read_from_file(kconfig_path)
+			if not self._kconfig.is_subset_of(existing_kconfig):
+				print('Regenerating .config ...')
+				os.remove(kconfig_path)
+				return self.build_config(build_dir)
+			else:
+				return True
+		else:
+			print('Generating .config ...')
+			return self.build_config(build_dir)
+
+	def build_um_kernel(self, jobs, build_dir):
+		try:
+			self._ops.make_olddefconfig(build_dir)
+			self._ops.make(jobs, build_dir)
+		except (ConfigError, BuildError) as e:
+			logging.error(e)
+			return False
+		used_kconfig = kunit_config.Kconfig()
+		used_kconfig.read_from_file(get_kconfig_path(build_dir))
+		if not self._kconfig.is_subset_of(used_kconfig):
+			logging.error('Provided Kconfig is not contained in final config!')
+			return False
+		return True
+
+	def run_kernel(self, args=[], timeout=None, build_dir=None):
+		args.extend(['mem=256M'])
+		process = self._ops.linux_bin(args, timeout, build_dir)
+		with open('test.log', 'w') as f:
+			for line in process.stdout:
+				f.write(line.rstrip().decode('ascii') + '\n')
+				yield line.rstrip().decode('ascii')
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
new file mode 100644
index 000000000000..4ffbae0f6732
--- /dev/null
+++ b/tools/testing/kunit/kunit_parser.py
@@ -0,0 +1,310 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Parses test results from a kernel dmesg log.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import re
+
+from collections import namedtuple
+from datetime import datetime
+from enum import Enum, auto
+from functools import reduce
+from typing import List
+
+TestResult = namedtuple('TestResult', ['status','suites','log'])
+
+class TestSuite(object):
+	def __init__(self):
+		self.status = None
+		self.name = None
+		self.cases = []
+
+	def __str__(self):
+		return 'TestSuite(' + self.status + ',' + self.name + ',' + str(self.cases) + ')'
+
+	def __repr__(self):
+		return str(self)
+
+class TestCase(object):
+	def __init__(self):
+		self.status = None
+		self.name = ''
+		self.log = []
+
+	def __str__(self):
+		return 'TestCase(' + self.status + ',' + self.name + ',' + str(self.log) + ')'
+
+	def __repr__(self):
+		return str(self)
+
+class TestStatus(Enum):
+	SUCCESS = auto()
+	FAILURE = auto()
+	TEST_CRASHED = auto()
+	NO_TESTS = auto()
+
+kunit_start_re = re.compile(r'^TAP version [0-9]+$')
+kunit_end_re = re.compile('List of all partitions:')
+
+def isolate_kunit_output(kernel_output):
+	started = False
+	for line in kernel_output:
+		if kunit_start_re.match(line):
+			started = True
+			yield line
+		elif kunit_end_re.match(line):
+			break
+		elif started:
+			yield line
+
+def raw_output(kernel_output):
+	for line in kernel_output:
+		print(line)
+
+DIVIDER = '=' * 60
+
+RESET = '\033[0;0m'
+
+def red(text):
+	return '\033[1;31m' + text + RESET
+
+def yellow(text):
+	return '\033[1;33m' + text + RESET
+
+def green(text):
+	return '\033[1;32m' + text + RESET
+
+def print_with_timestamp(message):
+	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+
+def format_suite_divider(message):
+	return '======== ' + message + ' ========'
+
+def print_suite_divider(message):
+	print_with_timestamp(DIVIDER)
+	print_with_timestamp(format_suite_divider(message))
+
+def print_log(log):
+	for m in log:
+		print_with_timestamp(m)
+
+TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
+
+def consume_non_diagnositic(lines: List[str]) -> None:
+	while lines and not TAP_ENTRIES.match(lines[0]):
+		lines.pop(0)
+
+def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
+	while lines and not TAP_ENTRIES.match(lines[0]):
+		test_case.log.append(lines[0])
+		lines.pop(0)
+
+OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
+
+OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
+
+OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
+
+def parse_ok_not_ok_test_case(lines: List[str],
+			      test_case: TestCase,
+			      expecting_test_case: bool) -> bool:
+	save_non_diagnositic(lines, test_case)
+	if not lines:
+		if expecting_test_case:
+			test_case.status = TestStatus.TEST_CRASHED
+			return True
+		else:
+			return False
+	line = lines[0]
+	match = OK_NOT_OK_SUBTEST.match(line)
+	if match:
+		test_case.log.append(lines.pop(0))
+		test_case.name = match.group(2)
+		if test_case.status == TestStatus.TEST_CRASHED:
+			return True
+		if match.group(1) == 'ok':
+			test_case.status = TestStatus.SUCCESS
+		else:
+			test_case.status = TestStatus.FAILURE
+		return True
+	else:
+		return False
+
+SUBTEST_DIAGNOSTIC = re.compile(r'^\t# .*?: (.*)$')
+DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
+
+def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
+	save_non_diagnositic(lines, test_case)
+	if not lines:
+		return False
+	line = lines[0]
+	match = SUBTEST_DIAGNOSTIC.match(line)
+	if match:
+		test_case.log.append(lines.pop(0))
+		if match.group(1) == DIAGNOSTIC_CRASH_MESSAGE:
+			test_case.status = TestStatus.TEST_CRASHED
+		return True
+	else:
+		return False
+
+def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
+	test_case = TestCase()
+	save_non_diagnositic(lines, test_case)
+	while parse_diagnostic(lines, test_case):
+		pass
+	if parse_ok_not_ok_test_case(lines, test_case, expecting_test_case):
+		return test_case
+	else:
+		return None
+
+SUBTEST_HEADER = re.compile(r'^\t# Subtest: (.*)$')
+
+def parse_subtest_header(lines: List[str]) -> str:
+	consume_non_diagnositic(lines)
+	if not lines:
+		return None
+	match = SUBTEST_HEADER.match(lines[0])
+	if match:
+		lines.pop(0)
+		return match.group(1)
+	else:
+		return None
+
+SUBTEST_PLAN = re.compile(r'\t[0-9]+\.\.([0-9]+)')
+
+def parse_subtest_plan(lines: List[str]) -> int:
+	consume_non_diagnositic(lines)
+	match = SUBTEST_PLAN.match(lines[0])
+	if match:
+		lines.pop(0)
+		return int(match.group(1))
+	else:
+		return None
+
+def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
+	if left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
+		return TestStatus.TEST_CRASHED
+	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
+		return TestStatus.FAILURE
+	elif left != TestStatus.SUCCESS:
+		return left
+	elif right != TestStatus.SUCCESS:
+		return right
+	else:
+		return TestStatus.SUCCESS
+
+def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
+	consume_non_diagnositic(lines)
+	if not lines:
+		test_suite.status = TestStatus.TEST_CRASHED
+		return False
+	line = lines[0]
+	match = OK_NOT_OK_MODULE.match(line)
+	if match:
+		lines.pop(0)
+		if match.group(1) == 'ok':
+			test_suite.status = TestStatus.SUCCESS
+		else:
+			test_suite.status = TestStatus.FAILURE
+		return True
+	else:
+		return False
+
+def bubble_up_errors(to_status, status_container_list) -> TestStatus:
+	status_list = map(to_status, status_container_list)
+	return reduce(max_status, status_list, TestStatus.SUCCESS)
+
+def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
+	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
+	return max_status(max_test_case_status, test_suite.status)
+
+def parse_test_suite(lines: List[str]) -> TestSuite:
+	if not lines:
+		return None
+	consume_non_diagnositic(lines)
+	test_suite = TestSuite()
+	test_suite.status = TestStatus.SUCCESS
+	name = parse_subtest_header(lines)
+	if not name:
+		return None
+	test_suite.name = name
+	expected_test_case_num = parse_subtest_plan(lines)
+	if not expected_test_case_num:
+		return None
+	test_case = parse_test_case(lines, expected_test_case_num > 0)
+	expected_test_case_num -= 1
+	while test_case:
+		test_suite.cases.append(test_case)
+		test_case = parse_test_case(lines, expected_test_case_num > 0)
+		expected_test_case_num -= 1
+	if parse_ok_not_ok_test_suite(lines, test_suite):
+		test_suite.status = bubble_up_test_case_errors(test_suite)
+		return test_suite
+	elif not lines:
+		print_with_timestamp(red('[ERROR] ') + 'ran out of lines before end token')
+		return test_suite
+	else:
+		print('failed to parse end of suite' + lines[0])
+		return None
+
+TAP_HEADER = re.compile(r'^TAP version 14$')
+
+def parse_tap_header(lines: List[str]) -> bool:
+	consume_non_diagnositic(lines)
+	if TAP_HEADER.match(lines[0]):
+		lines.pop(0)
+		return True
+	else:
+		return False
+
+def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
+	return bubble_up_errors(lambda x: x.status, test_suite_list)
+
+def parse_test_result(lines: List[str]) -> TestResult:
+	if not lines:
+		return TestResult(TestStatus.NO_TESTS, [], lines)
+	consume_non_diagnositic(lines)
+	if not parse_tap_header(lines):
+		return None
+	test_suites = []
+	test_suite = parse_test_suite(lines)
+	while test_suite:
+		test_suites.append(test_suite)
+		test_suite = parse_test_suite(lines)
+	return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
+
+def parse_run_tests(kernel_output) -> TestResult:
+	total_tests = 0
+	failed_tests = 0
+	crashed_tests = 0
+	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	for test_suite in test_result.suites:
+		if test_suite.status == TestStatus.SUCCESS:
+			print_suite_divider(green('[PASSED] ') + test_suite.name)
+		elif test_suite.status == TestStatus.TEST_CRASHED:
+			print_suite_divider(red('[CRASHED] ' + test_suite.name))
+		else:
+			print_suite_divider(red('[FAILED] ') + test_suite.name)
+		for test_case in test_suite.cases:
+			total_tests += 1
+			if test_case.status == TestStatus.SUCCESS:
+				print_with_timestamp(green('[PASSED] ') + test_case.name)
+			elif test_case.status == TestStatus.TEST_CRASHED:
+				crashed_tests += 1
+				print_with_timestamp(red('[CRASHED] ' + test_case.name))
+				print_log(map(yellow, test_case.log))
+				print_with_timestamp('')
+			else:
+				failed_tests += 1
+				print_with_timestamp(red('[FAILED] ') + test_case.name)
+				print_log(map(yellow, test_case.log))
+				print_with_timestamp('')
+	print_with_timestamp(DIVIDER)
+	fmt = green if test_result.status == TestStatus.SUCCESS else red
+	print_with_timestamp(
+		fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
+		    (total_tests, failed_tests, crashed_tests)))
+	return test_result
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
new file mode 100755
index 000000000000..4a12baa0cd4e
--- /dev/null
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -0,0 +1,206 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# A collection of tests for tools/testing/kunit/kunit.py
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import unittest
+from unittest import mock
+
+import tempfile, shutil # Handling test_tmpdir
+
+import os
+
+import kunit_config
+import kunit_parser
+import kunit_kernel
+import kunit
+
+test_tmpdir = ''
+
+def setUpModule():
+	global test_tmpdir
+	test_tmpdir = tempfile.mkdtemp()
+
+def tearDownModule():
+	shutil.rmtree(test_tmpdir)
+
+def get_absolute_path(path):
+	return os.path.join(os.path.dirname(__file__), path)
+
+class KconfigTest(unittest.TestCase):
+
+	def test_is_subset_of(self):
+		kconfig0 = kunit_config.Kconfig()
+		self.assertTrue(kconfig0.is_subset_of(kconfig0))
+
+		kconfig1 = kunit_config.Kconfig()
+		kconfig1.add_entry(kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		self.assertTrue(kconfig1.is_subset_of(kconfig1))
+		self.assertTrue(kconfig0.is_subset_of(kconfig1))
+		self.assertFalse(kconfig1.is_subset_of(kconfig0))
+
+	def test_read_from_file(self):
+		kconfig = kunit_config.Kconfig()
+		kconfig_path = get_absolute_path(
+			'test_data/test_read_from_file.kconfig')
+
+		kconfig.read_from_file(kconfig_path)
+
+		expected_kconfig = kunit_config.Kconfig()
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_UML=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+
+		self.assertEqual(kconfig.entries(), expected_kconfig.entries())
+
+	def test_write_to_file(self):
+		kconfig_path = os.path.join(test_tmpdir, '.config')
+
+		expected_kconfig = kunit_config.Kconfig()
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_UML=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+
+		expected_kconfig.write_to_file(kconfig_path)
+
+		actual_kconfig = kunit_config.Kconfig()
+		actual_kconfig.read_from_file(kconfig_path)
+
+		self.assertEqual(actual_kconfig.entries(),
+				 expected_kconfig.entries())
+
+class KUnitParserTest(unittest.TestCase):
+
+	def assertContains(self, needle, haystack):
+		for line in haystack:
+			if needle in line:
+				return
+		raise AssertionError('"' +
+			str(needle) + '" not found in "' + str(haystack) + '"!')
+
+	def test_output_isolated_correctly(self):
+		log_path = get_absolute_path(
+			'test_data/test_output_isolated_correctly.log')
+		file = open(log_path)
+		result = kunit_parser.isolate_kunit_output(file.readlines())
+		self.assertContains('TAP version 14\n', result)
+		self.assertContains('	# Subtest: example', result)
+		self.assertContains('	1..2', result)
+		self.assertContains('	ok 1 - example_simple_test', result)
+		self.assertContains('	ok 2 - example_mock_test', result)
+		self.assertContains('ok 1 - example', result)
+		file.close()
+
+	def test_parse_successful_test_log(self):
+		all_passed_log = get_absolute_path(
+			'test_data/test_is_test_passed-all_passed.log')
+		file = open(all_passed_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+		file.close()
+
+	def test_parse_failed_test_log(self):
+		failed_log = get_absolute_path(
+			'test_data/test_is_test_passed-failure.log')
+		file = open(failed_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.FAILURE,
+			result.status)
+		file.close()
+
+	def test_no_tests(self):
+		empty_log = get_absolute_path(
+			'test_data/test_is_test_passed-no_tests_run.log')
+		file = open(empty_log)
+		result = kunit_parser.parse_run_tests(
+			kunit_parser.isolate_kunit_output(file.readlines()))
+		self.assertEqual(0, len(result.suites))
+		self.assertEqual(
+			kunit_parser.TestStatus.NO_TESTS,
+			result.status)
+		file.close()
+
+	def test_crashed_test(self):
+		crashed_log = get_absolute_path(
+			'test_data/test_is_test_passed-crash.log')
+		file = open(crashed_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.TEST_CRASHED,
+			result.status)
+		file.close()
+
+class StrContains(str):
+	def __eq__(self, other):
+		return self in other
+
+class KUnitMainTest(unittest.TestCase):
+	def setUp(self):
+		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
+		file = open(path)
+		all_passed_log = file.readlines()
+		self.print_patch = mock.patch('builtins.print')
+		self.print_mock = self.print_patch.start()
+		self.linux_source_mock = mock.Mock()
+		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
+		self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
+
+	def tearDown(self):
+		self.print_patch.stop()
+		pass
+
+	def test_run_passes_args_pass(self):
+		kunit.main(['run'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+	def test_run_passes_args_fail(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['run'], self.linux_source_mock)
+		assert type(e.exception) == SystemExit
+		assert e.exception.code == 1
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
+
+	def test_run_raw_output(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		for kall in self.print_mock.call_args_list:
+			assert kall != mock.call(StrContains('Testing complete.'))
+			assert kall != mock.call(StrContains(' 0 tests run'))
+
+	def test_run_timeout(self):
+		timeout = 3453
+		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(timeout=timeout)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+if __name__ == '__main__':
+	unittest.main()
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
new file mode 100644
index 000000000000..62ebc0288355
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
@@ -0,0 +1,32 @@
+TAP version 14
+	# Subtest: sysctl_test
+	1..8
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
new file mode 100644
index 000000000000..0b249870c8be
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
@@ -0,0 +1,69 @@
+printk: console [tty0] enabled
+printk: console [mc-1] enabled
+TAP version 14
+	# Subtest: sysctl_test
+	1..8
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+Stack:
+ 6016f7db 6f81bd30 6f81bdd0 60021450
+ 6024b0e8 60021440 60018bbe 16f81bdc0
+ 00000001 6f81bd30 6f81bd20 6f81bdd0
+Call Trace:
+ [<6016f7db>] ? kunit_try_run_case+0xab/0xf0
+ [<60021450>] ? set_signals+0x0/0x60
+ [<60021440>] ? get_signals+0x0/0x10
+ [<60018bbe>] ? kunit_um_run_try_catch+0x5e/0xc0
+ [<60021450>] ? set_signals+0x0/0x60
+ [<60021440>] ? get_signals+0x0/0x10
+ [<60018bb3>] ? kunit_um_run_try_catch+0x53/0xc0
+ [<6016f321>] ? kunit_run_case_catch_errors+0x121/0x1a0
+ [<60018b60>] ? kunit_um_run_try_catch+0x0/0xc0
+ [<600189e0>] ? kunit_um_throw+0x0/0x180
+ [<6016f730>] ? kunit_try_run_case+0x0/0xf0
+ [<6016f600>] ? kunit_catch_run_case+0x0/0x130
+ [<6016edd0>] ? kunit_vprintk+0x0/0x30
+ [<6016ece0>] ? kunit_fail+0x0/0x40
+ [<6016eca0>] ? kunit_abort+0x0/0x40
+ [<6016ed20>] ? kunit_printk_emit+0x0/0xb0
+ [<6016f200>] ? kunit_run_case_catch_errors+0x0/0x1a0
+ [<6016f46e>] ? kunit_run_tests+0xce/0x260
+ [<6005b390>] ? unregister_console+0x0/0x190
+ [<60175b70>] ? suite_kunit_initexample_test_suite+0x0/0x20
+ [<60001cbb>] ? do_one_initcall+0x0/0x197
+ [<60001d47>] ? do_one_initcall+0x8c/0x197
+ [<6005cd20>] ? irq_to_desc+0x0/0x30
+ [<60002005>] ? kernel_init_freeable+0x1b3/0x272
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<601c0086>] ? kernel_init+0x26/0x160
+ [<60014442>] ? new_thread_handler+0x82/0xc0
+
+	# example_simple_test: kunit test case crashed!
+	# example_simple_test: example_simple_test failed
+	not ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: one or more tests failed
+not ok 2 - example
+List of all partitions:
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
new file mode 100644
index 000000000000..9e89d32d5667
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
@@ -0,0 +1,36 @@
+TAP version 14
+	# Subtest: sysctl_test
+	1..8
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: EXPECTATION FAILED at lib/kunit/example-test.c:30
+	Expected 1 + 1 == 3, but
+		1 + 1 == 2
+		3 == 3
+	# example_simple_test: example_simple_test failed
+	not ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: one or more tests failed
+not ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
new file mode 100644
index 000000000000..ba69f5c94b75
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
@@ -0,0 +1,75 @@
+Core dump limits :
+	soft - 0
+	hard - NONE
+Checking environment variables for a tempdir...none found
+Checking if /dev/shm is on tmpfs...OK
+Checking PROT_EXEC mmap in /dev/shm...OK
+Adding 24743936 bytes to physical memory to account for exec-shield gap
+Linux version 4.12.0-rc3-00010-g7319eb35f493-dirty (brendanhiggins@mactruck.svl.corp.google.com) (gcc version 7.3.0 (Debian 7.3.0-5) ) #29 Thu Mar 15 14:57:19 PDT 2018
+Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 14038
+Kernel command line: root=98:0
+PID hash table entries: 256 (order: -1, 2048 bytes)
+Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
+Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
+Memory: 27868K/56932K available (1681K kernel code, 480K rwdata, 400K rodata, 89K init, 205K bss, 29064K reserved, 0K cma-reserved)
+SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
+NR_IRQS:15
+clocksource: timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e205, max_idle_ns: 881590404426 ns
+Calibrating delay loop... 7384.26 BogoMIPS (lpj=36921344)
+pid_max: default: 32768 minimum: 301
+Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
+Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
+Checking that host ptys support output SIGIO...Yes
+Checking that host ptys support SIGIO on close...No, enabling workaround
+Using 2.6 host AIO
+clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
+futex hash table entries: 256 (order: 0, 6144 bytes)
+clocksource: Switched to clocksource timer
+console [stderr0] disabled
+mconsole (version 2) initialized on /usr/local/google/home/brendanhiggins/.uml/6Ijecl/mconsole
+Checking host MADV_REMOVE support...OK
+workingset: timestamp_bits=62 max_order=13 bucket_order=0
+Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
+io scheduler noop registered
+io scheduler deadline registered
+io scheduler cfq registered (default)
+io scheduler mq-deadline registered
+io scheduler kyber registered
+Initialized stdio console driver
+Using a channel type which is configured out of UML
+setup_one_line failed for device 1 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 2 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 3 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 4 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 5 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 6 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 7 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 8 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 9 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 10 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 11 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 12 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 13 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 14 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 15 : Configuration failed
+Console initialized on /dev/tty0
+console [tty0] enabled
+console [mc-1] enabled
+List of all partitions:
+No filesystem could mount root, tried:
+
+Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
diff --git a/tools/testing/kunit/test_data/test_output_isolated_correctly.log b/tools/testing/kunit/test_data/test_output_isolated_correctly.log
new file mode 100644
index 000000000000..94a6b3aeaa92
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_output_isolated_correctly.log
@@ -0,0 +1,106 @@
+Linux version 5.1.0-rc7-00061-g04652f1cb4aa0 (brendanhiggins@mactruck.svl.corp.google.com) (gcc version 7.3.0 (Debian 7.3.0-18)) #163 Wed May 8 16:18:20 PDT 2019
+Built 1 zonelists, mobility grouping on.  Total pages: 69906
+Kernel command line: mem=256M root=98:0
+Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
+Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
+Memory: 254468K/283500K available (1734K kernel code, 489K rwdata, 396K rodata, 85K init, 216K bss, 29032K reserved, 0K cma-reserved)
+SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
+NR_IRQS: 15
+clocksource: timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e205, max_idle_ns: 881590404426 ns
+------------[ cut here ]------------
+WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:458 clockevents_register_device+0x143/0x160
+posix-timer cpumask == cpu_all_mask, using cpu_possible_mask instead
+CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc7-00061-g04652f1cb4aa0 #163
+Stack:
+ 6005cc00 60233e18 60233e60 60233e18
+ 60233e60 00000009 00000000 6002a1b4
+ 1ca00000000 60071c23 60233e78 100000000000062
+Call Trace:
+ [<600214c5>] ? os_is_signal_stack+0x15/0x30
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<6001597e>] ? show_stack+0xbe/0x1c0
+ [<6005cc00>] ? __printk_safe_exit+0x0/0x40
+ [<6002a1b4>] ? __warn+0x144/0x170
+ [<60071c23>] ? clockevents_register_device+0x143/0x160
+ [<60021440>] ? get_signals+0x0/0x10
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<6002a27b>] ? warn_slowpath_fmt+0x9b/0xb0
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<6002a1e0>] ? warn_slowpath_fmt+0x0/0xb0
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<60021440>] ? get_signals+0x0/0x10
+ [<600213f0>] ? block_signals+0x0/0x20
+ [<60071c23>] ? clockevents_register_device+0x143/0x160
+ [<60021440>] ? get_signals+0x0/0x10
+ [<600213f0>] ? block_signals+0x0/0x20
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<60001bc8>] ? start_kernel+0x477/0x56a
+ [<600036f1>] ? start_kernel_proc+0x46/0x4d
+ [<60014442>] ? new_thread_handler+0x82/0xc0
+
+random: get_random_bytes called from print_oops_end_marker+0x4c/0x60 with crng_init=0
+---[ end trace c83434852b3702d3 ]---
+Calibrating delay loop... 6958.28 BogoMIPS (lpj=34791424)
+pid_max: default: 32768 minimum: 301
+Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
+Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
+*** VALIDATE proc ***
+Checking that host ptys support output SIGIO...Yes
+Checking that host ptys support SIGIO on close...No, enabling workaround
+clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
+futex hash table entries: 256 (order: 0, 6144 bytes)
+clocksource: Switched to clocksource timer
+printk: console [stderr0] disabled
+mconsole (version 2) initialized on /usr/local/google/home/brendanhiggins/.uml/VZ2qMm/mconsole
+Checking host MADV_REMOVE support...OK
+workingset: timestamp_bits=62 max_order=16 bucket_order=0
+Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
+io scheduler mq-deadline registered
+io scheduler kyber registered
+Initialized stdio console driver
+Using a channel type which is configured out of UML
+setup_one_line failed for device 1 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 2 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 3 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 4 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 5 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 6 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 7 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 8 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 9 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 10 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 11 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 12 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 13 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 14 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 15 : Configuration failed
+Console initialized on /dev/tty0
+printk: console [tty0] enabled
+printk: console [mc-1] enabled
+TAP version 14
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 1 - example
+List of all partitions:
diff --git a/tools/testing/kunit/test_data/test_read_from_file.kconfig b/tools/testing/kunit/test_data/test_read_from_file.kconfig
new file mode 100644
index 000000000000..d2a4928ac773
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_read_from_file.kconfig
@@ -0,0 +1,17 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# User Mode Linux/x86 4.12.0-rc3 Kernel Configuration
+#
+CONFIG_UML=y
+CONFIG_MMU=y
+
+#
+# UML-specific options
+#
+
+#
+# Host processor type and features
+#
+# CONFIG_MK8 is not set
+CONFIG_TEST=y
+CONFIG_EXAMPLE_TEST=y

--------------DA782D0C8C02D2F8120121D4--
