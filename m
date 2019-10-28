Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098B021479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gvIqtguR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404192AbfJ1Rpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:45:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbfJ1Rpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:45:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so2845028wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Rovnn7Tk4pjpqM2/fuwDU7PFCQET7R0UmlvO8C0rAFs=;
        b=gvIqtguRcWxgDg/gwI70B+XVTUBFbEECqZkgNuTXBu/6FRmnNqpSE1kz6cejE9bzPh
         XroT9a2bGuYjjn9WKH/PEkm0KV6HjGvrPyWXtCdsPV/PY7olHTv/0TR5fRaRIt+Ytbwp
         kYgntAINie2boQlbwLZNR2ojAd3ySj5DN5ivo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Rovnn7Tk4pjpqM2/fuwDU7PFCQET7R0UmlvO8C0rAFs=;
        b=EuCdGQsDeqB/x+Pm3dimu+W8nBDlTjQJaF+fRbh162f2MCxhK0VlWMUMkS2gI6vVoZ
         oC8dOwysaKMqnGTWFXRVrO90hlbVZbSDk/Tl8UhYsW8tQD78uqXE2K9p2Rl7LPavyHbK
         phKgONwTlakCt8+oDMUDQW4mRJMj3gBk3SR77RqY87n5CVPCBrmsYds2NpxPaD9w7pJU
         MqGwd3IfZzSQ4TkAHG17jK+i8nyensbDhdtDBetY6UqiFl8pIQDIr9TVmfaYI/I3N1Pu
         v3JhtuYF46DLyNXgysYT/GM+Q8Lpc0KdW2gHeqFjDqMi++O/Yg8YzMkKlXqReEB8vgjy
         EPLw==
X-Gm-Message-State: APjAAAUa1T1BgvJR2lh5Hb1V+zvT3ELogpwPVQWGrVKlQyLFM+7pAaM+
        K+TEgbyL2bAlfEMMYH2FeQKuKzKHxAcjAKyn7Ji07zbHRDKBZSna9Mc3Nx/cC75Q+vtdL84MSmY
        KcciQrcnSdnSh3y2ak7+HB6eBYZV+3+3J1wrhVkXyuLrQEP1LMxvyLoaaLJxtajlITnTNFsJqNA
        l/2rg=
X-Google-Smtp-Source: APXvYqym+LRObSGKJ/DfwMzxZxtJgEgyYINMiPvpZKnuPR3apHGmDRLQ6sP+9XpvBwHSeaH8PNxarg==
X-Received: by 2002:a1c:6282:: with SMTP id w124mr429924wmb.172.1572284735740;
        Mon, 28 Oct 2019 10:45:35 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f204sm264910wmf.32.2019.10.28.10.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 10:45:35 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Make lpfc_debugfs_ras_log_data static
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191028132556.16272-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <09b602f1-389a-8bf9-2963-60e1b9a49689@broadcom.com>
Date:   Mon, 28 Oct 2019 10:45:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028132556.16272-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2019 6:25 AM, YueHaibing wrote:
> Fix sparse warning:
>
> drivers/scsi/lpfc/lpfc_debugfs.c:2083:1: warning:
>   symbol 'lpfc_debugfs_ras_log_data' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_debugfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> index 6c8effc..2e6a68d 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -2079,8 +2079,8 @@ lpfc_debugfs_lockstat_write(struct file *file, const char __user *buf,
>   }
>   #endif
>   
> -int
> -lpfc_debugfs_ras_log_data(struct lpfc_hba *phba, char *buffer, int size)
> +static int lpfc_debugfs_ras_log_data(struct lpfc_hba *phba,
> +				     char *buffer, int size)
>   {
>   	int copied = 0;
>   	struct lpfc_dmabuf *dmabuf, *next;

Looks Fine.  Thanks!

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

