Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA7C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25AF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl288YrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKOTOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:14:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32177 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbfKOTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573845293;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aeKPDmbhVFkPfpFZ83fbmccBa2OFHpCHF58FRCqPwY=;
        b=Cl288YrGYXPs+jIjxIrKUPuHDzpigmJplF0WaCjMyj5bacJXTeG3DkE2hJ1zHB4QBUGGpq
        69/GzXsWJVESOe52Ix8feYgC3AA904QHkb8tPh5tW+zZsc0sbFALT0W+kgfIQxqfAUWnht
        bKOoBNfqpf1/5uQR08VHF1L/UY82cXQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-GQGJvN8hPmeaSBndARBd6w-1; Fri, 15 Nov 2019 14:14:52 -0500
Received: by mail-pg1-f198.google.com with SMTP id l5so7967710pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=FxBh+q2M0KKHt6TdqEdE1VpfsrS5eZh2oXrvCdz9BQo=;
        b=BssK//mIEFd6y+Ng6Cdp4kaYRqqDPHrd9HMq4QcnIWP3Xw0R2RrIHViEG2G6Tks9el
         asajqUOnbj9y0Kyx9D/BtXRWbeY2SBg2diyzM4XSmdDxEFvP6FpTIevh2fVV3EICqzEm
         4vrJR4QcxlK0FmJL147EtxJq5rPLy2ldezpufdQHnvYuRwDjcVdb0EdYgrZBsPKOLQU/
         S1KCM8aB2CySWRylwFg4ImQCtHgUqtJaNAqn3jI24ROXVp6R9G69oGL4IzIBIuO2YXxF
         /r3w5m+EkmxeBjv6kQihQIucXY1ZLr+OJtleXxJ/rLevwupJmEWbbOQtnNfUTKYv2Naa
         ZzuA==
X-Gm-Message-State: APjAAAWrUX/sXebX0Yr4kU1uGGUrVXUhPmtCns1UQJBg98z8hFnyd3At
        5WBVbnATv5HTXmGP0EI9sa5qKEVgEExFgSjHFCIq1V3/3WYFIPDRXpGXNlR0pzcZhlimEecxtkB
        cmh7VqCpp6I2Ygz6ym3+eIONW
X-Received: by 2002:a62:31c1:: with SMTP id x184mr19500523pfx.255.1573845291379;
        Fri, 15 Nov 2019 11:14:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxv+9Zt2zsiWTpVh31clu5gBOi8WXECDEI8w7e37+mZ8dEznH2KmYFs+APiWtJMjzZwXiqG3w==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr19500497pfx.255.1573845291027;
        Fri, 15 Nov 2019 11:14:51 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q34sm10731806pjb.15.2019.11.15.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:14:50 -0800 (PST)
Date:   Fri, 15 Nov 2019 12:14:49 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191115191449.qnqgos4nli3tjsdw@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112033637.kxotlhm6mtr5irvd@cantor>
 <6d6f0899-8ba0-d6cf-ef3b-317ca698b687@linux.ibm.com>
 <20191112201716.GA12340@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191112201716.GA12340@linux.intel.com>
X-MC-Unique: GQGJvN8hPmeaSBndARBd6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 12 19, Jarkko Sakkinen wrote:
>On Tue, Nov 12, 2019 at 08:28:57AM -0500, Stefan Berger wrote:
>> I set this flag for the TIS because it wasn't set anywhere else.
>> tpm_tis_send() wouldn't set the flag but go via the path:
>>
>> if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
>>
>> =A0=A0=A0=A0=A0=A0=A0 return tpm_tis_send_main(chip, buf, len);
>
>Wondering why this isn't just "if (priv->irq_tested)"? Isn't that the
>whole point. The tail is the test part e.g. should be executed when
>IRQ testing is done.
>
>/Jarkko
>

I wonder if it would make sense to rename tpm_tis_send_main to tpm_tis_send=
,
move the irq testing bits from the current tpm_tis_send to tpm_tis_gen_inte=
rrupt,
and have tpm_tis_gen_interrupt build its own tpmbufs to send via tpm_tis_se=
nd
for the testing. Have all the irq testing bits are off on their own and sep=
arated out
from sending commands.

