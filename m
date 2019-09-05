Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7351122CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="SDoKa9va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfIEKnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:43:46 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:45020 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:43:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 7ACD83FBBA;
        Thu,  5 Sep 2019 12:43:44 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=SDoKa9va;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cVxj9E_Kx0k8; Thu,  5 Sep 2019 12:43:43 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 2998A3F4F6;
        Thu,  5 Sep 2019 12:43:43 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id CDF6C360100;
        Thu,  5 Sep 2019 12:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567680222; bh=3aSlQOqBEa26RhExNsoDCnh6gCRDnU08CAzt/peygzw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SDoKa9varg3r/9yg9AsqqUn8xx8qN+fIsHsXWka13aKVAj7BWg4ruG5dshDT63itt
         VJkYaiK99i/ad1IdebWB4BEfHO5HbWd9ej9R63nt9nCNoPP1OoSc5H5/OCtQJRWoaV
         yyEpRTlCxhRMdWgg5L4kZzBW4YQHOEFzMA0EqbaM=
Subject: Re: [PATCH v2 0/4] Have TTM support SEV encryption with coherent
 memory
To:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org
References: <20190903131504.18935-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <5a41afa1-a1f9-128c-222a-542f102024b9@shipmail.org>
Date:   Thu, 5 Sep 2019 12:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190903131504.18935-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 3:15 PM, Thomas Hellström (VMware) wrote:
> With SEV memory encryption and in some cases also with SME memory
> encryption, coherent memory is unencrypted. In those cases, TTM doesn't
> set up the correct page protection. Fix this by having the TTM
> coherent page allocator call into the platform code to determine whether
> coherent memory is encrypted or not, and modify the page protection if
> it is not.
>
> v2:
> - Use force_dma_unencrypted() rather than sev_active() to catch also the
>    special SME encryption cases.

So, this patchset is obviously withdrawn since

a) We shouldn't have TTM shortcut the dma API in this way.
b) To reviewers it was pretty unclear why this was needed in the first 
place, and became
even more unclear in the context of the TTM fault handler.

I've just send out an RFC patchset that basically does the same but in 
the context of dma_mmap_coherent() I hope this clears things up and we 
should hopefully be able to use a new
dma API function from within the TTM fault handler.

Thanks,

Thomas



