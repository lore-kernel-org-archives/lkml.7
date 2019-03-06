Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE7120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oLunVfSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfCFJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:57:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43866 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:56:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x269upRa091145;
        Wed, 6 Mar 2019 03:56:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551866211;
        bh=EWdfRDkR47h5farf8flW3tudH2mBH1OHkT3I7G7iNNM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oLunVfScC9+SYhtfQSXU0ryGTsLTEcONNWchXOtNvd4MTznpCAa7vf3ZxJmWt338/
         niq2lvdh9kDQvZ+TeMpiU5WOwIDpMBar1hZ2UH+TDeX9X1MmmIxPf95xi6/7OtkChe
         +L066CP5emSVdB+zpxWw3ETYkbSE4u120u/1sk4g=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x269uo0J122855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Mar 2019 03:56:50 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Mar 2019 03:56:49 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Mar 2019 03:56:49 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x269ukPG021936;
        Wed, 6 Mar 2019 03:56:47 -0600
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <zhang.chunyan@linaro.org>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
 <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <8d72ff93-e07f-52b9-da85-acd54f046694@ti.com>
Date:   Wed, 6 Mar 2019 15:30:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On 25/02/19 1:47 PM, Adrian Hunter wrote:
> On 15/02/19 9:20 PM, Faiz Abbas wrote:
>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>> card insert/remove operations and a tasklet for finishing mmc requests.
>> With the addition of external dma support, dmaengine APIs need to
>> terminate in non-atomic context before unmapping the dma buffers.
>>
>> To facilitate this, remove the finish_tasklet and move the call of
>> sdhci_request_done() to the threaded_irq() callback.
> 
> The irq thread has a higher latency than the tasklet.  The performance drop
> is measurable on the system I tried:
> 
> Before:
> 
> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
> 1+0 records in
> 1+0 records out
> 1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s
> 
> After:
> 
> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
> 1+0 records in
> 1+0 records out
> 1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s
> 
> So we only want to resort to the thread for the error case.
> 

Sorry for the late response here, but this is about 1.6% decrease. I
tried out the same commands on a dra7xx board here (with about 5
consecutive dd of 1GB) and the average decrease was 0.3%. I believe you
will also find a lesser percentage change if you average over multiple
dd commands.

Is this really so significant that we have to maintain two different
bottom halves and keep having difficulty with adding APIs that can sleep?

Also I am not sure how to implement only the error handling part in the
threaded_irq. We need to enter sdhci_request_done() and get the current
mrq before we can check for error conditions like I've done in patch 2:

/* Terminate and synchronize dma in case of an error */
if (data && (mrq->cmd->error || data->error) &&
    host->use_external_dma) {
	struct dma_chan *chan = sdhci_external_dma_channel(host, data);
	dmaengine_terminate_sync(chan);
}

On a related note, do we really need to protect everything in
sdhci_request_done() with spinlocks? In patch 2 I have only removed lock
for the terminate_sync() parts that I added but the whole
dma_unmap/dma_sync parts should be left unprotected IMO.

Thanks,
Faiz
