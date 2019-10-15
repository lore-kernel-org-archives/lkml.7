Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E611ECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AD5217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bIYl2q2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfJOHy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:54:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfJOHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:54:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9F7sMn9010817;
        Tue, 15 Oct 2019 02:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571126062;
        bh=Mzqn6c+0k0mX7vUsMyVaApXjj856z39cLCEdEOZ0HuM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bIYl2q2pW3fBOuhAfqAqnLYj7dwSconekE/OhRrT20I9BDLc+pRVd0bbXfwbVBCtP
         37soc2LOKLdSMSotVg41XNg3ydOXUGsQcnc7whWHd85/4F4hYHJITJbIxRVIBJDO3p
         ZXc+gYoGZM2qHXrvQVLAfwfb0ZCMQMebjlyf3OCk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9F7sMQT109451
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Oct 2019 02:54:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 15
 Oct 2019 02:54:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 15 Oct 2019 02:54:22 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9F7sJNt020912;
        Tue, 15 Oct 2019 02:54:20 -0500
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <asutoshd@codeaurora.org>,
        <riteshh@codeaurora.org>, <adrian.hunter@intel.com>,
        <venkatg@codeaurora.org>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
Date:   Tue, 15 Oct 2019 13:25:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014183849.14864-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/10/19 12:08 AM, Faiz Abbas wrote:
> Add a write memory barrier to make sure that descriptors are actually
> written to memory before ringing the doorbell.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> 
> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
> I have been seeing after enabling command queuing for J721e.
> Also looking at memory-barriers.txt and this commit[1],
> it looks like we should be doing this before any descriptor write
> followed by a doorbell ring operation. It'll be nice if someone with more
> expertise in memory barriers can comment.
> 
> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>     doorbell")

So I see that cqhci_readl/writel() use readl/writel_relaxed() which
seems to be causing this issue. Should I just fix this by converting
those to readl/writel with memory barriers instead?

Thanks,
Faiz
