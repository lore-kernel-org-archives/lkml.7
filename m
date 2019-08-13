Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF29C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9014020842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X5QM0mr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHMVUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:20:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51852 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfHMVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:20:31 -0400
Received: from zn.tnic (p200300EC2F0D24001434546E6F7AC9DD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:1434:546e:6f7a:c9dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B02FC1EC09A0;
        Tue, 13 Aug 2019 23:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565731229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2yTRFcfoQAJUotojrKw6EZh+Y8eKJ3yXx+6PAGXWMgg=;
        b=X5QM0mr9JTQP4ZnEJ04D8BqJ1yHp5EX8vWX8ENk92UuCs/bHE3vG6Q3SmSkHQEaM9aUkPn
        GmR8Q9NC2vm3Ej/fISqATF8PebO5YXnlqSeNDCaW+AJVn84IMMQEXUjiGXMF95FScPAb1R
        URwaO/CVUZrPD9vdwYqqqUZj75q2QIU=
Date:   Tue, 13 Aug 2019 23:21:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kernel User <linux-kernel@riseup.net>
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
Message-ID: <20190813212115.GO16770@zn.tnic>
References: <20190813232829.3a1962cc@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813232829.3a1962cc@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:28:29PM +0300, Kernel User wrote:
> Hi,
> 
> 'ls /sys/devices/system/cpu/vulnerabilities/' doesn't show all known
> CPU vulnerabilities and their variants. Only some of them:
> 
> l1tf  mds  meltdown  spec_store_bypass  spectre_v1  spectre_v2
> 
> Wikipedia shows more variants:
> 
> https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability)#Speculative_execution_security_vulnerabilities
> 
> It would be good to have a full list with statuses. Then one won't need to use external (potentially non-safe) tools like https://github.com/speed47/spectre-meltdown-checker to find out the vulnerabilities of a system.
> 

You have to consider that some of those are addressed by a single
mitigation like MDS; the mitigation for others like lazy FPU restore
is not even present in /sys/devices/system/cpu/vulnerabilities/. Also,
depending on the CPU, some are not even affected.

So maintaining this in the kernel is unnecessary to say the least.

We could use a writeup somewhere which maps each vulnerability name -
and they're a gazillion by now - to the respective mitigation and what
is required but I'm not aware of such a writeup.

Documentation/admin-guide/hw-vuln/ could be a good start and
Documentation/admin-guide/hw-vuln/mds.rst could be a good example how
one should document the vulnerabilities and their mitigation. But that
would need to be exhaustive.

IMHO of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
