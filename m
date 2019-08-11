Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2C7C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD892208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHKHcT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 03:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:56438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfHKHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:32:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6A50AD73;
        Sun, 11 Aug 2019 07:32:15 +0000 (UTC)
Date:   Sun, 11 Aug 2019 09:32:12 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 7/9] mfd: ioc3: Add driver for SGI IOC3 chip
Message-Id: <20190811093212.88635fb1a6c796a073ec71ff@suse.de>
In-Reply-To: <20190809142222.4558691e@cakuba.netronome.com>
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
        <20190809103235.16338-8-tbogendoerfer@suse.de>
        <20190809142222.4558691e@cakuba.netronome.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 14:22:22 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Fri,  9 Aug 2019 12:32:29 +0200, Thomas Bogendoerfer wrote:
> > SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> > It also supports connecting a SuperIO chip for serial and parallel
> > interfaces. IOC3 is used inside various SGI systemboards and add-on
> > cards with different equipped external interfaces.
> > 
> > Support for ethernet and serial interfaces were implemented inside
> > the network driver. This patchset moves out the not network related
> > parts to a new MFD driver, which takes care of card detection,
> > setup of platform devices and interrupt distribution for the subdevices.
> > 
> > Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> There are a lot of changes in the ethernet part which are not easy to
> explain by the introduction of the other MFD parts.. Could you possibly
> break this change up into smaller chunks?

working on it

> Also please don't use stdint types in the kernel, please try checkpatch
> to catch coding style issues.

my patch already reduces them and checkpatch only warns about usage of printk
for the network part. Changing that to dev_warn/dev_err in the mfd patch didn't
seem the right thing to do. As I'm splitting the conversion patch into a few
steps I could also replace the printks.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
