Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00451C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CC420644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UPTNc4pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfGOGLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 02:11:25 -0400
Received: from mout.web.de ([212.227.17.12]:33653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfGOGLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563171072;
        bh=3ZZkAHhDv8mQxfxfH1KdMKQ5R68Q0J3rV3Bj4ckDrKk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UPTNc4pIOrxuwi17TZdi+U/Uet2xbXI8SMJDXwqAtz67pWOyJdRDHJSFQACr+4Wxx
         Pjmrpzzk6bkJOHn74tobf6pPCzojEvFsyQcO8Fo3WbuoPpkGxU+e2Y3U/TDAeOqWIt
         N5iSznzy6fbzrKKhKC9hFbMJ8+wP6LBq5bAUKiIA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.73.93]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK24P-1hm5G11IJh-001SD7; Mon, 15
 Jul 2019 08:11:12 +0200
Subject: Re: m68k: One function call less in cf_tlb_miss()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, kernel-janitors@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <c5713aa4-d290-0f7d-7de8-82bcdf74ee95@web.de>
 <alpine.LNX.2.21.1907060951060.67@nippy.intranet>
 <CAMuHMdWd31ch+eSje4ww=_JFSZgnxRAUAvS0TCHXq0nzLeVfgg@mail.gmail.com>
 <e75a25de-861a-8ab8-ffe7-c83572d6e553@web.de>
 <CAMuHMdU+sDjiTZph1gfii=WoWQ2c+jTvvqjq4mVSbFAi0eb_VA@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f9af74a1-dc4a-5ad9-9da3-8fba4b4f179c@web.de>
Date:   Mon, 15 Jul 2019 08:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU+sDjiTZph1gfii=WoWQ2c+jTvvqjq4mVSbFAi0eb_VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EibhP3tRbuPvKH+zR2pgGxpY+3THnksqs205VHkel1aU5V4R6uv
 Tchuecuu0xKN5iu0/zTPr2ctNdxxY+A+y8EwHOYmU3VHAFDwgV2yxcw53iUnBwM2bQB1d+I
 lKpCtvHEJMTRwNQ8DzChpMPjJEMotP4IqBHIhdCXvNCohMziLU9Vb9pMwNtmyLNAu1YSS2J
 hRZYWPhs6fiIC/t+kwP0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mbTl0qxx1sU=:qkK3NJkJTrO8B3RCC30Wuf
 TywQqy1riFVfnatqbxhIy1gbvVASxNumHOVGxsv5wQN6iwBxfAGE+1RC5Ef4X7t/znW5h+z4P
 rCAcSw4Tu9ILao996BcEUt39sVwwm84qdsyY7XrP/zLn8QhKQx2zRMxcKT8FLMHmV0UZwG27L
 xW/2MUWBZSktC58cbq9T72pfZCz+BORna+KTxn/xzvgGL4L1AaGKe2AedgiOl1BITN9mV/NGH
 PgUZ2Da8VHHWa9Hv76jGd0FvnZifDbOZtW1hzE3qdbj2ASqwmiCEBcnR3a0tsNuNhjeFxKlLj
 It9/7QWF5g+AW2HTPhCCM9g1YR8SxThroVkCHhmMnfSdLgucqKuNO1X/RDAzIKBn1qpUbWynt
 zzSCjcWZ3efWdc8nGmW9fnyncunbAde0O18g7ishC/EnPVAUBnM4Y+5Wp5gZS2y6+rxfHtCGR
 EE2R3qYbxzTFRNHbIlU9fVtuHURiDv/BkK8pMCveivO9JpKa+8buzriXaRfT9lsJpLLyflZfG
 OFs8rjS0sfU+gZ8vxxCe2iaVI4Bxk7pPqwiyPOG1y0yCnw+NsZopVwQ7hKGgXIRjZ6kEVPwCM
 c/t2QGuK7xdsbsg2FiykEEyvY+wIe/XZ0l3WUwxvYvD4WyJOED3+XB2oBo0xyUHqG7AhkQBzT
 zzkGnqKG4kW3ybvLXS59+2x1dZoIL424q/X5xkDURKZxCRCmfmlksIYmpPKzERv8ryb4fU6m/
 +fh08u79J1oaubS6cLj5lIUdB9RAewBU0Yf7hxLVddwbXNloYoe1dJ9XgFxiCf95iRyl3fRbR
 0ufZ3X65zdfCbQp2O9TruMzhO4AmUsM6sf1SQJQz9PbBR8XcC6j6qZsw+BPmDw4Ca1Zf2qMsw
 AncmdjiBbZXfKEOu4o/x7lxhhzQmKzQKpGRAsJ81oYp1xWGecX0vBRmscr89qch88I9xqpqgD
 JcOmo66Epn141SQDX2hmjT+LsOkQ78B3iwC5N1AK1geDRB2PrG1jDUQ5BidVCHd+777clTTgQ
 kQFpHAR/hEcSKtwOJeJ8EJmZenRtoUJT5+vuQDRxgdms65OPamzWllp85hczgHPfpPp7SfaPY
 mLzEU3NjmgNX0wk8o505sblwzB8dUvjn1Cg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You better do,

It can eventually happen again under other circumstances.


> it can be a good learning experience!

This can be also possible.


>> * Can the suggested small refactoring matter for a specific software co=
mbination there?
>> * Would you like to clarify this change possibility a bit more?
>
> -EPARSE

I am curious where you got parsing (or more understanding) difficulties
for these questions.

Regards,
Markus
