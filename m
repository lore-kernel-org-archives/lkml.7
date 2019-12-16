Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006EC206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sOju6x3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLPRUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:20:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50306 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPRUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:20:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBGHKCxn062735;
        Mon, 16 Dec 2019 11:20:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576516812;
        bh=nvnLJJLjqEIyErTA7Paag8/mmTBiEQwJM2eiIajEy14=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sOju6x3aCA5kunLx7hPETyUgL7dbSwZjZbXXiJC5ERtNcYRrGtlGvC6uO8A6OZBOP
         ryv8slNEWRD4p6W+H0bh6NGMynR7iaSmDEgobPVKVIVs/973mrfUVBBchgN+1CUo95
         ZRfcp2oHHKNL7cnjB4bkBzY5ZfeAVOY4VzSqTIQw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBGHKCq4097790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 11:20:12 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 11:20:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 11:20:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBGHKBhj125463;
        Mon, 16 Dec 2019 11:20:11 -0600
Date:   Mon, 16 Dec 2019 11:19:31 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] usb: musb: jz4740: Suppress useless field in priv
 structure
Message-ID: <20191216171931.GC14499@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191214221126.93116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191214221126.93116-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 11:11:21PM +0100, Paul Cercueil wrote:
> The 'dev' field was never read anywhere.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

The series is queued for -next. Thanks.

-Bin.
