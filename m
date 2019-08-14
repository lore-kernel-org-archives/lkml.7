Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00CC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CF020843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EHDCKtey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfHNHEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:04:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46838 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfHNHEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:04:14 -0400
Received: from zn.tnic (p200300EC2F0BD0001434546E6F7AC9DD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d000:1434:546e:6f7a:c9dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA0091EC02FE;
        Wed, 14 Aug 2019 09:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565766253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=apeO/Y9BwTwsaeyf+fZnRg01zq+ODzdXIwAuky6NwsM=;
        b=EHDCKteyEG0E3E+Y6U46OjwbTGFjqqI31w3PUou5vVP6wdbLVZhU2QwcFx56I6zY6kaH8G
        p0PrsTor/MFNoBiaarQqMsaHXU6NvPShyYkD8JvoXe85tPUPo4dv7qPhZwFw3oJxER2inL
        ocALddnyBusIkvcVp8w8wSD79SljYso=
Date:   Wed, 14 Aug 2019 09:04:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kernel User <linux-kernel@riseup.net>
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
Message-ID: <20190814070457.GA26456@zn.tnic>
References: <20190813232829.3a1962cc@localhost>
 <20190813212115.GO16770@zn.tnic>
 <20190814010041.098fe4be@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814010041.098fe4be@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:00:41AM +0300, Kernel User wrote:
> That could be clarified like:
> 
> vulnerability1 - mitigation MDS
> vulnerability2 - mitigation MDS
> vulnerability3 - mitigation 3 (another mitigation)
> ...
>
> Then it could be a file with content saying "No mitigation".

And keep adding a sysfs file for each new variant and CVE?

Hell no.

> Knowing that there is no mitigation or that a CPU is not affected is
> quite different from not knowing anything. So I don't see why you
> conclude that knowledge is unnecessary.

IMO, what you want does not belong in sysfs but in documentation.

I partially see your point that a table of sorts mapping all those CPU
vulnerability names to (possible) mitigations is needed for users which
would like to know whether they're covered, without having to run some
scripts from github, but sysfs just ain't the place.

Again, this is only my opinion.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
