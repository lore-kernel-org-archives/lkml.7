Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728DC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA520866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551615230;
	bh=5RpgLeJBPubCKWlYcfJvjNF2hNDhqUiIoRwJevAeUK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BVa+ZwpvGQD5vbKdGMcKfCFkW1B11g5Lza6Aiykv2TO3VXcPfxTBZnIRQIgHMpByx
	 8Coz37b/H/yiv5HIrWfAKzkX8bcmbwc/Bd85stfZtrOTy1k2r5JcczUc0jTpDPmvrX
	 jtF6NYKBvnhAnInMOnwbYZm22ODB4wUc27J+YvLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCCMNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfCCMNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:13:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A0220836;
        Sun,  3 Mar 2019 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551615226;
        bh=5RpgLeJBPubCKWlYcfJvjNF2hNDhqUiIoRwJevAeUK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pOMSSNBpDfEl0lkV9kzCjW78i6stFkMUpY2wLGL8NgqXRDfzOEiC6yzs8Ls50j70r
         5Dv16MSlJdZaagYQlXj9//yFX49B+0T7O82ORrYkB9CeAbvINg6HDgFDrVz1JgLWUE
         P+Wr+YWsLggS9LyVALMG2MMDMySXStxS9PFE6n7I=
Date:   Sun, 3 Mar 2019 12:13:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 3/4] staging: iio: ad5933: add ABI documentation
Message-ID: <20190303121341.7a689124@archlinux>
In-Reply-To: <20190301025314.p53nlcfey3qarms4@smtp.gmail.com>
References: <20190301025314.p53nlcfey3qarms4@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 23:53:14 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add an ABI documentation for the ad5933 driver.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Hi Marcelo,

The ABI that you have defined which is actually new is mostly fine,
however it seems that some of the existing ABI is not used correctly
and that will need to be fixed.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-ad5933          | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentati=
on/ABI/testing/sysfs-bus-iio-ad5933
> new file mode 100644
> index 000000000000..81e3d3f6f724
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> @@ -0,0 +1,91 @@
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The output peak-to-peak voltage range. Writting 0 sets range
> +		to 2.0V p-p typical, 1 sets range to 200mV p-p typical, 2 sets
> +		range to 400mV p-p typical, 3 sets range to 1.0V p-p typical.
> +		The p-p value of the ac output exitation voltage scales with=20
> +		supply voltage according to the following formula:
> +		Output Excitation Voltage (V p-p) =3D normalized_3v3 =C3=97 [VDD/3.3]
> +		where normalized_3v3 is one of the four voltage range above and
> +		VDD is the supply voltage.

Definitely not. The device must comply with standard ABI and this is not
using it correctly (see below or the docs).

> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale_available
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:=09
> +		Prints available peak-to-peak voltage range to buffer.

I really hope it doesn't.  Scale is a mulitplier not a range.  It should be
printing out the value by which the _raw reading should be multiplied to
get the voltage in the base units for voltage (millivolts)

> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The start frequency. Set this to define de frequency point at
> +		which the device should start the next frequency sweep. Default
> +		start frequency point set to 10000Hz.

No need to specify the default. It's trivial to read and any user of this
chip should set it to the value they want.

> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The frequency sweep increment. Set this to define at which rate
> +		frequency sweep points are incremented.=20
Rate is a temporal term.  Perhaps "step by which the frequency is increment=
ed"?

> After the measurement at
> +		a frequency point is completed, the next measurement will be=20
> +		made with a frequency 'frequency increment'Hz higher than the
> +		previous point until the defined number of increments has been
> +		made. Default frequency increment set to 200Hz.

No need to specify the default. People can just read the file to find that =
out.

> +	=09
> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The number of increments. This defines the number of frequency
> +		points in the frequency sweep. Device stores a 9-bit integer
> +		number in binary format for this so the maximum number of
> +		increments that can be programmed is 511.
I would relax this ABI description so that it doesn't describe the bit depth
and ideally doesn't describe the range either.  If we want to provide the
range, then provide an available attribute to pair with this.

The reason is that we should be looking to define interfaces in a way that
allows them to be potentially generalised to similar devices in future.

I suspect a lot of this is generic to impedance measuring ICs.

> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of settling time cycles. This attribute is a 11 bit field
> +		divided in two parts. The 9 least significant bit define the
> +		number of output excitation cycles that are passed through the
> +		unknown impedance, after the receipt of a start frequency sweep,
> +		increment frequency, or repeat frequency command, before the ADC
> +		is triggered to perform a conversion of the response signal. The
> +		2 most significant bits define a multiplier for the number of
> +		cycles obtained from de least significant bits. Let D10 and D9

de -> the=20

> +		be these two bits, the resulting multiplier is defined as
> +		follows.
> +		D10 D9 =3D 0 0 =3D> No. of cycles x 1 (default)
> +		D10 D9 =3D 0 1 =3D> No. of cycles x 2
> +		D10 D9 =3D 1 0 =3D> Reserved
> +		D10 D9 =3D 1 1 =3D> No. of cycles x 4
> +
> +		See the datasheet for detailed information.

Hmm. This is a bizare interface - but such is hardware.

However, just because it is bizare in the hardware doesn't mean the
userspace interface should be.  Just hide all this complexity and
map whatever number of cycles is input to the nearest possible value.

> +
> +What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale
> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The PGA gain amplifier for the response signal. Set this to 0
> +		to gain the output of the current-to-voltage amplifier by a
> +		factor of 5. Set to 1 (default) to amplify the response signal
> +		into the ADC by a multiplication factor of x1.
> +
> +What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale_available

There is no need to document standard ABI.  If this isn't documented in the
main Documentation/ABI/testing/sysfs-bus-iio please add it there.

> +Date:		February 2019
> +KernelVersion:	Kernel 4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Prints available PGA gain amplifier to buffer.
Pga is one element that should effect this, but it's not the only
one.  The resolution of the device also matters for example.


