Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67442C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3A62084F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="infkLwQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKMH1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:27:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46693 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMH06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:26:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id o65so1033027lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 23:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDdws34Rq5JH8sQUN0hdqQY10XjPq06N8OEfJVtJ98w=;
        b=infkLwQ4ols/YljFrq0q1EHDCTxYJ9I6JW1B0gxtlldWOg+TTabbxbwjRBtaQx+wQK
         WgBpqpmqIY9DCHqrgHhKGWBPwnCfKNIVeo+5v4472CqqXWDGbGJ3UTn3X2r1Tynkubkm
         V6o1wD5j1C3CiafXqbCSeWYKylOFg+1sPKmz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDdws34Rq5JH8sQUN0hdqQY10XjPq06N8OEfJVtJ98w=;
        b=hZoZqUhHoBUHO9JO4nWfxtsGTKMYDsexRr6a8/4S8d83ur8JiGKLkqxOaRzBVQs7tv
         LBSk2cpbuxIgY4S6jkIwhV2p67wvS05MVWqSLHoANTA+Wsw9JqKm9a6TxfppIa7O7hBU
         pYKo852yfjlgengMlSaClNRzss5EdsoHitOLSWTUsN+8jf6PtmJhrE9yja7sdNULFyUG
         CU2A4V6pr76/w/AY4iQADc8CGIkav+JQefsXG7dpoXhcsCNF3Nuc1GRliianVbXdYwUb
         b5JYYiqcwxLNR5k07yzGx6EOp6dVQKNDGOVeeI8sfW0YwHNYVkU0of56MtYA0sycwWMC
         Eh3A==
X-Gm-Message-State: APjAAAVTQvkjKm5j2Y6rQ8sbDL5sjgy45Hh1aqwqXB/eoEQlxPZMWwbK
        zQ1gAQA0JiS2L5hC2/wV5r5ZzG0Ix1XkIi1/
X-Google-Smtp-Source: APXvYqzFLTMfk5U2wuTAqB0pvxbh8egdOKI3L4BeWtTxYDFWuldchErNN4wBbpobHrBl+QXZvWrohg==
X-Received: by 2002:a19:41d7:: with SMTP id o206mr1526891lfa.188.1573630016296;
        Tue, 12 Nov 2019 23:26:56 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 7sm553587lfr.70.2019.11.12.23.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 23:26:55 -0800 (PST)
Subject: Re: [PATCH v4 00/47] QUICC Engine support on ARM and ARM64
To:     Li Yang <leoyang.li@nxp.com>, David Miller <davem@davemloft.net>,
        Scott Wood <oss@buserror.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <CADRPPNSeEvFnVzGeZW6RPo_LP8mq14G2ZmmDAuwNdC3hT8Ekcg@mail.gmail.com>
 <CADRPPNQFiPMvRcSkVgM8p2_AxhqBOVFus=cX5UC-8NYYUvf+0A@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3d6abdfd-b180-d382-ff8c-9777cab21e70@rasmusvillemoes.dk>
Date:   Wed, 13 Nov 2019 08:26:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNQFiPMvRcSkVgM8p2_AxhqBOVFus=cX5UC-8NYYUvf+0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 21.45, Li Yang wrote:
> On Mon, Nov 11, 2019 at 5:39 PM Li Yang <leoyang.li@nxp.com> wrote:
>>
>> On Fri, Nov 8, 2019 at 7:05 AM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>
>> I'm generally ok with these enhencements and cleanups.  But as the
>> whole patch series touched multiple subsystems, I would like to
>> collect the Acked-by from Scott, Greg and David if we want the whole
>> series to go through the fsl/soc tree.
> 
> Rasmus,
> 
> Since the patches also touched net and serial subsystem.  Can you also
> repost these patches(maybe just related ones) onto netdev and
> linux-serial mailing list?

They were sent to those lists already. For example, according to
<https://lore.kernel.org/lkml/20191108130123.6839-29-linux@rasmusvillemoes.dk/>,
the recipients for 28/47 were

To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-serial@vger.kernel.org

same for 29-33, and 43-46 was cc'ed to netdev@.

Rasmus
