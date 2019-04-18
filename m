Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5620C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D0206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W72vKDFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbfDRRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:25:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33588 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388450AbfDRRZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:25:54 -0400
Received: from zn.tnic (p200300EC2F112E00A8B56675B85BD571.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:a8b5:6675:b85b:d571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 720791EC05B5;
        Thu, 18 Apr 2019 19:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555608353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EFsD9FlLTs1ePhYkI3urb69Lbiqv2tsJDeAt36dQ1RA=;
        b=W72vKDFObCrLFBiA31Na8h0t8apH059YwjbCR7enB6RQnEu+ZEE2tUNOvTTdM1TfM74mob
        uLFVfyNV8cy7kBM2E0R5NkM/OBNkLLpsUxK91lQ7xqPJ3sBOOUMb8UpcV6tBlppz7W6UYp
        7YMBEvaXh+Pni9muryr7Hr8UZwvKZ8E=
Date:   Thu, 18 Apr 2019 19:25:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: EDAC: Fix memory leak in creating CSROW object
Message-ID: <20190418172548.GL27160@zn.tnic>
References: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:27:18AM +0800, Pan Bian wrote:
> In the function that creates a CSROW object, the object is not released
> when failing to add the device to device hierarchy.

Are you sure about this?

> This may result in a memory leak bug.

"May"?

I see a loop which unwinds by putting the already created devices. Do
you?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
