Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5091F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="iZJV4WTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfF1IxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:53:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2312 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfF1IxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:53:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45ZrBx4KdTz9v1dc;
        Fri, 28 Jun 2019 10:53:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=iZJV4WTx; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hpEMNWuvYw_w; Fri, 28 Jun 2019 10:53:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45ZrBx3HBlz9v1dW;
        Fri, 28 Jun 2019 10:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561711993; bh=QNUEzs2e6ZJPJ8ysIU+hR3hVhhJUmwBw6ciMTdldx7A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iZJV4WTxJKKUSiKol7dhPzbHdXh3ec9EIn5pAU5cZ0JJKx73Odp0IwloU69qraA7r
         6Zo4TMx5/pg6etpO2hsuq1/xSK17qLVslIfBbTtCtJCzaD2XNn9p0YS/2cehaW+aTE
         uyhro8CTUATQmvLZSsNKhWp6axzRPO3dqo66674w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7148C8B965;
        Fri, 28 Jun 2019 10:53:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id h0xoail7aHWy; Fri, 28 Jun 2019 10:53:14 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 436C08B961;
        Fri, 28 Jun 2019 10:53:14 +0200 (CEST)
Subject: Re: [PATCH 41/87] sound: ppc: remove memset after dma_alloc_coherent
To:     Takashi Iwai <tiwai@suse.de>,
        Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org
References: <20190627174018.4015-1-huangfq.daxian@gmail.com>
 <s5htvca6qp1.wl-tiwai@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b5f24a12-7fcf-63d3-4ca0-578aabbcbb8f@c-s.fr>
Date:   Fri, 28 Jun 2019 10:53:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <s5htvca6qp1.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/06/2019 à 10:48, Takashi Iwai a écrit :
> On Thu, 27 Jun 2019 19:40:17 +0200,
> Fuqian Huang wrote:
>>
>> In commit af7ddd8a627c
>> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
>> dma_alloc_coherent has already zeroed the memory.
>> So memset is not needed.
>>
>> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> 
> Applied, thanks.
> 

Euh ... looks like a v2 of this series was sent out.

Christophe
