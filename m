Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8DFC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8520859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lbhc2Z2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbfFJLhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:37:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389363AbfFJLhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:37:54 -0400
Received: from zn.tnic (p200300EC2F052B00DC69C02FEF5E8A62.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:dc69:c02f:ef5e:8a62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14DD31EC058B;
        Mon, 10 Jun 2019 13:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560166672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JcPPOxpdrKDneWXcyY+6HfB73k0vJfLFsanISYP2cSo=;
        b=lbhc2Z2mQh2K8/UwVLXrnC/N5Zfcz0utw0TsRKQEjewJvM0u2KnFldO57VqfNQDNeK2RW1
        fihGhUOvGoRY1pwzP66jwFazptb0uEPzH34PiYGGCaQ0NUO2qDIiaJBaYnFQ8i4nUYgtMN
        88M6D7Cb6BLLA0uvXsGdoJ1c2DB+uNo=
Date:   Mon, 10 Jun 2019 13:37:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190610113747.GD5488@zn.tnic>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190608102659.GA9130@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 06:26:59PM +0800, Baoquan He wrote:
> OK, I see. Then it should be the issue we have met and talked about with
> Tom.
> https://lkml.kernel.org/r/20190604134952.GC26891@MiWiFi-R3L-srv
> 
> You can apply Tom's patch as below. I tested it, it can make kexec
> kernel succeed to boot, but failed for kdump kernel booting. The kdump
> kernel can boot till the end of kernel initialization, then hang with a
> call trace. I have pasted the log in the above thread. Haven't got the
> reason.
> http://lkml.kernel.org/r/508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com

I can confirm the same observation.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
