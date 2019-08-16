Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F7C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10322077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JtcVwZzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfHPS3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:29:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38615 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:29:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so3339171pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fO2nsXcOD91Fm46vHTqedwEk5UPGSK+PcdJntAHJITw=;
        b=JtcVwZzKGVQoVyORWfnN0RvnjgUAdSYtszryB/kqDvycnAkOZj4CD+aYDhFiCUbXSD
         MbUjqfJX87rTTap9bwWCZs2hWHNU8pqDgykvM5JtQvq1lB/s7KCDNkM4j9ZU0TtJ1Ia3
         RgDpsZECWAb+O9K753TCZzDkjMYXqbtiHml9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fO2nsXcOD91Fm46vHTqedwEk5UPGSK+PcdJntAHJITw=;
        b=CrKEyX5H/+Rv9olP5aO7l4sqh/0L8sBRzbPXqvhWYdYcmndXE/f0cB1JIDVmwm/tYS
         KGFLlQWJH87c3kx3NRtIq6qnvwBcfzIprnjzH45zT9Xmv4oFYIS7XnmZPmW4uQnQ6Cvp
         VEoI9eKr7TgHjfkhxUOMV/5moOLWUzg80IdqN9uW7tP+Jy2wEeMFjM4ikvcghvtL+NfH
         5IxzFHF9DhvWub5XHZUyroI8vgZcCp3Ezp1kr5q7joTUFQS7EmjxvMNkkuLEuk2P/nq5
         GE4vxavVnxjYrz/e+pwJoy4TYwjEOacNJSWtqAQmt+qPVzP39XuT6mv0pBnXG1uvqo3o
         JBKQ==
X-Gm-Message-State: APjAAAUKIdevAqcqLiB32cUnZUars2qGzw97s/qUuUYOiqSa/TgFn5Tp
        fHZLzoBlHQiJ1IHpBUhUutGfCtCAYl6XH6n3mYcJ83M3qcJpTDZCWsg8t2eZFz1XhrKdNrNTlSa
        zMDRrqUAV6mQTW0h8yrKQp+diZ4ztv2YxzoQoVF8hyA46NeJnR4BrezvleVyG7zELpsB+KWcgXf
        cpQKE=
X-Google-Smtp-Source: APXvYqx4E4JEXIT3W1CyMQZyjzARmanb7SGgfATKCbUvdQ3JAktgB0NC2WDkgr+ANVTd8O3uSbdJcA==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr8916153pgc.56.1565980151108;
        Fri, 16 Aug 2019 11:29:11 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o11sm7563672pfh.114.2019.08.16.11.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 11:29:10 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: use spin_lock_irqsave instead of
 spin_lock_irq in IRQ context
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190812083134.7033-1-huangfq.daxian@gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <2cc6df9c-50d2-651c-9534-8a91e8e30bd8@broadcom.com>
Date:   Fri, 16 Aug 2019 11:29:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812083134.7033-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2019 1:31 AM, Fuqian Huang wrote:
> As spin_unlock_irq will enable interrupts.
> Function lpfc_findnode_rpi is called from
>      lpfc_sli_abts_err_handler (./drivers/scsi/lpfc/lpfc_sli.c)
>   <- lpfc_sli_async_event_handler
>   <- lpfc_sli_process_unsol_iocb
>   <- lpfc_sli_handle_fast_ring_event
>   <- lpfc_sli_fp_intr_handler
>   <- lpfc_sli_intr_handler
>   and lpfc_sli_intr_handler is an interrupt handler.
> Interrupts are enabled in interrupt handler.
> Use spin_lock_irqsave/spin_unlock_irqrestore instead of spin_(un)lock_irq
> in IRQ context to avoid this.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_hbadisc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 28ecaa7fc715..cf02c352b324 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -6065,10 +6065,11 @@ lpfc_findnode_rpi(struct lpfc_vport *vport, uint16_t rpi)
>   {
>   	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
>   	struct lpfc_nodelist *ndlp;
> +	unsigned long flags;
>   
> -	spin_lock_irq(shost->host_lock);
> +	spin_lock_irqsave(shost->host_lock, flags);
>   	ndlp = __lpfc_findnode_rpi(vport, rpi);
> -	spin_unlock_irq(shost->host_lock);
> +	spin_unlock_irqrestore(shost->host_lock, flags);
>   	return ndlp;
>   }
>   

Thank you.

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james
