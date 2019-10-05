Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A69C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00792133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="ZYaW7DfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfJEKu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:50:26 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:51325 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfJEKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xD/VQSMhPIhILBRPV/+Es2GSvycUj6n/OQKyPmLu98E=; b=ZYaW7DfQP2PoR8OwysID7RZfz+
        HcCV1Y1DO3T97kt2K8Av6SfMEIUnBIrcJ6p93gBUiWvyYgYAkSvspqxajxEk0FuPYKI/EY2h5WqDg
        SKrCK3X09/kFW7Z8DjlFP9yszNwJK6g9R+Yc0ohPHlKtlJpV8FR/KHCYeBkD3EorQlMDGZ54qZsDt
        bVJ+ST2iy5JxVSnx/9AhD0E8NsWpWLNJE3x41WYtmTENRTJpc4+GjKhKEhbxqRu+QospchA0YnCah
        D4XaeLde90+lEy45MJVSuaI4dgPIdd9ZPskgOPzJ6fG8LKvPNl/AkG8ZeF9BgqagMoOtxqTCJB8hb
        yHOGbwaw==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=55958)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1iGhdn-0008Dd-Ka; Sat, 05 Oct 2019 12:50:23 +0200
Subject: Re: BISECTED: Compile error on 5.4-rc1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
 <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
 <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org>
 <fafb9730-6d0c-eac1-e2e2-374de509244a@skogtun.org>
 <CAK7LNARsDQU11GGA3N11zERJdiGFCDR=fS6LtTUXfj5TZBEj4w@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <d0259e98-225c-58f8-1640-04322c621690@skogtun.org>
Date:   Sat, 5 Oct 2019 12:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARsDQU11GGA3N11zERJdiGFCDR=fS6LtTUXfj5TZBEj4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada [05.10.2019 12:19]:

> CONFIG_SHELL previously fell back to 'sh' when bash is not installed,
> so I just kept it as it was.
> 
> If we had used the exact absolute path /bin/sh,
> it would have worked irrespective of the PATH environment.
> 
> But, there is a counter option like this:
> 
> 
> commit 16f8259ca77d04f95e5ca90be1b1894ed45816c0
> Author: Bjørn Forsman <bjorn.forsman@gmail.com>
> Date:   Sun Nov 5 10:44:16 2017 +0100
> 
>     kbuild: /bin/pwd -> pwd
> 
>     Most places use pwd and rely on $PATH lookup. Moving the remaining
>     absolute path /bin/pwd users over for consistency.
> 
>     Also, a reason for doing /bin/pwd -> pwd instead of the other way around
>     is because I believe build systems should make little assumptions on
>     host filesystem layout. Case in point, we do this kind of patching
>     already in NixOS.
> 
>     Ref. commit 028568d84da3cfca49f5f846eeeef01441d70451
>     ("kbuild: revert $(realpath ...) to $(shell cd ... && /bin/pwd)").
> 
>     Signed-off-by: Bjørn Forsman <bjorn.forsman@gmail.com>
>     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 
> 
> I cannot find a way to satisfy everybody.
> 

I'm totally fine with the way it is now, now that I know how it works.
However, doesn't Posix dictate that there is a /bin/sh?
-- 
Hilsen Harald
