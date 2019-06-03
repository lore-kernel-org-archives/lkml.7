Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F31C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C2275D8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ZcmEs7c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfFCRLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:11:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37306 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfFCRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:11:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so3675236wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=HfMZm97BBBVN/Akj4ZX56akpwbWPXy5xSk8GJLfRVB4=;
        b=ZcmEs7c6fnfgurJJhQ8swRowMqvfM1d1aToAi1IBQX8PjP+72694Kz5ydGcmeZMrHK
         vhqBAHnY2+CqzdIxhswFfXzAR7dmqNrph4VMCPGVPQwuMyEaYkjjzCcCKbhyCCcN6DMQ
         61vvbQg4sbI839hKiJM+jhj9NIXtdqXLRf9RIQv2JBFOR0Iv27Fv3bibpyRJUENHn3YD
         Z481Tx+4uZ8dpFFJntARJCnzBPwt4uZMfGmjotcVwmHBM/oyMMi/Rbbe0gbgmX3LDUU4
         Dx4udN6PEWugFLgz0GsVPzFQXuxZGHXkIxJNSpaQVrcma1SjXSHsBRnU6pAAduGCotv7
         I3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=HfMZm97BBBVN/Akj4ZX56akpwbWPXy5xSk8GJLfRVB4=;
        b=NLab/hLCF9qOqIjGmtYn1oEjxE6IhCxqmpwktfBGI48OasNg9KOnWzlEvCmXHQAaXj
         JBsD0tC7fjjtK15gN9AQ+7IlHfjDuU7ZI98UBiLDa6rO9C1JnOheirbPXSG9SIgjsIL3
         dI9TarorFhFOitC9y+VwrGRU071bdobL3DER/WjN6tEua9gT4pzc0V6biWTDbKatXUkk
         Iuy7IG6fwkwI78Sm9uHyS/zTnqWeisYS2+LzcZe9wlofW5UAkvB0QB29nDCuVbhJg5Sw
         44Wl4pYh2/+6u8B9T27YWBojQ21oNRH1JyDgHiYShK0NIYGIaCTIg1T74zI+Ij9C8++l
         7D7g==
X-Gm-Message-State: APjAAAWYKgz+OhO6fJ0i5Y6WHcpnC2j7oUIHQDMCXPAMaMmIGUyfpFYt
        UyhVOAhvdOIyPZSsE+5GHqe+Hw==
X-Google-Smtp-Source: APXvYqyeRxdFQwhBL7xhyX75h0tjMNcW0x5MdFT80+6a5BnsE9USodq0FgyWwnPyz+46G0qYXCT2tg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr14196739wma.44.1559581888645;
        Mon, 03 Jun 2019 10:11:28 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f20sm11029386wmh.22.2019.06.03.10.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:11:27 -0700 (PDT)
Message-ID: <5cf554bf.1c69fb81.956a8.9d1b@mx.google.com>
Date:   Mon, 03 Jun 2019 10:11:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: next-20190603
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-mhart
X-Kernelci-Tree: next
Subject: next/master boot bisection: next-20190603 on jetson-tk1
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Uladzislau Rezki (Sony) <urezki@gmail.com>,
        broonie@kernel.org, matthew.hart@linaro.org,
        Hillf Danton <hdanton@sina.com>, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Andrew Morton <akpm@linux-foundation.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master boot bisection: next-20190603 on jetson-tk1

Summary:
  Start:      ae3cad8f39cc Add linux-next specific files for 20190603
  Details:    https://kernelci.org/boot/id/5cf4e76059b514265fd51501
  Plain log:  https://storage.kernelci.org//next/master/next-20190603/arm/m=
ulti_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-mhart/boot-tegra124-jetson-tk1.t=
xt
  HTML log:   https://storage.kernelci.org//next/master/next-20190603/arm/m=
ulti_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-mhart/boot-tegra124-jetson-tk1.h=
tml
  Result:     728e0fbf263e mm/vmalloc.c: get rid of one single unlink_va() =
when merge

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     jetson-tk1
  CPU arch:   arm
  Lab:        lab-mhart
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 728e0fbf263e3ed359c10cb13623390564102881
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Sat Jun 1 12:20:19 2019 +1000

    mm/vmalloc.c: get rid of one single unlink_va() when merge
    =

    It does not make sense to try to "unlink" the node that is definitely n=
