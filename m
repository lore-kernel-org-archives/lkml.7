Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B81204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DXoq3HNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHSHpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:45:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfHSHpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:45:30 -0400
Received: from zn.tnic (p200300EC2F04B700DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A116D1EC0B6E;
        Mon, 19 Aug 2019 09:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566200729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0dkuKpXpNOV2CcoIwLeUmjN7fWrdSqx1Cdg+eS5av44=;
        b=DXoq3HNHEGcuz8L5ZvvJ4H0sxCrtY24lnJeXrwKWHwcSJ5j+y890QAxrh9QbHhkMbW9/qZ
        ay48PC1OsZae02KJhB3+BgzS3uGfP9l1kL3OGjfXyBFVKucuuit5Emq3lj0BjWS97Z0571
        sqrU9UTmfkjNSb+jqsJeGXD/baBfBu8=
Date:   Mon, 19 Aug 2019 09:46:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Zhao, Yakui" <yakui.zhao@intel.com>, devel@driverdev.osuosl.org,
        Li@osuosl.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>, Fei <lei1.li@intel.com>
Subject: Re: [RFC PATCH 08/15] drivers/acrn: add VM memory management for
 ACRN char device
Message-ID: <20190819074614.GD4841@zn.tnic>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-9-git-send-email-yakui.zhao@intel.com>
 <20190816124757.GW1974@kadam>
 <8b909c22-3873-2b5d-4845-1fee1a5d81ce@intel.com>
 <20190819073958.GC4451@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190819073958.GC4451@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:39:58AM +0300, Dan Carpenter wrote:
> On Mon, Aug 19, 2019 at 01:32:54PM +0800, Zhao, Yakui wrote:
> > In fact as this driver is mainly used for embedded IOT usage, it doesn't
> > handle the complex cleanup when such error is encountered. Instead the clean
> > up is handled in free_guest_vm.
> 
> A use after free here seems like a potential security problem.  Security
> matters for IoT...  :(

Yeah, the "S" in "IoT" stands for security.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
