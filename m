Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F43C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3179A20835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmiZJyl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCCTaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 14:30:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46975 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfCCTaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 14:30:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so3016441qti.13;
        Sun, 03 Mar 2019 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7LwkNeOQccyN4n3K/Df2XoYgzkpFPLKz3Wbx6cPlJ9Y=;
        b=mmiZJyl3IeVS82gVRA6lMZ7GIFtlVyGQSeg68MoSYEr2qn5mCqRMVVWdMKRcKlD1Xf
         5BglZ+8g1ApdN8mau6GRAHeiq2yDwc5/F2/p4rcUJeIOhvRgZ0SBVngt5dN/FjqoQMG2
         jfgpnWspD4XEgjcqXXDMZSIRlBsMFsL/mMzhaxbGjjspoZbYvS0WPubV+z8iXznPnGyY
         YKDCdlofHW+sr74Y48y9Y7DQuamiJSojh7x8ZYAdPFPcaYBCMTzlg4Rz8GoInX+q3DT+
         AUJTmazK5fTYB4gfMnWXMwxZu9yLsSrusYwl4kEk6R4VICcM4UfRIFqoy7i5ic6uuhoh
         OijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7LwkNeOQccyN4n3K/Df2XoYgzkpFPLKz3Wbx6cPlJ9Y=;
        b=LnfiuqUsG12C/8LQKUhDihGEbhJjuky45Av8TZaDVjdPLJ3NexqbEsGFZ6muRwLNjM
         +bJMkUC2494jhxpa7tOWeMh3q5a5kUX4FOX5hFyLcZOaeg6+ruXVo/Cm7hxxUL2Dzgl5
         eVNu2zqH9VgLK3m2Bc7NRx43/UuPEHlUx0k4U2RwASzeqjb1xry6p927uzT92V/4bsec
         TzRK0dLiv7kM+MYkABEFSjptTfsnZBKEm61l6dKIX83rJNKfo1nw9HLCbu5Q8YE7gCBp
         8at2VcDWM5BZN5YU06qwLAyAFGc4M38A+mPuUl9xZQrTw1G2iPjCoFNao3bFmqkxh7i6
         a4sA==
X-Gm-Message-State: APjAAAXdbSJJ3+ISEvL5uM16UijL+HAAGxpogUh7WG3RQSWCF6aBWIUm
        TwXZRjSxbr5Wrbgn6GDaA0s=
X-Google-Smtp-Source: APXvYqxq3+lO6kleVAaJhVpO7+xF4yBaRtHEdL1Ka6mBYBVLYMv/jz414W7yfrzEcGtodEHhAlpA7w==
X-Received: by 2002:aed:3504:: with SMTP id a4mr12232461qte.139.1551641412188;
        Sun, 03 Mar 2019 11:30:12 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x80sm3634297qkx.85.2019.03.03.11.30.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 03 Mar 2019 11:30:11 -0800 (PST)
Date:   Sun, 3 Mar 2019 16:30:07 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 3/4] staging: iio: ad5933: add ABI documentation
Message-ID: <20190303193007.2zyvil4gmr7pv2pp@smtp.gmail.com>
References: <20190301025314.p53nlcfey3qarms4@smtp.gmail.com>
 <20190303121341.7a689124@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190303121341.7a689124@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03, Jonathan Cameron wrote:
> On Thu, 28 Feb 2019 23:53:14 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Add an ABI documentation for the ad5933 driver.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Hi Marcelo,
> 
> The ABI that you have defined which is actually new is mostly fine,
> however it seems that some of the existing ABI is not used correctly
> and that will need to be fixed.
> 
> Jonathan

Hi Jonathan,

Thanks for the comments.

> 
> > ---
> >  .../ABI/testing/sysfs-bus-iio-ad5933          | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > new file mode 100644
> > index 000000000000..81e3d3f6f724
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > @@ -0,0 +1,91 @@
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The output peak-to-peak voltage range. Writting 0 sets range
> > +		to 2.0V p-p typical, 1 sets range to 200mV p-p typical, 2 sets
> > +		range to 400mV p-p typical, 3 sets range to 1.0V p-p typical.
> > +		The p-p value of the ac output exitation voltage scales with 
> > +		supply voltage according to the following formula:
> > +		Output Excitation Voltage (V p-p) = normalized_3v3 × [VDD/3.3]
> > +		where normalized_3v3 is one of the four voltage range above and
> > +		VDD is the supply voltage.
> 
> Definitely not. The device must comply with standard ABI and this is not
> using it correctly (see below or the docs).
> 
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale_available
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:	
> > +		Prints available peak-to-peak voltage range to buffer.
> 
> I really hope it doesn't.  Scale is a mulitplier not a range.  It should be
> printing out the value by which the _raw reading should be multiplied to
> get the voltage in the base units for voltage (millivolts)

