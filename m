Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C90FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DyCP4NZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfJJWqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:46:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36290 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJJWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:46:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so4838482pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1bKGtbkU276Qic7083jH1GxErr25ze2mM6VPeh2J7GA=;
        b=DyCP4NZI/zuNYDu7jY/ZZUEXHfDKMSazvkYJ6PuzJxjMRKhp+rAxzK5Dt2H01Pv6+m
         LlMpUzTq+PUEEJZm/ab4gpJ3nZT0JvOiDbHG3GengQcNOIRuhA8pbDGv4navVXCn01qB
         xpFAse9TBG8UdMjY262hjIHZRhZAMMC7WV7UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1bKGtbkU276Qic7083jH1GxErr25ze2mM6VPeh2J7GA=;
        b=Qq+GBm3Vx6BKPHWlTHYUxit0caRyTl0hwtcwY49Vmq1gjv/l0m9tCAWPVvEWslK7tI
         KRujvkl8gp6/DXFfd7EZSVerOVNbvvzQKBqOmdz1RRfiM0h/rtNZkKh194NrviK+w/ME
         /UWijFmieKOEXYQBr+eCSwwFz4d7VxtsXveJHU6EzHOu5qsPLmUPAN13TifhAA+sXcQ2
         uWBmcq5XcZERlTxiNxIqWc+LO/pPIHUZwU3y691UUCDbKB+SUybG+Oil8mgmBzf4c8A9
         B6hbomJOuj5pW8HA6d9cif8LdFUkeHamEexpHvzV7yHyDbX7EivSGX8hEy8BBOAy2ter
         RtYQ==
X-Gm-Message-State: APjAAAUqMl/mJYWArpLmb1i+ei/9JwC7+VDitDVeYHp9/ZHrnioV0dVM
        U+0eYPSRZKwmer5QKsFSDXP9u1Vig7Q=
X-Google-Smtp-Source: APXvYqzPLTDHvgkpFIsRejZmoidbgu1xjUA2eDPKSvdkhsR2rKQm7kIBl5bRbTqnNTcfRoKBUArVEA==
X-Received: by 2002:a17:90a:c383:: with SMTP id h3mr13985098pjt.122.1570747609862;
        Thu, 10 Oct 2019 15:46:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w134sm6554453pfd.4.2019.10.10.15.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:46:49 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:46:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: OCTEON: Replace SIZEOF_FIELD() macro
Message-ID: <201910101545.586BCFC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

In preparation for switching to a standard sizeof_member() macro to find the
size of a member of a struct, remove the custom SIZEOF_FIELD() macro and use
the more common FIELD_SIZEOF() instead. Later patches will globally replace
FIELD_SIZEOF() and sizeof_field() with the more accurate sizeof_member().

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-4-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index ba8f82a29a81..44b506a14666 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -44,13 +44,6 @@ static struct cvmx_bootmem_desc *cvmx_bootmem_desc;
 
 /* See header file for descriptions of functions */
 
-/**
- * This macro returns the size of a member of a structure.
- * Logically it is the same as "sizeof(s::field)" in C++, but
- * C lacks the "::" operator.
- */
-#define SIZEOF_FIELD(s, field) sizeof(((s *)NULL)->field)
-
 /**
  * This macro returns a member of the
  * cvmx_bootmem_named_block_desc_t structure. These members can't
@@ -65,7 +58,7 @@ static struct cvmx_bootmem_desc *cvmx_bootmem_desc;
 #define CVMX_BOOTMEM_NAMED_GET_FIELD(addr, field)			\
 	__cvmx_bootmem_desc_get(addr,					\
 		offsetof(struct cvmx_bootmem_named_block_desc, field),	\
-		SIZEOF_FIELD(struct cvmx_bootmem_named_block_desc, field))
+		FIELD_SIZEOF(struct cvmx_bootmem_named_block_desc, field))
 
 /**
  * This function is the implementation of the get macros defined
-- 
2.17.1


-- 
Kees Cook
