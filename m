Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F520878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CnQVEDM3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CnQVEDM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfDXHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:04:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:04:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC9E660734; Wed, 24 Apr 2019 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556089451;
        bh=q9dlEJwIR9h0ZBdYQO/DatofHxeHvPI+ZzCOOqfqNkA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CnQVEDM3ghhWLDki6JejPHQLcY4Dq9FWcUDmRP4b7zKsWOmjrNwZ3H55xyfi77jE3
         F32bGr+WGf277ydvPLMMquoAPMMKBN4gXt9MMi/eIxMxIT1yto5Eq+1MNNfRIDV7PC
         ipcSWILuYk36hsJwUoX2sWhXiVpIgdPi8rh5eCxE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 85CC1602F2;
        Wed, 24 Apr 2019 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556089451;
        bh=q9dlEJwIR9h0ZBdYQO/DatofHxeHvPI+ZzCOOqfqNkA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CnQVEDM3ghhWLDki6JejPHQLcY4Dq9FWcUDmRP4b7zKsWOmjrNwZ3H55xyfi77jE3
         F32bGr+WGf277ydvPLMMquoAPMMKBN4gXt9MMi/eIxMxIT1yto5Eq+1MNNfRIDV7PC
         ipcSWILuYk36hsJwUoX2sWhXiVpIgdPi8rh5eCxE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Apr 2019 12:34:11 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Subject: Re: [RFC v1] Bluetooth: hci_core: Don't stop BT if the BD address
 missing in dts
In-Reply-To: <371A1719-7CDD-4940-9D6F-0F3339FA50E6@holtmann.org>
References: <20190418132123.12816-1-bgodavar@codeaurora.org>
 <371A1719-7CDD-4940-9D6F-0F3339FA50E6@holtmann.org>
Message-ID: <96d661afb42cd4c6605cf7e2fbec7478@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

On 2019-04-23 22:05, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>> When flag HCI_QUIRK_USE_BDADDR_PROPERTY is set, we will read the
>> bluetooth address from dts. If the bluetooth address node is missing
>> from the dts we will enable it controller UNCONFIGURED state.
>> This patch enables the normal flow even if the BD address is missing
>> from the dts tree.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> net/bluetooth/hci_core.c | 2 --
>> 1 file changed, 2 deletions(-)
> 
> can I get an ACK for this one?
> 
> Regards
> 
> Marcel

nit: it would be better if we print error message, if bd address missing 
in dts.

tested 20 times with bd address missing in dts.
tested 20 times with bd address available in dts.

Tested-by: Harish Bandi <c-hbandi@codeaurora.org>


Thanks,
Harish


