Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F01CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331162166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FRWBWBWX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OP4p4ZlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405324AbfHIFMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:12:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfHIFMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:12:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D8406038E; Fri,  9 Aug 2019 05:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565327528;
        bh=rexmz3pyVOn5/KSBkcTQuSsZPE7mmiFOL2Gp+zjAOIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FRWBWBWX7v34ViuTbfhMV4Dljird4fIKRWMiwxxAIXwAPc+1q6YyOgF5xR4miO11P
         a6STp0vykZYGFCJrkdFDZirOWHQeb2tlxoddLBKeofRi7J7SkUlyUVAyOI5pzGEuzD
         qDiFj0RbXiqBliwkeSRhLNgqwZhe7DU+vWASmzMU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6EA5060275;
        Fri,  9 Aug 2019 05:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565327527;
        bh=rexmz3pyVOn5/KSBkcTQuSsZPE7mmiFOL2Gp+zjAOIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OP4p4ZlHnWEGpatJdHw8tFmmfgyfuXxAqGv+BaN7akT48anMK8hKO16B7R23+Mtcg
         q2ATIVoh6RcWJmcWONGDwM6Uv5hbi04bO8/1gHUN3EsS98X9qlCfDueYi//BlZUZTp
         GG5KJmG2zz5ZkHQ8iLoKqkDDJ8B2PcYn38PsAVQ8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Aug 2019 10:42:07 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: wait for Pre shutdown to command
 complete event before sending the Power off pulse
In-Reply-To: <20190808145909.GP250418@google.com>
References: <1565256353-4476-1-git-send-email-c-hbandi@codeaurora.org>
 <20190808145909.GP250418@google.com>
Message-ID: <63b81f8235932de0d46164385d972b63@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-08-08 20:29, Matthias Kaehlcke wrote:
> On Thu, Aug 08, 2019 at 02:55:53PM +0530, Harish Bandi wrote:
>> When SoC receives pre shut down command, it share the same
>> with other COEX shared clients. So SoC needs a short
>> time after sending VS pre shutdown command before
>> turning off the regulators and sending the power off pulse.
>> 
>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> ---
>>  drivers/bluetooth/btqca.c   | 5 +++--
>>  drivers/bluetooth/hci_qca.c | 2 ++
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 2221935..f20991e 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -106,8 +106,9 @@ int qca_send_pre_shutdown_cmd(struct hci_dev 
>> *hdev)
>> 
>>  	bt_dev_dbg(hdev, "QCA pre shutdown cmd");
>> 
>> -	skb = __hci_cmd_sync(hdev, QCA_PRE_SHUTDOWN_CMD, 0,
>> -				NULL, HCI_INIT_TIMEOUT);
>> +	skb = __hci_cmd_sync_ev(hdev, QCA_PRE_SHUTDOWN_CMD, 0,
>> +				NULL, HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +
> 
> The commit message does not mention this change, it only talks about
> adding a delay.

[Harish] - I will add reason fo HCI_EV_CMD_COMPLETE in commit text and 
post new patch.
In commit text title I mentioned about command complete event, However I 
will add more details
about reason for command complete in commit text

> 
>>  	if (IS_ERR(skb)) {
>>  		err = PTR_ERR(skb);
>>  		bt_dev_err(hdev, "QCA preshutdown_cmd failed (%d)", err);
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 16db6c0..566aa28 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1386,6 +1386,8 @@ static int qca_power_off(struct hci_dev *hdev)
>>  	/* Perform pre shutdown command */
>>  	qca_send_pre_shutdown_cmd(hdev);
>> 
>> +	usleep_range(8000, 10000);
>> +
>>  	qca_power_shutdown(hu);
>>  	return 0;
>>  }
