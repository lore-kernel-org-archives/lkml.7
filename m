Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA842206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WGcKsYPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:14:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49144 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCQOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:14:37 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7B861EC01B6;
        Wed,  3 Apr 2019 18:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554308075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H1ruVofZVi+fxi953ENMW7GBv5r8y8bThr2vBdd8VKk=;
        b=WGcKsYPXkregnf/2kl6mQw8bdXNl0Uy6MzNnzfXfP9w90O7shQMkEv6Tho+s+MDJnrC3ZI
        jSfmEK6Lqee2GTyh2UCr7BLBZzDVlmXUCBjCReXHuSuJxtxB6mIMZw11sjS0lOIKd7xqAN
        IMII8foQCk8aadMGIM7DHt0AKZ9O2eQ=
Date:   Wed, 3 Apr 2019 18:14:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403161429.GD6970@zn.tnic>
References: <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
 <20190403073023.GF1555@localhost.localdomain>
 <20190403075015.GQ7627@MiWiFi-R3L-srv>
 <20190403082313.GA14838@dhcp-128-65.nay.redhat.com>
 <20190403082634.GA14852@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403082634.GA14852@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:26:34PM +0800, Dave Young wrote:
> Personally I would like to have a cmdline to bypass the early acpi code
> because early code is hard to debug, if we have something weird happens
> we can try to gate out these code, and then get some idea..

No, this early crap better work on all machines by default.

Also, Chao, are you telling me that you've only tested in a VM? Or
have you actually tested your code on an actual machine with memory
hotremove?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
