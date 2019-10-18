Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCEECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF5B21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X49zCiEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506205AbfJRVkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:40:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37724 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfJRVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:40:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so4053453pgi.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7OJQvUdbIgU24dX8Wppa0p8i/hgWncJ+YoZFNcc+lGc=;
        b=X49zCiExyAyWi1+gFzVqGwmOWpWLxwXDEx200I8M4RnY/uPMTul/q6C+vTAekR09fZ
         aTOimWrmwWA2QxlHdN3Zm6/r+Pn4IUll1jKMiZWooV7Z3zcVn3D1uU2qv+gfSrPc7eo5
         hrErgAxJB9PXQktTfkYLWdLON3cUApaxcjXoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7OJQvUdbIgU24dX8Wppa0p8i/hgWncJ+YoZFNcc+lGc=;
        b=frTOP9WkMm08RX+z9uKQOjIvf8nYDylxIYbZ7uy85reFl1w7uqUUaZl/4ZSj3PzFcm
         +3iaJM9jZiEnqezkSYfjdTsQieo1SOm1EYXv5VjUNIaG+Pgcds7Jp+Q72mBC6o3sKeHA
         7LdENzRAiBTJoeIlhI3YOMl80Vk5RTmFMg+zn6eRoxzwWsN0xAirFOnEghtUkG0LMHG5
         wPYRJsZlgwZLBoV9jZxun23DOx3RERjkCQpYuttN99C6WNRsSSay70CRpxzEvIPriWg5
         u6FXuhqClwGXE9bgRHMV1JOPZctXeMYO3dBedWIFwymPyIqkazq0dLgennnnitrq+1nD
         bPPw==
X-Gm-Message-State: APjAAAUdOfAjofKPVHtQbM4GuuvglL+cZP7n+5pVMPgJneb+70u7N38e
        uIaaZwEV9GFAL5lIRjxFqc8hsA==
X-Google-Smtp-Source: APXvYqyd70104l4NfgYqs0u3fMh/peuUQcWQ+/X7Dt/uJkQR3dIru18MtlzyrY5v+4YirtGrxn9NKQ==
X-Received: by 2002:a17:90a:1aa9:: with SMTP id p38mr14177240pjp.142.1571434832108;
        Fri, 18 Oct 2019 14:40:32 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t21sm7903012pgi.87.2019.10.18.14.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 14:40:31 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Check queue pointer before use
To:     Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20191018162111.8798-1-dwagner@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <3624b42a-712a-bab5-c325-7171f71a51e1@broadcom.com>
Date:   Fri, 18 Oct 2019 14:40:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018162111.8798-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2019 9:21 AM, Daniel Wagner wrote:
> The queue pointer might not be valid. The rest of the code checks the
> pointer before accessing it. lpfc_sli4_process_missed_mbox_completions
> is the only place where the check is missing.
>
> Fixes: 657add4e5e15 ("scsi: lpfc: Fix poor use of hardware queues if fewer irq vectors")
> Cc: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi,
>
> Not entirely sure if this correct. I tried to understand the logic of
> the mentioned patch but failed to grasps all the details. Anyway, we
> observe a crash in lpfc_sli4_process_missed_mbox_completions() while
> iterating the array. All but the last one entry has a valid pointer.
>
> Thanks,
> Daniel
>
>   drivers/scsi/lpfc/lpfc_sli.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 379c37451645..149966ba8a17 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -7906,7 +7906,7 @@ lpfc_sli4_process_missed_mbox_completions(struct lpfc_hba *phba)
>   	if (sli4_hba->hdwq) {
>   		for (eqidx = 0; eqidx < phba->cfg_irq_chann; eqidx++) {
>   			eq = phba->sli4_hba.hba_eq_hdl[eqidx].eq;
> -			if (eq->queue_id == sli4_hba->mbx_cq->assoc_qid) {
> +			if (eq && eq->queue_id == sli4_hba->mbx_cq->assoc_qid) {
>   				fpeq = eq;
>   				break;
>   			}

looks fine. Thanks!

Reviewed by: James Smart <james.smart@broadcom.com>

-- james

