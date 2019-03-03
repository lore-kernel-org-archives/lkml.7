Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B84C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5B320835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551633445;
	bh=UYVpKf7o+iUv3VFlzRGBxn5Iu+P1MZgtNJqsh8u977U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XSHS4nOl03CBogl4xNclGnTRYOYuCxZt9psEq3CraRUFwfFDKdbCwoJs4VXdN6qK5
	 yVluqpZUwyU/z9n4s8sbMP+A8S32Rolmj6G/+UOddpWci0Lb9zPluatU9/r5ZccW6Z
	 O+om4mqO0juF8gwyD5aVxKn+kGiRKCYvpB2LNBUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCCRRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfCCRRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:17:23 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC46206B8;
        Sun,  3 Mar 2019 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551633442;
        bh=UYVpKf7o+iUv3VFlzRGBxn5Iu+P1MZgtNJqsh8u977U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BRuFYsv3Q0+JhcS7OF91JidoNgMv4NU7/wEwY5YV2N6IPB6+/Sy9HAhCotR4z2zab
         WwJ6L4HjtpntYzyJaFkY2w60O2leeNgfJRJX31iVNIiOExI089UZvrpFitieH48wke
         wsfFU98EuK9apY4YQgtobPpCrr9W/JFfPhiAX7vw=
Date:   Sun, 3 Mar 2019 17:17:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Georg Ottinger <g.ottinger@abatec.at>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        Stefan Etzlstorfer <s.etzlstorfer@abatec.at>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in
 timeout case
Message-ID: <20190303171714.1f66d277@archlinux>
In-Reply-To: <20190222095924.ald66pmei3erur2e@M43218.corp.atmel.com>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
        <20190202102021.12bb0a72@archlinux>
        <0974ce54b3da4d82b6bd3026a3de5ff3@abatec.at>
        <20190204094540.00003072@huawei.com>
        <040567eeda7b40b38816da2df354386f@abatec.at>
        <20190222095924.ald66pmei3erur2e@M43218.corp.atmel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 10:59:24 +0100
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> On Mon, Feb 04, 2019 at 11:03:18AM +0000, Georg Ottinger wrote:
> > I don't know how the race condition is triggered in detail.  All I know=
 is that if Touch Acquisition is enabled the adc_demo_error2 will provoke a=
 systemhang. If Touch is disabled the issue goes away. The architecture of =
at91_adc.c uses (at least) two trigger mechanisms of the ADC peripheral: To=
uch Trigger and Channel Trigger (started by at91_adc_read_raw() ). In my th=
eory the following happens: =20
>=20
> I think you trigger this race condition because when a touchscreen
> conversion is done, it performs a conversion on *all active channels*.
>=20
> Regards
>=20
> Ludovic
This still feels like putting a band aid in the wrong place, but
I'll take it and mark it for stable.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Maybe there isn't a better way...

Jonathan

>=20
> >=20
> > 1.) at91_adc_read_raw is called, a ADC conversation gets started
> > 2.) Touch trigger initiates a new conversation (killing the first conve=
rsation)
> >=20
> > .... the conversation started from  at91_adc_read_raw() never finishes =
-> TIMEOUT!
> >=20
> > The following Email is a summary of our findings (I mailed to the micro=
chip people):
> >=20
> > -----
> >=20
> > I want to let you know our findings of our ADC bughunting marathon. We =
put around 100 hours of work to identify this issues and I think we found 4=
  of them (one of them is more hardware related). Although we could develop=
 workarounds for this issues - not all of them are fully understood - so if=
 possible including someone experienced with the ADC peripheral (maybe from=
 the hardware team) should be considered.
> >=20
> > Attached you will find our version of at91_adc.c together with a simple=
 error demonstrator program called adc_demo_error.c
