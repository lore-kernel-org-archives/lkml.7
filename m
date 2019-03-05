Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A142C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC78D2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3WIi8Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfCEMW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:22:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MPzhpscRytauqY0bU3jX+4ZTH08+VsYn8KiNXzLTaiM=; b=a3WIi8Vk7YTP592YxSJko+5QR
        CUk3vJtDPSlgnu3MFIv27SF9qks7+gzam6nHCfuytMgojFyZG8H9UGkW1ZFE3gAysnJTdVNchTb/O
        NhiHy4RIqLsUTys+3VvmOs2DQWwOfPOBJf4yyDUCGscVS8nboUFZgecnRxhWZEDNxPY8A1GVR0ERR
        MGEIXrbUBeRfHITHDhRFUD/QVy33VM4ujnlAkBY/tM7v9tql+i0jSWcL9I5nPYv9GnJqyWAOanNqX
        eAfueoBCQCJNFcFWu0i9xcJm6d24tV9ueG1LYIz3zPpE/IqGogwc0wzWAAxZGf2GttsP6ZJVektJ+
        TfWYLcWxw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h195O-0007q7-Ru; Tue, 05 Mar 2019 12:22:18 +0000
Date:   Tue, 5 Mar 2019 04:22:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: a.out coredumping: fix or delete?
Message-ID: <20190305122218.GD13380@bombadil.infradead.org>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305091904.GB8256@zn.tnic>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 10:19:04AM +0100, Borislav Petkov wrote:
> On Sat, Mar 02, 2019 at 12:57:30AM +0100, Jann Horn wrote:
> > In theory, Linux can dump cores for a.out binaries. In practice, that
> > code is pretty bitrotten and buggy. Does anyone want that code so much
> > that they'd like to fix it, or can we just delete it?
> 
> I was asking myself the same question while doing
> 
>   10970e1b4be9 ("x86/a.out: Clear the dump structure initially")
> 
> especially since it is kinda hard to get the toolchain to even create an
> a.out executable - your script to create one case-in-point.

It's been 25 years since Linux added support for ELF.  Can we just
delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
support was added in 1.1.52 (August 1994).  It's pretty much necromancy
at this point.
