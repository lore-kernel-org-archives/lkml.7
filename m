Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896720663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908609;
	bh=M9NO7uHdLQD8J4jwmAisGlOVUh6FfO6/zsVkDYGArDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tcgk4xF+XKiRVt6StwhOFVAGxwSlcrcUfAP5fjCF1uRjhZAAFzgoriAnpc1yKpIcO
	 mRxzdP2ex1Qb/CSZ9e0rEiGjL5NWVOkcn2JvYoj32rR8Q6NjqteHNVyN6i3hKuhMrn
	 oHoy8F8+zFmvm7mraTyKAo+GFK1Dp7ijOcAIS18w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCFVn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53963 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfCFVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D169822A8A;
        Wed,  6 Mar 2019 16:43:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 16:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=q01YGeCoIbHEEIB//S+2XygDhqyH/9qJaPDW3fWo93c=; b=8JzgRdlI
        wlbeEOegIMH/s8GRQ+Yr/us5es7S6oCHaLVTp6BapMgZeLbIwpphXfUyKUJBn6+b
        SYPsf6gTkFsrG00zG6vabqdSe20TA6bM02pHFrW4yR3eMlVNQcpsspAPhaVJnnTX
        b1M8Q0ofUtvdD0nXjRPXlDd0EUWMSbvDE7x9gSHS/4gZzzg2abcnPS2a7ETWhkoC
        yj7zBKabjnau99JyIB2ptNFOftAP05N6Wq9GYL9NMTwA7OoCxejxlpV62RW8ebpb
        3L6AReYf0nmbjIsPB7ZQDHakiG3a4h7moAChbyOwhzIUKUtPU0DZxjzQOJ8aT34k
        9TTvxX+4g0cjsA==
X-ME-Sender: <xms:_D6AXIdPpc5aBDgkIqGJrDtLUtZuyDAPMFQ902oF3wpw1JkBwxlBpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:_D6AXK4yksl6r1jqCHDarAcySm5Y9D2qzr7CvJjd3ZFesuXNYMIkHw>
    <xmx:_D6AXElPJ_g9PsZ8TaVKAlV-yau34EBfKvzl8tNpuuFtmt866AnpDg>
    <xmx:_D6AXN8pFcKtCya-ixNlqT1KTAjaVlvdZ6p7vESHeaoX_Zly54KpYQ>
    <xmx:_D6AXPHHzwpjMfPjOPLjN7NYoBFz-r5gbR8qn3bWZG1FF4tdUAjrVA>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F189E4362;
        Wed,  6 Mar 2019 16:43:19 -0500 (EST)
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
Subject: [PATCH v3 2/7] kselftest: Add test runner creation script
Date:   Thu,  7 Mar 2019 08:42:21 +1100
Message-Id: <20190306214226.14598-3-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we wish to use kselftest to run tests within a kernel
module we write a small script to load/unload and do error reporting.
There are a bunch of these under tools/testing/selftests/lib/ that are
all identical except for the test name.  We can reduce code duplication
and improve maintainability if we have one version of this.  However
kselftest requires an executable for each test.  We can move all the
script logic to a central script then have each individual test script
set the module name and call the main script.  There is a little bit of
boilerplate left in each script to handle building/running tests with
the O=/path/to/out make option.

Add test runner creation script.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/testing/selftests/kselftest_module.sh | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 tools/testing/selftests/kselftest_module.sh

diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
new file mode 100755
index 000000000000..b5d446738614
--- /dev/null
+++ b/tools/testing/selftests/kselftest_module.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+#
+# Runs an individual test module.  kselftest expects a separate
+# executable for each test.  So test should each have an individial
+# script that can call this script.
+#
+
+# Individual test scrits should define these:
+module=""			# filename (without the .ko).
+desc=""				# Output prefix.
+
+modprobe="/sbin/modprobe"
+
+main() {
+    parse_args $@
+    assert_root
+    assert_have_module
+    run_module
+}
+
+parse_args() {
+    script=${0##*/}
+
+    if [[ ! $# -eq 2 ]]; then
+	echo "Usage: $script <module_name> <description> [FAIL]"
+	exit 1
+    fi
+
+    module=$1
+    desc=$2
+}
+
+assert_root() {
+    if [[ $EUID -ne 0 ]]; then
+	skip "please run as root"
+    fi
+}
+
+assert_have_module() {
+    if ! $modprobe -q -n $module; then
+	skip "module $module is not found"
+    fi
+}
+
+run_module() {
+    if $modprobe -q $module; then
+	$modprobe -q -r $module
+	say "ok"
+    else
+	fail ""
+    fi
+}
+
+say() {
+    echo "$desc: $1"
+}
+
+
+fail() {
+    say "$1 [FAIL]" >&2
+    exit 1
+}
+
+skip() {
+    say "$1 [SKIP]" >&2
+    # Kselftest framework requirement - SKIP code is 4.
+    exit 4
+}
+
+#
+# Main script
+#
+main $@
-- 
2.20.1

