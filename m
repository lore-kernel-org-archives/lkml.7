Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B23C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A0520811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dVucFrEj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dVucFrEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHFNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:13:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCHFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:13:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AEDB16034E; Fri,  8 Mar 2019 05:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552021995;
        bh=boH7gqwvvNYPPnvKs4lDxycg0Jd5ZPt3IOoDfg1GZgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVucFrEjy4T/ROfPMaKwDftIWO9F+Pz62t9IjlArBeRub5zv5MANWQ/GNKbhCffyu
         /iTppbQd9x6j/pBjUU3AXe43W+xvN0IarjB3jJwkyQwBDHfAuK21W9EHu7z/Tp8Eky
         2MxDPQ45FJSSsGhxua1xDeJvKHHgHP7uCCLaiWnU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E74CB60316;
        Fri,  8 Mar 2019 05:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552021995;
        bh=boH7gqwvvNYPPnvKs4lDxycg0Jd5ZPt3IOoDfg1GZgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVucFrEjy4T/ROfPMaKwDftIWO9F+Pz62t9IjlArBeRub5zv5MANWQ/GNKbhCffyu
         /iTppbQd9x6j/pBjUU3AXe43W+xvN0IarjB3jJwkyQwBDHfAuK21W9EHu7z/Tp8Eky
         2MxDPQ45FJSSsGhxua1xDeJvKHHgHP7uCCLaiWnU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Mar 2019 10:43:14 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable the ldisc for ROME for x86
 platforms.
In-Reply-To: <20190307204224.GD138592@google.com>
References: <20190307101722.25871-1-bgodavar@codeaurora.org>
 <20190307204224.GD138592@google.com>
Message-ID: <6e0abe10b3ed44053e92ad6a21c75d93@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-08 02:12, Matthias Kaehlcke wrote:
> Hi Balakrishna,
> 
> On Thu, Mar 07, 2019 at 03:47:22PM +0530, Balakrishna Godavarthi wrote:
>> When using btattach to setup Rome over ldisc we observed a crash
>> in qca_setup as it will try to access the serdev which is not
>> available in the ldisc proto. This patch will fix the crash by
>> support both the ldisc and serdev way in the qca hci_uart driver.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Oh, I wasn't aware of the instantiation through ldisc and was actually
> considering to *remove* some of the seemingly unnecessary serdev
> checks.
> 
>> ---
>>  drivers/bluetooth/hci_qca.c | 47 
>> ++++++++++++++++++++++---------------
>>  1 file changed, 28 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 237aea34b69f..0a5c98d46864 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -963,7 +963,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  {
>>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>>  	struct qca_data *qca = hu->priv;
>> -	struct qca_serdev *qcadev;
>> +	struct qca_serdev *qcadev = NULL;
> 
> In many cases the only field that is accessed is qcadev->btsoc_type. I
> think something like 'qca_get_soc_type(struct hci_dev *hdev / struct
> hci_uart *hu)' would make things more readable.
> 
[Bala]: sure will update this in other patch once this change is landed 
as this has to
         go in priority as we have crash coming.

> IMO the whole 'qcadev' vs 'qca(_data)' is confusing anyway, in this
> sense even better if we can make most of the 'qcadev' references
> disappear.
> 
[Bala]: will note this improvement point and do it with the above 
change.

> Thanks
> 
> Matthias

-- 
Regards
Balakrishna.
