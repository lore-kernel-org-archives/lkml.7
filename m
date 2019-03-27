Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C367C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3274D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fj2q6R2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfC0XWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:22:22 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:46816
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfC0XWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553728941; bh=N1Y/xduTzQ6OCXrnnL0IaMKjTfMgIdc3bfsoLE+5rlg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fj2q6R2kHAt0j1d8EWDP9nKXw2cakpe+P6FdQcBU+DYmb4miOiT5loYR0Ny4SB1KESJrm92mDuS21RN3p0n0PmWc95fB4bLVugaOtanxuL72qTrKAfwG1wszyd94p50f1XN25Ydixiy2duoOivV6PsWNed9V5Q/YmnIRU9uT91vLp993bwSf6nUsEcq1w1AnqYU0qZk+gOJvft7MXoTUGshMQgVKnJLILCAsnV8e4cB8/QWd+WHv8T2GMUs3d8np2VOSMjGEDZlKFGzRFTal0Dno5NbGc0fmK8oqI6I7V1bw+Xu/E7riq2TgxOohZNTm/1S4cts9nMjeLeKr+1J5Mw==
X-YMail-OSG: sSnwK4MVM1n_3LlM8eBw_W0JdHYIHM8dc8OWjwNKcf9EvIMDwsP3cv74VH3ol4B
 mI9LvJe7jm27oyFQoEu9EIurbPw3b3IgNHzD915x4AsTw.VTb5zpFCWaZnPYMomGFV0a99rx84Nt
 AtVozKluqfmw6wIXb7C7MERsvveF_XAjW7AUYSzl7sa6bnX515PnIVFIw9V2sfQKzSy73MgPjHpX
 WHvmP2AgUBXpRgJfBtT1zy0VBlCIHWWiZ_yTU09j34gHi50U2JKKs0ygcQoOdA8SzsexxZqgVcSw
 .4l.2XbKV6_xejPvQ0xIOXvoi0Lx_0HFjDFkCS.onV.qlK5T39VyV.9K_tae4K3NCI0VJ47iud0_
 GJ8VkaaQJdVC0uXvt2x8B0PerB9FSG0V8X91A3MEZJxOxF2Ctf7og_IF6v6p_MNnOTTQAwr5puSz
 8fBAB2orY23hwwbPQyI8ATNMnsQaJAkPEX.OzfD7P3N.HSgIPYctoURCUWEM.DEag3ORrpWgQZm5
 3.wpRRap1l24gG5nYat1lJvUtBYRWY437kWmig7RsozKmaBt6nH8PPvUGUtoF1SYNHJEJMVbCaqR
 ME2u.QgeXzbUdjpGFgofjmN372k8a0TZtNqeF4zI89X4DhqmucNQG7OOBXVoO34NyN5tLUVeHlNu
 7YhBKZ6TM7RDj.__MaNZEMRslDdTD0g68GWOL8YJTt_riOczpbbjB4TXexVUXEtjwQDjkdGLgtjp
 viNoA1xz8jNKY0meoAmY2dhZZn3jVxw1jc71xrjz_iyE2ag5QuMizXqBrbjbsbHuwnEHaoHICyUN
 WZpbKRje0E_jIYSfNk5AnfRtn_Z7oVgyHRWHgUIAKH6FoSe4VIN4T7NB_LQCtzcDbgZOYgwSaloJ
 g451y016Y5pQKSpc7axo0Xff1e4HgNPLgSAdqs84VVBNmjm4NkI82LXlg2SPvmKPtrafXbSJkfrL
 BXWMBpBkaORzX.ypXyZ0SKscsAdFGxqx.gThYWwtT5t7FPpLknyU4nMzx3bS2Vzj_20a5ZfZkqY5
 DyK6_vlUQRontjc5UpJmJzYwhfYQBmlPOpfGmysPKGhSrpSUlUX3VVUsdplXcTP7X9MFebnMwn3L
 NB6cZfsX0Xdo6tg35z3r13ql4Da6tCEUUZlO7s1d_73sb7P0xIXx4tlq6VCifKd8W
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 27 Mar 2019 23:22:21 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c47a114b913bbcdfe59eab58e290194c;
          Wed, 27 Mar 2019 23:22:16 +0000 (UTC)
Subject: Re: Linux 5.1-rc2
To:     Randy Dunlap <rdunlap@infradead.org>,
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
 <366dcec3-1599-9e56-4660-44791e1c7a45@infradead.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3bca3aa4-ee37-cd1d-448a-c2e8c4aee81a@schaufler-ca.com>
Date:   Wed, 27 Mar 2019 16:22:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <366dcec3-1599-9e56-4660-44791e1c7a45@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2019 3:55 PM, Randy Dunlap wrote:
> On 3/27/19 3:23 PM, Casey Schaufler wrote:
>> On 3/27/2019 3:05 PM, Tetsuo Handa wrote:
>>> On 2019/03/28 6:43, Kees Cook wrote:
>>>>>> I don't see problems for an exclusive LSM user (AA, SELinux, Smack)
>>>>>> also initializing TOMOYO, though. It should be a no-op. Is there some
>>>>>> situation where this is not true?
>>>>> There should be no problem except some TOMOYO messages are printed.
>>>> Okay, so I should send my latest version of the patch to James? Or do
>>>> you explicitly want TOMOYO removed from all the CONFIG_LSM default
>>>> lines except when selected by CONFIG_DEFAULT_SECURITY_TOMOYO? (I worry
>>>> the latter will lead to less testing of the stacking.)
>>>>
>>> My approach is "opt-in" while your approach is "opt-out". And the problem
>>> here is that people might fail to change CONFIG_LSM from the default value
>>> to what they need. (And Jakub did not change CONFIG_LSM to reflect
>>> CONFIG_DEFAULT_SECURITY_APPARMOR from the old config.) Thus, I suggest
>>> "opt-in" approach; which includes up to only one legacy major LSM and allows
>>> people to change the default value to include multiple legacy major LSMs.
>>>
>>> You can propose your latest version. If SELinux/Smack/AppArmor people
>>> prefer "opt-out" approach, I'm fine with "opt-out" approach.
>> In the long haul we want people to use CONFIG_LSM to set their
>> list of modules. Providing a backward compatible CONFIG_DEFAULT_SECURITY_BLAH
>> makes some sense, but it's important that we encourage a mindset change.
>> Maybe with CONFIG_DEFAULT_SECURITY_LIST with a a full list, which uses the
>> value from CONFIG_LSM, and make it the default?
>>
> Hi,
>
> I'm still confused.  Does this mindset change include removing support of
> SECURITY_DAC?

No.

>    If so, where was this discussed and decided?

linux-security-module@vger.kernel.org on threads related to security
module stacking. It's easy to get the same result with a CONFIG_LSM
that includes none of the SELinux, Smack, TOMOYO or AppArmor.

> And if so (again), that feels like enforcing some kind of policy in the kernel.

Again, not so. It's a change from "The not-more-the One Major Module" to
"Whatever set of policies works for you". The NULL set is completely
supported. The current flap is that it's more difficult to express doing
things the old way. Kees and Tetsuo are hashing out how best to support
old .confg files in support of automated tools.


> thanks.
