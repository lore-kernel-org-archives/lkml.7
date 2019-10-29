Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ADFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C39C20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfJ2LFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:05:19 -0400
Received: from trent.utfs.org ([94.185.90.103]:59884 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2LFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:05:19 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id DB8076012D;
        Tue, 29 Oct 2019 12:05:16 +0100 (CET)
Date:   Tue, 29 Oct 2019 04:05:16 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        zhanglin <zhang.lin16@zte.com.cn>, dan.j.williams@intel.com,
        jgg@ziepe.ca, mingo@kernel.org, dave.hansen@linux.intel.com,
        namit@vmware.com, bp@suse.de, christophe.leroy@c-s.fr,
        rdunlap@infradead.org, osalvador@suse.de,
        richardw.yang@linux.intel.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] kernel: Restrict permissions of /proc/iomem.
In-Reply-To: <201910281213.720C0DB89@keescook>
Message-ID: <alpine.DEB.2.21.99999.352.1910290359280.2844@trent.utfs.org>
References: <1571993801-12665-1-git-send-email-zhang.lin16@zte.com.cn> <20191025143220.cb15a90fe95a4ebdda70f89c@linux-foundation.org> <201910281213.720C0DB89@keescook>
User-Agent: Alpine 2.21.99999 (DEB 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Kees Cook wrote:
> > It's risky to change things like this - heaven knows which userspace
> > applications might break.
> > 
> > Possibly we could obfuscate the information if that is considered
> > desirable.  Why is this a problem anyway?  What are the possible
> > exploit scenarios?
> 
> This is already done: kptr_restrict sysctl already zeros these values
> if it is set. e.g.:
> 
> 00000000-00000000 : System RAM
>   00000000-00000000 : Kernel code
>   00000000-00000000 : Kernel data
>   00000000-00000000 : Kernel bss
> 
> > Can't the same info be obtained by running dmesg and looking at the
> > startup info?
> 
> Both virtual and physical address dumps in dmesg are considered "bad
> form" these days and most have been removed.
> 
> > Can't the user who is concerned about this run chmod 0400 /proc/iomem
> > at boot?
> 
> That is also possible.

As a user, I still like this patch, or some variation of it. On various 
(server and desktop) systems I do this during boot for some time now and 
never had a problem:

find /proc -xdev -mindepth 1 -maxdepth 1 ! \( -name "[0-9]*" \
  -o -name cpuinfo -o -name modules -o -name loadavg -o -name meminfo \ 
  -o -name mounts -o -name net -o -name self -o -name diskstats \
  -o -name stat -o -name sys -o -name swaps -o -name thread-self \
  -o -name vmstat -o -name uptime \) -exec chmod -c go-rwx '{}' +

C.
-- 
BOFH excuse #436:

Daemon escaped from pentagram
