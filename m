Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB68206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cg260NvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLQSwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:52:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57918 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:52:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHIqL36024838;
        Tue, 17 Dec 2019 12:52:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576608741;
        bh=AXaa6NM1Y1kK/uPavMRBuIpfHjldkEwMha0pCdMWBkc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Cg260NvMtYA2V3RdYJF6AYWLY/whiQ3xC+HguErXW6YNkyqJN0cCmwv4kYJgTe7xS
         B7S+2WtdtqnXo0Q6oyNcI2JgRzbiYSQ6jNZ3RWJHPQJoGqIaWiRPYNLqHF8FpnTJoQ
         s2hu0cWINkqyarPkd6qbBHEb45S8jmgNrtNxrx6A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHIqL3g026715
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 12:52:21 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 12:52:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 12:52:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHIqLtW109793;
        Tue, 17 Dec 2019 12:52:21 -0600
Date:   Tue, 17 Dec 2019 12:51:39 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <gregkh@linuxfoundation.org>, <vkoul@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb/ux500: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20191217185139.GE14499@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, gregkh@linuxfoundation.org,
        vkoul@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217110030.26887-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191217110030.26887-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:00:30PM +0200, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied. Thanks.

-Bin.
