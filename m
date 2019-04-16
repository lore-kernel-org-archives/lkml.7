Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90686C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6148520821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tc8Fq89c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfDPNPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:15:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfDPNPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:15:54 -0400
Received: from zn.tnic (p200300EC2F0D690030B3A6530520175E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:30b3:a653:520:175e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E99E1EC02AE;
        Tue, 16 Apr 2019 15:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555420553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zVxj07jVogt5Hk1WdJjXggizYLQPKdX0WopBNEyREwk=;
        b=Tc8Fq89c2kKkDqJVu4BY0Ifsa95BRIITsZfaZkdqCzcnsH3dSJ4SkYx++cGCZ+pnNLyRpu
        0O6TWxaxsWShIm9opg3Cike6nCrbQGw/Tqe2oowyUgVxh5L9HFwhcIfXFcmdXzYj4mKs20
        UadxgI1pAvsAI21kKttt1qdso1QhDCg=
Date:   Tue, 16 Apr 2019 15:15:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, ebiederm@xmission.com,
        rppt@linux.ibm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        horms@verge.net.au, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
Subject: Re: [RESEND PATCH v5 0/4] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <20190416131549.GD31772@zn.tnic>
References: <20190416113519.90507-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416113519.90507-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 07:35:15PM +0800, Chen Zhou wrote:
> When crashkernel is reserved above 4G in memory, kernel should reserve
> some amount of low memory for swiotlb and some DMA buffers. So there may
> be two crash kernel regions, one is below 4G, the other is above 4G.
> 
> Crash dump kernel reads more than one crash kernel regions via a dtb
> property under node /chosen,
> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.

Can you please not flood everyone with this patchset every day, and
today twice?

This is not the frequency with how you send patchsets upstream. See

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don-t-get-discouraged-or-impatient

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
