Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B5C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708D8206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbfIJPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbfIJPLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:11:25 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 134B537E80
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:11:25 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id m6so20098324qtk.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 08:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mjlmQ8q4ebSGeqcCwGl4CP2ghV+MJ2RVpTWgq9fAfiY=;
        b=aFUhW6vAsekq455eZCuCVLNbehGrSfIc7IpkFl2aMe908ENAIe1cm0RcXQHRTdNjzL
         gUsd+dIhNu8v6ifNGCpEi0jc7FDuxqmR+b0g3nzwncN21/0DUCjFglMOqkV1QEu0v2rs
         iZ+X+/3w1dWUL+ICMAEi+4JMr5/kUvUDEMY6XrgrkcfXyyznrjRgYvVTz6g5mYhYz1sI
         oDRuwFMHwv9StSNalvpo74mBl3GYm+E8W+MmnIp6PF1w8t5suu228LJfxNMlH5HsMV7c
         qZ7x0bduYzIckXlpBjcEDzAntSh1HTmDQNG8fQxGNBkLKDn227wDY1Pg1Jr0d9MMTmkK
         pqMQ==
X-Gm-Message-State: APjAAAXug4jS4dpIfNxV2A8y2AdKBvLfSXhvBP+XqiI5Yw3WJDJ0hvOq
        SLyPKAnzdsQVNO3N2S6CfcMlEwzjVhKhD6Fp4I+/iyeZbjw3BS7xFnOKqIWyadOCqyVGwSkdihT
        /ttmQRt/Me5I5IY+vTqyag4P/
X-Received: by 2002:ad4:4246:: with SMTP id l6mr17975786qvq.140.1568128284314;
        Tue, 10 Sep 2019 08:11:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpuL3859rR0LE2rl/dgBb2h5pYNfUuwtFD0PdhTLyboBw9QPffFa+4gWJicHD8zJTrvwDs6A==
X-Received: by 2002:ad4:4246:: with SMTP id l6mr17975751qvq.140.1568128283949;
        Tue, 10 Sep 2019 08:11:23 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z72sm10001318qka.115.2019.09.10.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:11:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:11:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Call tpm_put_ops() when the validation for @digests
 fails
Message-ID: <20190910151121.3tgzwuhrroog5dvb@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190910142437.20889-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190910142437.20889-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 10 19, Jarkko Sakkinen wrote:
>The chip is not released when the validation for @digests fails. Add
>tpm_put_ops() to the failure path.
>
>Cc: stable@vger.kernel.org
>Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm-interface.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index 208e5ba40e6e..c7eeb40feac8 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -320,18 +320,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> 	if (!chip)
> 		return -ENODEV;
>
>-	for (i = 0; i < chip->nr_allocated_banks; i++)
>-		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
>-			return -EINVAL;
>+	for (i = 0; i < chip->nr_allocated_banks; i++) {
>+		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
>+			rc = EINVAL;
>+			goto out;
>+		}
>+	}
>
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> 		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
>-		tpm_put_ops(chip);
>-		return rc;
>+		goto out;
> 	}
>
> 	rc = tpm1_pcr_extend(chip, pcr_idx, digests[0].digest,
> 			     "attempting extend a PCR value");
>+
>+out:
> 	tpm_put_ops(chip);
> 	return rc;
> }
>-- 
>2.20.1
>
