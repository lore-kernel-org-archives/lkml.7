Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF50C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JxVqNMzO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BVw5wX2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfCGGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:49:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGGtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:49:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B96D6074F; Thu,  7 Mar 2019 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551941385;
        bh=h+1H9laOAG0hzNCViY330XOkwBHYt/gYkcAtTq0zoLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JxVqNMzO+6JkSj65885c/o70US0zeJGFXjsgIMTXZQVjcd64f2T1paHDGcJDfZ+9V
         shp4kbgycqG5VP+C+nqw+glStwxWuN+zIZQM6qCBQsElGnm0Ja/1x34RCj2VNotqKe
         DDbNsc5RYckhVb/H9r6JGCY26FcqMUxboARefEEM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A72B16030B;
        Thu,  7 Mar 2019 06:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551941384;
        bh=h+1H9laOAG0hzNCViY330XOkwBHYt/gYkcAtTq0zoLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVw5wX2HU7ck8OV2gn+vDiHEvsmjeR0jDBeiHx0lNBTdC8qrd4uTZwmG8TqX8lRSN
         k560/4y0nLh1IhvHLt9xoSCTe8jlJ2uvro2QVyhKsJH8iumTRotJN56Ry4LAW7A24Q
         mgrwD93/sprqGBfXIFb2ywp0EyQV2V33O1vdkmK8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Mar 2019 12:19:44 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     johan.hedberg@gmail.com, marcel@holtmann.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME
 controller to bootup.
In-Reply-To: <155191158734.20095.15990837191526416248@swboyd.mtv.corp.google.com>
References: <20190306162113.8585-1-bgodavar@codeaurora.org>
 <155191158734.20095.15990837191526416248@swboyd.mtv.corp.google.com>
Message-ID: <a22894cea091ee9945af9c22d6e42051@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stepen,

On 2019-03-07 04:03, Stephen Boyd wrote:
> Quoting Balakrishna Godavarthi (2019-03-06 08:21:13)
>> This patch enables enough time to ROME controller to bootup
>> after we bring the enable ping out of reset.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
> 
> Any Fixes tag? And maybe some more explanation or background on where
> 150 ms sleep comes from would be useful. Was it determined
> experimentally or did it come from a datasheet somewhere? Does the time
> differ between boards?
> 
[Bala]: this was observed in our stress testing and even the CHIP 
firmware team
         confirmed that BT chip required at least 150 ms to boot up.

@Rocky to confirm my statement.

>>  drivers/bluetooth/hci_qca.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 237aea34b69f..1953b13511e7 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
>>                 qcadev = serdev_device_get_drvdata(hu->serdev);
>>                 if (qcadev->btsoc_type != QCA_WCN3990) {
>>                         gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +                       /* Controller needs time to bootup. */
>> +                       msleep(150);
>>                 } else {
>>                         hu->init_speed = qcadev->init_speed;
>>                         hu->oper_speed = qcadev->oper_speed;

-- 
Regards
Balakrishna.
