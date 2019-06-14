Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB18C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E921537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NAnryftC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="a4FF/T4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfFNOyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:54:21 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38210 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfFNOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:54:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3CAA68EE147;
        Fri, 14 Jun 2019 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560524060;
        bh=MCF4Tqb2oKklo6nH/PJ4WDJ/J4GPxm8BnIGHPurjG7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NAnryftCE0J55HGOlqeJVtv87nhfKqvJpFznFXA3cLHdIhm7iK93mIoqwEZ51Appa
         0h7ReSTgmg9cH08kaUXGsjewY+Fnw6AUqers15VOII4p63IUJNmtDAtN2VV432HClv
         pmYVSdaTnqB8XENIpcQUWlxsVqQCBgAz869T+cAU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jMOTbLiAlgvS; Fri, 14 Jun 2019 07:54:20 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A76E58EE134;
        Fri, 14 Jun 2019 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560524059;
        bh=MCF4Tqb2oKklo6nH/PJ4WDJ/J4GPxm8BnIGHPurjG7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a4FF/T4myELlTU5GbtAJwtx3aBx2jRQ5K+TBRvy5Dj+DlkAzjLkcyCpGRKGvropeR
         zRzOzwZgnuEEIs3SCqeTeZy/iS8Fp+hDIOWLsHyx7YErXA4RoeYuKYyLKsZWSJ6Lpv
         JLRvf7hhio7dyrHeJCIam+oESMOogD5IGZbGQrG4=
Message-ID: <1560524058.27102.5.camel@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: print trim features at device
 initialization
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Fri, 14 Jun 2019 07:54:18 -0700
In-Reply-To: <cd91b050-cbc6-7c3b-f9f8-91c0760668e6@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
         <yq1wohxib7t.fsf@oracle.com>
         <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
         <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
         <1560116241.3324.19.camel@HansenPartnership.com>
         <b554c428-417e-5fef-1776-87a4db1d674a@yandex-team.ru>
         <1560206933.3698.27.camel@HansenPartnership.com>
         <cd91b050-cbc6-7c3b-f9f8-91c0760668e6@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 16:49 +0300, Konstantin Khlebnikov wrote:
> 
> On 11.06.2019 1:48, James Bottomley wrote:
> > On Mon, 2019-06-10 at 10:49 +0300, Konstantin Khlebnikov wrote:
> > > On 10.06.2019 0:37, James Bottomley wrote:
> > > > On Sat, 2019-06-08 at 17:13 +0300, Konstantin Khlebnikov wrote:
> > > > > > On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun
> > > > > > 07,
> > > > > > 2019
> > > > > > at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
> > > > > >    >
> > > > > >    > Do we really need to spam dmesg with even more ATA
> > > > > > crap?  What
> > > > > > about
> > > > > >    > a sysfs file that can be read on demand instead?
> > > > > >    >
> > > > > > 
> > > > > > Makes sense.
> > > > > > 
> > > > > > Trim state is exposed for ata_device:
> > > > > > /sys/class/ata_device/devX.Y/trim
> > > > > > but there is no link from scsi device to ata device so they
> > > > > > hard to match.
> > > > > > 
> > > > > > I'll think about it.
> > > > > 
> > > > > Nope. There is no obvious way to link scsi device with
> > > > > ata_device. ata_device is built on top of "transport_class"
> > > > > and
> > > > > "attribute_container". This some extremely over engineered
> > > > > sysfs
> > > > > framework used only in ata/scsi. I don't want to touch this.
> > > > 
> > > > You don't need to know any of that.  The problem is actually
> > > > when
> > > > the ata transport classes were first created, the devices
> > > > weren't
> > > > properly parented.  What should have happened, like every other
> > > > transport class, is that the devices should have descended down
> > > > to
> > > > the scsi device as the leaf in an integrated fashion.  Instead,
> > > > what we seem to have is three completely separate trees.
> > > > 
> > > > So if you look at a SAS device, you see from the pci device:
> > > > 
> > > > host2/port-2:0/end_device-
> > > > 2:0/target2:0:0/2:0:0:0/block/sdb/sdb1
> > > > 
> > > > But if you look at a SATA device, you see three separate paths:
> > > > 
> > > > ata3/host3/target3\:0\:0/3\:0\:0\:0/block/sda/sda1
> > > > ata3/link3/dev3.0/ata_device/dev3.0
> > > > ata3/ata_port/ata3
> > > > 
> > > > Instead of an integrated tree
> > > > 
> > > > Unfortunately, this whole thing is unfixable now.  If I
> > > > integrate
> > > > the tree properly, the separate port and link directories will
> > > > get
> > > > subsumed and we won't be able to recover them with judicious
> > > > linking so scripts relying on them will break.  The best we can
> > > > probably do is add additional links with what we have.
> > > > 
> > > > To follow the way we usually do it, there should be a link from
> > > > the
> > > > ata device to the scsi target, but that wouldn't help you find
> > > > the
> > > > "trim" files, so it sounds like you want a link from the scsi
> > > > device to the ata device, which would?
> > > 
> > > Yes, I'm talking about link from scsi device to leaf ata_device
> > > node.
> > > 
> > > In libata scsi_device has one to one relation with ata_device.
> > > So making link like /sys/class/block/sda/device/ata_device should
> > > be
> > > possible easy.
> > > But I haven't found implicit reference from struct ata_device to
> > > ata_device in sysfs.
> > 
> > If that's all you want, it is pretty simple modulo the fact we can
> > only
> > get at the tdev, not the lower transport device, which is what you
> > want, but at least it's linear from the symlink.
> > 
> > The attached patch should do this.
> > 
> > Now I see this for my non-sas device:
> > 
> > # ls -l /sys/class/scsi_device/3\:0\:0\:0/device/ata_device
> > lrwxrwxrwx 1 root root 0 Jun 10 13:39
> > /sys/class/scsi_device/3:0:0:0/device/ata_device ->
> > ../../../link3/dev3.0
> 
> I've tried this too. Such link is not very useful,
> because attribute 'trim' is deeper and suffix path isn't constant:
> 
> /sys/class/block/sda/device/ata_device/ata_device/dev1.0/trim
> 
> while I expect something like
> 
> /sys/class/block/sda/device/ata_device/trim

It provides you with an unambiguous way of finding the correct trim
file.

The problem with trying to lower the level of the link is that all the
devices below the one I linked to are transport class devices meaning
they're not visible at the point the link needs to be created.  That's
not to say some additional transport class magic couldn't be done, but
it would require pretty extensive code changes in drivers/base because
none of the current constructor functions carries additional
information, which is necessary to carry the link.

James

