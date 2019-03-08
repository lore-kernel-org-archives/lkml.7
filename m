Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A11C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3372081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZiUxcLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfCHVRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:17:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33297 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:17:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so15102125pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PC+irVBjfIRVPxtTFF9v199fQw8q2YEazxKDDM5NSTQ=;
        b=oZiUxcLmr1zGuLQnooeRsFYGtVga0zrRpXSRztMGlrPf8vfU7Ot5cCJSI5LVHEOwjh
         G3NfGoXQS6+EvbLNy81FuhrqJ2GTosxuj2Fc9+WWZ+d8KuEVQ6tLKuXdhozyaNT5ff0l
         USTLG9B6A+HkbhMtgzsPoX+jfA67dPieHbSyvBcLv5pRuAn/CneQY4jklegr1zwa7Zak
         C0LNWORZyrdKvLfGHwYGeLBkyRzMuisDeGaYIhReAfRT/w74P3zODwEZK416wMMJaCKU
         aqXyOI+IqsqlOzbNZqzwt+eIH+mqu0iDnLmAjbMUwA94Qo0Gw6eRPoTaVmQNbtCrIKfF
         g/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PC+irVBjfIRVPxtTFF9v199fQw8q2YEazxKDDM5NSTQ=;
        b=F4WpVSrSNABE8sAIG4E3L37iwhjwqzCRLvg6t0gfvr5/CjqhGAggNZK11kjbtn1vc8
         f8VPj1YHlDukyi/BM0pHfO1JRhJDUBT5vCkpgk7Mlre0sCfaOUCDWgVmAGsBH/DaGhtU
         DxxeqatxbtaIkBku/Yleau0Oigmia4moJ8UFk5DUaAoeY/V0gri8XX8PtefBQ9if74qH
         GL8Hzzrb3kTmwyGPd2+khuRTMOeiA+dfPbstb97oi55DvBpZjMvGgxpIkvymxCt312mG
         JKatTtACmQMH1tsgbHG+2Aipc+9TteBpiiOeP8Z7jxNx/B9FrJgRWyOsytri1/17es9o
         T/gg==
X-Gm-Message-State: APjAAAUlcfzTfDTaYaCc7hbG2JPpEhSwNSILJVkOMLRLZM9s4aJ64/MO
        krcWB+kaB3ZgcFNCCXBBX0ySp+Vqodpkar0OL5MQmQ==
X-Google-Smtp-Source: APXvYqwwpRN5yGydOWvfotDSxw3NfN8emixvBOyhhLcsE5ejRVK0UCyHWXnsqH24MGl9L47JtG7qcbIeuPub2ljIre0=
X-Received: by 2002:a63:fe58:: with SMTP id x24mr18688399pgj.255.1552079820211;
 Fri, 08 Mar 2019 13:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20190307184125.21419-1-natechancellor@gmail.com> <20190307231534.2640-1-natechancellor@gmail.com>
In-Reply-To: <20190307231534.2640-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 13:16:49 -0800
Message-ID: <CAKwvOdmFnnGOnbQ-0fAeOpAMDjnYnN1mkiNjbcW8uNss9cSrVg@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: qla4xxx: Don't call dma_free_coherent when buf
 is NULL
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 3:17 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/scsi/qla4xxx/ql4_os.c:5915:7: warning: variable 'buf_dma' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> Don't call dma_free_coherent when buf is NULL, meaning that we never
> called dma_alloc_coherent and initialized buf_dma.
>
> Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
> Link: https://github.com/ClangBuiltLinux/linux/issues/391
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Check that buf is not NULL, which matches how dma_free_coherent is
>   called in the rest of the tree. This still fixes the warning.
>
>  drivers/scsi/qla4xxx/ql4_os.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 16a18d5d856f..9f56dafc3cda 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -5982,7 +5982,8 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
>                           ddb_index[1]));
>
>  exit_boot_info_free:
> -       dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
> +       if (buf)
> +               dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);

Same thoughts as: https://lkml.org/lkml/2019/3/8/786
WDYT?

-- 
Thanks,
~Nick Desaulniers
