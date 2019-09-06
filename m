Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E047C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF472082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394617AbfIFOt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:49:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:53612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730799AbfIFOt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:49:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBD20B628;
        Fri,  6 Sep 2019 14:49:55 +0000 (UTC)
Date:   Fri, 6 Sep 2019 16:50:04 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: Deprecate the legacy eeprom driver
Message-ID: <20190906165004.5e5748cc@endymion>
In-Reply-To: <20190904075729.GA22307@kroah.com>
References: <20190902104838.058725c2@endymion>
        <20190904075729.GA22307@kroah.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 4 Sep 2019 09:57:29 +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 02, 2019 at 10:48:38AM +0200, Jean Delvare wrote:
> > Time has come to get rid of the old eeprom driver. The at24 driver
> > should be used instead. So mark the eeprom driver as deprecated and
> > give users some time to migrate. Then we can remove the legacy
> > eeprom driver completely.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/misc/eeprom/Kconfig |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)  
> 
> You might also want to add a big printk() message when the driver is
> loaded that it shouldn't be used.

Good idea, although unfortunately this means expanding
module_i2c_driver. Or maybe I can use printk_once() in eeprom_probe().
Or even just a dev_warn() there to really spam the kernel log in a very
visible way.

Would you prefer a v2 of this patch including that change, or a
separate, incremental patch?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
