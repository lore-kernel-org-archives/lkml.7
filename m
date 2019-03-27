Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41FC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD85A2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpKcru/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfC0Wz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:55:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0Wz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SnnOPuYGwfsBn4pr0Duph/PqYHKZWyJUupKIiMgpd8Y=; b=fpKcru/TWQCqVYR5w+Gi9IFHj
        +te9k0gDg/mu+05upnLvAiThj4KHpY0upeH8yShRHE65piOYbGA4Nys7H1auxtgoNdBaTGecv3Nmj
        ZlL1ehH5CWc/vg+aeKOEUQaNVshZmCOs0Vo+FCgXG9KEOba3229JNpPl7/d11Gcl3csvV3ozqom3a
        cnD4fzUbpn3iOE0B3lNmfi6/Hrtoe7qSCrhWjv6RZrZUqVpZdoGCNrGMM8Z59j8EfMmB+8E/kGDQX
        QqIDAt7HZDEw33IM1Phas8KGzEK3hbfZKK5X474TIUcgSMLYENQlpvGQ8T2aqwefDVQV3wsJE0KU0
        bKK/OxWaQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9HS7-0002g0-OD; Wed, 27 Mar 2019 22:55:23 +0000
Subject: Re: Linux 5.1-rc2
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
 <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
 <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
 <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
 <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com>
 <e1f6f5a6-9fce-2e95-4593-79f1e836bac5@i-love.sakura.ne.jp>
 <CAGXu5jL0YzgQR_p9otyOX4+00a0i7Tfv9aLqauZFZs4-Kfjakg@mail.gmail.com>
 <ea75aace-a493-b2fa-1fef-d6ae76085c39@i-love.sakura.ne.jp>
 <d067619e-8c7f-94ec-a835-fc86d1b449e3@schaufler-ca.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <366dcec3-1599-9e56-4660-44791e1c7a45@infradead.org>
Date:   Wed, 27 Mar 2019 15:55:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d067619e-8c7f-94ec-a835-fc86d1b449e3@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 3:23 PM, Casey Schaufler wrote:
> On 3/27/2019 3:05 PM, Tetsuo Handa wrote:
>> On 2019/03/28 6:43, Kees Cook wrote:
>>>>> I don't see problems for an exclusive LSM user (AA, SELinux, Smack)
>>>>> also initializing TOMOYO, though. It should be a no-op. Is there some
>>>>> situation where this is not true?
>>>> There should be no problem except some TOMOYO messages are printed.
>>> Okay, so I should send my latest version of the patch to James? Or do
>>> you explicitly want TOMOYO removed from all the CONFIG_LSM default
>>> lines except when selected by CONFIG_DEFAULT_SECURITY_TOMOYO? (I worry
>>> the latter will lead to less testing of the stacking.)
>>>
>> My approach is "opt-in" while your approach is "opt-out". And the problem
>> here is that people might fail to change CONFIG_LSM from the default value
>> to what they need. (And Jakub did not change CONFIG_LSM to reflect
>> CONFIG_DEFAULT_SECURITY_APPARMOR from the old config.) Thus, I suggest
>> "opt-in" approach; which includes up to only one legacy major LSM and allows
>> people to change the default value to include multiple legacy major LSMs.
>>
>> You can propose your latest version. If SELinux/Smack/AppArmor people
>> prefer "opt-out" approach, I'm fine with "opt-out" approach.
> 
> In the long haul we want people to use CONFIG_LSM to set their
> list of modules. Providing a backward compatible CONFIG_DEFAULT_SECURITY_BLAH
> makes some sense, but it's important that we encourage a mindset change.
> Maybe with CONFIG_DEFAULT_SECURITY_LIST with a a full list, which uses the
> value from CONFIG_LSM, and make it the default?
> 

Hi,

I'm still confused.  Does this mindset change include removing support of
SECURITY_DAC?  If so, where was this discussed and decided?
And if so (again), that feels like enforcing some kind of policy in the kernel.

thanks.
-- 
~Randy
