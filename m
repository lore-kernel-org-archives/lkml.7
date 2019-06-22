Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D0C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C2620665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p8qzLpHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFVKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:12:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56393 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:12:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MABt732097514
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:11:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MABt732097514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198316;
        bh=cs+proYs2/G4b6R8NzN1/srAp4B2A8bz7b0FErT2smE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p8qzLpHGV92b0MKhf+/isGD9RIabijOfJFodi9j6CIMvq0RuU3AJ6q9rI0B40FJbs
         P0ODJl2LtJfkdtzMV7O7FsQ9dY7l/4jBRwosrP92qCRN0ZaxUlmlHruB4tn5Fje5tR
         mDMKdfpqP1qFdR76RS6dJ2x8WjT47vNoNwU+UpY7muu5qR+4X88p8Sd5o8lL3ogvEn
         pBulug0RSSwTuvw80h+MhCqZlcTU4O4bitQyHIFoV+JDd94eoPFfVh1YG1ZYSZckmB
         GB73drzMZHVHGNxHVimWoiIUvyU+gj7drqeURR9+vCOQ8vMWC6Lu4+fVYyIKf4RIDE
         WGYlvAKGLnvww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MABtg72097511;
        Sat, 22 Jun 2019 03:11:55 -0700
Date:   Sat, 22 Jun 2019 03:11:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-5bf0cab60ee2c730ec91ae0aabc3146bcfed138b@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, chang.seok.bae@intel.com,
        luto@kernel.org, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, mingo@kernel.org
Reply-To: ak@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
          luto@kernel.org, chang.seok.bae@intel.com, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <1557309753-24073-14-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-14-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/entry/64: Document GSBASE handling in the
 paranoid path
Git-Commit-ID: 5bf0cab60ee2c730ec91ae0aabc3146bcfed138b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5bf0cab60ee2c730ec91ae0aabc3146bcfed138b
Gitweb:     https://git.kernel.org/tip/5bf0cab60ee2c730ec91ae0aabc3146bcfed138b
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:28 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:55 +0200

x86/entry/64: Document GSBASE handling in the paranoid path

On a FSGSBASE system, the way to handle GSBASE in the paranoid path is
different from the existing SWAPGS-based entry/exit path handling. Document
the reason and what has to be done for FSGSBASE enabled systems.

[ tglx: Massaged doc and changelog ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-14-git-send-email-chang.seok.bae@intel.com

---
 Documentation/x86/entry_64.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index a48b3f6ebbe8..b87c1d816aea 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -108,3 +108,12 @@ We try to only use IST entries and the paranoid entry code for vectors
 that absolutely need the more expensive check for the GS base - and we
 generate all 'normal' entry points with the regular (faster) paranoid=0
 variant.
+
+On a FSGSBASE system, however, user space can set GS without kernel
+interaction. It means the value of GS base itself does not imply anything,
+whether a kernel value or a user space value. So, there is no longer a safe
+way to check whether the exception is entering from user mode or kernel
+mode in the paranoid entry code path. So the GSBASE value needs to be read
+out, saved and the kernel GSBASE value written. On exit the saved GSBASE
+value needs to be restored unconditionally. The non paranoid entry/exit
+code still uses SWAPGS unconditionally as the state is known.
