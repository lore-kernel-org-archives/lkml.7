Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4808EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0618920693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bm5lBrJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfCYBTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:19:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:53157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfCYBTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553476752;
        bh=6ltL+c8f8yIUWA4h5cqKp/m1FaRIpzpblB49oQwoJqk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Bm5lBrJFZOPEW98coDTSYivGWvDW00uGiPByr2MVwE6Es6Pvu3Z4dgtyi+8PriMDy
         fj2fbn2EV+qsQt8p2Ck69Vl2l9Sg6tbXZ9qNoAUMUS2PtRzdXoYFseWAgVWHzfYzBf
         OX0+7q4GKSPAyT/mwyt61Y2KdxqH2p6AOQrzRf84=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.180.101] ([218.18.229.179]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MNZ9u-1h2BrJ3Czy-0079wp; Mon, 25
 Mar 2019 02:19:12 +0100
Subject: Re: [PATCH net] netlink: fix a memory leak on error path
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190322105845.25046-1-cgxu519@gmx.com>
 <2acfd376-7b25-5eeb-2770-413b880bd4d9@virtuozzo.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <786f1aec-fe47-f060-6f6e-4307ecaff82d@gmx.com>
Date:   Mon, 25 Mar 2019 09:19:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2acfd376-7b25-5eeb-2770-413b880bd4d9@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:te9b4vdvv2rQ88nYuLwkapse97nP7yaoigT66rvni0BD6CTIoXQ
 wAKzlZJHBbZ3HAJnVuEuWsb1olpTcp0Ea/AvyF/bpQuujBdxus0IjqW3r+EANRjt/leF+8p
 UsySAS7ape4UGkSp9n0mAs4c5J3CslP1FpnSj5MSL8bOhjHPcjNiapdIGGZP4fXekK3mFIE
 Rzg5qTSHnT8Y/8b0KRsOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:REPv2JLi530=:yhoF7O3Goqm6w9Z+jpVE4q
 BXLZwm861uPhXzlMDAzLMxhc07eRtpnUlf+vZ28UWoY/nDLdMEO6wbHDTUtQvmCUmBe+y5RKg
 z2Q3HhDcCHgXp+wng6REm0ebvI3zUXpLf1RCiM9R8oHYAF83/R5tb7korSfoy9lk1s+kZZNoy
 xLEg1tu14E6pij/8zxC1dvJb/cniCws/K9zHN6tB5YHfXOrAZhQ9CChHtmFkp3f8E4/UlFMxX
 t0jcI9nRdJ3EJuvc/vU9+3eNLbWF4IDvBMdeg3c7noG0JrzB83XGiWxHNteMIepbGVELDjwcJ
 tNPtYGqoUdkDrqF0yywV3bVF/4R6XhIJ1snOK12dOi4N9s+wZQpaXuliMdRuUM7K1/q6PPl2b
 IjAEU9sgRhG2Jg3ov2Ax7idpXeSxFRjlyCxRFEaAERSPBNtZt0N4dra6i4w/w3nc8fqMpQvIf
 dUH8xRCluWl6hUGHXbgWssa4IYQc9aOeEghjRb4/FeVDBcblKsmGydLQ1lGB5gp+a0mF1LKsF
 Fw1hnIKrosdUJpJcSbvC1s8d9kZDhurfqh7I6qriGcL3/U/4c/9qiPXMy7vK6g9J4G0AzZnZH
 ysRYbZuu5Aw0nSFC3iJ1rV/dA8n1GRy1jgC8B05MmXc9sr+UWAUzfQElUb+RsV4Y6AH91UZde
 Q+ePiJfAxIHYBilXo6kG6LTKYXuGfrSA0NcCj+POJ50ciWWdCZNnoM9NeU4ld/egeh9fpZgpr
 Xs4gzohjnDrIOYQZn6Df/oSLT206Hibj+pXo55g9ldWhCogAzp145Z0WNecGEgQoSwx2C6qvR
 8FUzxfRKU30NuuKvm6YH2hc90TjnDkJFslWzAmTIM5cDWNB3se4eu28Po7kA5jGAyA5yCfl+2
 IWP64RUJtKX3eFgZWkthiU8r9YSGNdWwmMwV01ksBi1yZJzJWKoiBt4I1Ad3g1Bn/jiokAiVb
 vzG2VrxjQ7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 7:03 PM, Kirill Tkhai wrote:
> Hi, Chengguang,
>
> On 22.03.2019 13:58, Chengguang Xu wrote:
>> In genl_register_family(), when idr_alloc() fails,
>> we forget to free family->attrbuf.
>>
>> Note, some callers call genl_unregister_family() to clean up
>> on error path, it doesn't work because the family is inserted
>> to the global list in the nearly last step.
>>
>> Fixes: 2ae0f17df1c ("genetlink: use idr to track families").
>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> have you seen https://patchwork.ozlabs.org/patch/1059834/ ?

Sorry, I didn't notice that because I'm mainly working on linus-tree.
Please just ignore this patch.

Thanks.

