Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E37C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E582321906
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uoWzyLR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfI0JhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:37:19 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:33055 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfI0JhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:37:02 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x8R9a5uh001372;
        Fri, 27 Sep 2019 18:36:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x8R9a5uh001372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569576973;
        bh=8Z1yZcx7lt82yK82hKDWaRuslS2lyBCS5/OQGziEcvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoWzyLR7WPO97Yw+7t2zQ6Bn+mWJ4wLoAivcRWkOp71OIQ4a7nclOHfnfEZcMfLq2
         gsfADMWqfz6bC+Epby+QMFO9UMLLAPmaOoQiOYb4pN843ldf5QrkWkPYAZ6B4KFLrT
         EHjvPttNsdP+0/CAKOdTvY3Xf4STusL1CBVtA2fcq1OK8Cg9yfWAdPAWeW/HbjcZ5n
         OtN0uNov4PROdyIluCGO1s+S4YLwJN+stI+hpC18A8xDmwkxfwzvczxj5ajXXyzHRu
         AYi7QmobHJr+rFXav0f1osZ59d0aD+l8SF0fF46Q3Cp3f7aXef+eMDSH6iHp7z5uGT
         ekA/bWw/6OMew==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] nsdeps: make generated patches independent of locale
Date:   Fri, 27 Sep 2019 18:36:03 +0900
Message-Id: <20190927093603.9140-8-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927093603.9140-1-yamada.masahiro@socionext.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_NS
tags, and what is nicer, it sorts the lines alphabetically with the
"sort" command. However, the output from the "sort" command depends
on locale.

Especially when namespaces contain underscores, the result is
different depending on the locale.

For example, I got this:

$ { echo usbcommon; echo usb_common; } | LANG=en_US.UTF-8 sort
usbcommon
usb_common
$ { echo usbcommon; echo usb_common; } | LANG=C sort
usb_common
usbcommon

So, this means people might potentially send different patches.

This kind of issue was reported in the past, for example,
commit f55f2328bb28 ("kbuild: make sorting initramfs contents
independent of locale").

Adding "LANG=C" is a conventional way of fixing when a deterministic
result is desirable.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index 964b7fb8c546..3754dac13b31 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -41,7 +41,7 @@ generate_deps() {
 		for source_file in $mod_source_files; do
 			sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
 			offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
-			cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
+			cat $source_file | grep MODULE_IMPORT_NS | LANG=C sort -u >> ${source_file}.tmp
 			tail -n +$((offset +1)) ${source_file} | grep -v MODULE_IMPORT_NS >> ${source_file}.tmp
 			if ! diff -q ${source_file} ${source_file}.tmp; then
 				mv ${source_file}.tmp ${source_file}
-- 
2.17.1

