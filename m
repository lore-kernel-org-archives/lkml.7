Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D63C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF17420855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cQph8sP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKRPCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:02:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38152 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfKRPCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:02:50 -0500
Received: from zn.tnic (p200300EC2F27B50084A11D83797EBEC7.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:84a1:1d83:797e:bec7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DBD21EC0200;
        Mon, 18 Nov 2019 16:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574089365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XTyhnj+xSqWpU/qMZmvQCg0iRnqzVjLg7BwIhpr3zhQ=;
        b=cQph8sP/Wq4TMZPdSE8nauihDpiKWq2+PUNTsGRyXR93blgFgGolkvH2++sCkmRy+b2k85
        R9jTpPCiKDJ6VxsaXVlWq3pzJYGYLgzKxVmnYC55QBAYUR6YBgXkmTX6lZj4y8XvlPHo/D
        2zykQtkHIyeZyJl7h88xvp7VAVEEIWc=
Date:   Mon, 18 Nov 2019 16:02:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH] x86/resctrl: Fix potential lockdep warning
Message-ID: <20191118150240.GF6363@zn.tnic>
References: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
 <20191113114334.GA1647@zn.tnic>
 <ec0f21ce-17a8-5038-4e69-565a28ca041d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec0f21ce-17a8-5038-4e69-565a28ca041d@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 12:13:20AM +0800, Xiaochen Shen wrote:
> Actually this fix covers all the cases of an audit of the calling paths
> of rdt_last_cmd_{clear,puts,printf}(), to make sure we only have the
> lockdep_assert_held() in places where we are sure that it must be held.

That's kinda what I suggested, isn't it?

All I meant was, not to have a

	rdtgroup_kn_lock_live()

call in the code as this function does *not* unconditionally grab the
rdtgroup_mutex. And then call a function which unconditionally checks
whether the mutex is held.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
