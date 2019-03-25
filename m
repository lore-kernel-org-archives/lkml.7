Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F116CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B2520850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QPLjSQUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfCYMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:01:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbfCYMBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:01:48 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A9A71EC0AB1;
        Mon, 25 Mar 2019 13:01:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553515306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jj6OEgUdGyvK5Ruk41VfP7owdlNji7XDwQ7O4kfF5lY=;
        b=QPLjSQUHWurhFY+IkMVdAZZqFLoiFvts8ooYgQl1VhQ+SwfvCngJHD9/M0j3hCE6BhyGcR
        txPmFaL5EOGuXoHEZIyvZfsmAdh79GeV7cS/8+UjJJZO85m2geq2Z43Gw2p0b+ICj2CcmC
        Q0lzwAOkvDRmUxMy/NLD2ZvaGyQEFS8=
Date:   Mon, 25 Mar 2019 13:01:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190325120149.GI12016@zn.tnic>
References: <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:36:33AM +0000, Junichi Nomura wrote:
> AFAIU, early parsing is new code in v5.1-rc1 to support kexec on systems
> with hotpluggable memory with KASLR enabled. For systems that requires the
> new feature, it may be ok to say "you need to use another kexec interface"
> and/or "you need new kexec-tools".

No, this exactly should *not* happen. kexec is already full of duct tape
- don't need any more of that.

So I suggested that efi_get_rsdp_addr() should exit early on in the
kexeced kernel but making this all play nice with the kexec-ed kernel,
as Dave suggests, is better.

Now, my next question is: why does the RDSP address need to come from
kexec(1) (by way of efi_setup_data) and why can't the kexec'ed kernel
figure it out itself by parsing the EFI tables in a similar way to
efi_get_rsdp_addr ?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
