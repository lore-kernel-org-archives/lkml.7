Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54AC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBDE21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xCM5Y0y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLQTQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:16:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:16:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHJGbFi069586;
        Tue, 17 Dec 2019 13:16:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576610197;
        bh=G7y3MfmJNT64rGhbQHUoHQkDrESAxOHKQ19opePNcgk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xCM5Y0y2/X0D9rz+ANciPLLHt62fW1t4HYw5902xgc8PLGME53hurjNtKoiNR5Sgw
         W2mheAnNarerRT91YmkIwg2ZUhKqNEd9Y6Bap5ICpkNpA2mqSp+lWsA2cAlyDNb/Ge
         Fkv9DcrKT0zSkbIkLumLfxmbVvyd2QzlVTADK3Cs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHJGbRP060937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 13:16:37 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 13:16:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 13:16:37 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHJGbrR034675;
        Tue, 17 Dec 2019 13:16:37 -0600
Date:   Tue, 17 Dec 2019 13:15:55 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Remove unnecessary check of musb->hcd in
 musb_handle_intr_connect()
Message-ID: <20191217191555.GF14499@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217095023.6878-1-baijiaju1990@gmail.com>
 <20191217095911.GA2807137@kroah.com>
 <b5c78da3-3d64-c3d5-0820-39747063b572@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5c78da3-3d64-c3d5-0820-39747063b572@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 08:27:09PM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2019/12/17 17:59, Greg KH wrote:
> > On Tue, Dec 17, 2019 at 05:50:23PM +0800, Jia-Ju Bai wrote:
> > > In musb_handle_intr_connect(), musb->hcd should be non-null,
> > > so the check of musb->hcd on line 783 could be dropped.
> > Have you verified that this is always the case?  How did you do that?
> 
> Ah, so sorry, I misunderstood your last message...
> I have not verified it, but I thought you made sure of it from your last
> message, sorry...
> 
> In my opinion, adding an if check is safer, as shown in my last patch:
> "usb: musb: Fix a possible null-pointer dereference in
> musb_handle_intr_connect()"
> 
> I recall that Bin Liu has applied my last patch:
> https://patchwork.kernel.org/patch/11283007/
> 
> Maybe we can listen to his opinion or other people's opinions?

The code path this patch touches is in OTG_STATE_B_WAIT_ACON branch,
which is part of the OTG HNP handling, but OTG protocol support has been
disabled since commit 0a9134bd733b, so technically this code path won't
be reached.

Let's not bother with this ->hcd pointer check, and wait for OTG code
cleanup in this driver.

-Bin.
