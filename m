Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD3C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4BE222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="WUnwTkfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfJEOEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:04:00 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:41583 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJEOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lZDSELIErTwgG0KoTCoXpFRWHdcKcdxouIRQ+zM6TLw=; b=WUnwTkfR/EIEhyc/38JqPOnpL7
        MDvfTrKGLFpXlpwrNZHx1LzY+vshk0u0evauxigI4AGKz7ndlO3Eg2aI2dVJEkBBYOJnoHvx6Ck9P
        2r85W/yeDbZTZXuhklfl4fWFxKSzaMdqQx6C3Oun/X7uO7pTI4XwhyN+mkBQiwcV+VEosyVSq8xQa
        27LmPro6XmV28dINRiF/8lbOxpHEETu6bLtuC+/JD9D3HDSItwNdKwxVOm7oILordCPccg/iG44Nc
        M2LcSQUQ0AggnQzy/QTsOySsHnaHBWUYAuGGL4VwY6nncaZU7zIqg8fTl5RdCOCKkAPXqmIODcEgE
        NrPHx14g==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=35232)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1iGkf8-00055a-FP; Sat, 05 Oct 2019 16:03:58 +0200
Subject: Re: BISECTED: Compile error on 5.4-rc1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
 <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
 <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org>
 <fafb9730-6d0c-eac1-e2e2-374de509244a@skogtun.org>
 <CAK7LNARsDQU11GGA3N11zERJdiGFCDR=fS6LtTUXfj5TZBEj4w@mail.gmail.com>
 <d0259e98-225c-58f8-1640-04322c621690@skogtun.org>
 <CAK7LNATF=50am-TBOAvr8-O+usgyczyfbDYbMp3MAmAKu46-1A@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <f7c3682b-2e5c-9b0a-b1e6-90500566f2ef@skogtun.org>
Date:   Sat, 5 Oct 2019 16:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATF=50am-TBOAvr8-O+usgyczyfbDYbMp3MAmAKu46-1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada [05.10.2019 15:17]:

> As for POSIX, I found this:
> 
> ---------------------->8----------------------------
> Applications should note that the standard PATH to the shell cannot
> be assumed to be either /bin/sh or /usr/bin/sh, and should be determined
> by interrogation of the PATH returned by getconf PATH , ensuring that
> the returned pathname is an absolute pathname and not a shell built-in.
> ---------------------->8----------------------------
> 
> https://pubs.opengroup.org/onlinepubs/009695399/utilities/sh.html

Okay. Then it's the Schilling/OpenSolaris shell that is the problem, not
that I use it anyway.
-- 
Hilsen Harald
