Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C139EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877562133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558606710;
	bh=JifrdQE47dqJRXjPaDe1E4L25whVXnXXOKoGofDLhRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ldNtqq+yBCrenP7YY3ucxEiYe0STlYpMJ0TUbdnmWnb6awNRcAEy6vZHiQ2bbr0Ro
	 FAC7gvH04/9Ah39tIzTYCpJWU1d4Q6x5XhShv3b58nNGrjUQXY5g7knTPGxSeDJQLq
	 FWNKkLxLgqeqZ7N35G3JHrY7WzrckHn9Xgovfaa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfEWKS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfEWKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:18:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D044E2081C;
        Thu, 23 May 2019 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558606708;
        bh=JifrdQE47dqJRXjPaDe1E4L25whVXnXXOKoGofDLhRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcAH1yVDp58hMy7lfCaaFsaTHMxvF8Ehrau1rSrtPR9NKLWzWWg9u6YAu8AEJnqbE
         NVqk83wa3AL42DP9lYJCCRFWssgE/NqA4LAR+30odq/J+vC8FIJECRKv5eNc+zDQ1m
         NT2Ix3l2UTadau1flt4TnKXxK3uGzS88brPnA9jQ=
Date:   Thu, 23 May 2019 12:18:26 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Message-ID: <20190523101826.GA11016@kroah.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:10:52AM +0000, TonyWWang-oc wrote:
> Add x86 architecture support for new Zhaoxin processors.
> Carve out initialization code needed by Zhaoxin processors into
> a separate compilation unit.
> 
> To identify Zhaoxin CPU, add a new vendor type X86_VENDOR_ZHAOXIN
> for system recognition.
> 
> Signed-off-by: TonyWWang <TonyWWang-oc@zhaoxin.com>
> ---
> MAINTAINERS                      |   6 ++
> arch/x86/Kconfig.cpu             |  13 +++
> arch/x86/include/asm/processor.h |   3 +-
> arch/x86/kernel/cpu/Makefile     |   1 +
> arch/x86/kernel/cpu/zhaoxin.c    | 178 +++++++++++++++++++++++++++++++++++++++
> 5 files changed, 200 insertions(+), 1 deletion(-)
> create mode 100644 arch/x86/kernel/cpu/zhaoxin.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c55b0f..cab21a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17460,6 +17460,12 @@ Q: https://patchwork.linuxtv.org/project/linux-media/list/
> S: Maintained
> F: drivers/media/dvb-frontends/zd1301_demod*
> +ZHAOXIN PROCESSOR SUPPORT
> +M: TonyWWang <TonyWWang-oc@zhaoxin.com>
> +L: linux-kernel@vger.kernel.org
> +S: Maintained
> +F: arch/x86/kernel/cpu/zhaoxin.c
> +
> ZPOOL COMPRESSED PAGE STORAGE API
> M: Dan Streetman <ddstreet@ieee.org>
> L: linux-mm@kvack.org

I think your email client ate the leading space here :(

Anyway, you need a blank line before your entry.

thanks,

greg k-h
