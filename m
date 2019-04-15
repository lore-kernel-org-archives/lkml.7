Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9582183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurorafoss.org header.i=@aurorafoss.org header.b="IbtcebVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfDOPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:40:41 -0400
Received: from out.migadu.com ([91.121.223.63]:56388 "EHLO out.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOPkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:40:41 -0400
Received: (Migadu outbound); Mon, 15 Apr 2019 15:40:37 +0000
Authentication-Results: out.migadu.com; auth=pass (plain)
Received: from _ (out.migadu.com [188.165.195.186])
        by out.migadu.com (Haraka/2.8.16) with ESMTPSA id E7C06CC5-2E44-4A7C-9EB8-DBA9074BE38C.1
        envelope-from <luis@aurorafoss.org> (authenticated bits=0)
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 verify=FAIL);
        Mon, 15 Apr 2019 15:40:37 +0000
Mime-Version: 1.0
Date:   Mon, 15 Apr 2019 15:40:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <c34e15ec4be9d783c7134491639eb176@_>
X-Mailer: RainLoop/1.10.5.192
From:   luis@aurorafoss.org
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based
 ultrabooks
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     jic23@kernel.org, "Hartmut Knaack" <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        "Stephan Gerhold" <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
In-Reply-To: <c2f3c22c-d491-17e7-ede7-54f9df11e064@redhat.com>
References: <c2f3c22c-d491-17e7-ede7-54f9df11e064@redhat.com>
 <20190402160433.15810-1-luis@aurorafoss.org>
 <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
 <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
DKIM-Signature: v=1;a=rsa-sha256;bh=/RjNgl2Ea8j213BPdIq2fXDGQ4ZJbhtpDV8l2X8ltJM=;c=relaxed/simple;d=aurorafoss.org;h=from:subject:date:to;s=default;b=IbtcebVB0aKkLJfDaJAE0nLxkpHb0+40VkHrW7i+WuppFbD7w3BWksTy12BqfKK4mRy7qOO7sbnBJ7my2EpC+iufbSO0r4CAIYaggZB58sIJGgevXHLETWrtdcyszcL90vYSjfR2RQLGJqMhhexk0JNBWQmPnpsVoiX+FZULWAg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 6, 2019 10:36 AM, "Hans de Goede" <hdegoede@redhat.com> wrote:=0A=
=0AHi,=0A=0A> Yes that seems the best way forward with this.=0A> =0A> Not=
e I think "base" is better then "keyboard" for the sensor which=0A> is in=
 the base/keyboard. But neither is perfect, so go which whatever=0A> you =
prefer.=0A=0AReference to:=0A- https://github.com/hadess/iio-sensor-proxy=
/pull/262=0A- https://github.com/systemd/systemd/pull/12322=0A=0ARegards,=
=0ALu=C3=ADs=0A=0A> Hi,=0A> =0A> On 06-04-19 01:01, Lu=C3=ADs Ferreira wr=
ote:=0A> =0A>> Hi,=0A>> Basically we need to come up with a convention to=
 (optionally) indicate=0A> =0A> the sensors location with a udev attribut=
e set by:=0A> /lib/udev/hwdb.d/60-sensor.hwdb=0A>> So should we start add=
ing `ACCEL_LOCATION=3Ddisplay` and=0A>> `ACCEL_LOCATION=3Dkeyboard` attri=
butes to that file and patch=0A>> iio-sensor-proxy to ignore the keyboard=
 ones as a first step ?=0A> =0A> Yes that seems the best way forward with=
 this.=0A> =0A> Note I think "base" is better then "keyboard" for the sen=
sor which=0A> is in the base/keyboard. But neither is perfect, so go whic=
h whatever=0A> you prefer.=0A> =0A> Thanks & Regards,=0A> =0A> Hans=0A> =
=0A>> On Wed, 3 Apr 2019 at 10:10, Hans de Goede <hdegoede@redhat.com> wr=
ote:=0A> =0A> Hi,=0A> =0A> On 02-04-19 18:04, Lu=C3=ADs Ferreira wrote:=
=0A>> Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on displa=
y=0A>> and KIOX020A sensor on keyboard base, to detect tablet mode or scr=
een=0A>> orientation.=0A> =0A> I deliberately left out the KIOX020A id fo=
r now, because currently=0A> userspace cannot really deal with having 2 s=
ensors.=0A> =0A> See:=0A> https://github.com/systemd/systemd/issues/6557=
=0A> https://github.com/hadess/iio-sensor-proxy/issues/166=0A> =0A> Basic=
ally we need to come up with a convention to (optionally) indicate=0A> th=
e sensors location with a udev attribute set by:=0A> /lib/udev/hwdb.d/60-=
sensor.hwdb=0A> =0A> And then patch iio-sensor-proxy to consume that attr=
ibute and ignore=0A> the one which has e.g. ACCEL_LOCATION=3Dkeyboard in =
its udev properties=0A> =0A> Ignoring would be a first step, maybe later =
it can do something useful=0A> with it, see e.g. : https://github.com/ale=
sguzik/linux_detect_tablet_mode=0A> =0A> IMHO we really should minimally =
get code in place for iio-sensor-proxy=0A> to ignore the keyboard acceler=
ometer before merging this patch.=0A> =0A> I realize that having the code=
 in place will not magically get it on=0A> all users machines, but I beli=
eve this is the minimum which needs to=0A> happen before we push this out=
 and potentially breaks people screen=0A> rotation.=0A> =0A> I've had wor=
king on this on my TODO list for a long long time now,=0A> but -ENOTIME. =
If you have some time to work on this then that would=0A> be great.=0A> =
=0A> Regards,=0A> =0A> Hans=0A>> Signed-off-by: Lu=C3=ADs Ferreira <luis@=
aurorafoss.org>=0A>> ---=0A>> drivers/iio/accel/kxcjk-1013.c | 1 +=0A>> 1=
 file changed, 1 insertion(+)=0A>> =0A>> diff --git a/drivers/iio/accel/k=
xcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c=0A>> index 7096e577b23f..9a5=
e445facc1 100644=0A>> --- a/drivers/iio/accel/kxcjk-1013.c=0A>> +++ b/dri=
vers/iio/accel/kxcjk-1013.c=0A>> @@ -1492,6 +1492,7 @@ static const struc=
t acpi_device_id kx_acpi_match[] =3D {=0A>> {"KIOX0009", KXTJ21009},=0A>>=
 {"KIOX000A", KXCJ91008},=0A>> {"KIOX010A", KXCJ91008}, /* KXCJ91008 insi=
de the display of a 2-in-1 */=0A>> + {"KIOX020A", KXCJ91008},=0A>> {"KXTJ=
1009", KXTJ21009},=0A>> {"KXJ2109", KXTJ21009},=0A>> {"SMO8500", KXCJ9100=
8},
