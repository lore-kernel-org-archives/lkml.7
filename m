Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F79C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E8120835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lotr40/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfD3Jdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:33:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44208 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfD3Jdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:33:46 -0400
Received: from zn.tnic (p200300EC2F073600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 393941EC0AD8;
        Tue, 30 Apr 2019 11:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556616824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ljxzd7ohjGfa/y1AJl6pGQde15gtyslFFyhUFGUUNAU=;
        b=lotr40/nuVuGL3vT4h5G5VutB3s/wvjt+rcxHxqIws9p6QtZFSfqlfc2dZuJpC7m5U4E1/
        EGKwZUYIHuHBHu5Fxt7TTO3z0aZx/cnJdDp7mGCIRz0LYOTzconMBId6hWj/0xCxBhjksk
        Z8s4M+PeugmXqVWcwWeZW5A353F/qcA=
Date:   Tue, 30 Apr 2019 11:33:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
Message-ID: <20190430093338.GA3518@zn.tnic>
References: <20190226062012.23746-1-lenb@kernel.org>
 <20190226190512.GR2861@worktop.programming.kicks-ass.net>
 <CAJvTdK=SGZy+vbTcCKAmBeQSkeuAW0UxEpKXY2YNvmUofFXNUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdK=SGZy+vbTcCKAmBeQSkeuAW0UxEpKXY2YNvmUofFXNUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:50:58AM -0400, Len Brown wrote:
> If one were to make a change here, I'd consider adding the (physical) die_id,
> though it is already in sysfs topology as an attribute.

 From: Documentation/x86/topology.txt

"The kernel does not care about the concept of physical sockets because
a socket has no relevance to software. It's an electromechanical
component. In the past a socket always contained a single package
(see below), but with the advent of Multi Chip Modules (MCM) a socket
can hold more than one package. So there might be still references to
sockets in the code, but they are of historical nature and should be
cleaned up."

So that die thing has only small relevance to some software, as you say:

"These topology changes primarily impact parts of the kernel and some
applciations that care about package MSR scope."

So if there's no real need to add it there, then it probably shouldn't
be added. The topology is already too complex - so much so, that tools
are even generating PDFs from it :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
