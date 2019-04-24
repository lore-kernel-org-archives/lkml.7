Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF99C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BA321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfDXMRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:17:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727230AbfDXMRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:17:11 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 173B18227A5D9DEDBF60;
        Wed, 24 Apr 2019 20:17:08 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 20:17:05 +0800
Date:   Wed, 24 Apr 2019 13:16:55 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mohan Kumar <mohankumar718@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: proximity: This patch fix the following
 checkpatch warning.
Message-ID: <20190424131655.000013bb@huawei.com>
In-Reply-To: <CAJCx=g=8WEAVxdhOQni1gd2D-mTbuc8kTa6nQhF3nQ9JfGDJKg@mail.gmail.com>
References: <1555524925-15450-1-git-send-email-mohankumar718@gmail.com>
        <CAJCx=gmi6=uXbydpE2gY2x-XijtAd=bfufoJ+gbO1KU1n++g3Q@mail.gmail.com>
        <20190422114821.5955d4fa@archlinux>
        <CAJCx=g=8WEAVxdhOQni1gd2D-mTbuc8kTa6nQhF3nQ9JfGDJKg@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 17:23:26 +0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Mon, Apr 22, 2019 at 6:48 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 18 Apr 2019 16:23:51 -0700
> > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> >  
> > > See comments inline
> > >
> > > On Wed, Apr 17, 2019 at 11:15 AM Mohan Kumar <mohankumar718@gmail.com> wrote:  
> > > >
> > > > As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> > > > up to 20ms. so use usleep_range.
> > > >
> > > > Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> > > > ---
> > > >  drivers/iio/proximity/mb1232.c | 2 +-
> > > >  drivers/iio/proximity/srf08.c  | 4 ++--
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> > > > index 166b3e6..74f7eae 100644
> > > > --- a/drivers/iio/proximity/mb1232.c
> > > > +++ b/drivers/iio/proximity/mb1232.c
> > > > @@ -81,7 +81,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
> > > >                 }
> > > >         } else {
> > > >                 /* use simple sleep if announce irq is not connected */
> > > > -               msleep(15);
> > > > +               usleep_range(15000, 20000);  
> > >
> > > This is actually less than ideal.. because usleep_range uses the
> > > hrtimers which forces an interrupt.
> > >
> > > Unless you actually need to read between 15ms and 20ms it is best just
> > > to leave the msleep() as it is, and let it take a bit longer
> > > if required.  
> > Good response.  Perhaps Mohan could follow up with a patch to add
> > a comment to this effect to save anyone else trying to 'fix' this
> > issue in future?  
> 
> Change of the warning message in the checkpatch.pl script you mean?
No. That's basically telling people to 'think about it'.  I meant a comment
in the source for this driver to say 'We don't care here because...'.

That way anyone preparing a patch for this in future will see the comment
and not bother.

Jonathan

> 
> - Matt
> 
> >
> > Thanks,
> >
> > Jonathan  
> > >
> > > - Matt
> > >  
> > > >         }
> > > >
> > > >         ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> > > > diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> > > > index f2bf783..605a582 100644
> > > > --- a/drivers/iio/proximity/srf08.c
> > > > +++ b/drivers/iio/proximity/srf08.c
> > > > @@ -150,7 +150,7 @@ static int srf08_read_ranging(struct srf08_data *data)
> > > >          * polling for not more than 20 ms should be enough
> > > >          */
> > > >         waittime = 1 + data->range_mm / 172;
> > > > -       msleep(waittime);
> > > > +       usleep_range(waittime * 1000, (waittime * 1000) + 2000);
> > > >         for (i = 0; i < 4; i++) {
> > > >                 ret = i2c_smbus_read_byte_data(data->client,
> > > >                                                 SRF08_READ_SW_REVISION);
> > > > @@ -158,7 +158,7 @@ static int srf08_read_ranging(struct srf08_data *data)
> > > >                 /* check if a valid version number is read */
> > > >                 if (ret < 255 && ret > 0)
> > > >                         break;
> > > > -               msleep(5);
> > > > +               usleep_range(5000, 15000);
> > > >         }
> > > >
> > > >         if (ret >= 255 || ret <= 0) {
> > > > --
> > > > 2.7.4
> > > >  
> >  


