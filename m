Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45451C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EF62148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GzZRtLAm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lsnK3pOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfDXHIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:08:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXHIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:08:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01D6460741; Wed, 24 Apr 2019 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556089725;
        bh=rbv719mvB1XYN4kQg7t8bSUQ+9vuRm6Kt3M3q0gMIOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GzZRtLAmhcsPSxyn3CdFy8eOm5WLSPTrx3X8OUzPzhfWt6+pd2x6rGQabzWQDsKW/
         iNhJ12edv0mrJVHicXpLY9p4VBfItskt5jlFoCSzfa8uaPzAf9aLQD/fkduTvYkJx2
         lNdPozl1s8Ii8nHOEPg75ROHGRMVxgHLPt3dvNgg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 579226072E;
        Wed, 24 Apr 2019 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556089724;
        bh=rbv719mvB1XYN4kQg7t8bSUQ+9vuRm6Kt3M3q0gMIOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lsnK3pOEDWw9clKxM8O1T88xy+btYgz9wpgSD313GnrFvvpqBbOiojtthcXVbs/6V
         fqAAsBJt584SotUc0Cn3VLL6Lpg7tNxps2W80BdpKNMSuGdcwNn38gk7cA5y+xKkMm
         V51PEDSmKllCVzMkTkRrG//zfYTAVKKc0StgBGbM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Apr 2019 12:38:44 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [RFC v1] Bluetooth: hci_core: Don't stop BT if the BD address
 missing in dts
In-Reply-To: <96d661afb42cd4c6605cf7e2fbec7478@codeaurora.org>
References: <20190418132123.12816-1-bgodavar@codeaurora.org>
 <371A1719-7CDD-4940-9D6F-0F3339FA50E6@holtmann.org>
 <96d661afb42cd4c6605cf7e2fbec7478@codeaurora.org>
Message-ID: <91deac040a35235e52079cdbdef2f425@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

On 2019-04-24 12:34, Harish Bandi wrote:
> Hi Balakrishna,
> 
> On 2019-04-23 22:05, Marcel Holtmann wrote:
>> Hi Balakrishna,
>> 
>>> When flag HCI_QUIRK_USE_BDADDR_PROPERTY is set, we will read the
>>> bluetooth address from dts. If the bluetooth address node is missing
>>> from the dts we will enable it controller UNCONFIGURED state.
>>> This patch enables the normal flow even if the BD address is missing
>>> from the dts tree.
>>> 
>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>> ---
>>> net/bluetooth/hci_core.c | 2 --
>>> 1 file changed, 2 deletions(-)
>> 
>> can I get an ACK for this one?
>> 
>> Regards
>> 
>> Marcel
> 
> nit: it would be better if we print error message, if bd address 
> missing in dts.
> 
> tested 20 times with bd address missing in dts.
> tested 20 times with bd address available in dts.
> 
> Tested-by: Harish Bandi <c-hbandi@codeaurora.org>
> 
> 
> Thanks,
> Harish

Thanks for testing will note this improvement and send an incremental 
patch.

-- 
Regards
Balakrishna.
