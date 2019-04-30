Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07352C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C304A21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ecObLWPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfD3C13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:27:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:58017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfD3C13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556591240;
        bh=gXFsgHzPD6J7UQ9KSqF9iz7GNYGix/DEVgHu32cVH5g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ecObLWPThGzTkZT2MRHMPOnQP171R05kW8fSRKMrzTbi/ZyW+mX9CJDmnQMJuGFRX
         xj0A5BzfmiMVgPjjvSPvNXjC3IjsLI+647jxkYauqsQ4uEB+GyDRBj25mOII40mn+2
         OLhToYtIKurmDZjCF931t+7JXDGE3H9GFavPY1RU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.189.147] ([218.18.229.179]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZkpR-1hEzex1hFn-00WmUJ; Tue, 30
 Apr 2019 04:27:20 +0200
Subject: Re: [PATCH] quota: set init_needed flag only when successfully
 getting dquot
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
References: <20190428053921.5984-1-cgxu519@gmx.com>
 <20190429214956.GA6740@quack2.suse.cz>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <5d005f7a-0e5b-57a5-44d4-83b12fdfa9e9@gmx.com>
Date:   Tue, 30 Apr 2019 10:27:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429214956.GA6740@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:zWtgcCT0QM3/aVAXP0ltgTAFWSo7O9XnzuXZJPCBCtcv0h0lCNQ
 qCjiccIdXUSij1gwbSf97s5xhBaTG5JjKBKdoyqpa/IUgcsAA7IRaxYdzHcq4BlZZ0IuOXD
 mWQpEo9pPFlgbv/iM/l7bCzONE9q2lKBwK9RIwzQdCOHsfWT/AYk9FixfJW3dSHc6ShsriC
 4ptWZn6Qb3rDX12cxg4BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LOiZKh1A8Us=:DVKf3QwjlBgSquh2ha0Lt0
 t7KuyZORXRIuYtVnDKB5ab/hpBF5MVH7pUcqgxrCLumelwTLUlgxfEMjiXseNzQairj4glrU1
 PnYGHJtLf2Ix7O/L3EPDYahNk8OEDTyOEs1m2Wilui/jWrb6Cwqp6YhwDKQJ9Sk//+cX8Mp6V
 LaDuUNNx8+pXfRMs9lIxQIzPS44y3J6za2RYQtPCgXqOA3L8Tcc3cGCCBs6BP6Dtj2cr2D4Zl
 TFD5EdMQf8YHXDrhMC2OZyFU6hfYovB95WE5aSduiXx5hl5eseSk3ayhASNAeehnHtC/GkpNi
 DJbnVOWP9Kn9YZYPgyhNT4z0ynf5HALtPuJUxWAmIBzqCXZOyovnaO0zxcHPpQREMGZSw6r3y
 Bk0/PwBwUXphsWREseIyRr3q55bVCr4xfiKc7Vi2V7ebS0ScXb03Iu3A5lxWxWUFAH/3MmeVd
 +sQNcTwIzt8PLpsCBjZ7EGL3BsWB5ZHtR0TBinkR3lnStKlYr2GC0ZGTVO8Qm8ScAjIV/KRZk
 nU5eVyDBjRX6rZwqilLZaQXkKQYVi7nV7KP9egVZbXIcK0s/u7WWK0m8FIs7+57svk77x2JcZ
 k0p4BdR2XYrcYiUjtrCkJxPvKK30xEym/7Sc/EH9fYCkEqlWREUttGmf4aWIrEYkYAHHVsafr
 F59cPbMplUW7cQgS3NadEh7H+popF9wKkqwbTaX5M5VbLRD+LnBAIXbJowJ2ZtLB86rRk+H1v
 S3Qdnw8iIZHqGtrLZdW25ezUDZ2UL7zpye1hrhjb6lWkIksTHQxj4conD98pUtI2ReMZkA0Yy
 jrKUW1XnfzXwArebCakN7skKeV3J6CfK4znnDcupmd72VgtKU2wnITGnImG2jiVXARw7yXdT9
 mfz7CkrS3/FxQ78HPTv+69gVCO983YgbWywB4NJssSPNoFoJnNg358Pf9ib2L7utxQ3K808JH
 Pxx7MnztQeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/19 5:49 AM, Jan Kara wrote:
> On Sun 28-04-19 13:39:21, Chengguang Xu wrote:
>> Set init_needed flag only when successfully getting dquot,
>> so that we can skip unnecessary subsequent operation.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> Thanks for the patch but I don't think it's really useful. It will be very
> rare that we race with quotaoff of dqget() fails due to error. So the
> additional overhead of iterating over dquots doesn't really matter in that
> case.

Hi Jan,

Thanks for the comment, I got it.

Chengguang.

