Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB7AC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 06:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AE520B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 06:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PvdsuIic";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EoiwYruP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDGGOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 02:14:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfDGGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 02:14:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5868260A4E; Sun,  7 Apr 2019 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554617658;
        bh=+5XYTpOTJVruRV++m8AeJBSwFkQFMD2B4o3UfQMoAGw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PvdsuIic6YhblHWDy3J4Rdz8Pb5YXSuclQISoQdEzQIQ5B7NpNSWiIkwr5bFtfl2c
         cpVBOUjXHxsP4IN4SNcqk2MkyVT/ftwsGgfC6DWuOgcDUs72Qi2bW4x1iy6/GD0qQF
         yl45s+/RVwHn1U1ANLEv2Zl+RqBZkPNrKSCVWe2w=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C6CE6044E;
        Sun,  7 Apr 2019 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554617657;
        bh=+5XYTpOTJVruRV++m8AeJBSwFkQFMD2B4o3UfQMoAGw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=EoiwYruPg+7JdizjT0Af9maeN9lZPEvxr5sGv4A4F9jDN10hqihGB+VikTwXoeQEx
         Y7B/YXaTYPs7/FI7/5hc9GIxE7VVYlUiVJP3s7HMoCF+ld7cYUGm6AIA/ltPmSThYC
         d7VgrerHaXmvLXMmIgOlz1skWs8r8J+d5VbvC+ZM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C6CE6044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] scsi: mvumi: fix warning Using plain integer as NULL
 pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190406175331.GA22504@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c84ef8f8-5a3d-4027-5f92-edb3544fecde@codeaurora.org>
Date:   Sun, 7 Apr 2019 11:44:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406175331.GA22504@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 11:23 PM, Hariprasad Kelam wrote:
> Changed "0 to NULL" to avoid below sparse warnings
>
> drivers/scsi/mvumi.c:755:58: warning: Using plain integer as NULL
> pointer
> drivers/scsi/mvumi.c:1797:48: warning: Using plain integer as NULL
> pointer
> drivers/scsi/mvumi.c:2142:50: warning: Using plain integer as NULL
> pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/scsi/mvumi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> index 3df0269..a541061 100644
> --- a/drivers/scsi/mvumi.c
> +++ b/drivers/scsi/mvumi.c
> @@ -752,7 +752,7 @@ static int mvumi_issue_blocked_cmd(struct mvumi_hba *mhba,
>   		spin_lock_irqsave(mhba->shost->host_lock, flags);
>   		atomic_dec(&cmd->sync_cmd);
>   		if (mhba->tag_cmd[cmd->frame->tag]) {
> -			mhba->tag_cmd[cmd->frame->tag] = 0;
> +			mhba->tag_cmd[cmd->frame->tag] = NULL;
>   			dev_warn(&mhba->pdev->dev, "TIMEOUT:release tag [%d]\n",
>   							cmd->frame->tag);
>   			tag_release_one(mhba, &mhba->tag_pool, cmd->frame->tag);
> @@ -1794,7 +1794,7 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
>   		cmd = mhba->tag_cmd[ob_frame->tag];
>   
>   		atomic_dec(&mhba->fw_outstanding);
> -		mhba->tag_cmd[ob_frame->tag] = 0;
> +		mhba->tag_cmd[ob_frame->tag] = NULL;
>   		tag_release_one(mhba, &mhba->tag_pool, ob_frame->tag);
>   		if (cmd->scmd)
>   			mvumi_complete_cmd(mhba, cmd, ob_frame);
> @@ -2139,7 +2139,7 @@ static enum blk_eh_timer_return mvumi_timed_out(struct scsi_cmnd *scmd)
>   	spin_lock_irqsave(mhba->shost->host_lock, flags);
>   
>   	if (mhba->tag_cmd[cmd->frame->tag]) {
> -		mhba->tag_cmd[cmd->frame->tag] = 0;
> +		mhba->tag_cmd[cmd->frame->tag] = NULL;
>   		tag_release_one(mhba, &mhba->tag_pool, cmd->frame->tag);
>   	}
>   	if (!list_empty(&cmd->queue_pointer))
