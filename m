Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F628CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C320873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nqiSdt4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbfJ1MaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:30:20 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36896 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbfJ1MaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:30:20 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id A4F612E1328;
        Mon, 28 Oct 2019 15:30:17 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 6Fu8u0MPPn-UH9iLsVu;
        Mon, 28 Oct 2019 15:30:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572265817; bh=h4R7gAYWe/scn/f66qDu9D79C/IxSZiGreX4NgDSdgk=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=nqiSdt4EXnFjo9X4lzlGT5Ez1HeA0PiIV3pBxrbCvN/jjwYNR520wr2vn/rKhu8nz
         s4dpAPFVeqXT2mqO+0jJ4UrLM/+fvTrtgk+CDZ5BMOTL/Wa2nLrGeAR611xoYNu8yo
         FVHYoecTjoqRY6AFehPhNIwCY09QDgA7p7bgMCYY=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id TX5UGfeJdg-UHW0FLCs;
        Mon, 28 Oct 2019 15:30:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] pipe: wakeup writer only if pipe buffer is at least half
 empty
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <157219118016.7078.16223055699799396042.stgit@buzz>
 <CAHk-=wjoTncMYdQFmY4yspKOUsDSNn1dHp1FWvJ0eRO94ZM3dQ@mail.gmail.com>
 <5b970999-c714-6bfb-0b02-ed206bafced4@yandex-team.ru>
 <CAHk-=wjtLz=S00b0T+_Zrx0bfQ1QDLpWAq7eo=w0FPi5N_UqOA@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4bffd184-ff9e-7b9b-0322-e6359e3db71c@yandex-team.ru>
Date:   Mon, 28 Oct 2019 15:30:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjtLz=S00b0T+_Zrx0bfQ1QDLpWAq7eo=w0FPi5N_UqOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2019 15.22, Linus Torvalds wrote:
> On Mon, Oct 28, 2019 at 10:09 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>>
>> Ok. This breakage scenario is doubtful but such weird software really might exist.
>>
>> What about making this thing tunable via fcntl like size of pipe buffer?
> 
> Let's see if we can do it without a tunable and maybe nobody notices?
> 
> But I'd like you to do it on top of David's pipe patches, so that we
> don't have unnecessary churn and conflicts next merge window in this
> area. Ok?
> 

Sure. This change is trivial in comparison to his patchset.
