Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B4C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06856206E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BwotiYmo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xOELlbUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfFIVhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 17:37:24 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39678 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbfFIVhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 17:37:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 59D678EE193;
        Sun,  9 Jun 2019 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560116243;
        bh=ozpHEnXCNqm+O0nKKUhf/rpuVu8D7tgMnNXcmehmhRQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BwotiYmo3ZXIn+8pV2kbvh0lSxMUo8YZuBZERNAxt4OrnvIy+B/WhJcYFvCCXYBy/
         2L1IPOrqzGxIZkyVxthetp/V7RgBVarSu8OS6uAWXNANetx4aoKuRBkcMhaFLZY/7/
         hnZosHs2N4r8Wl5FlRmAE4H59gq8kHpzVzEUJHKo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0y5EiMEx1Mhj; Sun,  9 Jun 2019 14:37:23 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8AC488EE0DF;
        Sun,  9 Jun 2019 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560116242;
        bh=ozpHEnXCNqm+O0nKKUhf/rpuVu8D7tgMnNXcmehmhRQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xOELlbUk+ziamqt2gJcTsmCofSTPR42xVXKqldCcpYHZ6yA5Zc5iX8tMjlMQfUSAu
         joPjQwmAv5aBOeYKP8vDur2+4KlAl+NPYbzxcHSzI7Z3Wj5ClX0y43CkPYaNg0LVVu
         /MuhV1ZAM5w4vWTSbQBA6Og4NB4IpRrrx8P8RGkk=
Message-ID: <1560116241.3324.19.camel@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: print trim features at device
 initialization
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Sun, 09 Jun 2019 14:37:21 -0700
In-Reply-To: <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
         <yq1wohxib7t.fsf@oracle.com>
         <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
         <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-08 at 17:13 +0300, Konstantin Khlebnikov wrote:
> > On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07, 2019
> > at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
> >  >
> >  > Do we really need to spam dmesg with even more ATA crap?  What
> > about
> >  > a sysfs file that can be read on demand instead?
> >  >
> > 
> > Makes sense.
> > 
> > Trim state is exposed for ata_device:
> > /sys/class/ata_device/devX.Y/trim
> > but there is no link from scsi device to ata device so they hard to
> > match.
> > 
> > I'll think about it.
> 
> Nope. There is no obvious way to link scsi device with ata_device.
> ata_device is built on top of "transport_class" and
> "attribute_container".
> This some extremely over engineered sysfs framework used only in
> ata/scsi. I don't want to touch this.

You don't need to know any of that.  The problem is actually when the
ata transport classes were first created, the devices weren't properly
parented.  What should have happened, like every other transport class,
is that the devices should have descended down to the scsi device as
the leaf in an integrated fashion.  Instead, what we seem to have is
three completely separate trees.

So if you look at a SAS device, you see from the pci device:

host2/port-2:0/end_device-2:0/target2:0:0/2:0:0:0/block/sdb/sdb1

But if you look at a SATA device, you see three separate paths:

ata3/host3/target3\:0\:0/3\:0\:0\:0/block/sda/sda1
ata3/link3/dev3.0/ata_device/dev3.0
ata3/ata_port/ata3

Instead of an integrated tree

Unfortunately, this whole thing is unfixable now.  If I integrate the
tree properly, the separate port and link directories will get subsumed
and we won't be able to recover them with judicious linking so scripts
relying on them will break.  The best we can probably do is add
additional links with what we have.

To follow the way we usually do it, there should be a link from the ata
device to the scsi target, but that wouldn't help you find the "trim"
files, so it sounds like you want a link from the scsi device to the ata device, which would?

James


