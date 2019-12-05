Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01543C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FFC2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="lgf9fTIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfLEJSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:18:14 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:35691 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfLEJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:18:14 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 27B372305C;
        Thu,  5 Dec 2019 10:18:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575537492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/Tl9y0vlxprYCBrvMb1aya8Frr3Lyxlo7NlxWTMqUU=;
        b=lgf9fTIKUVaOWWjXw/69XcooxlrBdTSukoRwUQcp1g0v/iSfnIdYWw+ete1aMsIxdMWXZO
        +36NxPACCHWHppH36Gg7oSGBQRvd7i3DE5L8XyacL/MHGEw5nVY8Nf1FE6RED7DZzTdSmC
        OMxzTgAFh2qQ1Csg8+1STlDZxi+7KTk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 10:18:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: fsl_sai: add IRQF_SHARED
In-Reply-To: <CAEnQRZCnQAUVowOJw5aPe9rYWU5DKR4bFbmQLYV2BzYqOhRJmQ@mail.gmail.com>
References: <20191128223802.18228-1-michael@walle.cc>
 <CAEnQRZCnQAUVowOJw5aPe9rYWU5DKR4bFbmQLYV2BzYqOhRJmQ@mail.gmail.com>
Message-ID: <a5accae02f840f7e25099c2ccd7b02ff@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 27B372305C
X-Spamd-Result: default: False [1.40 / 15.00];
         TO_DN_SOME(0.00)[];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         NEURAL_HAM(-0.00)[-0.696];
         FREEMAIL_CC(0.00)[alsa-project.org,lists.ozlabs.org,vger.kernel.org,kernel.org,gmail.com,perex.cz,suse.com];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am 2019-12-05 09:43, schrieb Daniel Baluta:
> On Fri, Nov 29, 2019 at 12:40 AM Michael Walle <michael@walle.cc> 
> wrote:
>> 
>> The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
>> IRQF_SHARED to be able to use these SAIs simultaneously.
> 
> Hi Michael,
> 
> Thanks for the patch. We have a similar change inside our internal tree
> (it is on my long TODO list to upstream :D).
> 
> We add the shared flag conditionally on a dts property.
> 
> Do you think it is a good idea to always add shared flag? I'm thinking
> on SAI IP integrations where the interrupt is edge triggered.

Mhh, I don't really get the point to make the flag conditionally. If
there is only one user, the flag won't hurt, correct?

If there are two users, we need the flag anyway.

> AFAIK edge triggered interrupts do not get along very well
> with sharing an interrupt line.

So in that case you shouldn't use shared edge triggered interrupts in 
the
SoC in the first place, I guess.

-michael
