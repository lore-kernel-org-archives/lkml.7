Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64620C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D612089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIBlrj6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFUOqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:46:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41796 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFUOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:46:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so3715277pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YeYJiWJp9MsHiUEX6h5i5KyJQ1uqyv+cgtbzLuwMxJA=;
        b=bIBlrj6SJvGm27coMv8gvcGVis7CVdPkpuGVWbd8tlzMmKHY/tO8nInPNLafJhE5zb
         NNTk/M8pLR1NaEP0jv5VRvPjJOwUjCWesHq6avVC8bl6N/M2GDS95mp/+BWk1xPGAmF/
         NyBzQLRjOZotg5Rev6aQzro/uz0QLbZesbEttO4M5rTeurreTDsNJrzSnTV+ByHXzZAQ
         kqZG+VhRgW6fPciH2z6iiRuW1psLqQsn+ExazE0MxgWcSlfd69CSvadPlAhD/+0aHQQP
         3Qn4zZ+TDRmAvwpnOZdV1lJFxv6UXa150iubOAQdlj0wLlJACW4/q6Ki3X5Ysj0K0quk
         Fykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YeYJiWJp9MsHiUEX6h5i5KyJQ1uqyv+cgtbzLuwMxJA=;
        b=RIYVxuAdFUhsOYuLDGQU3xtx6ZmxbV81oqn3BR0+tWfrYBO2DpdEUq306+U0/XjLIQ
         GStCd+QQ25sJ7GKn5DvE6jXFocm8CO9yx1aPjhUGUxWdzgiSRah5DBBHpVqCm+5pCnib
         /trcZC2u0RTSYfix7V5GE3lWvpY4GjG9fLqC6ntAtMVQnuTO0cPwzIaTV9JfxRmq7nLm
         1bQceqxvdxvyXXa6Bi9qdq7MtdG2GwR6VsL/B6w5d+GbTTrMh1+HrR4vDPnRj0oXZUwh
         Lqj9WgrEMZ6E0idqGCny7GneX+k+UqMJ1btB57CJYOzVJl0PhDr5bmnmujQdXWsUBEAe
         TGZw==
X-Gm-Message-State: APjAAAXzh33n7G5pd9ZJODaQ3ohe2uzN3joouvnDNQhjv4mCBAasf8GR
        0uV3qnZV4HUocL/C2HiYK/0=
X-Google-Smtp-Source: APXvYqxHIVzUGzZFjBCxC6IFlvlwe0JS6Fyaw3V10ffP0u+kmWXjt4WMcU7mQ2dUL9OvC9PRWh/cpQ==
X-Received: by 2002:a65:41c7:: with SMTP id b7mr18737069pgq.165.1561128412761;
        Fri, 21 Jun 2019 07:46:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id q144sm5187006pfc.103.2019.06.21.07.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 07:46:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] ARM: smp: Moved cpu_logical_map[] to smp.h
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
References: <20190603231830.24129-1-f.fainelli@gmail.com>
 <20190603231830.24129-3-f.fainelli@gmail.com>
 <20190621075730.nubg7657nwlkmmmk@shell.armlinux.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4e6e7f40-ab4e-f41b-94a7-176cbbbb30f2@gmail.com>
Date:   Fri, 21 Jun 2019 07:46:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621075730.nubg7657nwlkmmmk@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2019 12:57 AM, Russell King - ARM Linux admin wrote:
> On Mon, Jun 03, 2019 at 04:18:30PM -0700, Florian Fainelli wrote:
>> asm/smp.h is included by linux/smp.h and some drivers, in particular
>> irqchip drivers can access cpu_logical_map[] in order to perform SMP
>> affinity tasks. Make arm64 consistent with other architectures here.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I merged this last night, and it causes ojn's builder to fail 98
> defconfigs with errors like:
> 
> arch/arm/include/asm/smp_plat.h:79:7: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
> arch/arm/kernel/setup.c:594:21: error: lvalue required as left operand of assignment
> arch/arm/kernel/setup.c:596:22: error: lvalue required as left operand of assignment
> 
> Dropping this patch.
> 
> Also, you may wish to make the patch description refer to the correct
> architecture.

Sorry about that, I will go back and revisit this patch.
-- 
Florian