> >=20
> > * 1st issue: Unwanted PEN/NOPEN Interrupts at low temperatures
> >=20
> > When in Pendetect mode we received a lot of unwanted interrupts. This i=
ssue only appeared in our test settings when our board approached -20 degre=
es Celsius. We suspect that the internal Pull-down Resistor connected befor=
e the Pendetect-Schmitt trigger (selected by PENDETSENS), has a negative te=
mperature coefficient and at low temperature the impedance might be too hig=
h and so false detects are triggered by capturing surrounding noise -> we c=
ould solve this issue by changing the value  ts_pen_detect_sensitivity =3D =
2 to ts_pen_detect_sensitivity =3D 3.
> >=20
> > This issue can be considered to be related to our specific configuratio=
n, nevertheless we want to mention that the current Datasheet States on Pag=
e 1711 states the following:
> >=20
> > "PENDETSENS: Pen Detection Sensitivity-Modifies the pen detection input=
 pull-up resistor value. See the section 'Electrical Characteristics' for f=
urther details."
> >=20
> > There are two issues with this description. First: This resistor is a p=
ull-down resistor (measured and logical). Second the 'Electrical Characteri=
stics' sections is lacking the detailed description of this resistor value.
> >=20
> > * 2nd issue: at91_adc_read_raw() keeps Channel and corresponding interr=
upt enabled in case of timeout.
> >=20
> > Having a brief look at at91_adc_read_raw() it is obvious that in the ca=
se of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is =
omitted.
> > If 2 different channels are queried  we can end up with a situation whe=
re two Interrupts are enabled - but only one Interrupt is cleared in the In=
terrupt handler. Resulting in a interrupt loop and a system hang.
> >=20
> > This Issue can be reproduced by compiling and running the error demonst=
ration with two channel support. (-D2ND_CHANNEL)
> >=20
> > $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o a=
dc_demo_error2
> >=20
> > * 3rd issue: Race condition between PEN/NOPEN Interrupts using periodic=
 trigger and ADC_START in at91_adc_read_raw()
> >=20
> > This issue represents one way how timeout situations are provoked. Actu=
ally we consider the architecture of at91_adc.c a bit risky because it is u=
sing two trigger sources (periodic trigger for Touch, and ADC_START for rea=
ding raw values). We believe that changing the trigger source during an ong=
oing conversion can have unwanted side effects, like destroying an ongoing =
conversion. We currently don't fully understand what is going on, but we de=
veloped a workaround that is enhancing the timeout handling in at91_adc_rea=
d_raw() with a simple retry mechanism. (restarting with ADC_START)
> >=20
> > * 4th issue: when touch operation is enabled (TSMODE) a delay time betw=
een a channel disable (AT91_ADC_CHDR) and channel enable (AT91_ADC_CHER) is=
 needed otherwise the following conversion will fail.
> >=20
> > This issue represents the second way how timeout situations can arise. =
We measured around 40 to 42 ADC Cycles (at different ADC Clocks 500khz, 1mh=
z, 2mhz, 3mhz, 5mhz) of delay needed between the channel disable and the ch=
annel enable. At higher adc clock frequency (10mhz, 20 mhz) the issue doesn=
't show up (most likely because the function calls are delaying already eno=
ugh). We also observed that the need delay time increases further according=
 to the transfer time settings (TRANSFER) by 0, 2, 4 or 8  ADC cycles.
> >=20
> > This Issue can be reproduced by compiling and running the error demonst=
rator (single channel) and including a simple error message in the kernel m=
odule in the timeout case.
> >=20
> > $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -o adc_demo_error
> >=20
> > This issue is least understood by us and I think that talking to the ha=
rdware people regarding this issue can be worthwhile.=20
> > As a workaround we put at91_adc_read_raw() to sleep after the writing A=
T91_ADC_CHDR for 50 to 75 ADC Cycles.=20
> >=20
> > ------------------------------------
> >=20
> > We will run another round of tests next week - and after that I would l=
ike to prepare a pull request concerning the 2nd Issue. For the 3rd and the=
 4th Issue I would like to hear your opinion if our modifications are sound=
 before I will write an pull request.
