Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89E9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B776020652
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLLAgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:36:53 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:52228 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfLLAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:36:53 -0500
X-Greylist: delayed 1324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 19:36:52 EST
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ifC7r-0000O6-5Q; Thu, 12 Dec 2019 00:14:39 +0000
Message-ID: <0e00090ef6fcf310159d6ce23f2c92f511dd01de.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v7 6/9] ALSA: Avoid using timespec for struct
 snd_timer_tread
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 12 Dec 2019 00:14:38 +0000
In-Reply-To: <20191211212025.1981822-7-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
         <20191211212025.1981822-7-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 22:20 +0100, Arnd Bergmann wrote:
[...] 
> +static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
> +				unsigned int cmd, bool compat)
> +{
> +	int __user *p = argp;
> +	int xarg, old_tread;
> +
> +	if (tu->timeri)	/* too late */
> +		return -EBUSY;
> +	if (get_user(xarg, p))
> +		return -EFAULT;
> +
> +	old_tread = tu->tread;
> +
> +	if (!xarg)
> +		tu->tread = TREAD_FORMAT_NONE;
> +	else if (cmd == SNDRV_TIMER_IOCTL_TREAD64 ||
> +		 (IS_ENABLED(CONFIG_64BITS) && !compat))

This needs to check for CONFIG_64BIT not CONFIG_64BITS.

[...]
> @@ -2145,14 +2202,34 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
>  		tu->qused--;
>  		spin_unlock_irq(&tu->qlock);
>  
> -		if (tu->tread) {
> -			if (copy_to_user(buffer, &tu->tqueue[qhead],
> -					 sizeof(struct snd_timer_tread)))
> +		tread = &tu->tqueue[qhead];
> +
> +		switch (tu->tread) {
> +		case TREAD_FORMAT_TIME64:
> +			if (copy_to_user(buffer, tread,
> +					 sizeof(struct snd_timer_tread64)))
>  				err = -EFAULT;
> -		} else {
> +			break;
> +		case TREAD_FORMAT_TIME32:
> +			memset(&tread32, 0, sizeof(tread32));
> +			tread32 = (struct snd_timer_tread32) {
> +				.event = tread->event,
> +				.tstamp_sec = tread->tstamp_sec,
> +				.tstamp_sec = tread->tstamp_nsec,
> +				.val = tread->val,
> +			};
> +
> +			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
> +				err = -EFAULT;
> +			break;
> +		case TREAD_FORMAT_NONE:
>  			if (copy_to_user(buffer, &tu->queue[qhead],
>  					 sizeof(struct snd_timer_read)))
>  				err = -EFAULT;
> +			break;
> +		default:
> +			err = -ENOTSUPP;
[...]

This is not a valid error code for returning to user-space, but this
case should be impossible so I don't think it matters.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

