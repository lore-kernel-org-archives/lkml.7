Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016AEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3084206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5Kr8noE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfFEMxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:53:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33466 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfFEMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:53:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so4990881pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8OO5de15CKFr8wHCwMW+y7NtSPgZuAg+fbs0S4ZOD4Q=;
        b=i5Kr8noEdSNioZn7W1oY8BIV8RpAglWLDKr42IaJOjk6FK6VMipuk4CGufa8xW5jfI
         ZrDrSxMcPS9QaNWioDIKpXxLyunhXcUcl1h2vFIH2qnHtcFCXI0cHCHvf+lUbp5XvZI0
         S/Wph6YKBYI/+crFDWak1n/bWiGC+MGt3iRlAY8JrH2dPdRbXd9R0AFyoLItjUrQ6DrE
         aWDgjqHXRE0BhjJzCp851LJST/hcb16uJmL8tl9W1nJbT+S4cp3c7ClW/CFZwmg829Fp
         Yk2j6SGhWamYleoWjjfuGGpAYbP5qF7ihvsCoN/SPwF05744+6MPZeU1fB9h4H+F+7tC
         zcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8OO5de15CKFr8wHCwMW+y7NtSPgZuAg+fbs0S4ZOD4Q=;
        b=FibW4SHkz5hqx2uPwFLFD8amLTON7Bi7U6u1Kps31kGUODuZhZvyKVNoVHBcXhY28x
         95WYVQ4TnkAQU1eef4J8RdbActZ+o6zS0HMGKdO98INd76+UhE9S7i2ZkIO0fveht0fi
         tFfeJCzQU8sxtSA3dEqp9rC5/8NCdY/x32PWHEjN1P2jPYApHlo6MX4B/zSsiU1EW3eL
         zdJmn69cSszHO2CxeUk3h1V0MW+XNYYBaRX7Clz9u1rvT/KCJA31ABw8GVvXvNXXpvnj
         3bG2kEPpAUe/hXR9b95rDEE3iMh6hsi3KkMT1lx2ZoSul5PFTn407uZ6mlafslKEe/J+
         wcUg==
X-Gm-Message-State: APjAAAVTyx+L5QZ1nVi4lAoMlq42N15RkDzgvoJ6eZQdea8V4HQWtYJp
        Yu4aioz/XykUv9mzcNeFxi3NMlwD
X-Google-Smtp-Source: APXvYqwcqApiGCTxpaxAAnU91R4amjEo/dzeMf2KNPOdiUs7zunJNsapZ2Mr5NHnI2I+7T3kmE1Q4A==
X-Received: by 2002:a63:d504:: with SMTP id c4mr4132889pgg.20.1559739180549;
        Wed, 05 Jun 2019 05:53:00 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id o66sm16898206pje.8.2019.06.05.05.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:52:58 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire
 peripherals
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190429081937.7544-1-geert@linux-m68k.org>
 <20190603122608.GA21347@jerusalem>
 <d474e366-cf5f-bbf3-9521-c5ea29bb9c19@linux-m68k.org>
 <CAMuHMdVTOO13Y49D82r5YgTFGwvgB0UdCZ3o1VAXHWzYof05xA@mail.gmail.com>
Message-ID: <f5e30b21-3c88-c134-d2bb-dabd191c6122@linux-m68k.org>
Date:   Wed, 5 Jun 2019 22:52:51 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVTOO13Y49D82r5YgTFGwvgB0UdCZ3o1VAXHWzYof05xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 4/6/19 5:34 pm, Geert Uytterhoeven wrote:
> On Tue, Jun 4, 2019 at 9:18 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 3/6/19 10:26 pm, Angelo Dureghello wrote:
>>> couldn't seen any follow up on this patch. I tested it and at least
>>> for mcf5441x it works properly and solves all issues.
>>>
>>> Do you think it may be accepted as an initial fix ?
>>
>> I'll add it to the m68knommu git tree.
>> Seeing as you wrote it Geert I assume you have no problem with that?  :-)
> 
> Actually I wanted to look into the issues pointed out by Arnd, but didn't
> get to that yet...

Ok, no worries. I won't do anything with this right now then.

Regards
Greg


