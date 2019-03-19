Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66230C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324BC20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWPZDvDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCSPwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:52:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37886 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:52:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so21751203wro.4;
        Tue, 19 Mar 2019 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1GLwgfd2Ql6f6GoUQ8kxxPCs3F76RP7kpHG7mfH8/io=;
        b=tWPZDvDJi0/0aY8v8aO/2tTJPORsZPdHoUU+kxHSB0NBeiKkXjliPNbGUZDrIDBBFf
         wBQdEQKCQsDJLFvA/EzKWOgIJ+WWCMwBuz/wYduzhg/qdzax34bkqb0h9x+1qduH1J3s
         UihcmbjD77aQ/LL7eyfrZmIzTlcJUBADguMbI93uABFRVa8nBRxtyCp0TCxvedUwO2Ce
         Oc1BFF3+GajjE6w6iGmFjCnqcR4g67cLOCye3LD878RkV9u0BwrBpUNlR6ZUPLjFNrjA
         h5BMBdp+iqQLYtPznufpZ3JGcK0Ejq2dz1uzgiDjd5O8beCRRutceSdXviVxUxJb/OBD
         Izkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GLwgfd2Ql6f6GoUQ8kxxPCs3F76RP7kpHG7mfH8/io=;
        b=FfsI1rGMOxewxhP9qyxpIlZp92KjN7OyXI3FlZQCuneg+85lIm8Qyy86p2obbha+0X
         DfsyshYn8rCNzm2zTHJDWRa0dAvm5L0aNwe5dyBe+TbCQeGC16wfPkTywXPjK27mtape
         +YtxXLo7ZyqUAb9OqMLYuV3Cu446R/TSOpU3JihrwNBdzazOurmdImzEoMyf+w9oaAcW
         QAddshzHbVCdbXutn4Rw8AiS67Ni3Zr8ON7vTyOS6nP0Kld9jeK76g82Q6A1q078HAeC
         /NpSo0HTNOT/vc/GBJ8iaY1KVw/PCzzl9CIrMBhLL0qyQ1uWqSbbWbeTnHdJJJmCf3Re
         xuHg==
X-Gm-Message-State: APjAAAVGR22pIG7p+BWHSg3/q+PcQ7YE3r2++ariJaF9xXLddtFUzCKk
        A7ELPhpNtGSV4xD2hF0kfLErJzXI
X-Google-Smtp-Source: APXvYqz3DqMvLgM3wx75+iuFlHfkBQidiMhnQvGcIwF47a5DBlve9O50qnD4VvnvLMZKuApZtyMeVg==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr12349422wrp.197.1553010769659;
        Tue, 19 Mar 2019 08:52:49 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id g8sm14904276wro.77.2019.03.19.08.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 08:52:48 -0700 (PDT)
Subject: Re: [PATCH v3] net: xfrm: Add '_rcu' tag for rcu protected pointer in
 netns_xfrm
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Su Yanjun <suyj.fnst@cn.fujitsu.com>, davem@davemloft.net,
        fw@strlen.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190311101006.GK3758@gauss3.secunet.de>
 <b2beff03-f789-5c8b-bd69-57ece92372f8@gmail.com>
 <20190319151503.GW6035@gauss3.secunet.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <fc5b9608-4980-ae05-fab5-d050b80cf49e@gmail.com>
Date:   Tue, 19 Mar 2019 08:52:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190319151503.GW6035@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/19/2019 08:15 AM, Steffen Klassert wrote:
> On Mon, Mar 18, 2019 at 10:22:46AM -0700, Eric Dumazet wrote:
>>
>>
>> On 03/11/2019 03:10 AM, Steffen Klassert wrote:
>>> On Wed, Mar 06, 2019 at 08:54:08PM -0500, Su Yanjun wrote:
>>>> For rcu protected pointers, we'd better add '__rcu' for them.
>>>>
>>>> Once added '__rcu' tag for rcu protected pointer, the sparse tool reports
>>>> warnings.
>>>>
>>>> net/xfrm/xfrm_user.c:1198:39: sparse:    expected struct sock *sk
>>>> net/xfrm/xfrm_user.c:1198:39: sparse:    got struct sock [noderef] <asn:4> *nlsk
>>>> [...]
>>>>
>>>> So introduce a new wrapper function of nlmsg_unicast  to handle type
>>>> conversions.
>>>>
>>>> This patch also fixes a direct access of a rcu protected socket.
>>>>
>>>> Fixes: be33690d8fcf("[XFRM]: Fix aevent related crash")
>>>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>>>
>>> Patch applied, thanks!
>>>
>>
>> Has this patch ever been tested ?
> 
> I had this on your testing system and it did
> not complain. But maybe my testcases did not
> trigger that codepath. Su, can you answer
> on Eric question?
> 

I can release four syzbot reports if you want.

