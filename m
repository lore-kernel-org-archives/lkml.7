Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB1C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82621849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563406291;
	bh=8VpnxGStLf8E5O7z0t32FrG8nOd4aZ30LIjDn4eMqCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmLt4qjdNXIjB1otaiqB6foCvQ1k3qh5GW12/eY9e0q9hhwmJFoOhms+si4ce9oxx
	 fbmotP1Hou4szggQThw4TvE4U84JHOFy45DLut6WI1hHGPmZSjNmQz3JmAXdY0bveO
	 P0phcU4joF4KW2QFeFuZQit/8RBVfY2u96M55/cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfGQXba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfGQXba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:31:30 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BDD520651;
        Wed, 17 Jul 2019 23:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563406289;
        bh=8VpnxGStLf8E5O7z0t32FrG8nOd4aZ30LIjDn4eMqCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r01M60NWkw8fznxWilOLF4w8ZPxjnmrEfdkmqVj156+7ZWyrosI1IL6TPX/oCKQZ0
         oy2vQ7UQ+90CCBMdvSV5CvM4EKIrVwIiwguYjO6FIMdZq8K8qsX9UP61ie+IkbFJaf
         sQuEEWFunKmVil4IsA35Gc+sw/p4vx8VcMsBvm78=
Date:   Wed, 17 Jul 2019 19:31:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v4 2/6] ASoC: sgtl5000: Improve VAG power and mute control
Message-ID: <20190717233128.GB3079@sasha-vm>
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com>
 <20190717163014.429-3-oleksandr.suvorov@toradex.com>
 <CAOMZO5AgCqH+8W36vh4n3tCFvqUE=H+4Zp0jG1NQi5UFOsSSAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOMZO5AgCqH+8W36vh4n3tCFvqUE=H+4Zp0jG1NQi5UFOsSSAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 01:48:43PM -0300, Fabio Estevam wrote:
>On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
><oleksandr.suvorov@toradex.com> wrote:
>>
>> Change VAG power on/off control according to the following algorithm:
>> - turn VAG power ON on the 1st incoming event.
>> - keep it ON if there is any active VAG consumer (ADC/DAC/HP/Line-In).
>> - turn VAG power OFF when there is the latest consumer's pre-down event
>>   come.
>> - always delay after VAG power OFF to avoid pop.
>> - delay after VAG power ON if the initiative consumer is Line-In, this
>>   prevents pop during line-in muxing.
>>
>> Also, according to the data sheet [1], to avoid any pops/clicks,
>> the outputs should be muted during input/output
>> routing changes.
>>
>> [1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf
>>
>> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Fixes: 9b34e6cc3bc2 ("ASoC: Add Freescale SGTL5000 codec support")
>
>Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
>By the way, I prefer the description you put in the cover letter as it
>explicitly talks about a bug being fixed.

Yes. This patch describes itself as an improvement rather than a fix.

You need to add an explicit stable tag, rather than just cc us.
Something like:

	Cc: stable@kernel.org

--
Thanks,
Sasha
