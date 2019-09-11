Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCCCC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F152082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BheTapsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfIKMiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:38:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19936 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfIKMiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:38:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46T1dj3qf5z9ttBh;
        Wed, 11 Sep 2019 14:38:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BheTapsZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mYSQiCEUNZcF; Wed, 11 Sep 2019 14:38:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46T1dj2lqhz9ttBL;
        Wed, 11 Sep 2019 14:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568205481; bh=DhX4WED4iVEDvM7Oo6DUrJ7y5zvr1cIiyY6i5byB5xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BheTapsZKTb+mshgPxc5LdW+Rjt6YT+UWBHiyi8BqPZzqijoiF4b8ASoCLfoJqGIo
         u2zdN67hu9KFy/D7DmUHWGbYstPxxBodFfJcUcoxDR/bUVxj38gJIOHySRpbnIugt1
         PbCeRLYqhEnvNMELqUUbiz0qeDa36xLBGYDo6rOk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB57A8B8BF;
        Wed, 11 Sep 2019 14:38:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SJCnYKUN_9kO; Wed, 11 Sep 2019 14:38:02 +0200 (CEST)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 945FD8B8A6;
        Wed, 11 Sep 2019 14:38:02 +0200 (CEST)
Subject: Re: [PATCH v7 0/5] kasan: support backing vmalloc space with real
 shadow memory
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
References: <20190903145536.3390-1-dja@axtens.net>
 <d43cba17-ef1f-b715-e826-5325432042dd@c-s.fr>
 <87ftl39izy.fsf@dja-thinkpad.axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f1798d6b-96c5-18a7-3787-2307d0899b59@c-s.fr>
Date:   Wed, 11 Sep 2019 14:38:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87ftl39izy.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/09/2019 à 13:20, Daniel Axtens a écrit :
> Hi Christophe,
> 
>> Are any other patches required prior to this series ? I have tried to
>> apply it on later powerpc/merge branch without success:
> 
> It applies on the latest linux-next. I didn't base it on powerpc/*
> because it's generic.
> 

Ok, thanks.

I backported it to powerpc/merge and I'm testing it on PPC32 with 
VMAP_STACK.

Got a few challenges but it is working now.

Christophe
