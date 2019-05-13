Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E693C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139EC206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rPyRgNqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfEMHuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:50:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33050 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfEMHuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:50:14 -0400
Received: from zn.tnic (p200300EC2F29E500E0EF2AA1CE3E4EBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:e500:e0ef:2aa1:ce3e:4ebd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5E561EC0380;
        Mon, 13 May 2019 09:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557733812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6D4CnAScIoeS9pJoUChZMx+t6OGcqUGcrnbQZkMlkII=;
        b=rPyRgNqQXxs1vWh/ITXiBzXG7D+gWpV4kZLi7Y1THG3sNJi7H+FDRvPBPzUynfBCmuNJge
        t36Jx9RSqZe9rA9LJ1U8pTgW8DcjNiS+YneBo/fHN9vdxqt7uZEDvYSr+lZU7Kbt+qrhEJ
        4AaLvoFPBQV4sSTs6YVwvMVua4hLUFw=
Date:   Mon, 13 May 2019 09:50:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190513075006.GB20105@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513073254.GB16774@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> This is a critical bug which breaks memory hotplug,

Please concentrate and stop the blabla:

36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")

already explains what the deal is. This code was *purposefully* disabled
because we ran out of time and it broke a couple of machines. Don't make
me repeat all that - you were on CC on *all* threads and messages!

So we're going to try it again this cycle and if there's no fallout, it
will go upstream. If not, it will have to be fixed. The usual thing.

And I don't care if Kairui's patch fixes this one problem - judging by
the fragility of this whole thing, it should be hammered on one more
cycle on as many boxes as possible to make sure there's no other SNAFUs.

So go test it on more machines instead. I've pushed it here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
