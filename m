Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9116AECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DB920835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP72eCTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfJGXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:46:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729285AbfJGXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570491993;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBWMaaGZzF4oSdvKphv04ldIFyjgzUH1UG+ukukd4tA=;
        b=bP72eCTqe2UWF6LVZMuBa2QDgu7gv2pwYGtP7r4/yHnrS5TjcWHYyAb/FFqDf1FV/GIxZx
        aBx8r6jqsaTsLPzX5tmttb6x+I3SW5hAZ8yG7b5HpvzmorYOplkUbes3uAc+wAiaytVJa/
        AzgwKHMgOMDR0rSUQMQgcnoPCq0flrg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-EzImMbzZPZesaDm2Q1dnrg-1; Mon, 07 Oct 2019 19:46:30 -0400
Received: by mail-io1-f70.google.com with SMTP id w8so29333941iod.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 16:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bz4UjdSVNp8i1AWweRPklpY8fKMpEuB9OPQPSrcsQNE=;
        b=Ofh8+5jxR62wSkQAL+hCBPl2mGfV+4bIa0B2mwnoMdOT5AtbWnoBjFNztfdqDqI2YW
         iSJbPJmrtWsf9bLLiaCjj0sPlo/lv5AmsqsGlS1MCdnQquxoQMd7UD8RPt3nTpNuM/mw
         tcHkTQdBbRDCrVb4+uB0ZVGxvPUpZqgdITvUvepsDnBPrrL4RHkYRIjDbIfG7B44WP1U
         aG5Zd2wsbI9/0OLJlWNBviGt15X8022J1u8PwoXgvCxugWIvn/3cBWndt/buFhSzdkhe
         IYt9TjlmDXa3kZvT13RLLr2WbpMgydlY4naAIx6XQG+KmwvriXQbfjszxerL3uS28ZRx
         BcLg==
X-Gm-Message-State: APjAAAWOMlDF9oaWO+KIW9pWbq7oWxn5tAca+vn4E8eTf04n3kVwlNRx
        xjZ9/JIZBK4w5hXTBPk8n/2tUO9vhhifTa6uWiOvOaG7JGbRHgECeAEyBMLGsnlV8oNkAanHOCL
        4s9h90qzwlbH3UkrgJqlwOXdQ
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr22142816iod.261.1570491989673;
        Mon, 07 Oct 2019 16:46:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUyzMIKtSVrSSQNpi4VVwUStK1lbTXh/m+TlzldDHOGdeKhuYb3kugOzuLH4UYPPsJE50T9g==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr22142801iod.261.1570491989440;
        Mon, 07 Oct 2019 16:46:29 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t17sm6047767ioc.18.2019.10.07.16.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 16:46:28 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:46:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: add check after commands attribs tab allocation
Message-ID: <20191007234627.fna7s5nvhgpv3bmq@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <157048479752.25182.17480591993061064051.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
In-Reply-To: <157048479752.25182.17480591993061064051.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: EzImMbzZPZesaDm2Q1dnrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 07 19, Tadeusz Struk wrote:
>devm_kcalloc() can fail and return NULL so we need to check for that.
>
>Fixes: 58472f5cd4f6f ("tpm: validate TPM 2.0 commands")
>Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
>---
> drivers/char/tpm/tpm2-cmd.c |    4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index ba9acae83bff..5817dfe5c5d2 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -939,6 +939,10 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chi=
p)
>
> =09chip->cc_attrs_tbl =3D devm_kcalloc(&chip->dev, 4, nr_commands,
> =09=09=09=09=09  GFP_KERNEL);
>+=09if (!chip->cc_attrs_tbl) {
>+=09=09rc =3D -ENOMEM;
>+=09=09goto out;
>+=09}
>
> =09rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY)=
;
> =09if (rc)
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

