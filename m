Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B82DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD5323430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ggwKB1p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfH3TgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:36:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60330 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfH3TgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:36:05 -0400
Received: from zn.tnic (p200300EC2F0AAA0065BEA12EFE5D4E65.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:aa00:65be:a12e:fe5d:4e65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55C261EC0819;
        Fri, 30 Aug 2019 21:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567193763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FTGKhVuj3U6v9FsAz7Xts6Aci6B1WqfD2IhDMm4Gyy4=;
        b=ggwKB1p6KENXFxHZSrgTtJiNNhKCXZMkBEY4L1zRwZ22OYNJJwG+V5PBzwgtRUr3rZ/Ln5
        KFoDXfx3ZYSpj6CbIJeCFDRz0DEvYtpqQdz90bgHQ2q9VNy5vNB/hnLSB7tQxgKSR/5oS2
        isbzRBLmzDN+PqDVpx+4VFmBBF6fn+8=
Date:   Fri, 30 Aug 2019 21:35:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        linux-input@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
        pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>,
        Doug Covelli <dcovelli@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Message-ID: <20190830193557.GF30413@zn.tnic>
References: <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
 <20190830080650.GA30413@zn.tnic>
 <20190830143645.GA4784@intel.com>
 <20190830144628.GC30413@zn.tnic>
 <20190830150002.GA6931@intel.com>
 <20190830150856.GB6931@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830150856.GB6931@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:08:56PM +0800, Philip Li wrote:
> hi Boris, for the build status notification, we currently send to below
> address, is it still valid? If not, can you suggest one for us?

Sure, here's an update patch ontop of your master branch:

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 30 Aug 2019 21:33:29 +0200
Subject: [PATCH] repo/linux/tip: Update tip tree contact information

Replace hpa with Borislav and change contact mail address.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 repo/linux/tip | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/repo/linux/tip b/repo/linux/tip
index 4fc5d88176fd..96a7dec66f97 100644
--- a/repo/linux/tip
+++ b/repo/linux/tip
@@ -2,11 +2,11 @@ url: https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git
 integration_testing_branches: auto-latest
 mail_cc:
 - linux-kernel@vger.kernel.org
-- tipbuild@zytor.com
+- x86@kernel.org
 owner:
 - Ingo Molnar <mingo@kernel.org>
-- H. Peter Anvin <hpa@zytor.com>
 - Thomas Gleixner <tglx@linutronix.de>
+- Borislav Petkov <bp@suse.de>
 subsystems:
 - x86
 - fpu
@@ -16,4 +16,4 @@ subsystems:
 - locking
 blacklist_branch: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus
 notify_build_success_branch: .*
-build_success_mail_to: tip build status <tipbuild@zytor.com>
+build_success_mail_to: x86-ml <x86@kernel.org>
-- 
2.21.0

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
