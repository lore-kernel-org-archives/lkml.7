Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445BCC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CAF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cvHeDP1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfDJQkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:40:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731199AbfDJQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:40:40 -0400
Received: from zn.tnic (p200300EC2F0CAE00C097970AF3E0D9DA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:c097:970a:f3e0:d9da])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20A061EC027B;
        Wed, 10 Apr 2019 18:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554914439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dabhGz1MzsTNEpTD2UMLq7QG7e32vfby7N/7r+qOPAY=;
        b=cvHeDP1E2+ONeV8WTm8NRfjB8p0bK3IfnAKsoYfr1CFp68oE/Z9caAQPtadOYHJshdDViy
        ApE7l62D9ID4eiWxSTwmS+Duu10JTNfFoUa//F0FJUld8GJEbynDRHZUFwNGcqAaJtljfe
        yKZG/XchgR2gCSX/aUbQW4imr1lU4Q4=
Date:   Wed, 10 Apr 2019 18:40:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Message-ID: <20190410164036.GC26580@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190409203412.GE6150@zn.tnic>
 <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:36:30PM +0000, Ghannam, Yazen wrote:
> We have this case on AMD Family 17h with Bank 4. The hardware enforces
> this bank to be Read-as-Zero/Writes-Ignored.
>
> This behavior is enforced whether the bank is in the middle or at the
> end.

Does num_banks contain the disabled bank? If so, then it will work.

> I'm thinking to redo the sysfs interface for banks in another patch
> set. I could include a new file to indicate enabled/disabled, or maybe
> just update the documentation to describe this case.

No, the write to the bank controls should fail on a disabled bank.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
