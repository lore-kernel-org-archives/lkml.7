Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D197C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25492081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="CZmcJgO9";
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="CZmcJgO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfILL7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:59:00 -0400
Received: from mail-out.elkdata.ee ([185.7.252.64]:62461 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731438AbfILL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:58:59 -0400
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-out.elkdata.ee (Postfix) with ESMTP id C492A37207C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:58:54 +0300 (EEST)
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id BF9D0830881
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:58:54 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay2.elkdata.ee ([185.7.252.69])
        by mail-relay2.elkdata.ee (mail-relay2.elkdata.ee [185.7.252.69]) (amavisd-new, port 10024)
        with ESMTP id 5qWOC6umzKRv for <linux-kernel@vger.kernel.org>;
        Thu, 12 Sep 2019 14:58:52 +0300 (EEST)
Received: from mail.elkdata.ee (unknown [185.7.252.68])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 5BC638308C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:58:52 +0300 (EEST)
Received: from mail.meie.biz (21-182-190-90.sta.estpak.ee [90.190.182.21])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id 54D9760BF17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:58:52 +0300 (EEST)
Received: by mail.meie.biz (Postfix, from userid 500)
        id 43DE3A97881; Thu, 12 Sep 2019 14:58:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1568289532; bh=aAy9Hz9dJJxWqNFUhmDvCASjPhVVCM0iaPo/txBf8lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CZmcJgO93seGVxPrvJeF48551SDbAs0p6qqY+hdyoQs9kVDNXbBDjrUx5EFyCRkZl
         1+ctXrME2HEcxhLB6wT0mwjUNg5XCVO5KrX/LtDBzgxPJ/gRnw6rOo2al0uGuFpkGf
         bGGEmpWVGtKCuJEdvAb1DVRQ+q1Z/9N1Y6gEbqjM=
Received: from papaya (papaya.meie.biz [192.168.1.206])
        by mail.meie.biz (Postfix) with ESMTPA id EC45CA97875;
        Thu, 12 Sep 2019 14:58:51 +0300 (EEST)
Authentication-Results: mail.meie.biz; dmarc=fail (p=none dis=none) header.from=kraav.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1568289532; bh=aAy9Hz9dJJxWqNFUhmDvCASjPhVVCM0iaPo/txBf8lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CZmcJgO93seGVxPrvJeF48551SDbAs0p6qqY+hdyoQs9kVDNXbBDjrUx5EFyCRkZl
         1+ctXrME2HEcxhLB6wT0mwjUNg5XCVO5KrX/LtDBzgxPJ/gRnw6rOo2al0uGuFpkGf
         bGGEmpWVGtKCuJEdvAb1DVRQ+q1Z/9N1Y6gEbqjM=
Received: (nullmailer pid 24731 invoked by uid 1000);
        Thu, 12 Sep 2019 11:58:51 -0000
Date:   Thu, 12 Sep 2019 14:58:51 +0300
From:   "leho@kraav.com" <leho@kraav.com>
To:     Martin Wilck <Martin.Wilck@suse.com>
Cc:     "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Michal Koutny <MKoutny@suse.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.3-rc3: Frozen graphics with kcompactd migrating i915 pages
Message-ID: <20190912115851.GD6147@papaya>
References: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
 <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
 <20190910142047.GB3029@papaya>
 <3dcff41048621ff440687dd6691aae31a8647a1e.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3dcff41048621ff440687dd6691aae31a8647a1e.camel@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.500000, version=1.2.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 11:23:09AM +0000, Martin Wilck wrote:
> 
> There's a considerable risk that many users will start seeing this
> regression when 5.3 is released. I am not aware of a workaround.
> 
> Is there an alternative to reverting aa56a292ce62 ("drm/i915/userptr:
> Acquire the page lock around set_page_dirty()")? And if we do, what
> would be the consequences? Would other patches need to be reverted,
> too?

I've been running with revert patch for a couple of days and have not
encountered any kernel warnings thus far, nor any other ill effects that
could be attributed to this locking mechanism.

But I'm far from familiar with these subsystems.

Graphics does not hang anymore.

I've also received developer feedback in private that this really should
be fixed before 5.3 release.

-- 
Leho Kraav, senior technology & digital marketing architect
