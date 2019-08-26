Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE01C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC1A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfHZRSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:18:47 -0400
Received: from rankki.sonarnerd.net ([194.142.149.154]:28812 "EHLO
        mail.sonarnerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfHZRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:18:47 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 13:18:46 EDT
Received: from [IPv6:fc00::2] (porkkala.uworld [IPv6:fc00::2])
        by mail.sonarnerd.net (Postfix) with ESMTP id D10372310EC;
        Mon, 26 Aug 2019 20:10:33 +0300 (EEST)
Subject: Re: [PATCH] ALSA: usb-audio: Add Hiby R3 to quirks for native DSD
 support
To:     ilya.pshonkin@netforce.ua
Cc:     Sudokamikaze <sudokamikaze@protonmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
From:   Jussi Laako <jussi@sonarnerd.net>
Message-ID: <021132df-8deb-b9f0-2d9e-e934f92c6c7a@sonarnerd.net>
Date:   Mon, 26 Aug 2019 20:10:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* ESS Sabre based USB DACs */
> +	case USB_ID(0xc502, 0x0051): /* Hiby R3 */
> +		if (fp->altsetting == 4)
> +			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
> +		break;

Do you know who's vendor id is this? ESS Sabre is a DAC chip with I2S 
input, I'm not aware of any product from ESS under Sabre brand that 
would include USB interface. (?) So likely the USB interface is sourced 
from somewhere else...

It is good to check with "lsusb -vvv" if the device flags DSD altsetting 
as raw. Then you know it'll work with the auto-detection code and 
doesn't break so easily if firmware update changes altsettings (not 
uncommon to happen).


	- Jussi