> >=20
> > Thanks for your time,
> > Best wishes,
> > Georg Ottinger
> >=20
> > -----
> >=20
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: Jonathan Cameron [mailto:jonathan.cameron@huawei.com]=20
> > Gesendet: Montag, 04. Februar 2019 10:46
> > An: Georg Ottinger <g.ottinger@abatec.at>
> > Cc: Jonathan Cameron <jic23@kernel.org>; eugen.hristev@microchip.com; S=
tefan Etzlstorfer <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.d=
e>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pm=
eerw.net>; Nicolas Ferre <nicolas.ferre@microchip.com>; Alexandre Belloni <=
alexandre.belloni@bootlin.com>; Ludovic Desroches <ludovic.desroches@microc=
hip.com>; David S. Miller <davem@davemloft.net>; Ard Biesheuvel <ard.bieshe=
uvel@linaro.org>; Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.=
org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ma=
xime Ripard <maxime.ripard@bootlin.com>
> > Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in t=
imeout case
> >=20
> > On Mon, 4 Feb 2019 07:17:07 +0000
> > Georg Ottinger <g.ottinger@abatec.at> wrote:
> >  =20
> > > Actually this issue occurred to us with an concrete product, where we=
 experienced a system hang at -20 =C2=B0C.
> > > It was triggered by a race condition between the Touch Trigger and th=
e Channel Trigger of the ADC. Once triggered we got in to the situation whe=
re an ongoing Channel Conversion was lost (Timeout case).When we queried a =
second channel than we got a system hang. Investigating this issue we devel=
oped an error demonstrator - reading alternating two channels as fast as po=
ssible (when Touch is enabled). This also provokes this issue at room tempe=
rature.
> > >=20
> > > For the error demonstrator use following commandline to compile:
> > >=20
> > > $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o=
=20
> > > adc_demo_error2
> > >=20
> > > -------------
> > > // adc_demo_error.c
> > > #include <unistd.h>
> > > #include <fcntl.h>
> > >=20
> > > #define VLEN 10
> > >=20
> > > int main()
> > > {
> > >   int fd_adc,fd_adc2;
> > >   int ret;
> > >   char dummy[VLEN];
> > >  =20
> > >   fd_adc =3D open=20
> > > ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltag
> > > e4_raw",O_RDONLY);
> > > #ifdef 2ND_CHANNEL
> > >   fd_adc2 =3D open=20
> > > ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltag
> > > e5_raw",O_RDONLY);
> > > #endif
> > >=20
> > >   while(1) {
> > >=20
> > >     lseek(fd_adc, 0, SEEK_SET);
> > >     ret =3D read(fd_adc, dummy, VLEN);
> > > #ifdef 2ND_CHANNEL
> > >     lseek(fd_adc2, 0, SEEK_SET);
> > >     ret =3D read(fd_adc2, dummy, VLEN);
> > > #endif
> > >=20
> > >   }
> > > }
> > >=20
> > > ------------
> > >=20
> > >=20
> > > Greeting, Georg =20
> > Hi Georg,
> >=20
> > Thanks for the detailed error report and reproducer.
> >=20
> > What has me wondering now is where the race is that is triggering this?
> > Could you talk us through it?  I don't know this driver that well so pr=
obably much quicker for you to fill in the gaps rather than me try to figur=
e out the race path!
> >=20
> > I have no problem with defense in depth (with appropriate comments) but=
 I'd like to close that down as well.  If it really is unsolvable I'd like =
