Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C292C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC5420823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="fs9W1KIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfC1Rmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:42:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:25819 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfC1Rmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553794966;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PVbAzKTQzvusGPUTg7OF5dZ50Dub8g6zwUaVIxcYBvI=;
        b=fs9W1KIPbqRpd2FFmi3RbbVk4e0pFQ8uQ8nGd41PAE62GrMM/Xar0wuoeop/lXbbg+
        JJ3B0EsGrmpdOMCi7qqlnIfOJEatnWXClFdCjw5712octvPWWDji0Ih9yfLd+uefkagi
        pexhGTqYQEgrQ7IcX38NjM4GWt6eqqlHUyXFE0EECvGEKfwLeK2bPW8t/Pxe4iJNcCTg
        7yUZqtak2Ew8Po+LwA1z24JHM1C+NyDVOgah5iizUWSA3hOtp4Z7rPCAHsJvqIPit1kS
        Ga5atrEtv2jJXwn7mio43wsFg1xXCTycPEhw/oEZ2tA4r4FQIRcEu/YjB6S2IRdycvCO
        NLEw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWdXA0IgQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2SHgjMSk
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 28 Mar 2019 18:42:45 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 0/4] iio-input-bridge so that accelerometers which only have an iio driver can still present evdev input events
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190324182920.66242add@archlinux>
Date:   Thu, 28 Mar 2019 18:42:44 +0100
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <890047F6-E288-41F0-A8D0-B91CC5A3A0A4@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com> <20190324182920.66242add@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> Am 24.03.2019 um 19:29 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Mon, 18 Mar 2019 21:39:30 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
> =09
>> Some user spaces (e.g. some Android) use /dev/input/event* for =
handling the 3D
>> position of the device with respect to the center of gravity (earth). =
This can
>> be used for gaming input, rotation of screens etc.
>>=20
>> This should be the standard because this interface is an abstraction =
of how
>> this data is acquired from sensor chips. Sensor chips may be =
connected through
>> different interfaces and in different positions. They may also have =
different
>> parameters. And, if a chip is replaced by a different one, the values =
reported
>> by the device position interface should remain the same.
>>=20
>> But nowadays, new accelerometer chips usually just get iio drivers =
and rarely
>> an evdev input driver.
>>=20
>> Therefore we need something like a protocol stack: input device vs. =
raw data.
>> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. =
Or keyboard
>> input events vs. raw gpio or raw USB access.
>>=20
>> This patch set bridges the gap between raw iio data and the input =
device abstraction
>> so that accelerometer measurements can also be presented as X/Y/Z =
accelerometer
>> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
>>=20
> Hi,
>=20
> I've kind of run out of time today and want to give this a detailed =
look.

No problem, please take the time it needs.

>=20
> In the meantime a few initial comments.
>=20
> 1. Resend the whole series cc'ing the linux-input list and maintainer.

Ok!

> 2. In the vast majority of devices the interrupt pin is connected for =
an
>   accelerometer. and they support data ready signals.  My gut feeling =
is
>   that should be the preferred mode.

Mine too, and the commit message 1/4 describes this by=20

"If it runs, the driver polls the device(s) once every 100 ms. A mode =
where the
iio device defines the update rate is not implemented and for further =
study."

But I didn't manage to get this correctly set up for in-kernel iio on =
demand
(start/stop when a process does an open/close - it was simpler to =
start/stop
polling).

Here I am lacking some understanding of details of the subsystems and =
their
capabilities.

Therefore I focussed on the polling case to leave the interrupt driven =
case
for later improvements. Also, since 100ms doesn't seem to be a big =
resource
burden.

I am also not sure if we really want to process every fidget detected by =
the
raw sensor to the input subsystem. This could require more resources =
than
polling with 100ms distance.

>  It was for that use case that we originally
>   put all the demux and multiple buffer code in IIO. The original =
series for
>   that actually had an input bridge.
> =
https://lore.kernel.org/linux-iio/1351679431-7963-5-git-send-email-jic23@k=
ernel.org/

Oh, nice! I wasn't aware of that. If I had known, we might have based =
our
code on it.

It seems to be a good blueprint to understand how to set up the =
callbacks.

What I do not understand is where the "iio map" comes from in your =
approach.

