Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D16C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E4C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iIMtsh8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfHEMCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:02:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:37261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfHEMCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565006506;
        bh=KmcLdHf0XwKTJJgL+H3RVxeu5Ne9CquLQEwQPSvQMcY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iIMtsh8qB2coFc12upwLyWLPCpegsOyMNCIqdt6+P1VldhE9r1JiTpVjQzf0zFdu8
         /U7Gt5LJW4Sxs4vg/VtCFyxSwY1Uqv+QfQfJ7krIYXXTxxXoFVCbohPqgIRJtPYZTt
         RFrgBO4gM7Z83i5D6/9VW75w/UukoKQqZu6iEdPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.80.10.6] ([196.52.84.6]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M6jIK-1iHtle1n8e-00wVpV; Mon, 05
 Aug 2019 14:01:46 +0200
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190805090514.5992-1-hdanton@sina.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <91360b32-f20a-9f2a-838f-bd00e991db40@gmx.com>
Date:   Mon, 5 Aug 2019 12:01:43 +0000
MIME-Version: 1.0
In-Reply-To: <20190805090514.5992-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fwHdWITLjRI+5T9B5auq4PfprFdsXP/AYtLPf0YQchM4VGI0l4N
 1cdcOiAx8gY1azaY6k1Rk9Yh1nIq+LpDAzHIDJzXmPO0XAaoM8pIB1Yet7tSfQLa6h1eg2Y
 9xDOuwrbmAwQR9XZAZ+z1We9AJyR8nKW8q3u3bo8u461sIoGUMyIrtICdRXd1/Qmek4PA3s
 wy/D4t23NlwZ9fLUcEPsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fCNy7Kaw2TU=:TGdcb/4vwRcYIRAUgaiQJ+
 2Ip3rrEOk3dVwx3k7sTysuG8eiidhH5MRSfX97tf7O8CelPpYodeZsrQyTLAsUKkDuQo0+Eh2
 KbfDHEOsks0m/Ba52aqNlXvkggZrUTuY6JRKAMYffFCejJlKRYIejcmmBiHUY+eH2IR2eGAo2
 WG2egJArJd6G+35QclPh9FcRSHMYu/eLIOAiYeOC9NCuYkVpHypd67WKRVJQxDE1oqUSv8LlP
 gjeNalPkwNACua/OR6IfawJ5xBN5CTJAqcoXsfxPd4hrB+77HNnRIh7i+kPZlBNMZuAjQ7P8s
 170MOAblDh9VtD8uID1VgbYkTcw6frkpwATF8X+/Son6ei74L22tgeVRxW9sdN5gjn9wRz5tJ
 8NGnUGq+y603ovHGYnqqwwBzutX+A4s67xmQM3OgtBc4fbiubeX6ABkKfuVWbiaBjsJMrUhBt
 ICvZ5VbdRBpKjWh0pKtt2IKUedNy9apMNWSyr3f2zwGnZqpE25+64WNzdrWk7LKdVN3ry+UJN
 AjYHItEFaZZxzaX45DUilehlESyBtEDaS+W6+qPrbkhFq9Nvx/xp2dDrcOOtj2THnmmP9AYBK
 pyiUVTjFj83CPWF2nyJCJnp8ZkT98qzuddE8QsOiSur9XES3dPlGEdlozsyPind2BAAEtnkQo
 eDlArJKQ6Ppq6E0Bo+hOYgwWU/WTQ/8+YET6BIXSCw7410Wu7+LoxQDvN9Ly21X7WoSGT5R/I
 ZhCRwh3NBMOLaVZKBl3t6RpiRRHIbbFzTAB8Vjf5ToUfFmv5qFr9wKggtytMkJEAaisaswLjo
 FtTSb+DhntTzIEjkTe4R1oodw6aNFVLVDUlBxO27y/c3WHLoBJZ9yontI+/rzNiRyyBaFXAGE
 wFdHvolcSxvEER6sXnnD6IHlpQNw45qPWAuZoXpZDBKjHxopOse1NTR61Fl1kMviqEIAvy4i0
 cL94ueGli4wouXH1BFezu7zPC2/1t8qD8/uWUhdPboLJ0/viYimL1pTBFEdXXhGZZDyWyi8by
 YK6fZMJfc17z8/3faZKnO1c+MsSXuZnkigJN0rkdZSc4Lo5ZN9Fv/6iZzQ8WYtTERj9tXomFC
 G600hDIOQChv9MAf9ORIjc3BxrcMhY/LXSBhR99DqI8vCuDv/d5JH+AXO6MEheVYPXiwOENlq
 0S2jk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 9:05 AM, Hillf Danton wrote:
>
> On Sun, 4 Aug 2019 09:23:17 +0000 "Artem S. Tashkinov" <aros@gmx.com> wr=
ote:
>> Hello,
>>
>> There's this bug which has been bugging many people for many years
>> already and which is reproducible in less than a few minutes under the
>> latest and greatest kernel, 5.2.6. All the kernel parameters are set to
>> defaults.
>
> Thanks for report!
>>
>> Steps to reproduce:
>>
>> 1) Boot with mem=3D4G
>> 2) Disable swap to make everything faster (sudo swapoff -a)
>> 3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
>> 4) Start opening tabs in either of them and watch your free RAM decreas=
e
>
> We saw another corner-case cpu hog report under memory pressure also
> with swap disabled. In that report the xfs filesystem was an factor
> with CONFIG_MEMCG enabled. Anything special, say like
>
>   kernel:watchdog: BUG: soft lockup - CPU#7 stuck for 22s! [leaker1:7193=
]
> or
>   [ 3225.313209] Xorg: page allocation failure: order:4, mode:0x40dc0(GF=
P_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=3D(null),cpuset=3D/,mems_allowed=
=3D0
>
> in your kernel log?

I'm running ext4 only without LVM, encryption or anything like that.
Plain GPT/MBR partitions with plenty of free space and no disk errors.

>>
>> Once you hit a situation when opening a new tab requires more RAM than
>> is currently available, the system will stall hard. You will barely  be
>> able to move the mouse pointer. Your disk LED will be flashing
>> incessantly (I'm not entirely sure why). You will not be able to run ne=
w
>> applications or close currently running ones.
>
> A cpu hog may come on top of memory hog in some scenario.

It might have happened as well - I couldn't know since I wasn't able to
open a terminal. Once the system recovered there was no trace of
anything extraordinary.

>>
>> This little crisis may continue for minutes or even longer. I think
>> that's not how the system should behave in this situation. I believe
>> something must be done about that to avoid this stall.
>
> Yes, Sir.
>>
>> I'm almost sure some sysctl parameters could be changed to avoid this
>> situation but something tells me this could be done for everyone and
>> made default because some non tech-savvy users will just give up on
>> Linux if they ever get in a situation like this and they won't be keen
>> or even be able to Google for solutions.
>
> I am not willing to repeat that it is hard to produce a pill for all
> patients, but the info you post will help solve the crisis sooner.
>
> Hillf
>

In case you have troubles reproducing this bug report I can publish a VM
image - still everything is quite mundane: Fedora 30 + XFCE + web
browser. Nothing else, nothing fancy.

Regards,
Artem
