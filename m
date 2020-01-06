Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED92C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210F21775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578295481;
	bh=eQ8yqiTzUyPNFIqy24QttGgeP6WmbwCLza0/SEWxECM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PEb+66Y18S+Tx2MQPB1E9eC6Y89qQ3TZrtL/6bXteURg9n8U+iUXMQqZJBlxawmEF
	 CdR6LODJEcZFB/V/rs+/LHaORtQKPf1YSHLro1Vma4irx55va6WV5X3j6hXHLAnWZo
	 xp7COLpIybdIotGus26VQfvsOjBF0Gj8DMFwKw2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgAFHYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:24:40 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:59020 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgAFHYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:24:40 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0067NuUK027666;
        Mon, 6 Jan 2020 16:23:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0067NuUK027666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578295439;
        bh=TYKpX6W0znwh1gMd4rZiv+4YStRd99Hk1SGjhmu432g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iV76gizfLZEcrcaMKma+rvXBNwpc8Kw6dhOKfPcMOYM45Vxx7PF06mSI4o/TtLgrj
         sc1KKq+OMZ2hffyq61ssieKOezh3SJ6YrkBPwrNuJVRpouVaV19sRBWA2W5SfV0OMo
         Eo6hNfJO7uLLoKbqLWbIvxq9pFSVfJjFOmVIzEe+CBqVMwn0LSMUR0heiRnjd5BkZX
         0JDbe0r19gUzZGMIaUpXMNZ12Q67XEur1ZN/ARjCIKlkn0QQAFtvuC65DyH6qcYQVD
         e75b+08Of4Qa7NOk4rYvt3Lnrh/fjtUyrWCEfc/pEiqtm7nOhzRs4RI0laMBg89CPw
         C4ZamYSvwvNnQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Fumiya Shigemitsu <shfy1014@gmail.com>,
        Yongxin Liu <yongxin.liu@windriver.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: allow modules to link *.a archives
Date:   Mon,  6 Jan 2020 16:23:55 +0900
Message-Id: <20200106072355.32178-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106072355.32178-1-masahiroy@kernel.org>
References: <20200106072355.32178-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 69ea912fda74 ("kbuild: remove unneeded link_multi_deps"),
modules cannot link *.a archives.

I do not see such a usecase in the upstream code, but multiple people
reported this issue, so it seems to be a desired feature for external
modules.

For example, libfoo.a is not linked in the following test case:

    obj-m := foo.o
    foo-objs := foo1.o libfoo.a

I used $(filter $(multi-m-prereqs), $^) to avoid linking the same object
multiple times in case Makefile is written as follows:

    obj-m := foo.o
    foo-$(CONFIG_FOO1_X) += foo1.o
    foo-$(CONFIG_FOO1_Y) += foo1.o
    foo-y += libfoo.a

Reported-by: Fumiya Shigemitsu <shfy1014@gmail.com>
Reported-by: Yongxin Liu <yongxin.liu@windriver.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - add $(filter ..., $^) to avoid build errors caused by multiple linking

 scripts/Makefile.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d8445b696d5b..9ffb9300705e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -429,13 +429,13 @@ targets += $(obj)/lib-ksyms.o
 endif
 
 # NOTE:
-# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
-# module is turned into a multi object module, $^ will contain header file
-# dependencies recorded in the .*.cmd file.
+# Do not replace $(filter $(multi-m-prereqs), $^) with $(real-prereqs).
+# When a single object module is turned into a multi object module,
+# $^ will contain header file dependencies recorded in the .*.cmd file.
 quiet_cmd_link_multi-m = LD [M]  $@
-      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
+      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter $(multi-m-prereqs), $^)
 
-$(multi-used-m): FORCE
+$(multi-used-m): $(obj)/%.o: FORCE
 	$(call if_changed,link_multi-m)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
-- 
2.17.1

