Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C0BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036E206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfG2Usv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:48:51 -0400
Received: from hall.aurel32.net ([195.154.113.88]:46344 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388000AbfG2Usv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:48:51 -0400
X-Greylist: delayed 1545 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 16:48:50 EDT
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1hsCAg-0003MP-On; Mon, 29 Jul 2019 22:23:02 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1hsCAg-0007Jz-AQ; Mon, 29 Jul 2019 22:23:02 +0200
Date:   Mon, 29 Jul 2019 22:23:02 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, steve.mcintyre@arm.com, dave.martin@arm.com
Subject: Re: [PATCH 0/2] Don't use SIGMINSTKSZ when enforcing alternative
 signal stack size for compat tasks
Message-ID: <20190729202302.GA3443@aurel32.net>
Mail-Followup-To: Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, oleg@redhat.com,
        steve.mcintyre@arm.com, dave.martin@arm.com
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-25 14:45, Will Deacon wrote:
> Hi all,
> 
> The Debian folks have observed a failure in the 32-bit arm glibc testsuite
> when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
> enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
> which is higher for native arm64 tasks than compat 32-bit tasks.
> 
> These patches resolve the issue by allowing an architecture to define
> COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
> checking code.
> 
> Feedback welcome,
> 
> Will
> 
> --->8
> 
> Will Deacon (2):
>   signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
>   arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ

Only the first patch went to the stable kernels. The second one is
missing, so the bug is still not fixed in those kernels. Would it be
possible to also get it included?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
