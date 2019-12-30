Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5653C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BB420663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577712046;
	bh=yXjtj3QOO5nG863hqRtcRcOVEvhCcTn95UWi2cv017M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Du+PQw6J690eO/qTiKK5qWZcCN5nlUA9ktAKEaefRIzleHlOaD/eY1DpS3Td7hOjo
	 2Ohp5+PCjlUkq4bmjqEpKn86Wq+FcZd14/9qEQPM4ixAuPAqkq6cjF5luLNdDq3W78
	 8jaIobTv30Ojoq0YHR0XOIFOwSri4DJqaL4UzEO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfL3NUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:20:45 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64258 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3NUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 08:20:44 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id xBUDK8fI023590;
        Mon, 30 Dec 2019 22:20:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com xBUDK8fI023590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1577712010;
        bh=pnBt8xUVdXEnrnK1yEByI/0eROSFkY8hUgAQAoImYAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HluJL/CBuyQeAdk7OIIZRrd69Ejlmzhjkac59K+L68i5vhiA1d8Jcgjw3PIKCpkXk
         wHBZB7/bz6DhpNIKJKwdpntoXuFVJ1gOrTnAx4rwP+G3BfZdgqWubFhhUmstqKl45m
         bFswy6EsRIqxEmDC7sd/fQjsKMq7UBdjmA7HnNmEPGHprPGYaQHH/2vr7K/PvrwfxU
         pU5Aoa+c0HLFe1BnFfMmHSsiyMX5E+8TLFkNjpQslBRNcRGJ4dOB9/Mf3f7LkGmq5u
         2FYLKE0/7bfc5+7uyx3KVKRine7RokWDztzduVtLBYF+irc6X1ZtOMI2PTM0WoGNNU
         m3NOOqx+WeePA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     "Jory A . Pratt" <anarchy@gentoo.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: fix 'bad variable name' error in gen_initramfs_list.sh
Date:   Mon, 30 Dec 2019 22:20:06 +0900
Message-Id: <20191230132006.7401-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 858805b336be ("kbuild: add $(BASH) to run scripts with
bash-extension"), this shell script was almost always run by bash since
bash is usually installed on the system by default.

Now, this script is run by sh, which might be a symlink to dash. On such
distros, the following code emits an error:

  local dev=`LC_ALL=C ls -l "${location}"`

You can reproduce the build error, for example by setting
CONFIG_INITRAMFS_SOURCE="/dev".

    GEN     usr/initramfs_data.cpio.gz
  ./usr/gen_initramfs_list.sh: 131: local: 1: bad variable name
  make[1]: *** [usr/Makefile:61: usr/initramfs_data.cpio.gz] Error 2

This is because `LC_ALL=C ls -l "${location}"` contains spaces.
Surrounding it with double-quotes fixes the error.

Fixes: 858805b336be ("kbuild: add $(BASH) to run scripts with bash-extension")
Reported-by: Jory A. Pratt <anarchy@gentoo.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/gen_initramfs_list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs_list.sh b/usr/gen_initramfs_list.sh
index 0aad760fcd8c..2bbac73e6477 100755
--- a/usr/gen_initramfs_list.sh
+++ b/usr/gen_initramfs_list.sh
@@ -128,7 +128,7 @@ parse() {
 			str="${ftype} ${name} ${location} ${str}"
 			;;
 		"nod")
-			local dev=`LC_ALL=C ls -l "${location}"`
+			local dev="`LC_ALL=C ls -l "${location}"`"
 			local maj=`field 5 ${dev}`
 			local min=`field 6 ${dev}`
 			maj=${maj%,}
-- 
2.17.1

