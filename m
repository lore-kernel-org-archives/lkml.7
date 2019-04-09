Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4166120857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzdOPlu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDIFGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:06:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44700 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIFGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:06:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so8950292pfm.11;
        Mon, 08 Apr 2019 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPzuYWAD9n3E7cK9DQsoS+9to3SIkl5lmMig0KfgMSY=;
        b=jzdOPlu/x8auCMomI1PhvJbl6f2twqu5f+3vfkvAV+xE4cSTD4MEdJHxBxcS6yZqq7
         Wi39SerktOeg2gpodvg1AttXtj/Agsk4ZqT+ll/DmXRCFXA3Rjxv4W5JXcJX12w2wN76
         dRlAvbUeYZEdvLSCT/Uss7a0WGfW2BKtrXLgXRvC3oSExXDC5J5XOfEY7Bmkeaqldqo5
         ofQJMLjd1hvJFdB8CUbFyyIJY+r2saK636byggJ7IyW27rDUZrXVU6SyMCAhmEBOTAxA
         KKZ9ZFWfs5Cuc9geuO38yzWGzY7Wi5VVNgI6n1sfPWfNRYKsiEibfk9xWlxOtSOlTpg3
         qikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPzuYWAD9n3E7cK9DQsoS+9to3SIkl5lmMig0KfgMSY=;
        b=XLB0dxROcSnRoYQGx3uK4gSXmI/qWzSPmNitZmDHSnTslBbcw0lxFaxtgV4I31RoBt
         UboBIJjtTq6Ukg8b3vDLjwb/cEXU6y4rgZjOsbAD0uvWGgA1UkIsxRG0C7p0Nlu6Ihza
         JnEquF4qzWT0pd3wU5LUwYfZGoaIorsJP9FMFl06jaz97M6WPHwlRLjc9CHyOMG67Feq
         AjQDGKmQM5mi9D5xg+X97EY9hJ0Mze0wT5UxiizaqhE0XRsJSS+wvYB5KoYvQOf0T/Pw
         ARLO//dFGVzTidtAXrpURF9Sr1S2GVJOrTKEOU76WOM0IBoXFeqTf5r9cnaQAJdOjL0w
         8XIA==
X-Gm-Message-State: APjAAAVTqVJxkRC5VW2gBgbFeQoMzsm47WzT1eTKGq3FB1M9OcSXMvl0
        JAOiWo2s/Qn6TfyH7GW08pc=
X-Google-Smtp-Source: APXvYqxpbmL0psDw+R51UHqyQpUsOO53H3NyesVqG9HDMScxBNzwN2DcZVBVbnl14am4Y2jDppOgXw==
X-Received: by 2002:a65:6212:: with SMTP id d18mr30672141pgv.162.1554786366700;
        Mon, 08 Apr 2019 22:06:06 -0700 (PDT)
Received: from icarus ([2001:268:c1c0:11e:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id j19sm15751431pfr.155.2019.04.08.22.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 22:06:05 -0700 (PDT)
Date:   Tue, 9 Apr 2019 14:07:08 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org,
        david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 02/18] counter: Documentation: Add Generic Counter
 sysfs documentation
Message-ID: <20190409050708.GB2842@icarus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215531.GB27592@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408215531.GB27592@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:55:31PM +0200, Pavel Machek wrote:
> On Tue 2019-04-02 15:30:37, William Breathitt Gray wrote:
> > This patch adds standard documentation for the userspace sysfs
> > attributes of the Generic Counter interface.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
> >  MAINTAINERS                                 |   1 +
> >  2 files changed, 231 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> > new file mode 100644
> > index 000000000000..566bd99fe0a5
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -0,0 +1,230 @@
> > +What:		/sys/bus/counter/devices/counterX/countY/count
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count data of Count Y represented as a string.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/ceiling
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count value ceiling for Count Y. This is the upper limit for the
> > +		respective counter.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/floor
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count value floor for Count Y. This is the lower limit for the
> > +		respective counter.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/count_mode
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Count mode for channel Y. The ceiling and floor values for
> > +		Count Y are used by the count mode where required. The following
> > +		count modes are available:
> > +
> > +		normal:
> > +			Counting is continuous in either direction.
> > +
> > +		range limit:
> > +			An upper or lower limit is set, mimicking limit switches
> > +			in the mechanical counterpart. The upper limit is set to
> > +			the Count Y ceiling value, while the lower limit is set
> > +			to the Count Y floor value. The counter freezes at
> > +			count = ceiling when counting up, and at count = floor
> > +			when counting down. At either of these limits, the
> > +			counting is resumed only when the count direction is
> > +			reversed.
> > +
> > +		non-recycle:
> > +			The counter is disabled whenever a counter overflow or
> > +			underflow takes place. The counter is re-enabled when a
> > +			new count value is loaded to the counter via a preset
> > +			operation or direct write.
> > +
> > +		modulo-n:
> > +			A count value boundary is set between the Count Y floor
> > +			value and the Count Y ceiling value. The counter is
> > +			reset to the Count Y floor value at count = ceiling when
> > +			counting up, while the counter is set to the Count Y
> > +			ceiling value at count = floor when counting down; the
> > +			counter does not freeze at the boundary points, but
> > +			counts continuously throughout.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
> > +What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
> > +What:		/sys/bus/counter/devices/counterX/countY/function_available
> > +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> > +KernelVersion:	5.2
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Discrete set of available values for the respective Count Y
> > +		configuration are listed in this file. Values are delimited by
> > +		newline characters.
> 
> Elsewhere in sysfs we do space-separated:
> 
> pavel@amd:~$ cat /sys/power/state
> freeze mem disk
> 
> And we use [] to mark current selection:
> 
> pavel@amd:~$ cat /sys/class/leds/tpacpi\:\:thinkvantage/trigger
> [none] bluetooth-power rfkill-any rfkill-none kbd-scrolllock
> kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock
> kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock
> kbd-ctrlrlock AC-online BAT0-charging-or-full BAT0-charging BAT0-full
> BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
> phy0radio phy0tpt mmc0 timer heartbeat audio-mute audio-micmute
> rfkill1
> 
> Note this only works if you have less than PAGE_SIZE of entries... and
> will never have more.
> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Marking the current selection with [] or similar does seem useful. But
delimiting by space does seem to cause confusion in cases where the
values also include spaces (e.g. "quadrature x1 a"). I see that in these
cases a "-" is used in place of a space, but that wouldn't work very
well when values can also contain hyphens (e.g. "pulse-direction").

William Breathitt Gray
