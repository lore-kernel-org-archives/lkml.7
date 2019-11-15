Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC0EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CEE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573828437;
	bh=mF87Nl6gED2r2qJHxN4WWU1Jb6PLM4yh2d+dwZW5Hk8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=O3M0Q4BgmquzNda+0gvRxMuAt24BdPWLuc9HL/FhqTfeprsEjONE8upWr/Qy5fAoC
	 36dxZcdCfsrHNZFWFwawmfVa9uk0NZbzK3Y43bJmJWwq8re1GT1ssXYAUW8VUn10yt
	 vo1FNw1UvKbUgRz+1+A1Ke3rmEn61HkCs9Pmie/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKOOd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbfKOOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:33:56 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E6E620733;
        Fri, 15 Nov 2019 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573828435;
        bh=mF87Nl6gED2r2qJHxN4WWU1Jb6PLM4yh2d+dwZW5Hk8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vvc8P1N2l/zeirxvFEhap3H1A3jDhl2uKzyj33rEKW2rwdgj5T8pzOsDy4fw1UWub
         XOWWlOSXPH1wP5r87NRbpax/A2wzVHEpPawa5nMHZ+KwvkJODp0QrvuDT4Y1ONRqcu
         eG/BLYr6FtmyUe4Co3Y8nzyrcQUTocfk9sbUsS/M=
Subject: Re: [PATCH v4 45/47] net/wan/fsl_ucc_hdlc: reject muram offsets above
 64K
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, netdev <netdev@vger.kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-46-linux@rasmusvillemoes.dk>
 <CAOZdJXUibQ6RM8O4CfkYBdGsg+LMcE2ZoZEQ4txn2yvquUWwCA@mail.gmail.com>
 <79101f00-e3ff-9dd0-7a05-760f8be1ff69@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <3db19b28-90a4-f204-07b3-517cfd44010b@kernel.org>
Date:   Fri, 15 Nov 2019 08:33:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <79101f00-e3ff-9dd0-7a05-760f8be1ff69@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 1:44 AM, Rasmus Villemoes wrote:
> I can change it, sure, but it's a matter of taste. To me the above asks
> "does the value change when it is truncated to a u16" which makes
> perfect sense when the value is next used with iowrite16be(). Using a
> comparison to U16_MAX takes more brain cycles for me, because I have to
> think whether it should be > or >=, and are there some
> signedness/integer promotion business interfering with that test.

Ok.
