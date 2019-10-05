Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4094C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1BD222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="mUqGfMVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJEJgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:36:10 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:42723 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yhr3P6QDJ5P2/xa5/OMk/WHlqGvYCHv5owId7eV5XsQ=; b=mUqGfMVwBTYwljYtKD2Y0lJ7dp
        peIQk1FY8oLW5H1rBykiA5eiAf47IXz3D4ZtMh07AFOBcPJnbdrN71PV0Kb+2yZsaDdl24uktYZsP
        4KRqA98eKhW/RhBazqdHAOmj0gEgVAM2xeHlaGDC4U5pXOxf9ba+VMeJz3Yqhft9ffdYOGMhN02uT
        1VK1IjZH2RRhW4nR/h0VbVbgy89yfa8pabL9C3iQb79btSaI5Mt0NdCDNmGl3FuKE86SfpDRtquMF
        nbaLlADnxvYvm05GKMY/iehPKs/vyaxcACFU1rLSBRR+USnR68HYg6s05j/3zxH90YlKt101TKmem
        A3zzE+EA==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=55756)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1iGgTw-0003w6-9X; Sat, 05 Oct 2019 11:36:08 +0200
Subject: Re: BISECTED: Compile error on 5.4-rc1
From:   Harald Arnesen <harald@skogtun.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
 <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
 <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org>
Message-ID: <fafb9730-6d0c-eac1-e2e2-374de509244a@skogtun.org>
Date:   Sat, 5 Oct 2019 11:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Arnesen [05.10.2019 11:03]:

> Masahiro Yamada [05.10.2019 05:24]:
> 
>> I cannot reproduce it.
>> 
>> I tested bindeb-pkg for the latest Linus tree successfully.
> 
> Strange, I have now tried another machine running the same distro
> (Devuan Beowulf), and I get the same result there. Will check further.

I found out what was wrong.

Both machines have been used for dvd burning, and I have used Jörg
Schilling's cdrecord - and I had installed all of the "Schily Tools",
which unfortunately includes a shell command. Now, I had (by mistake)
/opt/schily/bin early in my path, and his OpenSolaris-derived shell
didn't work as expected.

Moving /opt/schily/bin to the end of the path fixes the problem.

But shouldn't it work even if "sh" is not equal to "/bin/sh"?
-- 
Hilsen Harald

