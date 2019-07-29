Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D376C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93E520659
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J8yOS+2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfG2F5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:57:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39192 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfG2F5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:57:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6T5vHcG112416;
        Mon, 29 Jul 2019 00:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564379837;
        bh=ZBBtjgkp3IEZyi3dmUJg7t2qmPquHE7qmyrLb1xnUKQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J8yOS+2YWlufXItfpnBiWP2ROPc6nuF8jarEJVIKHkiHIfCJYNrF58hZHlP/2ilRN
         D8VF4msiKNZWVFsWkt6Sj8qIsDfEgajpnhnnfVIKDJadYWuOxVjTl9WOdxQ4Qx3K66
         RO3uX7XLfpVcdSGsysceUYdKc2aoY3wwwo9ZB+T8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6T5vHmS017456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jul 2019 00:57:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 29
 Jul 2019 00:57:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 29 Jul 2019 00:57:17 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6T5vFPe056273;
        Mon, 29 Jul 2019 00:57:16 -0500
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc tree
To:     Mark Brown <broonie@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190726072752.2acb2149@canb.auug.org.au>
 <14710d5e-7dfd-84e0-2ea1-712863c4e455@ti.com>
 <20190726121127.GB55803@sirena.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <03b5c26b-73e3-5c72-2d64-91c049f06c78@ti.com>
Date:   Mon, 29 Jul 2019 08:57:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726121127.GB55803@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On 26/07/2019 15.11, Mark Brown wrote:
> On Fri, Jul 26, 2019 at 09:04:37AM +0300, Peter Ujfalusi wrote:
> 
>> Mark: can you either drop the patch and I'll send a new one with fixed
>> SHA1 or can you fix the commit message in place?
> 
> Both of which involve rebasing :(  Against my better judgement I
> rebased.

thank you and sorry again...

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
