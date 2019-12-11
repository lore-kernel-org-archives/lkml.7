Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFC0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuVvxgh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfLKNEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:04:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43109 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfLKNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:04:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so23954860ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YGyDJ+9hlQ8oih8SvLA1JbGE0Ua/Vbyqj4pDMpx5+Ck=;
        b=MuVvxgh8WzA7ufU4Tkxd1fH+nT06jK9wLq1I2QUVel9elBFO35SmCa8D9+ZjAL+x7k
         GUmAZiG2bwzkCyuDYp6BPrH2ii9uZQ32BByYq8fQ5q9Aj67fJBjU0zIm56NbNWaE34rh
         9Bh5QnfNqxxRHOhaGMTk0kWHWNgOP4LVHm8fCSoTgcUp5x4pMRtRAab+hu0yeTvJ+yOD
         Pm7RqmFpL1HbMRuLDdpnV9bevV7CVQxluGwQOTrkLxbh18JuUvv3HYfRA5rayytjxS58
         YUpTRyFrcE/ce+PR1HLLBG/Ua+iUTLcSyXc12Xol4Q9VJyHpoc3nNOdKIeLyqXZrpdcI
         ctqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YGyDJ+9hlQ8oih8SvLA1JbGE0Ua/Vbyqj4pDMpx5+Ck=;
        b=WA5IMd6dMlDgLUCKwmCG0dVjW9wtgJ/yphOWgAAWQFRI0DI/anAn30XwvSZbNn4cNM
         SPXMdAtxcKtxXyxtIO4Faomm4q9SAxYpcCylVT7nDbfsDezHQnZiReyfJjoqhZYrMu8P
         S+PKc8AmJfPZvHg61CvxF5KUwUfQ6miIseLfniqEQO2q4XxbmwiwZ38gxwkjbvIKuF+D
         SGP+u+w2z1jsNHyYhInXV1O3wGUugfIcdLO6FWOV12tbXM/X8LSdSFCmzkOIwrlpqTcR
         cU2TAC2Wc808sEfxT0E73uDhsdMzb2SbID7rd+xedyYz93UhodzzOtBBJJnsx4juO1V/
         i4Ng==
X-Gm-Message-State: APjAAAWo0PMNyjOTa5rvF5CwJcTjwWT/G0mJY6pt0zlYP3IQKdg9/jmm
        0+5qqZd3kUeJXajRA5EATa1Or8XOsAa6H7LyOWJbiancOkm9BA==
X-Google-Smtp-Source: APXvYqy9SyCT0b4saAV+EzPmyr6c456zkPQ5FFMAsD6zEx+MLbO2MBEbQ+conOxVcpAocNSEN/vNT9zVLI+jVSSb5c8=
X-Received: by 2002:a05:651c:104:: with SMTP id a4mr2030813ljb.104.1576069470327;
 Wed, 11 Dec 2019 05:04:30 -0800 (PST)
MIME-Version: 1.0
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 11 Dec 2019 21:04:17 +0800
Message-ID: <CAFH1YnM_2xud4V7sAZAMWPpWP0CBHxuddAKjxHJsj9U9WfH2ww@mail.gmail.com>
Subject: [PATCH] x86/boot/KASLR: Fix unused variable warning
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, ardb@kernel.org,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning by moving variable 'i':
arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable =E2=80=98i=
=E2=80=99
[-Wunused-variable]

Also use true/false instead of 1/0 for boolean return.

Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the
kernel in immovable memory only")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/boot/compressed/kaslr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/ka=
slr.c
index d7408af55738..fff24a55bfd5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -695,7 +695,6 @@ static bool process_mem_region(struct mem_vector *regio=
n,
        unsigned long long minimum,
        unsigned long long image_size)
 {
- int i;
  /*
  * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
  * use @region directly.
@@ -705,12 +704,13 @@ static bool process_mem_region(struct mem_vector *reg=
ion,

  if (slot_area_index =3D=3D MAX_SLOT_AREA) {
  debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
- return 1;
+ return true;
  }
- return 0;
+ return false;
  }

 #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
+ int i;
  /*
  * If immovable memory found, filter the intersection between
  * immovable memory and @region.
@@ -734,11 +734,11 @@ static bool process_mem_region(struct mem_vector *reg=
ion,

  if (slot_area_index =3D=3D MAX_SLOT_AREA) {
  debug_putstr("Aborted e820/efi memmap scan when walking immovable
regions(slot_areas full)!\n");
- return 1;
+ return true;
  }
  }
 #endif
- return 0;
+ return false;
 }

 #ifdef CONFIG_EFI
--=20
2.23.0
