Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9A3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7406B21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfDEMkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:40:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:40:44 -0400
Received: from [192.168.178.52] ([109.104.35.214]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmDVA-1gUYvt0tiS-00iE1Y; Fri, 05 Apr 2019 14:40:29 +0200
Subject: Re: [PATCH 0/3] staging: vchiq: use interruptible waits
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devel@driverdev.osuosl.org, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190405113423.14495-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <762bb0f7-b9d1-3182-524b-6cdec87a08f8@i2se.com>
Date:   Fri, 5 Apr 2019 14:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405113423.14495-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:RdtEvFc7EkU7YQ3dNqn30EBEdudnvSeJtPEHl2WabGFyztuR3s4
 hfziD52+m8tHSvtDbIQDasoabtUvCHDjDYLM5AcvfOJei8dJgxyUiWkl61549+86vsJ9qDo
 MVoIt5bSi+ckisWRFYRftiAzNS5VUYGQXa25qmMwtJRyPCDmg5UfTeGyXSmN+a8UXeUaI3i
 bZHwXZOMX02X/GpUJ85fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSmI1rQL72w=:hxRB/+0eC4zl748Oqn9Amb
 izXRoauAF2uvraExf26nJRUQjlP0mL26fKYcX4WFsBo3WUbTCNvPS4OPHPT050h9VbTofnAej
 BbatbcC2MkAQuqEZ/U3mw2redsJgR71iPSyg2x0QA1PhxnTZnBPvGBa0nH7cmpCw5SVxEvYm0
 ftcla20zbZbrYRmY3CdszoaQtE2IEHX6vynX2RqUxrujss9jcm/yk9Vk8sQ+EJbOqVfkcvR0e
 pq/N5GuW66k/7L7uX1iavCJAIAp8wVQ6nfMfHjRa0FyMo9DHEUQkC6UJIuhmvPKnB5quTujuX
 FtUsNIXxqtmPSIKUos2dzoGS2m9BybJJutUdhXmp7ESrJJIJk0P+aqJ51xO2nzDx5hZBub+GL
 HMrwU4zVovwm6fjTY9dd+iMgV8DCFhjZtX+hNuHdbBtxioW2vWKWImU2nayUPmLvaOoghJT/+
 l/CPZe7Us5Dx4GuC9sXt983Iz2+cJRjmBl70Xpn18+1zS8drA+AOTIgiQk8bvsjshMGh6PvXa
 lZonbl4HlsoqZpHTC3uccMmsSqUe5AD89sInTV7vY1ps8UU3dPiYT0uOFAaL88FbPr7PZm3Hs
 O0Z+/eBjOp5bB2Bdxi7JBlhye2VgWIbPU2VBlqzdxM8FCANMu2W+c3rfLurZXF4/xcOX8aeQ0
 /wcoKqyj2RN9TLWAj3GVJJDS3dQMy3HNaE0qc7kEdaxtGhFeqR+XvVmxyzW9CTEUWAKxDI5J+
 Ke8BlIdaISihMdlPCqYYWuY7Qo+l3dsl+taNw1rWuzi/XuggQIUU2k+C5CE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 05.04.19 um 13:34 schrieb Nicolas Saenz Julienne:
> Hi,
> this series tries to address an issue that came up in Raspbian's kernel
> tree [1]. After pulling from upstream some changes that moved wait calls
> from a custom implementation to the more standard killable family some
> users complained that all the VCHIQ threads showed up in D state (which
> is the expected behaviour).

this issue has already been noticed in mainline distributions [1],[2].

> The custom implementation we deleted tried to mimic the killable family
> of functions, yet accepted more signals than the later.  SIGKILL |
> SIGINT | SIGQUIT | SIGTRAP | SIGSTOP | SIGCONT for the custom
> implementation as opposed to plain old SIGKILL.
>
> Raspbian maintainers decided roll back some of those changes and leave
> the wait functions as interruptible. Hence creating some divergence
> between both trees.
>
> One could argue that not liking having the threads stuck in D state is
> not really a software issue. It's more a cosmetic thing that can scare
> people when they look at "uptime". On the other hand, if we are ever to
> unstage this driver, we'd really need a proper justification for using
> the killable family of functions. Which I think it's not really clear at
> the moment.

I like to see this decision as a short comment in the code to prevent
other for doing this mistake again.

Thanks

Stefan

>
> As Raspbian's kernel has been working for a while with interruptible
> waits I propose we follow through. If needed we can always go back to
> killable. But at least we'll have a proper understanding on the actual
> needs. In the end the driver is in staging, and the potential for errors
> small.
>
> Regards,
> Nicolas
>
> [1] https://github.com/raspberrypi/linux/issues/2881
>
[1] - https://archlinuxarm.org/forum/viewtopic.php?f=65&t=13485

[2] -
https://lists.fedoraproject.org/archives/list/arm@lists.fedoraproject.org/message/GBXGJ7DOV5CQQXFPOZCXTRD6W4BEPT4Q/

