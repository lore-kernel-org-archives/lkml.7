Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BB620C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LtFNceci";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AC1UzdEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfB1Xta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:49:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1Xt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:49:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9735F60E5C; Thu, 28 Feb 2019 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551397768;
        bh=1Z/n+pqjJ0cvMY7P/tIrTBaNTOTvLfuaAaYwTvQxo+s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LtFNceciwSTW2se/jz/oQ7ANdUnaBd/QcSKgtrm45Q7Ib0xgVk8+N8bMn8US+zFZW
         PXz9lmRi1AJ+qYIYF2N//l/UMf/Kh7Wi2IxihtUFZGbYOke/8MpastLZscMykg4gID
         d/sCRBlnXTxGsG52ehKHYMwmPmn29Tw1uu9tvvWY=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0679C60A00;
        Thu, 28 Feb 2019 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551397767;
        bh=1Z/n+pqjJ0cvMY7P/tIrTBaNTOTvLfuaAaYwTvQxo+s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AC1UzdEBIlxg8lEGs5pC4ikVj9qvEYph3JdtC4qvZq9uCCddn4WwhYqDOWlf56XBF
         Gvd0THYT+3crxUm3v41IstJO8cot+jfNrcajEExVxwRj4KHgWbGe8+Dq4Fnw7MFLtW
         u4B0jPwT63Yf4wYo6sHqNJrYQbje9PQrLhLLEiU0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0679C60A00
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Thu, 28 Feb 2019 15:49:26 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?ISO-8859-15?Q?=D8rjan_Eide?= <Orjan.Eide@arm.com>
cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "tkjos@android.com" <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "arve@android.com" <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>, nd <nd@arm.com>,
        "maco@android.com" <maco@android.com>,
        "christian@brauner.io" <christian@brauner.io>
Subject: Re: [Linaro-mm-sig] [PATCH 2/4] staging: android: ion: Restrict
 cache maintenance to dma mapped memory
In-Reply-To: <20190206154021.GC3768@e106893-lin.trondheim.arm.com>
Message-ID: <alpine.DEB.2.10.1902281541260.16374@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-3-git-send-email-lmark@codeaurora.org> <69b18f39-8ce0-3c4d-3528-dfab8399f24f@ti.com> <alpine.DEB.2.10.1901181316380.9328@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1901291544001.19412@lmark-linux.qualcomm.com> <20190130113122.fipxgcmgrqggozcm@DESKTOP-E1NTVVP.localdomain> <20190206154021.GC3768@e106893-lin.trondheim.arm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2046127808-1661773238-1551397767=:16374"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2046127808-1661773238-1551397767=:16374
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

+ Sumit

Hi Sumit,

Do you have any thoughts on this patch? 

It fixes a potential crash in on older kernel and I think limiting 
begin/end_cpu_access to only apply cache maintenance when the buffer is 
dma mapped makes sense from a logical perspective and performance 
perspective.



On Wed, 6 Feb 2019, Ørjan Eide wrote:

> 
> I've run some testing, and this patch does indeed fix the crash in
> dma_sync_sg_for_cpu when it tried to use the 0 dma_address from the sg
> list.
> 
> Tested-by: Ørjan Eide <orjan.eide@arm.com>
> 
> I tested this on an older kernel, v4.14, since the dma-mapping code
> moved, in v4.19, to ignore the dma_address and instead use sg_phys() to
> get a valid address from the page, which is always valid in the ion sg
> lists. While this wouldn't crash on newer kernels, it's still good to
> avoid the unnecessary work when no CMO is needed.
> 

Isn't a fix like this also required from a stability perspective for 
future kernels? I understand from your analysis below that the crash has 
been fixed after 4.19 by using sg_phys to get the address but aren't we 
breaking the DMA API contract by calling dma_sync_* without first dma 
mapping the memory, if so then we have no guarantee that future 
implementations of functions like dma_direct_sync_sg_for_cpu will properly 
handle calls to dma_sync_* if the memory is not dma mapped.

> Is this patch a candidate for the relevant stable kernels, those that 
> have this bug exposed to user space via Ion and DMA_BUF_IOCTL_SYNC?
> 

My belief is that is relevant for older kernels otherwise an unprivileged 
malicious userspace application may be able to crash the system if they 
can call DMA_BUF_IOCTL_SYNC at the right time.

BTW thanks Ørjan testing and anaalsyis you have carried out on this 
change.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
---2046127808-1661773238-1551397767=:16374--
