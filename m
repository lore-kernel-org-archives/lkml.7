Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F001E2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXA+Xt4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfCYPy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:54:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44250 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfCYPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:54:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so7326531oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g6xGLodDDgms6w7FgUnf63b+SEV7be9PLO7OpdSc9co=;
        b=QXA+Xt4zS98QAT1iMWr0PB2q+bd0QqoeGt1UUMGWoYbJA5qaZAfXrlLGGIvExFKzbs
         Cp+ZapzS+BaJgRHxiGW/Ih16kqVbjO6amuh8nHSDzqiz3I+ObBYQD1bHyMjRg30c+Pp7
         ab4h/4+rrODUKF9zjy4HKOGeUx7bzfZdDwAIbInpUcl3r2FyRc/waGWZzlQjRsxBStje
         JMY5J5+2YTmpvvvFoQGbMc6t3buIfHw159vlqlHYVf20cwgPDmqyfg8AU13wB3WXJiVU
         9zUYk/IcOgOG4pQkuv8bBxHv8JJoh3v2Cf/ZWfB4dTNK5ThU48Zg2HRR9Gu51LW7Zxvx
         l0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g6xGLodDDgms6w7FgUnf63b+SEV7be9PLO7OpdSc9co=;
        b=Tg1scjvT93BwwJ1o5e04W31lrHQl63R7z5QCrslc86jpBp3cjiK+jaQ4O3UROwkkoh
         qx9iKMvC57CptYg8yhhnZ9WgCW21uo8O8ei2LAsHQrBYFWGKn78dIhYzdcMnAfvF8BAl
         8GpITTe1UjAxrJaiPKFeBx+HvrDhDH9cDHqosMR8QYgeFNHHoWkNL43oBVuEdbN9PjMN
         50U0icOf4CqkyI9GqPDKhznklN35Byjch0ZZ8I/0Eb04mOpqXGkBzSgc1VPfRPT74x2S
         H3zWioC3XW0kWUBull+zt4HQ1M3VuxLcG1upetP5kXM3Gc/wJzeIS+x6n6JWGRfVznOM
         NmeQ==
X-Gm-Message-State: APjAAAW6nb8xnmTg5aJ1faAsFQ0usaKAxxaUV1MEv8Cob9LrOWoapnGt
        I/FTJ3yNpftZWnVuvG3ZkCtOG1RA
X-Google-Smtp-Source: APXvYqzrdVbP1vJ2P/zA6tb6UGnKD8dVr9GhxVKzHData6Qvx63d3nkS0N7itSMP/NMgim1CWDEnqg==
X-Received: by 2002:aca:34d6:: with SMTP id b205mr1045966oia.14.1553529267224;
        Mon, 25 Mar 2019 08:54:27 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s73sm6743279oie.53.2019.03.25.08.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 08:54:26 -0700 (PDT)
Subject: Re: Regression in 5.1.0-rc2: PowerBook G4 Aluminum fails to boot -
 bisected to commit 0df977eafc792
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
 <ee247f37-8889-934c-571c-01c43fc31071@c-s.fr>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <af5603cb-5726-213a-adba-164c635d1a66@lwfinger.net>
Date:   Mon, 25 Mar 2019 10:54:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <ee247f37-8889-934c-571c-01c43fc31071@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 1:53 AM, Christophe Leroy wrote:
> 
> 
> Le 25/03/2019 à 01:49, Larry Finger a écrit :
>> A build of kernel 5.1.0-rc2 resulted in a failure to boot on my PowerBook G4 
>> Aluminum. The bootstrap loads the initial kernel and issues the appropriate 
>> start, but the machine hangs at that point.
> 
> Can you please be more explicit ? What do you mean by "issues the appropriate 
> start" ? What is "that point" ? Any messages on the console ?

Sorry to be unclear. The bootstrap code prints a line saying "Booting Linux via 
__start() @ 0x00c00000" and then hangs.

Your idea of confusion between physical and virtual address sounds right. I am 
building a kernel with that patch applied now. As it seems to be going quickly, 
I should have the answer fairly quickly.

Thanks,

Larry


