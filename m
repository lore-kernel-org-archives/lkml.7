Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3121479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctBA88xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfDSTcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:32:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45545 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfDSTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:32:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so3032857pgk.12;
        Fri, 19 Apr 2019 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgOYNUsB0wPyvHZ3hNvXxT87/HJMQO14ngzODsNYyHU=;
        b=ctBA88xkzwIFuLJdC8ZpinWF8eML+6NG+lKFJKXXWwX0kxg6PtHVW2i1MAysqm5e4q
         TlESTou9lOQ1KR8qN/Q00Nn+f9iDTQrXJLI5Z5chkd9N75rzI6Lu4NZs+GjnG+fRsQ+x
         BRro+FOA3oivCFvn12aSsL+yjM4YCeCeUS8CFp+f8IZtbeyVDn0NMqNIWpH3XwJaBOsd
         O2TMFxhTsVZA4sr+sDvQuhNC9DbHY5E2YezA4qEMOxtree8i0OWlvqLTrC/LBwVnOPVK
         kOGpuXbW8Gf2psYI38tomQlpGhYDSvTsqM7tK+bRkfTkbabvRgdeKotBzy6ndS087neH
         sLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgOYNUsB0wPyvHZ3hNvXxT87/HJMQO14ngzODsNYyHU=;
        b=Fk15pWV2EoSJ0ELHGKQAWMoFZkum92wD9ZuanrG/hq5s/Bh08b3PedahuJ1sj7ipOv
         wA3WLMMx4i6MMp4XdOL9csE8HoyfyEtq370ypdRQptOGPsTa38EIHmKN5XY11jvpBE5U
         2QWdl57p5S3MixLBOZYLTIn9EPfftGe+9t/Ao6uc28BpsohBq5e5mKG1uiRuuig0cnYJ
         Zq+7Emzap5x4SGVzSZjKXwtlkV+ApU7U++tha90wvy8MjB39L8umtdf+fxN8NRxBovej
         Quv/Qnrb625R33i6g5TQd/dHNBJdxdpiL5GCrPs+iBE7miUYbSLA3f9LuN7zqN6UcBEB
         nhkg==
X-Gm-Message-State: APjAAAUAakNE2sPeb0VyJyQB/oUm2V5iHHQFxUFqmzNfoXSuz8J6glqZ
        0Jsb0/DMkww93p8PcTjvf37rwluk
X-Google-Smtp-Source: APXvYqzRK6SW3IkGdjdvVUmM2z3ES1iiCYsNP2Ai0dtLcY1LrRC23mhbP+S8BpDrfb9m09eHwbPavw==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr3932994pfn.132.1555681021746;
        Fri, 19 Apr 2019 06:37:01 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id w3sm8802501pfn.179.2019.04.19.06.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 06:37:00 -0700 (PDT)
Subject: Re: [PATCH 1/4] net/skbuff: don't waste memory reserves
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
 <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
 <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <299e5bb3-665b-2d3c-fa4c-75466c4a51bf@gmail.com>
Date:   Fri, 19 Apr 2019 06:36:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/19/2019 06:17 AM, Andrey Ryabinin wrote:
> 
> 
> On 4/18/19 9:55 PM, Eric Dumazet wrote:

>> Are you targeting net or net-next tree ?
>>
> 
> I think it's up to Dave to decide where the patches should go. They apply cleanly on both trees.
> The last two patches just minor cleanups so they are definitely net-next material.
> 

Not at all, please carefully read 

Documentation/networking/netdev-FAQ.rst

Q: How do I indicate which tree (net vs. net-next) my patch should be in?

You need to split your patches in two series, not assume that David will manually do
the manual work for you.

Thank you
