Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45DC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828A0214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLNM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 07:58:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:59496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfLNM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 07:58:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65A29ADEB;
        Sat, 14 Dec 2019 12:58:38 +0000 (UTC)
Date:   Sat, 14 Dec 2019 13:58:31 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fanc.fnst@cn.fujitsu.com, ardb@kernel.org,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20191214125831.GA29335@zn.tnic>
References: <CAFH1YnM_2xud4V7sAZAMWPpWP0CBHxuddAKjxHJsj9U9WfH2ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFH1YnM_2xud4V7sAZAMWPpWP0CBHxuddAKjxHJsj9U9WfH2ww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:04:17PM +0800, Zhenzhong Duan wrote:
> This patch fixes below warning by moving variable 'i':

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’
> [-Wunused-variable]

You could explain here why the warning fires...

> Also use true/false instead of 1/0 for boolean return.
> 
> Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the
> kernel in immovable memory only")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


WARNING: please, no spaces at the start of a line
#45: FILE: arch/x86/boot/compressed/kaslr.c:707:
+ return true;$

WARNING: please, no spaces at the start of a line
#48: FILE: arch/x86/boot/compressed/kaslr.c:709:
+ return false;$

WARNING: please, no spaces at the start of a line
#52: FILE: arch/x86/boot/compressed/kaslr.c:713:
+ int i;$

ERROR: patch seems to be corrupt (line wrapped?)
#60: FILE: arch/x86/boot/compressed/kaslr.c:736:
regions(slot_areas full)!\n");

WARNING: please, no spaces at the start of a line
#62: FILE: arch/x86/boot/compressed/kaslr.c:737:
+ return true;$

WARNING: please, no spaces at the start of a line
#67: FILE: arch/x86/boot/compressed/kaslr.c:741:
+ return false;$


$ test-apply.sh /tmp/zhenzhong.duan.01 
checking file arch/x86/boot/compressed/kaslr.c
patch: **** malformed patch at line 60: regions(slot_areas full)!\n");

I'd be very interested to know how you even managed to create such a
well, hm, "patch"?!

For the future, before you send a patch:

- use checkpatch on it
- send it to yourself and try applying it first

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
