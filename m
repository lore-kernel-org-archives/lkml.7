Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037DDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E53206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWKId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:08:33 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39035 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfLWKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:08:33 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ijKdZ-0007QU-7o; Mon, 23 Dec 2019 11:08:29 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ijKdY-00049x-De; Mon, 23 Dec 2019 11:08:28 +0100
Date:   Mon, 23 Dec 2019 11:08:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] leds: trigger: implement a tty trigger
Message-ID: <20191223100828.bqtda4zilc74fqfk@pengutronix.de>
References: <20191219093947.15502-1-u.kleine-koenig@pengutronix.de>
 <20191219093947.15502-4-u.kleine-koenig@pengutronix.de>
 <20191221184047.GC32732@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191221184047.GC32732@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

On Sat, Dec 21, 2019 at 07:40:47PM +0100, Pavel Machek wrote:
> > +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> > @@ -0,0 +1,6 @@
> > +What:		/sys/class/leds/<led>/dev
> > +Date:		Dec 2019
> > +KernelVersion:	5.6
> > +Contact:	linux-leds@vger.kernel.org
> > +Description:
> > +		Specifies $major:$minor of the triggering tty
> 
> Ok, sounds reasonable.
> 
> > +static ssize_t dev_store(struct device *dev,
> > +			 struct device_attribute *attr, const char *buf,
> > +			 size_t size)
> > +{
> > +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> > +	struct tty_struct *tty;
> > +	unsigned major, minor;
> > +	int ret;
> > +
> > +	if (size == 0 || (size == 1 && buf[0] == '\n')) {
> > +		tty = NULL;
> > +	} else {
> > +		ret = sscanf(buf, "%u:%u", &major, &minor);
> > +		if (ret < 2)
> > +			return -EINVAL;
> 
> If user writes 1:2:badparsingofdata into the file, it will pass, right?

Yes, and it will have the same effect as writing 1:2. I wonder if this
is bad.

> > +		tty = tty_kopen_shared(MKDEV(major, minor));
> > +		if (IS_ERR(tty))
> > +			return PTR_ERR(tty);
> > +	}
> 
> Do you need to do some kind of tty_kclose()? What happens if the
> device disappears, for example because the USB modem is unplugged?

Only tty_kref_put is needed to close.

> > +static void ledtrig_tty_work(struct work_struct *work)
> > +{
> > +	struct ledtrig_tty_data *trigger_data =
> > +		container_of(work, struct ledtrig_tty_data, dwork.work);
> > +	struct serial_icounter_struct icount;
> > +	int ret;
> > +
> > +	if (!trigger_data->tty) {
> > +		led_set_brightness(trigger_data->led_cdev, LED_OFF);
> > +		return;
> > +	}
> > +
> > +	ret = tty_get_icount(trigger_data->tty, &icount);
> > +	if (ret)
> > +		return;
> > +
> > +	if (icount.rx != trigger_data->rx ||
> > +	    icount.tx != trigger_data->tx) {
> > +		unsigned long delay_on = 100, delay_off = 100;
> > +
> > +		led_blink_set_oneshot(trigger_data->led_cdev,
> > +				      &delay_on, &delay_off, 0);
> > +
> > +		trigger_data->rx = icount.rx;
> > +		trigger_data->tx = icount.tx;
> > +	}
> 
> Since you are polling this, anyway, can you just manipulate brightness
> directly instead of using _oneshot()? _oneshot() will likely invoke
> another set of workqueues.

I copied that from the netdev trigger. I failed to find a suitable
helper function, did I miss that or does it need creating?
 
> LED triggers were meant to operate directly from the events, not based
> on statistics like this.

Ditto; just copied from the netdev trigger. I tried to find a suitable
place to add a trigger in the core, but this is hard without having to
modify all drivers; additionally this is in thier hot path. So I
considered using statistics a good idea. Greg also liked it and someone
before us for the network trigger, too ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
