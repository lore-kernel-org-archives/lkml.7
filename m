Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C452084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VLMZE5yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfDLNfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:35:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLNfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:35:37 -0400
Received: from zn.tnic (p200300EC2F08840068A43035F0D96009.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:68a4:3035:f0d9:6009])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A22581EC00FF;
        Fri, 12 Apr 2019 15:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555076135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UPWzm4vt0PY0+c6ptfDK1JVk5pXwzJlg2U0OHKqmWuM=;
        b=VLMZE5yIeNBHSYJO5gtOS9RFE0nPnE/DxnEqxK4QL1cL/n30Mmy4QjFVOW8mvYBVD3fBip
        I7GycxOPpw2zTqEy5Z/Q8SqTq/2fp+58tKKkXVgj866G0jmydI5qCgpFFfdU9nCz91KHRb
        Tuc6kkH21HBgev+lEkrptFs/h9vFRJI=
Date:   Fri, 12 Apr 2019 15:35:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190412133528.GD19808@zn.tnic>
References: <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412084956.GC19808@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 10:49:56AM +0200, Borislav Petkov wrote:
> Now I need to go figure out whether there's a reliable way to know in
> the kexec kernel that it *is* a kexec kernel.

Actually, thinking about this more, we don't need to know whether the
kernel was kexeced or not. Why?

Because if it is kexec'ed, kexec(1) passes the required info in
setup_data. Now, if for whatever reason the kexec'ed kernel fails to
parse that EFI info and get the systab to figure out the RDSP, then it
doesn't have any other choice but fail booting.

Because there's no way it can figure out where the EFI runtime has been
mapped and recover by finding the RDSP from there.

So I think we're perfectly fine with the old approach:

        if (!pa)
                pa = kexec_get_rsdp_addr();

        if (!pa)
                pa = efi_get_rsdp_addr();


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
