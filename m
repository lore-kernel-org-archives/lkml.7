Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB10206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="mR9dvPh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfLRTZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:25:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40481 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:25:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3163366wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Vh60d8XCONWUkatogtfY9A2nJ49EsfixlnmcJEQxlF8=;
        b=mR9dvPh7FF79YB35mOPwbwP31AjoKRJmH4ha8hnobUZquXXgAKnGIjZZD4hVGjx3Q2
         BsKKeHK7P4nRc1bqjzc+44fpgYXdrKZ14uHl7oIdOCooUHbWOcINhmn4K8hLJYe5Otbz
         ai0WaVuW/xxztDG32eJPvid96fnV7bNzypF/GdyAK5KGyMM7xI7DFLU/0X4ScFdd1mOi
         gFdg55sz69D4BxdXObG0+cqYu5iAvHewJQzhDsC0foQAqVbg6Pl4zFtWplfdQQGTjwbZ
         Xqin27PdsvX5YcCUYeyENtHA/5IsaETAJSsTPi41nBptuScTjBmC8gJbwLxLOxWYnhmv
         rRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vh60d8XCONWUkatogtfY9A2nJ49EsfixlnmcJEQxlF8=;
        b=EniFOJ+kBg2dWJgYOcbxd3NY6uh16GXZx+Z/MjfhFn174izDxdl/UrlnL+vi+1GJ8z
         /M6+/3QTYxuWFniHuqnIEsxaxQhYUEKvLPDtMKyQ1P6mILvZgzUKYDDI+NGRTa6eKQAh
         rYNa8gYixMPfQJ2s1RzGPw3yJYQKB8lESeg7pzxjkS4M4CCwhLrCFAJXd54nYqYkJVS3
         OwEd20uDHoHZG38NdkAgIpM5D3C6K3Zs4fyNC7b2qwI6rUWu6NsoflvS1/oZlbq7C/YB
         gdYayEktWZkINROeOcqD1nQ4MQhzcD60+IAw/M6AtedE5Dt2iCxeJGAsVwNEkGMfPcFP
         dgHA==
X-Gm-Message-State: APjAAAXuJK2pvDMvOB+6zdx0cvuSJiveWY2bzAWLtyfyPcaI/41Vlzh9
        tP2CGSPfzeviAKSMxYnC6QpYSQ==
X-Google-Smtp-Source: APXvYqxDiS52rz8WG6Z2bJuLui9YI8l1n+o0vjAp2u/TNZuWDmkjG32hIsCYnK2+fZ73xdnK7qQxrQ==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr5159955wma.34.1576697105813;
        Wed, 18 Dec 2019 11:25:05 -0800 (PST)
Received: from linux.fritz.box (p200300D997066900416DA9112A67C4DF.dip0.t-ipconnect.de. [2003:d9:9706:6900:416d:a911:2a67:c4df])
        by smtp.googlemail.com with ESMTPSA id p15sm3463397wma.40.2019.12.18.11.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:25:05 -0800 (PST)
Subject: Re: [PATCH] Revert "ipc,sem: remove uneeded sem_undo_list lock usage
 in exit_sem()"
To:     "Herton R. Krzesinski" <herton@redhat.com>
Cc:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
        akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        malat@debian.org, joel@joelfernandes.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        ioanna.alifieraki@gmail.com
References: <20191211191318.11860-1-ioanna-maria.alifieraki@canonical.com>
 <d66d41fe-212f-effd-905a-5966a96ddb6e@colorfullife.com>
 <20191217211745.GT7463@unknown>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <07d574be-0d97-d0f8-8f22-017abebc6b6d@colorfullife.com>
Date:   Wed, 18 Dec 2019 20:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217211745.GT7463@unknown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello together,

On 12/17/19 10:17 PM, Herton R. Krzesinski wrote:
> On Mon, Dec 16, 2019 at 08:04:53PM +0100, Manfred Spraul wrote:
>> Hi Ioanna,
>>
>> On 12/11/19 8:13 PM, Ioanna Alifieraki wrote:
>>
>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1694779
>>>
>>> Fixes: a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage in exit_sem()")
>>> Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
>> Acked-by: Manfred Spraul <manfred@colorfullife.com>
> Acked-by: Herton R. Krzesinski <herton@redhat.com>

What I forgot:

I think Cc: stable@vger.kernel.org should be added:

The change is obviously correct, it fixes a real issue.

>>> ---
>>>    ipc/sem.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/ipc/sem.c b/ipc/sem.c
>>> index ec97a7072413..fe12ea8dd2b3 100644
>>> --- a/ipc/sem.c
>>> +++ b/ipc/sem.c
>>> @@ -2368,11 +2368,9 @@ void exit_sem(struct task_struct *tsk)
>>>    		ipc_assert_locked_object(&sma->sem_perm);
>>>    		list_del(&un->list_id);
>>> -		/* we are the last process using this ulp, acquiring ulp->lock
>>> -		 * isn't required. Besides that, we are also protected against
>>> -		 * IPC_RMID as we hold sma->sem_perm lock now
>>> -		 */
>>> +		spin_lock(&ulp->lock);
>>>    		list_del_rcu(&un->list_proc);
>>> +		spin_unlock(&ulp->lock);
>>>    		/* perform adjustments registered in un */
>>>    		for (i = 0; i < sma->sem_nsems; i++) {
>>

