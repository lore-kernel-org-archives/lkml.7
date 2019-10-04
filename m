Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0AC222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHastvM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbfJDO6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:58:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389043AbfJDO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EebPJjW7CeMsMN24rCmsXR+EUlCGm5eTWQTWMlbNyOI=; b=EHastvM3Dx7teNQpDnI37EMHZ
        jfh/ASOsqy2kGpoFmIfP6I2Qn4YVXVYEvmsbc8ZiYUAcJ1v1xd68LIktDTiv9r9POsdc7piBaqMaV
        NrVt+uPa2cqe+xOoFy7donO6RGd7NfEJWjs8B43aFlN//Et0OkExQOrmyF5k6+q516T0go6IuaMEg
        1o75bPkdB+cUuxH/b0tKo0FNB3WiyVsihijkd+XIu2z2FHihXv7Z6Mt38DT2PPsBjmSBJ+YOX+IDe
        m4UGCmjDr6RVtySsi/0Cqzq+yrjVkkuOxXDiPTQpAZaaM6FpMZzrwwTy9U2p5N/VioyTmwtRLejYy
        Jmc3j0MIw==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGP2X-0008Ow-T4; Fri, 04 Oct 2019 14:58:41 +0000
Subject: Re: [PATCH] serial: move Non-standard serial drivers menu to the
 Serial drivers menu
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
 <20191004125446.GB583048@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d28e9315-a42d-fbea-e03f-1da7158d30a8@infradead.org>
Date:   Fri, 4 Oct 2019 07:58:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004125446.GB583048@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 5:54 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 25, 2019 at 06:16:28PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Since Non-standard serial port drivers are also Serial drivers,
>> move the "Non-standard serial port support" menu to be under/in
>> the "Serial drivers" menu. With this move, the "Serial drivers"
>> menu contains (a) 8250/16550 support, (b) non-8250 support, and
>> (c) non-standard serial port support.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  drivers/tty/Kconfig        |  119 -----------------------------------
>>  drivers/tty/serial/Kconfig |  119 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 119 insertions(+), 119 deletions(-)
>>
>> --- lnx-53.orig/drivers/tty/Kconfig
>> +++ lnx-53/drivers/tty/Kconfig
>> @@ -151,125 +151,6 @@ config LEGACY_PTY_COUNT
>>  	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
>>  	  architectures and 24 bytes on 64-bit architectures.
>>  
>> -config SERIAL_NONSTANDARD
>> -	bool "Non-standard serial port support"
>> -	depends on HAS_IOMEM
>> -	---help---
>> -	  Say Y here if you have any non-standard serial boards -- boards
>> -	  which aren't supported using the standard "dumb" serial driver.
>> -	  This includes intelligent serial boards such as Cyclades,
>> -	  Digiboards, etc. These are usually used for systems that need many
>> -	  serial ports because they serve many terminals or dial-in
>> -	  connections.
>> -
>> -	  Note that the answer to this question won't directly affect the
>> -	  kernel: saying N will just cause the configurator to skip all
>> -	  the questions about non-standard serial boards.
>> -
>> -	  Most people can say N here.
>> -
>> -config ROCKETPORT
>> -	tristate "Comtrol RocketPort support"
>> -	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
> 
> I would agree with the move, but the files are not in
> drivers/tty/serial/ for the drivers you are asking to configure in that
> directory.
> 
> So unless we want to move these drivers (and it's not really worth it,
> unless we want to create drivers/tty/serial/obsolete/ or something like
> that), I would just leave this alone.

ack that.  Thanks.

-- 
~Randy