ot
    linked with a list nor tree.  On the first merge step VA just points to
    the previously disconnected busy area.
    =

    On the second step, check if the node has been merged and do "unlink" if
    so, because now it points to an object that must be linked.
    =

    Link: http://lkml.kernel.org/r/20190527151843.27416-4-urezki@gmail.com
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Acked-by: Hillf Danton <hdanton@sina.com>
    Cc: Ingo Molnar <mingo@elte.hu>
    Cc: Joel Fernandes <joelaf@google.com>
    Cc: Matthew Wilcox <willy@infradead.org>
    Cc: Michal Hocko <mhocko@suse.com>
    Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
    Cc: Roman Gushchin <guro@fb.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Tejun Heo <tj@kernel.org>
    Cc: Thomas Garnier <thgarnie@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 899d73a27d13..6a490c35801a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -719,8 +719,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 =

-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
+			if (merged)
+				unlink_va(va, root);
 =

 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
@@ -746,9 +746,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 =

-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a] Linux 5.2-rc3
git bisect good f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a
# bad: [ae3cad8f39ccf8d31775d9737488bccf0e44d370] Add linux-next specific f=
iles for 20190603
git bisect bad ae3cad8f39ccf8d31775d9737488bccf0e44d370
# good: [8ff6f4c6e067a9d3f3bbacf02c4ea5eb81fe2c6a] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 8ff6f4c6e067a9d3f3bbacf02c4ea5eb81fe2c6a
# good: [6c93755861ce6a6dd904df9cdae9f08671132dbe] Merge remote-tracking br=
anch 'iommu/next'
git bisect good 6c93755861ce6a6dd904df9cdae9f08671132dbe
# good: [1a567956cb3be5754d94ce9380a2151e57e204a7] Merge remote-tracking br=
anch 'cgroup/for-next'
git bisect good 1a567956cb3be5754d94ce9380a2151e57e204a7
# good: [a6878ca73cf30b83efbdfb1ecc443d7cfb2d8193] Merge remote-tracking br=
anch 'rtc/rtc-next'
git bisect good a6878ca73cf30b83efbdfb1ecc443d7cfb2d8193
# bad: [b2b94a9c4f8fc4229cd8b14d8417fc491e5f5d7c] mm, memcg: make memory.em=
in the baseline for utilisation determination
git bisect bad b2b94a9c4f8fc4229cd8b14d8417fc491e5f5d7c
# good: [e824d3a072bd3f93a0c7616dee4bdb3410e0a767] memcg, fsnotify: no oom-=
kill for remote memcg charging
git bisect good e824d3a072bd3f93a0c7616dee4bdb3410e0a767
# good: [83f89893bd05fe97b43cbe7f5c2eacbb0fdc966a] drivers/base/memory: pas=
s a block_id to init_memory_block()
git bisect good 83f89893bd05fe97b43cbe7f5c2eacbb0fdc966a
# bad: [8d388102126d935b8d7294162f6b4ebf6b0494c5] tools/vm/slabinfo: add op=
tion to sort by partial slabs
git bisect bad 8d388102126d935b8d7294162f6b4ebf6b0494c5
# good: [df18a3805de35506cd05da7aceba3704c8ec6962] mm/vmalloc.c: remove "no=
de" argument
git bisect good df18a3805de35506cd05da7aceba3704c8ec6962
# bad: [adc7c46cd31f1a3ca27508cb9435187b3c6539a4] mm: vmscan: remove double=
 slab pressure by inc'ing sc->nr_scanned
git bisect bad adc7c46cd31f1a3ca27508cb9435187b3c6539a4
# bad: [728e0fbf263e3ed359c10cb13623390564102881] mm/vmalloc.c: get rid of =
one single unlink_va() when merge
git bisect bad 728e0fbf263e3ed359c10cb13623390564102881
# good: [1ed20f4bc22412db94535d4df384082c98903da9] mm/vmalloc.c: preload a =
CPU with one object for split purpose
git bisect good 1ed20f4bc22412db94535d4df384082c98903da9
# first bad commit: [728e0fbf263e3ed359c10cb13623390564102881] mm/vmalloc.c=
: get rid of one single unlink_va() when merge
---------------------------------------------------------------------------=
----
