Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A4CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4329208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfE1HoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:44:17 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:40800 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfE1HoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:44:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id E9277201DB;
        Tue, 28 May 2019 09:44:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dTKhhgUGSkYu; Tue, 28 May 2019 09:44:10 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id BD51F200BA;
        Tue, 28 May 2019 09:44:10 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 09:44:11 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 4722B31804FB;
 Tue, 28 May 2019 09:44:10 +0200 (CEST)
Date:   Tue, 28 May 2019 09:44:10 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Anirudh Gupta <anirudhrudr@gmail.com>,
        Anirudh Gupta <anirudh.gupta@sophos.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Fix xfrm sel prefix length validation
Message-ID: <20190528074410.GD14601@gauss3.secunet.de>
References: <20190521152947.75014-1-anirudh.gupta@sophos.com>
 <20190522031700.ynp6ctodqlztybb2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190522031700.ynp6ctodqlztybb2@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:17:00AM +0800, Herbert Xu wrote:
> On Tue, May 21, 2019 at 08:59:47PM +0530, Anirudh Gupta wrote:
> > Family of src/dst can be different from family of selector src/dst.
> > Use xfrm selector family to validate address prefix length,
> > while verifying new sa from userspace.
> > 
> > Validated patch with this command:
> > ip xfrm state add src 1.1.6.1 dst 1.1.6.2 proto esp spi 4260196 \
> > reqid 20004 mode tunnel aead "rfc4106(gcm(aes))" \
> > 0x1111016400000000000000000000000044440001 128 \
> > sel src 1011:1:4::2/128 sel dst 1021:1:4::2/128 dev Port5
> > 
> > Fixes: 07bf7908950a ("xfrm: Validate address prefix lengths in the xfrm selector.")
> > Signed-off-by: Anirudh Gupta <anirudh.gupta@sophos.com>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Patch applied, thanks everyone!