As the driver is right now I believe that calling this device attribute will
print "1980, 970, 383, 198" which are the mean values of four distributions
(called range1 to range4) of possible actual millivolt values used as the AC
output excitation. Certainly they don't mean "the value by which the _raw
reading should be multiplied to get the voltage in the base units for voltage"
so, as you said, this ABI is probably being misused here. Hence, I guess
I ought to change this attribute's call to something different than 
out_voltage0_scale_available (as well as the out_voltage0_scale above). Maybe
out_voltage0_excit_available or out_voltage0_mean_excit_available, any other
suggestion?

> 
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The start frequency. Set this to define de frequency point at
> > +		which the device should start the next frequency sweep. Default
> > +		start frequency point set to 10000Hz.
> 
> No need to specify the default. It's trivial to read and any user of this
> chip should set it to the value they want.

OK, then I will remove these on the next patch.

> 
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The frequency sweep increment. Set this to define at which rate
> > +		frequency sweep points are incremented. 
> Rate is a temporal term.  Perhaps "step by which the frequency is incremented"?

Maybe

"define the amount by which the frequency is incremented after each scan point."

would it be ok?

> 
> > After the measurement at
> > +		a frequency point is completed, the next measurement will be 
> > +		made with a frequency 'frequency increment'Hz higher than the
> > +		previous point until the defined number of increments has been
> > +		made. Default frequency increment set to 200Hz.
> 
> No need to specify the default. People can just read the file to find that out.
> 
> > +		
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The number of increments. This defines the number of frequency
> > +		points in the frequency sweep. Device stores a 9-bit integer
> > +		number in binary format for this so the maximum number of
> > +		increments that can be programmed is 511.
> I would relax this ABI description so that it doesn't describe the bit depth
> and ideally doesn't describe the range either.  If we want to provide the
> range, then provide an available attribute to pair with this.
> 
> The reason is that we should be looking to define interfaces in a way that
> allows them to be potentially generalised to similar devices in future.
> 
> I suspect a lot of this is generic to impedance measuring ICs.
> 

Then I think we would keep just the very beginning of it "The number of ... 
frequency sweep."

> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Number of settling time cycles. This attribute is a 11 bit field
> > +		divided in two parts. The 9 least significant bit define the
> > +		number of output excitation cycles that are passed through the
> > +		unknown impedance, after the receipt of a start frequency sweep,
> > +		increment frequency, or repeat frequency command, before the ADC
> > +		is triggered to perform a conversion of the response signal. The
> > +		2 most significant bits define a multiplier for the number of
> > +		cycles obtained from de least significant bits. Let D10 and D9
> 
> de -> the 

oops, thanks for pointing it out.

> 
> > +		be these two bits, the resulting multiplier is defined as
> > +		follows.
> > +		D10 D9 = 0 0 => No. of cycles x 1 (default)
> > +		D10 D9 = 0 1 => No. of cycles x 2
> > +		D10 D9 = 1 0 => Reserved
> > +		D10 D9 = 1 1 => No. of cycles x 4
> > +
> > +		See the datasheet for detailed information.
> 
> Hmm. This is a bizare interface - but such is hardware.
> 
> However, just because it is bizare in the hardware doesn't mean the
> userspace interface should be.  Just hide all this complexity and
> map whatever number of cycles is input to the nearest possible value.
>

Trying to be generic I would say:

	Number of settling time cycles. This sets the delay between a start
	frequency sweep/increment frequency /repeat frequency to be proportional
	to the excitation signal frequency times the number of settling time
	cycles.
 
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The PGA gain amplifier for the response signal. Set this to 0
> > +		to gain the output of the current-to-voltage amplifier by a
> > +		factor of 5. Set to 1 (default) to amplify the response signal
> > +		into the ADC by a multiplication factor of x1.
> > +
> > +What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale_available
> 
> There is no need to document standard ABI.  If this isn't documented in the
> main Documentation/ABI/testing/sysfs-bus-iio please add it there.

I guess this would be /sys/bus/iio/devices/iio:deviceX/in_voltage_scale.

> 
> > +Date:		February 2019
> > +KernelVersion:	Kernel 4.19
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Prints available PGA gain amplifier to buffer.
> Pga is one element that should effect this, but it's not the only
> one.  The resolution of the device also matters for example.
> 
>
 
Weren't this one described in /sys/.../iio:deviceX/in_voltageX_scale_available?

