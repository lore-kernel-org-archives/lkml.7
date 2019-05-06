Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51AB205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEFSMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:12:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfEFSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:12:45 -0400
Received: from [192.168.1.166] ([37.4.249.123]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHFwM-1hS3hN2Tz6-00DJIf; Mon, 06 May 2019 20:12:29 +0200
Subject: Re: [PATCH v2 0/3] staging: vchiq: use interruptible waits
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.org, dan.carpenter@oracle.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
References: <20190506144030.29056-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <b2679404-ba00-d18e-fe15-44c6e280dc11@i2se.com>
Date:   Mon, 6 May 2019 20:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506144030.29056-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:OO0YujQIAL03yiODcrGeZwSAoqP+QyZGcS3Rb/0D4viZDd3HuAr
 A0n/6hygucW8vIYS2sdJnsPBdTgKZVIeJrBLQfCJXdQU82yox2zXEi82Aeh1xK73P87Lwkf
 fdt1AfVEuBdqTkkgEITpoL3bFeRm3MvFQBya5po2xJvt4rt2lLSzf0NQlXFpi32U8ln6dhY
 NDXoAES+YgvwLNCrGIXTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3UH7jCBTWv8=:f5pksuQByHCya4v0SpsqPd
 rvQGgK/Xf2fZ9FYd+D6KuDn3qJN+Zbt9Tw+SFtQBpaq6cFtjdcKxJXw9Fy5JuQlVgwtBCX31b
 z0Z0Hl0XTK6phUUZkj7VGHQdgtexXFW8TPIHyFr7rIgwjxMPKJ+LxKO27AYkkUtd/vCF9U+lr
 xCigT9DIOy9Mwe8xe7yhDu/bnEn4MO4TwIrG4iU9woBrZgZV9vL/xKNwgTLi74duS9Q16ew5X
 VoAUCtjyPTO3kdUWffGc/512KXhfUkZwHCzzfWPyZ5LOnAee/MxoExhsgUppX/iB6n7Vd3roy
 Dvu3n0HeGlFQlFPj3AoduvgguL/J9ONCEIbVTRHdRbZ+CXcjHducbyhmgH5qyQOAgtGOXTadg
 rBOdc610VxGRLPEDH1kMYiJR3par4JD8+78izqlvoNEY75HoppdHzZeY2j8SZfGc/HJaSgbLi
 3Kas8kPfJgRZBLDDw4+C0QFEIz9qYjqSaTGS64OHFZMxonrm2hixuuXkn6pcNRzm/vkaBkEMQ
 YZ1til0P90w1e9vmGgK51WXz6YsEUZRdHWFnqkWQF9lT33dqWgu8/zuLjV4CHuLQ73+5mCdz9
 eVsae038tLQ+5C8LzogmOk/I6yTvlwHG36GhYxl7pkJgo2mtZW7qugKnhPpQ688Oz1niaOd6V
 TRl7aEpOA56HSzu+8FKf4FH++RBHLUE7dT2yQo47X5PU6S6BuDiLDvVeYoKDa6f1Rv792Ws3q
 crWF3LZmzEg8pNdmeg6mBWvOFSW1uX/f4LpOGp7o5LudukrpVUORNlxnGeA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 06.05.19 um 16:40 schrieb Nicolas Saenz Julienne:
> Hi,
> ...
>
> Regards,
> Nicolas
>
> [1] https://github.com/raspberrypi/linux/issues/2881
> [2] https://archlinuxarm.org/forum/viewtopic.php?f=65&t=13485
> [3] https://lists.fedoraproject.org/archives/list/arm@lists.fedoraproject.org/message/GBXGJ7DOV5CQQXFPOZCXTRD6W4BEPT4Q/
>
> --
>
> Changes since v1:
>   - Proplery format revert commits
>   - Add code comment to remind of this issue
>   - Add Fixes tags
>
> Nicolas Saenz Julienne (3):
>   staging: vchiq_2835_arm: revert "quit using custom
>     down_interruptible()"
>   staging: vchiq: revert "switch to wait_for_completion_killable"
>   staging: vchiq: make wait events interruptible
>
>  .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +-
>  .../interface/vchiq_arm/vchiq_arm.c           | 21 +++++++------
>  .../interface/vchiq_arm/vchiq_core.c          | 31 ++++++++++++-------
>  .../interface/vchiq_arm/vchiq_util.c          |  6 ++--
>  4 files changed, 35 insertions(+), 25 deletions(-)
>
against which tree should this series apply?

Since the merge window opened the current staging-linus wont be
available soon.

Stefan

