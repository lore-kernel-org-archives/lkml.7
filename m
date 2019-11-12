Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33992222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMfB3ViC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKLOY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:24:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40902 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727074AbfKLOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573568664;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M77sYtpSw/g9JRg/IfCLuexix7fcghmSQ3Jw6ATftUk=;
        b=EMfB3ViC3wdZPTuB/ZcB2rvof5+N4ibk6hFSgjdHT8DQ1Mibj8r20NyUmbThz5lwQEDR39
        j51782uhpaQY9Py/pR1E/7+tv7gwS+gYbL2OzRDxMnsdpGbqvvxw5C9SQ7TkxZg90PvBnN
        BAiTQVHBBpvwZzlGOPcjd7467AEQuxE=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-ix84nM5bOMGtfc8cW1VBAA-1; Tue, 12 Nov 2019 09:24:21 -0500
Received: by mail-yw1-f70.google.com with SMTP id h13so12235602ywc.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 06:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ta39WYxBtJE/JXsxQ2/3SPPahK/8w69J/Szz/R4mdEE=;
        b=AZ/gPRow6rzGfSL3yBgZUNOpsT1rKc/JH12pm28yJbwl0fMn+bW3vb0y4uHmnTVru3
         PSZg6FTU8o7RQNOonOSXm+Z82R0DSnJDfqoadcx8aQU9TWHHcky2qEtVM/l8zatG76uh
         1/ZsJUp7SDwwHqq29DVwuRTP9DxQ7K8PwyTucrEX33XiOTDvPsDl5KkJqwAwykpP6n3L
         ht7CFsHpO2bdI2e4NJ3VSF56I9XUeTeU8QpWQWS0ejjnrhVComVQIcNOkq/0NV233WWd
         K/gO8S3qjMa7DsE/3ecP/C3cXKW0yeKFYlh5gHoL0UPie1dnVW9imj8/ZblOSqAw7rzA
         +3mA==
X-Gm-Message-State: APjAAAUPdcVpPFJggnq336jRL0DNFLd8tvEf/viUjapdlEPquM7RCh6Q
        tashqWcT/8BWpbiZYOOwnOzIUwgmGqb4PMfwVq/3P3igMyKhDLTNzsd+7iYpWn09ujE37Hc5qgo
        Shc9Kfyk2DjpNDQdjLUIUlHxF
X-Received: by 2002:a81:3b13:: with SMTP id i19mr17810124ywa.323.1573568660971;
        Tue, 12 Nov 2019 06:24:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUg78618D2fcXoQYSagmvyiQSiUMbyoovS8k3jxjqiMme2L6aGaCnicA9qmzOnKuupXAXXjg==
X-Received: by 2002:a81:3b13:: with SMTP id i19mr17810105ywa.323.1573568660693;
        Tue, 12 Nov 2019 06:24:20 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n128sm1880219ywc.99.2019.11.12.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 06:24:19 -0800 (PST)
Date:   Tue, 12 Nov 2019 07:24:18 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112142418.3wwa4iukas4h2glp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
X-MC-Unique: ix84nM5bOMGtfc8cW1VBAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 12 19, Stefan Berger wrote:
>On 11/11/19 10:36 PM, Jerry Snitselaar wrote:
>>Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ=20
>>before probing for interrupts").
>>Doesn't tpm_tis_send set this flag, and setting it here in=20
>>tpm_tis_core_init short circuits what
>>tpm_tis_send was doing before? There is a bug report of an interrupt=20
>>storm from a tpm on a t490s laptop
>>with the Fedora 31 kernel (5.3), and I'm wondering if this change=20
>>could cause that. Before they got
>>the warning about interrupts not working, and using polling instead.
>>
>I set this flag for the TIS because it wasn't set anywhere else.=20
>tpm_tis_send() wouldn't set the flag but go via the path:
>
>if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>
>=A0=A0=A0=A0=A0=A0=A0 return tpm_tis_send_main(chip, buf, len);
>
>the only other line for the TIS to set the IRQ flag was in the same=20
>function further below, though that wouldn't be reached due to the=20
>above:
>
>[...]
>
>priv->irq =3D irq;
>
>chip->flags |=3D TPM_CHIP_FLAG_IRQ;
>
>
>=A0=A0 Stefan
>
>

Ugh, you're right I was reading that as ! around both the flag and priv->ir=
q_tested.

Should the flag be cleared if tpm_tis_probe_irq_single fails prior to calli=
ng
tpm_tis_gen_interrupt?

