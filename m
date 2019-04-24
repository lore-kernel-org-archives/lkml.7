Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EA1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6FF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbfDXSus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:50:48 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36647 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDXSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:50:46 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 70EC63C00D1;
        Wed, 24 Apr 2019 20:50:42 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v_zvJA-lUgeK; Wed, 24 Apr 2019 20:50:35 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A23BD3C0034;
        Wed, 24 Apr 2019 20:50:35 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 20:50:35 +0200
Date:   Wed, 24 Apr 2019 20:50:32 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Christian Gromm <christian.gromm@microchip.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        <driverdev-devel@linuxdriverproject.org>,
        <linux-kernel@vger.kernel.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 16/28] staging: most: sound: call snd_card_new with
 struct device
Message-ID: <20190424185032.GA9019@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180609182902.A31D621C28@pdx-korg-gitolite-1.ci.codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, 08 May 2018 02:46:44 -0700, Christian Gromm wrote:
>     This patch is needed as function snd_card_new needs a valid
>     parent device. Passing a NULL pointer leads to kernel Ooops.
>     
>     Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
> ---
>  drivers/staging/most/core.h        | 1 +
>  drivers/staging/most/sound/sound.c | 2 +-
>  drivers/staging/most/usb/usb.c     | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/most/core.h b/drivers/staging/most/core.h
> index 7a3c70bead19..64cc02f161e7 100644
> --- a/drivers/staging/most/core.h
> +++ b/drivers/staging/most/core.h
> @@ -230,6 +230,7 @@ struct mbo {
>   */
>  struct most_interface {
>  	struct device dev;
> +	struct device *driver_dev;
>  	struct module *mod;
>  	enum most_interface_type interface;
>  	const char *description;
> diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
> index 18f722410a63..04c18323c2ea 100644
> --- a/drivers/staging/most/sound/sound.c
> +++ b/drivers/staging/most/sound/sound.c
> @@ -590,7 +590,7 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = snd_card_new(NULL, -1, card_name, THIS_MODULE,
> +	ret = snd_card_new(&iface->dev, -1, card_name, THIS_MODULE,
>  			   sizeof(*channel), &card);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/staging/most/usb/usb.c b/drivers/staging/most/usb/usb.c
> index 5ed1dccc0839..f18726049528 100644
> --- a/drivers/staging/most/usb/usb.c
> +++ b/drivers/staging/most/usb/usb.c
> @@ -1043,6 +1043,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
>  	mdev->link_stat_timer.expires = jiffies + (2 * HZ);
>  
>  	mdev->iface.mod = hdm_usb_fops.owner;
> +	mdev->iface.driver_dev = &interface->dev;
>  	mdev->iface.interface = ITYPE_USB;
>  	mdev->iface.configure = hdm_configure_channel;
>  	mdev->iface.request_netinfo = hdm_request_netinfo;

Just for your information, when mapping commits from vanilla to those
from https://github.com/microchip-ais/linux/commits/mld-1.8.0, we've
stumbled upon some subtle but striking difference between mld-1.8.0
commit [0] and v4.18-rc1 commit [1]. The latter looks like an upstreamed
version of the former. However, while commit [0] creates a new 'dev'
member in 'struct most_interface' and uses it consistently, commit [1]
creates 'driver_dev' and uses it intermixed with 'dev'.

Since we don't use aim-sound, we just signal this feedback to you
as FWIW without sending a patch (which we can't test).

[0] https://github.com/microchip-ais/linux/commit/2fef0f89f04703
    ("staging: most: add struct device to most interface")
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69c90cf1b2faf5
    ("staging: most: sound: call snd_card_new with struct device")

-- 
Best regards,
Eugeniu.
