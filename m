Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35EDC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C82075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QmAL3kq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDJUE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:04:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDJUE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:04:27 -0400
Received: from zn.tnic (p200300EC2F0CAE0088EC372D30EF1627.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:88ec:372d:30ef:1627])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58E401EC0301;
        Wed, 10 Apr 2019 22:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554926666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UiwWceHvbke+Yaj4yVTQMNIDb++qNBrOt5TLHhjPT/k=;
        b=QmAL3kq7LH5T8Xog6gx2DavBoRdBG72vsplvN2/Hc0W1q6w8rRNJqiA9cdPIj3qTSHv/1g
        PgAsEworR5rgTJqg97qrOKUsSCnhnwrX0mWYYogSm/bh5q49rjGXQY/SexbgdnXbyE71kA
        MIwlEd9+7lPvWRhZqBU4VhQvnaH9VfE=
Date:   Wed, 10 Apr 2019 22:04:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Message-ID: <20190410200418.GI26580@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190409203412.GE6150@zn.tnic>
 <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190410164036.GC26580@zn.tnic>
 <SN6PR12MB2639F37C634BC7F6D4B86194F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190410172539.GF26580@zn.tnic>
 <SN6PR12MB2639F1786ED9F6BD261B1632F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639F1786ED9F6BD261B1632F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 07:41:47PM +0000, Ghannam, Yazen wrote:
> So I'm thinking to add another patch to the set. This will set
> mce_bank.init=0 if we read MCA_CTL=0 from the hardware.

Ok.

> Then we check if mce_bank.init=0 in the set/show functions and give a
> message if the bank is not used.

Nah, not a message. return -ENODEV or -EINVAL or so.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
