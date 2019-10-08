Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2681DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF865206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKwdUpgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfJHQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:16:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729008AbfJHQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570551363;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMCrrylCRmBl2ci0sro7S3+VKpru5MCXIR/yx7hpz7Q=;
        b=OKwdUpgtoSG5330oMojiXPuNfRRMGyEEpD5aqI1gMj67xbemyDtJovPPR2SgF2mIss5iLT
        4CqpXOpdIQU8Gf5ekQghQoc+vw6EbFOuoAwHGCCgI0/VKofrUhc2Ur1kvtGqA/OsBAA+8z
        rhxlCTQCiG2t4+fe5XCRR52KknN94SI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-nnYCwx14Paa-moIgD7jqoA-1; Tue, 08 Oct 2019 12:15:56 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so33727230ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 09:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ou0tS7RrxGwJYbkv5P7tqtmWszS5GQLWwcSoY8Uzr/4=;
        b=TyUvnc2x132N1d6vQfxgRZDbo0zGXf82k0MILNu/CQAG22q2geV+eekgTpadwNJ/R8
         vvJvrKVyATArXm9rj6B9kFKB1KpKv+o85JO8283TBe4L9LQ4Kquq4coJnuJDdmkhk4dz
         DdBxC6EgcMuf+3BqLIDidY9AhiD1qSRJYERXXP76pwE1HmUZjeYB8hP0WmobfPjRZTE/
         41R+rjZRKuVofGsTg9HlI2f6F/58gm81G9cCVwVCOCTBGsM4RaiEczfN2x+Pnu9/u6eC
         y0/PT0ZSrsldaWUEj0au+leGphXiMpHnCSieAnzEgZO3WiBusTOP/7FAW2Td4kQYSqZV
         LJ5A==
X-Gm-Message-State: APjAAAVrNKO1GcW/0waM+R03pMRpbxy8t87LJ+AnXN1Gu2DoJ+tA+L0t
        +ZQLs0uyypHt0Y1l3w3uHEG47oUzEMSDTmLOhZOUWg4Mw+cN7CtZ0fqcec8+kdek+zHCXt6mSZD
        AckdsaywLBxdgSs6aUTcZwrzp
X-Received: by 2002:a5d:8ac4:: with SMTP id e4mr5793637iot.185.1570551355515;
        Tue, 08 Oct 2019 09:15:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0+hoB1v72LiMOycxhZcE17wVcnSgjBHNmFhBxaa0wEB6Fdy7656PMyUlh6rq7awUIB1D8Bg==
X-Received: by 2002:a5d:8ac4:: with SMTP id e4mr5793615iot.185.1570551355314;
        Tue, 08 Oct 2019 09:15:55 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id c8sm9338443ile.9.2019.10.08.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 09:15:54 -0700 (PDT)
Date:   Tue, 8 Oct 2019 09:15:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] efi/tpm: fix sanity check of unsigned tbl_size
 being less than zero
Message-ID: <20191008161553.qls5lbyaxlasw25v@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191008100153.8499-1-colin.king@canonical.com>
 <20191008114559.GD25098@kadam>
MIME-Version: 1.0
In-Reply-To: <20191008114559.GD25098@kadam>
User-Agent: NeoMutt/20180716
X-MC-Unique: nnYCwx14Paa-moIgD7jqoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 08 19, Dan Carpenter wrote:
>On Tue, Oct 08, 2019 at 11:01:53AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the check for tbl_size being less than zero is always false
>> because tbl_size is unsigned. Fix this by making it a signed int.
>>
>> Addresses-Coverity: ("Unsigned compared against 0")
>> Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after s=
uccessful event log parsing")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/firmware/efi/tpm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index 703469c1ab8e..ebd7977653a8 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
>>  {
>>  =09struct linux_efi_tpm_eventlog *log_tbl;
>>  =09struct efi_tcg2_final_events_table *final_tbl;
>> -=09unsigned int tbl_size;
>> +=09int tbl_size;
>>  =09int ret =3D 0;
>
>
>Do we need to do a "ret =3D tbl_size;"?  Currently we return success.
>It's a pitty that tpm2_calc_event_log_size() returns a -1 instead of
>-EINVAL.
>
>regards,
>dan carpenter
>

perhaps "ret =3D -EINVAL;"? Currently nothing checks the return value of ef=
i_tpm_eventlog_init though.