at least to have some clear comments in the code explaining why.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > >=20
> > > -----Urspr=C3=BCngliche Nachricht-----
> > > Von: Jonathan Cameron [mailto:jic23@kernel.org]
> > > Gesendet: Samstag, 02. Februar 2019 11:21
> > > An: Georg Ottinger <g.ottinger@abatec.at>
> > > Cc: eugen.hristev@microchip.com; Stefan Etzlstorfer=20
> > > <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.de>;=20
> > > Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler=20
> > > <pmeerw@pmeerw.net>; Nicolas Ferre <nicolas.ferre@microchip.com>;=20
> > > Alexandre Belloni <alexandre.belloni@bootlin.com>; Ludovic Desroches=
=20
> > > <ludovic.desroches@microchip.com>; David S. Miller=20
> > > <davem@davemloft.net>; Ard Biesheuvel <ard.biesheuvel@linaro.org>;=20
> > > Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.org;=20
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;=20
> > > Maxime Ripard <maxime.ripard@bootlin.com>
> > > Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in=
=20
> > > timeout case
> > >=20
> > > On Wed, 30 Jan 2019 14:42:02 +0100
> > > <g.ottinger@abatec.at> wrote:
> > >  =20
> > > > From: Georg Ottinger <g.ottinger@abatec.at>
> > > >=20
> > > > Having a brief look at at91_adc_read_raw() it is obvious that in th=
e=20
> > > > case of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR=20
> > > > registers is omitted. If 2 different channels are queried we can en=
d=20
> > > > up with a situation where two interrupts are enabled, but only one=
=20
> > > > interrupt is cleared in the interrupt handler. Resulting in a=20
> > > > interrupt loop and a system hang.
> > > >=20
> > > > Signed-off-by: Georg Ottinger <g.ottinger@abatec.at> =20
> > >=20
> > > Whilst I agree this looks like a correct change, I would like Maxime =
to take a look as he is obviously much more familiar with the driver than I=
 am.
> > >=20
> > > I suspect you can only actually get there in the event of a hardware =
failure as that isn't actually a timeout you should ever see.
> > > Could be wrong though!
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >  =20
> > > > ---
> > > >  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
> > > >  1 file changed, 17 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.=
c=20
> > > > index 75d2f7358..596841a3c 100644
> > > > --- a/drivers/iio/adc/at91_adc.c
> > > > +++ b/drivers/iio/adc/at91_adc.c
> > > > @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *=
idev,
> > > >  		ret =3D wait_event_interruptible_timeout(st->wq_data_avail,
> > > >  						       st->done,
> > > >  						       msecs_to_jiffies(1000));
> > > > -		if (ret =3D=3D 0)
> > > > -			ret =3D -ETIMEDOUT;
> > > > -		if (ret < 0) {
> > > > -			mutex_unlock(&st->lock);
> > > > -			return ret;
> > > > -		}
> > > > -
> > > > -		*val =3D st->last_value;
> > > > =20
> > > > +		/* Disable interrupts, regardless if adc conversion was
> > > > +		 * successful or not
> > > > +		 */
> > > >  		at91_adc_writel(st, AT91_ADC_CHDR,
> > > >  				AT91_ADC_CH(chan->channel));
> > > >  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
> > > > =20
> > > > -		st->last_value =3D 0;
> > > > -		st->done =3D false;
> > > > +		if (ret > 0) {
> > > > +			/* a valid conversion took place */
> > > > +			*val =3D st->last_value;
> > > > +			st->last_value =3D 0;
> > > > +			st->done =3D false;
> > > > +			ret =3D IIO_VAL_INT;
> > > > +		} else if (ret =3D=3D 0) {
> > > > +			/* conversion timeout */
> > > > +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> > > > +				chan->channel);
> > > > +			ret =3D -ETIMEDOUT;
> > > > +		}
> > > > +
> > > >  		mutex_unlock(&st->lock);
> > > > -		return IIO_VAL_INT;
> > > > +		return ret;
> > > > =20
> > > >  	case IIO_CHAN_INFO_SCALE:
> > > >  		*val =3D st->vref_mv; =20
> > >  =20
> >=20
> >  =20

