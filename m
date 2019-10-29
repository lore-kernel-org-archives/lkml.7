Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53788CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ND1yGnwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfJ2TL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:11:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729263AbfJ2TLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572376283;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVQp5CGRx1PyvKgrlWv3b5v3aS+4Vv1jm/fv8rfBPR4=;
        b=ND1yGnwIeD+eS070Y5VWDN9ts8EdzqJmz5czWPOByk3u96I1zcI9ZtNE1v9iS9iRMb1aWM
        lJF68uSe0SJmATfVW8itsf4tdR09Yrc20jYMY1R2fRxnG/81INpTo5RSS+s2c1GFWXzxO2
        vLDXHcmKzCs7VFrcwlohc4T+0UFRrUA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-AJGw9TtkOQ6jcL70bfC8Xw-1; Tue, 29 Oct 2019 15:11:20 -0400
Received: by mail-yb1-f200.google.com with SMTP id n17so7217686ybm.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sVtwN1kmSxVpSY0Gti66u5ds+Iq3Vu9z0OH9D/yOKKA=;
        b=Q9NmdNx+ISacIdMw/jC2PnWBHnR1sLLlAnaimHOi9fSZfPrXVi2KQnzAZNXJ+LHoi4
         BTRr0OkM7NniClTBmTGiIfrHko1HfHZf8z6djn0cUrDBCNpAUzqdfSuRZdu1gTJjx2P1
         31OpcEuj0cM98BOKNIkLD/x5FyDrfcH1phhGs+iH+qi9N7qQOHm3N/v0zXAHfUqWaN73
         7kHmyRn3OS5KUssa0vegagOQSEVkQXXzPjCVeItACGAXLFCjzGOL3oSUwR7gY/kJQeVw
         2FEHP61DQh/eFNvlSwyhKvKMvdNvYVBI4CPrj31qANtk+s6Xb1G3ujW5mZBbJ8JHizA7
         SSsQ==
X-Gm-Message-State: APjAAAW/PeT5LQehBbEQqD0QwQKNB3bVLl5YK9y3HY0qBt8M37kqaTvF
        XBqlOsuglmZ8Wunh479v1l/c4qIUUBEWDrqKf3l2a7xviZK8TFZRa/Y6Cn//MG0jTyItdXZ98ng
        y+KPeKNzl4iTeIgY/LtPtFIS2
X-Received: by 2002:a81:9342:: with SMTP id k63mr18603329ywg.259.1572376280189;
        Tue, 29 Oct 2019 12:11:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIo0nu1QiFYzXsqc3qYVMlhK7WX5N1PZWEXhpO273XA5O1YWuA+Lg/iBZkH+W6gtx/LKofNQ==
X-Received: by 2002:a81:9342:: with SMTP id k63mr18603306ywg.259.1572376279827;
        Tue, 29 Oct 2019 12:11:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z196sm21489453ywz.30.2019.10.29.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:11:18 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:11:17 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add major_version sysfs file
Message-ID: <20191029191117.g2mwmhslko4b2sgx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
References: <20191025193103.30226-1-jsnitsel@redhat.com>
 <20191028205313.GH8279@linux.intel.com>
 <20191028210507.7i6d6b5olw72shm3@cantor>
 <20191029091731.GC9896@linux.intel.com>
 <20191029124342.GB6128@ziepe.ca>
 <20191029142225.GC7415@linux.intel.com>
 <1572361008.4812.2.camel@HansenPartnership.com>
 <20191029152211.GE6128@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191029152211.GE6128@ziepe.ca>
User-Agent: NeoMutt/20180716
X-MC-Unique: AJGw9TtkOQ6jcL70bfC8Xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 29 19, Jason Gunthorpe wrote:
>On Tue, Oct 29, 2019 at 07:56:48AM -0700, James Bottomley wrote:
>> On Tue, 2019-10-29 at 16:22 +0200, Jarkko Sakkinen wrote:
>> > On Tue, Oct 29, 2019 at 09:43:42AM -0300, Jason Gunthorpe wrote:
>> > > On Tue, Oct 29, 2019 at 11:17:31AM +0200, Jarkko Sakkinen wrote:
>> > > > On Mon, Oct 28, 2019 at 02:05:07PM -0700, Jerry Snitselaar wrote:
>> > > > > On Mon Oct 28 19, Jarkko Sakkinen wrote:
>> > > > > > On Fri, Oct 25, 2019 at 12:31:03PM -0700, Jerry Snitselaar
>> > > > > > wrote:
>> > > > > > > +=09return sprintf(buf, "%s\n", chip->flags &
>> > > > > > > TPM_CHIP_FLAG_TPM2
>> > > > > > > +=09=09       ? "2.0" : "1.2");
>> > > > > >
>> > > > > > This is not right. Should be either "1" or "2".
>> > > > > >
>> > > > > > /Jarkko
>> > > > >
>> > > > > Okay I will fix that up. Do we have a final decision on the
>> > > > > file name,
>> > > > > major_version versus version_major?
>> > > >
>> > > > Well, I don't see how major_version would make any sense. It is
>> > > > not as future proof as version_major. Still waiting for Jason's
>> > > > feedback for this.
>> > >
>> > > $ find /sys/ -name  "*version*"
>> > > /sys/devices/pci0000:00/0000:00:17.0/ata1/host0/scsi_host/host0/ahc
>> > > i_host_version
>> > > /sys/devices/virtual/net/docker0/bridge/multicast_mld_version
>> > > /sys/devices/virtual/net/docker0/bridge/multicast_igmp_version
>> > > /sys/firmware/efi/esrt/entries/entry0/lowest_supported_fw_version
>> > > /sys/firmware/efi/esrt/entries/entry0/last_attempt_version
>> > > /sys/firmware/efi/esrt/entries/entry0/fw_version
>> > > /sys/module/acpi/parameters/acpica_version
>> > >
>> > > etc..
>> > >
>> > > Not a single example of the backward version.
>> > >
>> > > Most likely it should be called 'tpm_version'
>> >
>> > The postfix gives tells the part of the version number that the file
>> > reports. If you really want to add the prefix, then the appropriate
>> > name would be tpm_version_major.
>> >
>> > I'd still go with just version_major as tpm_ prefix is somewhat
>> > redundant.
>>
>> You have to be careful with overly generic names in sysfs ... this is
>> what happened to us in SCSI:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D42caa0edabd6a0a392ec36a5f0943924e4954311
>>
>> That's not to say version_major is wrong ... plenty of sysfs files have
>> generic names like this, it's just that tpm_version_major might be more
>> future proof.
>
>Indeed, it is a bit a global namespace, so nothing wrong with adding
>tpm_
>
>Jason

So tpm_version_major?

