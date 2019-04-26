Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC978C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7612089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aia7Du3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDZJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:58:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47826 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfDZJ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:58:06 -0400
Received: from zn.tnic (p200300EC2F0E4E00083B53278C752809.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4e00:83b:5327:8c75:2809])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 826671EC014A;
        Fri, 26 Apr 2019 11:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556272685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VHXOYvuGCEpH7+kGFsoVKXhWhjrn8vwqYBRpfwVM8sk=;
        b=aia7Du3by+IGDICmz9K38elC/tV+J9McwxWcSSmQPBlQEHlKgsfOHwatDcPpD++i+Gbzjh
        JQW7GfGAIP2ugjjz+WOciuiZKsmsjg/Ew00keEF+AokcXBKrVTaIYO7FvAP0wwo2/e4dBm
        Ezed39TIWF5OMnkXNIjvZIexv7fH5uc=
Date:   Fri, 26 Apr 2019 11:58:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>, dyoung@redhat.com,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190426095800.GB4608@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic>
 <20190419113621.GD10324@zn.tnic>
 <20190422143346.GD3584@localhost.localdomain>
 <20190422151723.GD21457@zn.tnic>
 <20190426095134.GP3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190426095134.GP3584@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 05:51:34PM +0800, Baoquan He wrote:
> I can make a patch to add a bit into xloadflags, to indicate that this
> is kexec-ed kernel. It can help to differentiate kexec-ed kernel from
> kdump kernel.

From the recent snafu, the only thing we needed is to differentiate
between the *first* kernel and the following kernel(s) which has been
started/loaded using a kexec syscall.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
