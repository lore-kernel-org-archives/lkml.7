Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB42C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015CD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDBUw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:52:26 -0400
Received: from volans.uberspace.de ([95.143.172.210]:35240 "EHLO
        volans.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:52:25 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 16:52:25 EDT
Received: (qmail 21952 invoked by uid 691); 2 Apr 2019 20:45:43 -0000
Received: from habor by volans.uberspace.de with BSMTP; 2 Apr 2019 20:45:43 -0000
Received: by habor.lkamp.de (Postfix, from userid 1000)
        id A04255A00B4; Tue,  2 Apr 2019 22:46:58 +0200 (CEST)
Date:   Tue, 2 Apr 2019 22:46:58 +0200
From:   Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>
To:     NeilBrown <neil@brown.name>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergej Perschin <ser.perschin@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 03/16] staging: m57621-mmc: delete driver from the tree.
Message-ID: <20190402204658.GA5187@habor.localdomain>
Mail-Followup-To: NeilBrown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergej Perschin <ser.perschin@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-4-gregkh@linuxfoundation.org>
 <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com>
 <87r2ak18yy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2ak18yy.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:51:49AM +1100, NeilBrown wrote:
> People keep telling me that drivers/mmc/host/mtk-sd.c should be able to
> handle the same hardware as this driver, with a little bit of work.
> Unfortunately they haven't told me what the little bit of work involves.
> 
> Have you explored that possibility at all?  I might try to have a look
> if I can make time.

I have started to look into it, when I was working on that
driver. First sorry for me doing nothing in the last few
month. Generally the two drivers seem to be very similar, the main
difference is the code for tuning. In the staging driver. this is a
total mess. It tries to account for tuning itself, so it also tries to
account which command was executed (succesfully) before a tuning is
necessary and reexecutes it, when it was the APP_CMD. But there are
still some differences in the tuning code, that are not due to
handling it in the driver.

If have mainly understand how to remove the 'in driver handling' of
the tuning and thing I could prepare a patch for that. But the
differences in the tuning code itself, I do not understand
completely.

There are two other larger differences that I found during my
work. One is that drivers/mmc/host/mtk-sd.c has much more features,
like voltage and clock handling and some support for high speed
modes. I don't know if these features are required/useful for this
device. The other thing is the card detect handling. This driver is
doing the card detect / read only detection on its own, where the in
tree one just uses some default gpio functions there and I don't know
weather this must be changed or weather there is a gpio driver for the
mt7621.

That is all I currently remember. Hope it helps.

Christian
