Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F867206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YO0/HFc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDAMsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:48:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDAMsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:48:21 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C98A1EC0310;
        Mon,  1 Apr 2019 14:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554122900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0CSND4EDKrNHbb+ptwIFlKOpDBcIg0eteMtBzaS7M/w=;
        b=YO0/HFc5gj/ULfJD35DPs8KvBE5mEwqI6okeh8zwI1MWtVNwbsHUNsESsvpmuSMIayeRSy
        9mNUwRBpK33Kf1t0GbTcFXOyrUxm5abavM7a0kNDkbgP4aL4/0EGkG+1/KCwbVDLr3ZTxr
        Xbr1i/XRLslhac4y8gplZFbmXfrwt4o=
Date:   Mon, 1 Apr 2019 14:48:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
Message-ID: <20190401124814.GD28264@zn.tnic>
References: <20190330112022.28888-1-bp@alien8.de>
 <20190330112022.28888-6-bp@alien8.de>
 <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
 <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:32:59AM +0200, Rafael J. Wysocki wrote:
> Or I can queue it up if you prefer.

Doesn't matter to me - it doesn't have any dependencies to previous
patches so however you like.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
