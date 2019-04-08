Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90091C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4996E20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDHSxb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:53:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHSxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:53:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63189AF93;
        Mon,  8 Apr 2019 18:53:29 +0000 (UTC)
Date:   Mon, 8 Apr 2019 20:53:28 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/6] MIPS: SGI-IP27: fix readb/writeb addressing
Message-Id: <20190408205328.062042a4f6e12f750bd4c05e@suse.de>
In-Reply-To: <20190408145834.GO7480@piout.net>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-5-tbogendoerfer@suse.de>
        <20190408145834.GO7480@piout.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 16:58:34 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 08/04/2019 16:20:56+0200, Thomas Bogendoerfer wrote:
> > diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
> > index 0cf6507de3c7..05f0d91366af 100644
> > --- a/drivers/rtc/rtc-m48t35.c
> > +++ b/drivers/rtc/rtc-m48t35.c
> > @@ -24,6 +24,16 @@
> >  
> >  struct m48t35_rtc {
> >  	u8	pad[0x7ff8];    /* starts at 0x7ff8 */
> > +#ifdef CONFIG_SGI_IP27
> > +	u8	hour;
> > +	u8	min;
> > +	u8	sec;
> > +	u8	control;
> > +	u8	year;
> > +	u8	month;
> > +	u8	date;
> > +	u8	day;
> > +#else
> 
> I'm not sure why the RTC driver has to know about that. Shouldn't your
> accessors be fixing that?

no, because the hardware is weird. RTC is connected to IOC3 byte bus and IOC3 is
connected to PCI. With a correct readb for PCI bus access to RTC behind IOC3 is byte
swapped.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
