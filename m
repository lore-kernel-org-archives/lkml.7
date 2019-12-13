Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE34D24658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="FRSVUotM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLMIXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:23:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34132 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:23:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so5671153wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=/n6svHz4Nhwr1guA/nXjQOEhBSqpjVu2FY23vRyinvU=;
        b=FRSVUotMIJofxJad/rZd7kCJ8Y7nXijudcSlKE9KGrNXfQbf0qtrcvP6GPUu3YvXJ2
         BiW5Hhs2oTf82oiFB8RL/dV6UAFltH1KR/GaLhUgLzwZJoWUYpJ/l43oOnHAcRpSP8GZ
         6fxM5EQ3cSeJOOtqsD6B/bXhEP54ndI69Rrp3zpUDKjYyByNOFBhSgBf2+AZzPPkSX+p
         59y2oQ5yxoIcSC/lPwT4OntZ0sSH2BgNz5sRmbH2cbZRRnt24LUdQmExZzXPlTxQePZq
         RyBVzlc81ZCMrQXlGyg78vV7Q/ie0PN2ZzSxixnrXe5H3tIh6BaEgfVQLBKGISoUtVm+
         8CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=/n6svHz4Nhwr1guA/nXjQOEhBSqpjVu2FY23vRyinvU=;
        b=HwYNtkPTzScZEkTqQAvz9avnYxrSaPc3IaXVy1dKniiqzJmXjbnmXt8YS9vF8Uzo3c
         ihcP7SAo3XCUoHDuJC343v+HG3QS2pYfO8oWG7dEiCSWtKb+H00TjrCYTd3C8K7cD4ro
         6LEdUxYUniKf1H8f1gq22vgzntqA3V8/3K/i1is5m+g2xpwJjpTHZScVkid8nq3TvcPF
         HSbkbg5iDZ830ZxBzTEwMIH4MU6oBNIQ66GvtqZc7dZshV2eQiIO7BwGc8jslAtjGLD2
         fQ7hk1p4DYsmFq/wS+lAsMEZbQu6hN/wzaWvgudPmdlbsnkW0zj9+nmPATYbA6mwxbPx
         TBBA==
X-Gm-Message-State: APjAAAX7dlzHynFU2kIK2aZC03uWmB5+2So0YAjhB103z89Y8EvYsbR1
        uuM3f+grAUsElI6qkx0f5LH9JQ==
X-Google-Smtp-Source: APXvYqw8LEasSSVzxxkPAJSe2ZPAvuQ6jkwCYqjirQWYgIzMOERgeGXsFyA7cLLFA+xpj1ofR4kPZw==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr11177829wrt.41.1576225394047;
        Fri, 13 Dec 2019 00:23:14 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 5sm9237421wrh.5.2019.12.13.00.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:23:13 -0800 (PST)
Message-ID: <5df34a71.1c69fb81.74136.f165@mx.google.com>
Date:   Fri, 13 Dec 2019 00:23:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.5-rc1-399-g9626c50a1d3d
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Lab-Name: lab-baylibre
Subject: next/pending-fixes bisection: boot on meson-gxl-s905x-khadas-vim
To:     broonie@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        khilman@baylibre.com, tomeu.vizoso@collabora.com,
        enric.balletbo@collabora.com, mgalka@collabora.com,
        guillaume.tucker@collabora.com, YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Joe Perches <joe@perches.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/pending-fixes bisection: boot on meson-gxl-s905x-khadas-vim

Summary:
  Start:      9626c50a1d3d Merge remote-tracking branch 'pinctrl-intel-fixe=
