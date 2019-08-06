Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA61C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F12070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="T2GiLCQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfHFP5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:57:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37798 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfHFP5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:57:22 -0400
Received: from zn.tnic (p200300EC2F0DA000B4A7A08B15BB062F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a000:b4a7:a08b:15bb:62f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38BEA1EC0C31;
        Tue,  6 Aug 2019 17:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565107041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MYkGzGBuQSIWtSoa+slPGOLaQ8BEFqSf3UAwSnHf9G4=;
        b=T2GiLCQi8RmwrBEmQAGcFFplqm0t62rzP3MRUBSH59lq516QK1GaGzPqsByRGY3AYfwDvy
        GNPmcPI29QX8FXMfCV2yH4xW5sj36FMQ6GGPVUDNOCzZIQs0zuPdKBsPbioaBwXakaRQe2
        47oo9UqkOcgyX0okXiDPbnuWCWGHflA=
Date:   Tue, 6 Aug 2019 17:57:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190806155716.GE25897@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
 <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:57:04AM -0700, Reinette Chatre wrote:
> What do you think?

Actually, I was thinking about something a lot simpler: something
along the lines of adding the CPUID check in a helper function which
rdt_pseudo_lock_init() calls. If the cache is not inclusive - and my
guess is it would suffice to check any cache but I'd prefer you correct
me on that - you simply return error and rdt_pseudo_lock_init() returns
early without doing any futher init.

How does that sound?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
