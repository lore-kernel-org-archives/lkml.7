Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1432C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EF521872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfDEMqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:46:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfDEMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:46:23 -0400
Received: from [192.168.178.52] ([109.104.35.214]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6sSV-1gqm1E1a63-018NHQ; Fri, 05 Apr 2019 14:46:11 +0200
Subject: Re: [PATCH 3/3] staging: vchiq: make wait events interruptible
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        phil@raspberrypi.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190405113423.14495-1-nsaenzjulienne@suse.de>
 <20190405113423.14495-4-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <10eaf3ec-8932-9e48-3e24-deeb66bf13c8@i2se.com>
Date:   Fri, 5 Apr 2019 14:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405113423.14495-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:eMMTL/QmwWuF80aUU5VcijEXZgSMgJzuJ76xPesMHo9pSY4V5Pn
 Trp1Txz1lGNSCOrKh+q/D9du0RkUKr3O89T6o+LOfyE6thhLuJ/xV/fl7maJxoG4Wy1y6U4
 w9SwIMX+km9CbTPCmTZgWg0Bj54AwCdMhkKJaBSz4bGnFQxqJiSLTxvbIrzvgk+N8vudSEi
 7UCf0ri9Yllok9/JRDrLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V+Jft51AeS8=:A58GiCkNy9frmQxMt/HUaE
 FD5wTe0cb5SU0bwGld2apABsL2iU6NpLjo6zDoufB+AqAju+Sge6l0XoOmjBvXQNsiEp16p8y
 9zq7Ua7p4DCLr82OAxytsfBzH8rw0VmIzpd01MUOBo7kSffQDBAOdHEqPUGqiYQI2YH/7Wj7z
 FeIDoxwZtHakfmpm4fMXuLtcsI72gXn8gmU3iJix5ksQk/2BTNEAZZrNxuQT/+7lRfexCoi/c
 oc9OLANUbabC9Twi3L/zARsgl60vvdWsWoEnzgGEgDQHmpUkmbhu7yq7ZGy/HDa9UlPF9csi5
 7vRXLWndwyAuareuYQX3wrYScbykS9m+EXN+4vJS3xZzjpPAX44qxX579f06sDywJK+HTe7lM
 5a3qGOrG6wUWygdhvNLet6ClQa4R6grBFrblxKwVjoz/ZSm5lyxDvBKthokuuoOHpe1kdZVf4
 j30FH6XdBBbjKiauAt+Z84i0dLivCUHs7ftiihynMqQiFkuVc8f37tyng8y8d2nCMwvpi79Yu
 dn377wI2PFtdOfsKS26O8GgNO7V5PR++dY5YpKk2V040WkksdNFZSeJCGl7yVMe/lkPeN8oEA
 ClxHgwYPCFl0J5SN82HYxEymidEn8ipaKah8ejb8gnxh7sI/Id8asXpnyBccj8M/To/Tw6p+b
 SbnQIZW68VcOueJRbck/FktpR72U5iWnW3NgxAkGfr/SsB6ZyXn32JGbr7LmRqHfRNkhMUwq4
 2LJZvidzCY4f+R/AxwAZlWMjVeEEHzhma8eBFA+Lso0y5xW5DA2MmknJn3U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.04.19 um 13:34 schrieb Nicolas Saenz Julienne:
> The killable version of wait_event() is meant to be used on situations
> where it's not meant to fail at all costs, but still have the convenience
> of being able to kill it if really necessary. For instance it's used
> while waiting on an page write on some file systems.
>
> Wait events in VCHIQ don't fit this criteria, as it's mainly used as an
> interface to V4L2 and ALSA devices.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Shouldn't this have a Fixes tag?
