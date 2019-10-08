Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CCE206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln6fCUWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfJHPru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:47:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbfJHPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570549668;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBGvZIF571HTn35++5kc9Le27q5+H0WDHt3Pl1cs/as=;
        b=Ln6fCUWAGxIUbHAvDAtwruxEvnoxMJl7uWevUrS+CvrF4l3No+Qe3gQ7nddhufWE3khz8f
        OVmfkTH/EcDfpzgSw6A/+fXEp/Z6HRS+7T4/YdjhieBT91yF/KirapNRidbVDkg9M+5XKi
        7hQtzDxkVfp+WsJ6hcr//CygcdruPTg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-KT6ZV5m6O2KwqDv_FzVUFQ-1; Tue, 08 Oct 2019 11:47:47 -0400
Received: by mail-io1-f69.google.com with SMTP id k14so33601438iot.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=numh0AsMF/f6J8tPWFvYvdNcl71ucF4WJz8Q0cwIn1c=;
        b=F9MxaO+CI0l4B4uQiQw+oY+rjKhVdoFJJupY880ZB4py3/gHd+sUTtTv5zxfaOPHdv
         k2GH/W8ZjzGnAHf2q2J/ai9Q5LSzczBQ2sUShwcppfYuTsmq6m95Y0QtTLdMjkP3oSCK
         e8jGPiazqF+o+Xo2hf1XMWk4uIXim6vjrBWyH4HCmKko5GzzSSW4XL5XsXvPVeElvq5u
         9HU6xehIpYEc+UHyLkpuSlyrw4BBmRIvsmSZz3UxJq0u37fDw4/zL2/oplexGujo9lAk
         qhKLh0PtZJXAHO7HcfloVnKMAdHEWAoT8mipARecIKTvEhQWr9CIloDp+TS5ZhuPOsg9
         1UCw==
X-Gm-Message-State: APjAAAWp33vUYmyekmLl3Hr+fMi+gGthng3pGYHCwjHCepHUXPUI4lgk
        VRVlnHfBfeagBpx5lUiBm4q+KVsDOLsS9XRTjk5nlIi7b66DfgiFDtxjAJZ7QFzSghQ5ngNS0Rt
        bhngXtakGUCWjZtoeheD1R2PI
X-Received: by 2002:a92:d952:: with SMTP id l18mr37425756ilq.114.1570549666760;
        Tue, 08 Oct 2019 08:47:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR4ZSdz58d23xVxIvLtsUUAjcUQrAZZO2o0ImYt67YaZe8YDlXpEc0cdZFhuDDzD96j/KSYg==
X-Received: by 2002:a92:d952:: with SMTP id l18mr37425730ilq.114.1570549666524;
        Tue, 08 Oct 2019 08:47:46 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d6sm6549608iop.34.2019.10.08.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:47:45 -0700 (PDT)
Date:   Tue, 8 Oct 2019 08:47:44 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] efi/tpm: fix sanity check of unsigned tbl_size
 being less than zero
Message-ID: <20191008154744.c3ppu63cbhg5kr7q@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191008100153.8499-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20191008100153.8499-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: KT6ZV5m6O2KwqDv_FzVUFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 08 19, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Currently the check for tbl_size being less than zero is always false
>because tbl_size is unsigned. Fix this by making it a signed int.
>
>Addresses-Coverity: ("Unsigned compared against 0")
>Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after suc=
cessful event log parsing")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/firmware/efi/tpm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>index 703469c1ab8e..ebd7977653a8 100644
>--- a/drivers/firmware/efi/tpm.c
>+++ b/drivers/firmware/efi/tpm.c
>@@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
> {
> =09struct linux_efi_tpm_eventlog *log_tbl;
> =09struct efi_tcg2_final_events_table *final_tbl;
>-=09unsigned int tbl_size;
>+=09int tbl_size;
> =09int ret =3D 0;
>
> =09if (efi.tpm_log =3D=3D EFI_INVALID_TABLE_ADDR) {
>--=20
>2.20.1
>

Thanks for catching that. Somehow I dropped it from v2 to v3.

