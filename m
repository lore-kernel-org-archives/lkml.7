Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C30C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DFA216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfEJI5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:57:18 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34299 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEJI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:57:18 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B557724000E;
        Fri, 10 May 2019 08:57:08 +0000 (UTC)
Message-ID: <d9f2ee79b8690939f36377990fb6d6fb08e9f0bc.camel@hadess.net>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
From:   Bastien Nocera <hadess@hadess.net>
To:     Roderick Colenbrander <thunderbird2k@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input <linux-input@vger.kernel.org>,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
Date:   Fri, 10 May 2019 10:57:07 +0200
In-Reply-To: <CAEc3jaCnHLA9PV5gLiBvHT5y26mwMGSUxa3YCO=c+FYmcszePQ@mail.gmail.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
         <20190407133037.0ad98897@archlinux>
         <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
         <20190414124029.1f1f6084@archlinux>
         <CAEc3jaCnHLA9PV5gLiBvHT5y26mwMGSUxa3YCO=c+FYmcszePQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-04-14 at 09:26 -0700, Roderick Colenbrander wrote:
> 
<snip>
> We at the time were one of the first to expose acceleration and gyro
> data through /dev/input for DualShock 4 as supported by hid-sony. We
> report acceleration in 'g' and angular velocity in 'degree / s'. We
> set the resolution to respectively '1 g' and '1 degree / s'. The range
> we set to the range of the device e.g. for DS4 -4g to +4g for
> acceleration. I need to check though what coordinate system we use,
> but I think it is right handed (gyro counter clockwise relative to
> acceleration axes).

How do you export the gyro information through the input device?

FWIW, we needed to do extra work in iio-sensor-proxy so that the
accelerometer in the Sixaxis/DS4 joypads (and uDraw tablet) didn't
appear as though they were accelerometer for the system:
https://github.com/hadess/iio-sensor-proxy/commit/401d59e54b3123860180d4401e09df8a1e1bc6c3

> The two other drivers using INPUT_PROC_ACCELEROMETER are hid-wacom and
> hid-udraw-ps3 Wacom. Both seem to report resolution in 'g'  as well.

I wrote hid-udraw-ps3, and it's reporting accelerometer data through
input because the rest of the driver is input, and it didn't make much
sense to use another subsystem for just that small portion of the
events the device sends out.

