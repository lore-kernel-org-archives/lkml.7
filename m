Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FEC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1772085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FBtrqnbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfGDPxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:53:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41610 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfGDPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:53:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x64FrZX0020307;
        Thu, 4 Jul 2019 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562255615;
        bh=1aAOg3DUMC85aQ9Mtdo75I0mcP1z9dseQgr2lPYDhZk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FBtrqnbKFYQJQvmXJao71IvWQ6Gm+lWocwFUoL2t4AAtfHpjUe5LCyxqEaEW5muCq
         mp0iMJK4FDvXg/jFlkwX3C2Lp0Ns9O2b1ru2pviiOZQhMidbW908Bb0GZqja3tWNxM
         LfZ78kN/DnmDEMAi9ckFXZNzIkYQs69MvKODIqTo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x64FrZuS071648
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Jul 2019 10:53:35 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Jul
 2019 10:53:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Jul 2019 10:53:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x64FrZOf078909;
        Thu, 4 Jul 2019 10:53:35 -0500
Date:   Thu, 4 Jul 2019 10:53:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: linux-next: build failure after merge of the usb and usb-gadget
 trees
Message-ID: <20190704155326.f75xhkpyh5mq4467@kahuna>
References: <20190704163458.63ed69d2@canb.auug.org.au>
 <20190704065949.GA32707@kroah.com>
 <CAH8TKc_4ggxOPgii8gLGo2d7nvx08cbTk8_xDUQfA2Ckcxb_Aw@mail.gmail.com>
 <BYAPR07MB470946609232100714B3EA29DDFA0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87imsiyzo3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87imsiyzo3.fsf@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:25-20190704, Felipe Balbi wrote:
[...]

> This is what I get for trusting people to do their part. I couldn't even
> compile test this since I don't have ARM compilers anymore (actually,
> just installed to test). Your customer, however, uses ARM cores so I
> would expect you to have at least compile tested this on ARM. How come
> this wasn't verified by anybody at TI?

Sorry about that Felipe/Greg, will try and make sure we put in steps so
that this does'nt happen again.

> 
> TI used to have automated testing for many of the important defconfigs,
> is that completely gone? Are you guys relying entirely on linux-next?

We still do. Kind of a unfortunately co-incidence, there has been for a
few weeks a downtime given the test infrastructure has been changing and
the continual automated testing env is down for community kernel. But,
that said, we also did move to focussing on linux-next, which should be
revisited.


-- 
Regards,
Nishanth Menon