=46rom device tree? That would IMHO be against the rule that DTS should =
describe
hardware but bridging data to a different user-space interface is not =
related
to hardware description.

So our approach does not need a specific mapping.

>=20
> 3. It's going to be a hard sell to have it 'always' map an =
accelerometer in IIO
>   to an input device when configured.  There are lots of other =
accelerometer use
>   cases where this would be crazy.  In the repost, give some comentary =
perhaps on
>   the following options:
>   a) Explicit binding - like the iio-hwmon bridge.
>   b) A userspace bridge (I even wrote one of those years ago using =
uevent)
>   c) Some sort of userspace triggered way of creating these on demand.

Basically, if you have one of these many other use cases, one can just =
keep this
bridge unconfigured. Then, it does not eat up memory or code space or =
processor
cycles.

Its only use case is to map iio accelerometers to input devices which =
are
really used as input devices, i.e. gaming, device orientation etc. Other =
use
cases (e.g. industrial sensor grid data aggregator) should not consider =
this as
an alternative interface and use e.g. libiio of course.

Those (handheld) devices in mind usually have only a single =
accelerometer chip, but
there are exceptions like the GTA04 and the Pyra which can have two of =
them (with
different precision, mounting orientation and functions). Maybe there =
are some
devices with more than two. So these iio devices should be reported =
separately
but the data (X,Y,Z) should mainly agree on input device level.

In the two-sensor case, our proposed driver simply creates two distinct =
/dev/input/event
files which can be given fixed file names by udev instead of inventing a =
new trigger
to create these on demand. IMHO it should not be handled differently =
from plugging in
multiple mice or joysticks or other gaming devices to USB.

And, this driver converts "raw" accelerometer data into a higher =
abstraction level
input event in a way that user-space becomes independent of the specific =
chip set
and its orientation. This is like hiding different flash hardware =
interfaces
by MTD or file systems. All the hardware details are hidden and =
shielded. Or it
is like mapping gpios or alternatively an i2c scanner chio into =
standardized key codes.

Finally, there is no polling (in this polling setup) if no process opens =
the input device.
So the only waste of 'always' mapping 'all' accelerometers but not using =
them are some
data structure allocations in the kernel and duration of probe().

> 4. Input has polled modes. Don't reinvent them.

Haven't heard of, but that is what a RFC is good for.

Anyways, if we use iio interrupts we don't need it, because the =
information flow
should go from the chip to the iio driver to the input bridge to the =
input subsystem
and only then notify user space (wake up the process running a select on =
the event
device file).

Now, there is something I have learned from studying your comment and =
struct input_dev.

Although I did not find polled modes, I can simplify our approach =
significantly
since we do not have to count open/close ourselves and define a mutex =
for that.

This is already done by the input_dev. So I should improve this part of =
our patches
before resending to input list. Thanks for inpsiring this.

> 5. The patch break up is very very random.  Just have one patch :)

Well, it tries to have small pieces in a specific order that you can =
bisect and
do not run into compile problems (e.g. adding Makefile before code).

But I can squash it. Seems to make sense since it is not really useful =
to know
which of these pieces breaks other things. It can only be the driver
and bisect will still pin-point it.

>=20
> Anyhow, I'll take a look in detail but may be a little while.

No reason to hurry. We can wait.

>=20
> Thanks,
>=20
> Jonathan

Thanks and BR,
Nikolaus

>=20
>=20
>>=20
>> H. Nikolaus Schaller (4):
>>  iio: input-bridge: optionally bridge iio acceleometers to create a
>>    /dev/input
>>  iio: input-bridge: add iio-input-bridge to Makefile
>>  iio: input-bridge: add IIO_INPUT_BRIDGE kernel config option
>>  iio: input-bridge: make the iio-input-bridge driver called by =
iio-core
>>=20
>> drivers/iio/Kconfig                    |   7 +
>> drivers/iio/Makefile                   |   1 +
>> drivers/iio/industrialio-core.c        |  12 +
>> drivers/iio/industrialio-inputbridge.c | 420 =
+++++++++++++++++++++++++
>> drivers/iio/industrialio-inputbridge.h |  28 ++
>> 5 files changed, 468 insertions(+)
>> create mode 100644 drivers/iio/industrialio-inputbridge.c
>> create mode 100644 drivers/iio/industrialio-inputbridge.h
>>=20
>=20

