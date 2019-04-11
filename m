Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E362EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80EC2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ikwcMpIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDKIhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:37:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59576 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfDKIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:37:42 -0400
Received: from zn.tnic (p200300EC2F0ABD00803D8A3D4BEC4F6D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:bd00:803d:8a3d:4bec:4f6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 031A91EC04B9;
        Thu, 11 Apr 2019 10:37:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554971861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ultOY7/yowO3fy1k9g9PaL/Ewux13tHRl3KnOEqGg2U=;
        b=ikwcMpIQfuf+QVBw51ZlOIDCG6FauITSvRn5nTR3AVCpGl+IZ59RUGg9jisf1S2R+MMBZ+
        HdaQNpBalh8W9+Dp9ZvIgVwBKYGNshPwa+zCOiVk5ATPrB4PqKd9b5ylg2LSqwFojdAIJq
        nPyJpTtc61XkCp5zw2SEKo3w3PINWjg=
Date:   Thu, 11 Apr 2019 10:37:38 +0200
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
Message-ID: <20190411083738.GC30080@zn.tnic>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:16:45AM +0000, Junichi Nomura wrote:
> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
> will hit the problem of accessing invalid table pointer again.

Then you need to do this:

	if (kexeced kernel) {
		addr = kexec_get_rsdp_addr();
		if (!addr) {
			/* cannot get address */
			return -1;
		}

		return addr;
	}

and the calling function get_rsdp_addr() must check the return value and
if it is not 0, return immediately.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
