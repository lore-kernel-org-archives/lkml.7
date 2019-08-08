Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF12C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4D4217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfHHBga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:36:30 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53590 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389520AbfHHBga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:36:30 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x781aSoi026872
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 21:36:28 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x781aN2n002716
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 21:36:28 -0400
Received: by mail-qt1-f197.google.com with SMTP id x7so84075207qtp.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 18:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=wDD/Lr50jKFSJWyHsHjv3tgUZU/V2ZEkgULGp3YS+ak=;
        b=JAPERsD8rHrkc3yZvJx8fJ4Niyk11bZPVzPyDnnbjqSsnWBUm3OZLwG7Hmz9cyw8Uz
         XEVTyijVdGuun9iD9SvnGIQXcNS2VWEO8zkw0RmnJqo41OMUJkanzNNPy4YF9ftj8Plm
         NJEkY8WoAkEKw7cv0GARt2WunPw1IO44CrO/y4EWMTqPzBsqdrAtsbjnB5RzDofxKNgC
         MtOFuGcOvZW/v+V5c8v9xIedUNWCuTMihNj3fW7H0bptn2uuiF3/I92eT01uvi3Cae3S
         Hm5ZnFHCm/CG5KK5cmVsAyx82yxk9h00bvcnRb/D58VhMDeG6inD5tnOLWHRBhHLyDiv
         ip7w==
X-Gm-Message-State: APjAAAVPzuL7MEhBmKnXcdwjGUgAkYgj8TbHC3g2liVxq1X6mgonehEl
        CKzPxD15NFgtARioNmFEM7um8Xmthf47+qgsWZzE6+BvlLlBmCM7bwLZF/xW/6nEno9eSLAh6c8
        DLs+YRREyezaGyMLDT698GBadhUbU5GEox3Q=
X-Received: by 2002:a0c:b909:: with SMTP id u9mr11162795qvf.10.1565228183132;
        Wed, 07 Aug 2019 18:36:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzV2hQB57dz/EKjM2sdk199ASLDNBL6auC6xWOoUCv5Mm8H0p2JGaKX4TyHYfniuHnjrYtJmQ==
X-Received: by 2002:a0c:b909:: with SMTP id u9mr11162781qvf.10.1565228182823;
        Wed, 07 Aug 2019 18:36:22 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id t15sm3264392qkm.36.2019.08.07.18.36.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 18:36:21 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 21:36:21 -0400
Message-ID: <33485.1565228181@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 81398d99e9de80d9dbe65dfe7aadec9497f88242
Author: Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed Jul 31 14:44:23 2019 +1000

    checkpatch: add *_NOTIFIER_HEAD as var definition

has a typo, resulting in a truly amazing error message:

Unescaped left brace in regex is passed through in regex; marked by <-- HERE in m/(?:
                                \n.}\s*$|
                                ^.DEFINE_(?^x:
                        [A-Za-z_][A-Za-z\d_]*
                        (?:\s*\#\#\s*[A-Za-z_][A-Za-z\d_]*)*
                )\(rtl_usb_probe\)|
                                ^.DECLARE_(?^x:
                        [A-Za-z_][A-Za-z\d_]*
                        (?:\s*\#\#\s*[A-Za-z_][A-Za-z\d_]*)*
                )\(rtl_usb_probe\)|
                                ^.LIST_HEAD\(rtl_usb_probe\)|
                                ^.{ <-- HERE (?^x:
                        [A-Za-z_][A-Za-z\d_]*
                        (?:\s*\#\#\s*[A-Za-z_][A-Za-z\d_]*)*
                )}_NOTIFIER_HEAD\(rtl_usb_probe\)|

(Rexexp dump continues for 236 lines total)

Fix the typo.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5c00151cdee8..dd095d1e5a19 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3891,7 +3891,7 @@ sub process {
 				^.DEFINE_$Ident\(\Q$name\E\)|
 				^.DECLARE_$Ident\(\Q$name\E\)|
 				^.LIST_HEAD\(\Q$name\E\)|
-				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
+				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
 				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
 				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()
 			    )/x) {