s/fixes'
  Details:    https://kernelci.org/boot/id/5df2d947024b891c56960f1b
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.5-rc1-399=
-g9626c50a1d3d/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-gxl-s905x-khad=
as-vim.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.5-rc1-399=
-g9626c50a1d3d/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-gxl-s905x-khad=
as-vim.html
  Result:     2f4d984b9544 staging: hp100: Fix build error without ETHERNET

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     pending-fixes
  Target:     meson-gxl-s905x-khadas-vim
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 2f4d984b9544e03ef9435a750f4cc7de1df61051
Author: YueHaibing <yuehaibing@huawei.com>
Date:   Wed Nov 13 10:13:06 2019 +0800

    staging: hp100: Fix build error without ETHERNET
    =

    It should depends on ETHERNET, otherwise building fails:
    =

    drivers/staging/hp/hp100.o: In function `hp100_pci_remove':
    hp100.c:(.text+0x165): undefined reference to `unregister_netdev'
    hp100.c:(.text+0x214): undefined reference to `free_netdev'
    =

    Fixes: 52340b82cf1a ("hp100: Move 100BaseVG AnyLAN driver to staging")
    Signed-off-by: YueHaibing <yuehaibing@huawei.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
    Link: https://lore.kernel.org/r/20191113021306.35464-1-yuehaibing@huawe=
i.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/hp/Kconfig b/drivers/staging/hp/Kconfig
index fb395cfe6b92..f20ab21a6b2a 100644
--- a/drivers/staging/hp/Kconfig
+++ b/drivers/staging/hp/Kconfig
@@ -6,6 +6,7 @@
 config NET_VENDOR_HP
 	bool "HP devices"
 	default y
+	depends on ETHERNET
 	depends on ISA || EISA || PCI
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [37d4e84f765bb3038ddfeebdc5d1cfd7e1ef688f] Merge tag 'ceph-for-5.5-=
rc2' of git://github.com/ceph/ceph-client
git bisect good 37d4e84f765bb3038ddfeebdc5d1cfd7e1ef688f
# bad: [9626c50a1d3daecad647af5f45f4f91fadb610fc] Merge remote-tracking bra=
nch 'pinctrl-intel-fixes/fixes'
git bisect bad 9626c50a1d3daecad647af5f45f4f91fadb610fc
# good: [82ef4500432fecdff6c857e46caf61cee9d0e250] Merge remote-tracking br=
anch 'driver-core.current/driver-core-linus'
git bisect good 82ef4500432fecdff6c857e46caf61cee9d0e250
# bad: [60b91f6383bc97ea632b0f4c2887500755614de4] Merge remote-tracking bra=
nch 'omap-fixes/fixes'
git bisect bad 60b91f6383bc97ea632b0f4c2887500755614de4
# bad: [843fc1ab17e0cc8580b6555a29aea083ee9af8b8] Merge remote-tracking bra=
nch 'staging.current/staging-linus'
git bisect bad 843fc1ab17e0cc8580b6555a29aea083ee9af8b8
# bad: [74ca34118a0e05793935d804ccffcedd6eb56596] staging: rtl8188eu: fix i=
nterface sanity check
git bisect bad 74ca34118a0e05793935d804ccffcedd6eb56596
# good: [bd41c445b7b96e46efb799ff33bdf870479488cf] iio: imu: st_lsm6dsx: do=
 not power-off accel if events are enabled
git bisect good bd41c445b7b96e46efb799ff33bdf870479488cf
# bad: [2f4d984b9544e03ef9435a750f4cc7de1df61051] staging: hp100: Fix build=
 error without ETHERNET
git bisect bad 2f4d984b9544e03ef9435a750f4cc7de1df61051
# good: [7347f09a198a045d5f6ea5e9c8fcc1db98e5a854] Merge tag 'iio-fixes-for=
-5.5a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into stag=
ing-linus
git bisect good 7347f09a198a045d5f6ea5e9c8fcc1db98e5a854
# good: [1184fd9966702a5a1cea73bdb6fe646b961c387c] staging: exfat: properly=
 support discard in clr_alloc_bitmap()
git bisect good 1184fd9966702a5a1cea73bdb6fe646b961c387c
# good: [453a4b6d8e1bdff2b8e1f56f4b8a8ef6d36b0e77] staging: fbtft: Do not h=
ardcode SPI CS polarity inversion
git bisect good 453a4b6d8e1bdff2b8e1f56f4b8a8ef6d36b0e77
# first bad commit: [2f4d984b9544e03ef9435a750f4cc7de1df61051] staging: hp1=
00: Fix build error without ETHERNET
---------------------------------------------------------------------------=
----
