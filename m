Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C992FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93732214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QCgzr6Yy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QCgzr6Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCMJpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:45:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47204 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfCMJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:45:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E237B608FC; Wed, 13 Mar 2019 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552470307;
        bh=nR2cEbDKqSpROTGnCoz8RsA5qEaUCe4k5P4cYsTiXSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCgzr6YyXiUCqO3NryLcvgueShXNvsmCKRUUjmb/bCfKyJqTEWCme+pMNwR+kYlJ2
         SXCMSjTzr974u61r+0XUfO16yafUqmPIDQpho0vaMHBymUwSB8TR4duULIkK7RCV0O
         ThlTQV05q54E4AURVLOD7AhlIQRFFWJm7FRVIiww=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8287760312;
        Wed, 13 Mar 2019 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552470307;
        bh=nR2cEbDKqSpROTGnCoz8RsA5qEaUCe4k5P4cYsTiXSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QCgzr6YyXiUCqO3NryLcvgueShXNvsmCKRUUjmb/bCfKyJqTEWCme+pMNwR+kYlJ2
         SXCMSjTzr974u61r+0XUfO16yafUqmPIDQpho0vaMHBymUwSB8TR4duULIkK7RCV0O
         ThlTQV05q54E4AURVLOD7AhlIQRFFWJm7FRVIiww=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 13 Mar 2019 17:45:07 +0800
From:   rjliao@codeaurora.org
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, johan.hedberg@gmail.com,
        marcel@holtmann.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME
 controller to bootup.
In-Reply-To: <a22894cea091ee9945af9c22d6e42051@codeaurora.org>
References: <20190306162113.8585-1-bgodavar@codeaurora.org>
 <155191158734.20095.15990837191526416248@swboyd.mtv.corp.google.com>
 <a22894cea091ee9945af9c22d6e42051@codeaurora.org>
Message-ID: <82fdfbd3dc4dbc1b6258dd470afff589@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-03-07 14:49，Balakrishna Godavarthi 写道：
> Hi Stepen,
> 
> On 2019-03-07 04:03, Stephen Boyd wrote:
>> Quoting Balakrishna Godavarthi (2019-03-06 08:21:13)
>>> This patch enables enough time to ROME controller to bootup
>>> after we bring the enable ping out of reset.
>>> 
>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>> ---
>> 
>> Any Fixes tag? And maybe some more explanation or background on where
>> 150 ms sleep comes from would be useful. Was it determined
>> experimentally or did it come from a datasheet somewhere? Does the 
>> time
>> differ between boards?
>> 
> [Bala]: this was observed in our stress testing and even the CHIP 
> firmware team
>         confirmed that BT chip required at least 150 ms to boot up.
> 
> @Rocky to confirm my statement.
> 
>>>  drivers/bluetooth/hci_qca.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/hci_qca.c 
>>> b/drivers/bluetooth/hci_qca.c
>>> index 237aea34b69f..1953b13511e7 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
>>>                 qcadev = serdev_device_get_drvdata(hu->serdev);
>>>                 if (qcadev->btsoc_type != QCA_WCN3990) {
>>>                         gpiod_set_value_cansleep(qcadev->bt_en, 1);
>>> +                       /* Controller needs time to bootup. */
>>> +                       msleep(150);
>>>                 } else {
>>>                         hu->init_speed = qcadev->init_speed;
>>>                         hu->oper_speed = qcadev->oper_speed;

Hello,

Any concern to merge this change? Without this change the Rome cannot up 
while running the serdev way, we should mainline this change ASAP.
