Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1841C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1F9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bQfGNoFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfHSUdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:33:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36986 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfHSUdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:33:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46C5H75FfWz9v0v6;
        Mon, 19 Aug 2019 22:33:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bQfGNoFg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OJe11MnV4u4U; Mon, 19 Aug 2019 22:33:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46C5H740q2z9v0v5;
        Mon, 19 Aug 2019 22:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566246819; bh=hFWGJxIKGcnvPhboOuIrOh8sFB7rg4yQxRCCBqljhVs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bQfGNoFgJOwJwV3UEvhSpwp+VN7EREX0Qb86kX5U3MQXGv7+E8m7MP3J/fjASUEzn
         NE6tvRzYSPvcADj/rwyEQ/f2rTJQ+9ZUgIHtCagnnUX7BWey3EvRc8nqGzzFYlvJD8
         Jdj3oMoB1Pc8lKhR4H0oXI9W5AD0VlOLcCM+SUDc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43D068B7BF;
        Mon, 19 Aug 2019 22:33:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kfbpiWo7zOu0; Mon, 19 Aug 2019 22:33:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C89798B7B9;
        Mon, 19 Aug 2019 22:33:39 +0200 (CEST)
Subject: Re: [PATCH] powerpc/vdso32: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1eb059dcb634c48980e5e43f465aabd3d35ba7f7.1565960416.git.christophe.leroy@c-s.fr>
 <87tvadru13.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d988bf0d-1780-2a0a-4f9d-48d233c32e5f@c-s.fr>
Date:   Mon, 19 Aug 2019 22:33:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87tvadru13.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 19/08/2019 à 18:37, Nathan Lynch a écrit :
> Hi,
> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Benchmark from vdsotest:
> 
> I assume you also ran the verification/correctness parts of vdsotest...? :-)
> 

I did run vdsotest-all. I guess it runs the verifications too ?

Christophe
