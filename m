Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A59C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E4B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355229;
	bh=HCyf28W2q6RYFGzfHnn73T0o6U1pk2uCmy6mOPUU+D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qttpAJ1YktQ+pNT6xf6RufSO1Y8QaJX1bz30lIiIeOexBysphBQSKhQF0ju8LOvif
	 rPHArKXpgDCn2OKXns5AxjeXqeYEUDc1ssKJolmF2ik86N4CgspnqfvBeGmv12KQ5e
	 I+3+30zhMqCKvO2vrlwNnJEStLDLNO/m37qxKZvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfDOTHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfDOTHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9782087C;
        Mon, 15 Apr 2019 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355224;
        bh=HCyf28W2q6RYFGzfHnn73T0o6U1pk2uCmy6mOPUU+D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fps9GXCc9/plEyj+lmG6ZHcieHnE7pkwPhgpLG8R/b22YhZQa+P5Fv0jtJxsVVCzG
         wSeD7Bg7jyyJnMZtF9+mZq9AJU/zEiUCknvYHbqSo2mIxZYs2zulU0tGCizT2mS8t5
         crii3p4GuKcBHIWARAV/aOZ9x4LjYz7qyzoxqmY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/101] kbuild: deb-pkg: fix bindeb-pkg breakage when O= is used
Date:   Mon, 15 Apr 2019 20:58:35 +0200
Message-Id: <20190415183742.418747020@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 02826a6ba301b72461c3706e1cc66d5571cd327e ]

Ard Biesheuvel reports bindeb-pkg with O= option is broken in the
following way:

  ...
    LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
    LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
   fakeroot -u debian/rules binary
  make KERNELRELEASE=4.19.0-12677-g19beffaf7a99-dirty ARCH=arm64 KBUILD_SRC= intdeb-pkg
  /bin/bash /home/ard/linux/scripts/package/builddeb
  Makefile:600: include/config/auto.conf: No such file or directory
  ***
  *** Configuration file ".config" not found!
  ***
  *** Please run some configurator (e.g. "make oldconfig" or
  *** "make menuconfig" or "make xconfig").
  ***
  make[12]: *** [syncconfig] Error 1
  make[11]: *** [syncconfig] Error 2
  make[10]: *** [include/config/auto.conf] Error 2
  make[9]: *** [__sub-make] Error 2
  ...

Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
for out-of-tree build"), both srctree and objtree were added to
--include-dir redundantly, and the wrong code '$MAKE image_name'
was working by relying on that. Now, the potential issue that had
previously been hidden just showed up.

'$MAKE image_name' recurses to the generated $(objtree)/Makefile and
ends up with running in srctree, which is incorrect. It should be
invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
in objtree.

Fixes: 80463f1b7bf9 ("kbuild: add --include-dir flag only for out-of-tree build")
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/builddeb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 90c9a8ac7adb..0b31f4f1f92c 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -81,7 +81,7 @@ else
 	cp System.map "$tmpdir/boot/System.map-$version"
 	cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
 fi
-cp "$($MAKE -s image_name)" "$tmpdir/$installed_image_path"
+cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
 
 if grep -q "^CONFIG_OF=y" $KCONFIG_CONFIG ; then
 	# Only some architectures with OF support have this target
-- 
2.19.1



