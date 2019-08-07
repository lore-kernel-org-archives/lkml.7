Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8854C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3621E71
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yzvFdiJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbfHGThq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:37:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59772 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389347AbfHGThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:37:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77JbeJj114197;
        Wed, 7 Aug 2019 14:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565206660;
        bh=Q+2cpz/WafAWr4TCoIWFzScWCE0Y9htC7zmVBsK+hNk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yzvFdiJgzRmJ8zvZpoAI2LEkdi+Vcl/JD/Sl2nyCKN6j+PvRD6dZfhygONQgUfRy5
         0WmhIV3D1wYDYn+wv+krFj/2YvuNdLAaJdm9y36PuPe6DnV0TqpmNLuzlFi7jbiFff
         bRxifQ28CMNIDfDpd8y9CyMfqcM3uvnPrWG1aQbg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77JbeUb031518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 14:37:40 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 14:37:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 14:37:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77JbeOQ094410;
        Wed, 7 Aug 2019 14:37:40 -0500
Date:   Wed, 7 Aug 2019 14:37:40 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tony@atomide.com>,
        <saurav.girepunje@hotmail.com>
Subject: Re: [PATCH] usb: musb: Fix external abort on non-linefetch for
 vbus_store
Message-ID: <20190807193740.GB14027@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>;,
        gregkh@linuxfoundation.org;, linux-usb@vger.kernel.org;,
        linux-kernel@vger.kernel.org;, tony@atomide.com,
        saurav.girepunje@hotmail.com
References: <20190807184141.GA7916@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190807184141.GA7916@saurav>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:11:46AM +0530, Saurav Girepunje wrote:
> Without pm_runtime_{get,put}_sync calls in place, writing
> vbus value via /sys causes the error
> 
> "Unhandled fault external abort on non-linefetch"
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Thanks for the patch. Can you please merge another two similar patches
you just sent with this one? They all fix the same bug in the same file
so could be just in one patch.

-Bin.
