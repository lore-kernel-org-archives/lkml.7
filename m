Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1BECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED6B21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbiCjU4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfJYSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:45:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52745 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbfJYSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572029129;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9paRnLLRdvZXOp9cLGb2RQRU7/GKkqNC1DIqfB0QbeY=;
        b=dbiCjU4o0M/Nfh0+4z1JsJLakXThFDA8fF4QaCgciQ3qCfv8pZz5yyyV4fIVc4OZtIe2Q9
        n0CvbjpUSUTXBhKZF7C7f8QrJVy9tdVGp82h52BgKN/GGvMuKIKHJ4D6N0wvAEtIsBRF9I
        O1x02zGgvXFSEgC8cBXzxyJT/39+J9g=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-MtxwpfdGO3eY-0HBqeHNlg-1; Fri, 25 Oct 2019 14:45:25 -0400
Received: by mail-yw1-f71.google.com with SMTP id j3so855003ywg.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fVbHX43wiPqb+J3ydMwqDaYmuPF6XwOJdbaDgrdUDlo=;
        b=M2xAtohMZqBpU7ggRDq7EI+k9v8vL4aFWnvSyXEqPFdtz+mO1E50pmKPUCzwUxQOyU
         50imxuXpK7Hw9y3bmKkeEacJtOBls+v/laoeMF5PDZFjlKSIQ90xntAtNZxetBZoCFsA
         YZ2tkfiQkpSIh5e8DEnVlFZHBdRGVXRuUQr5Ty/rxb/c7KXGA58DnvGs94fjWedTrgHh
         eBCNPw9BixkASVA6eHcr4H3eEBC1vrMarctRyAiAZ8Uuru2GzhXAoeLUQ4ZaJRIb+a+U
         iNVVyhZjsMec6bJPSTRRdpdVQG9/d8YqKpruN3pimrSLOlNAHryqRL5jyakaiWUZHDKL
         kwAA==
X-Gm-Message-State: APjAAAXiQBbjcParXR3EXrEM2IUy1Jg6FtEYvzrKXHaBZuibj59L17JL
        IL7H1+QjrNSg2PUZetPKWgt5BtN5e+kkyU59EMgrOeUv6r8848FV1av7Juu4KcsGpJVEUECsGwr
        2GVhv/lkCcGliGp5Ps7aPUyGM
X-Received: by 2002:a81:9a0c:: with SMTP id r12mr3336233ywg.25.1572029124854;
        Fri, 25 Oct 2019 11:45:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhdyun8ZpCPIfqKiBejy4EXQawnRyIbjDi97brP0Q/QRJiA3sF00QeN4QWfgu7CUUQeOZuzw==
X-Received: by 2002:a81:9a0c:: with SMTP id r12mr3336208ywg.25.1572029124425;
        Fri, 25 Oct 2019 11:45:24 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 137sm4513696ywu.84.2019.10.25.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 11:45:23 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:45:22 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191025184522.5txabdikcrn2dgvj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
References: <20191025142847.14931-1-jsnitsel@redhat.com>
 <1572027516.4532.41.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1572027516.4532.41.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: MtxwpfdGO3eY-0HBqeHNlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 25 19, Mimi Zohar wrote:
>On Fri, 2019-10-25 at 07:28 -0700, Jerry Snitselaar wrote:
>> Easily determining what TCG version a tpm device implements
>> has been a pain point for userspace for a long time, so
>> add a sysfs file to report the tcg version of a tpm device.
>
>Use "TCG" uppercase consistently.
>=A0
>>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>thanks!
>
>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
>FYI, on my system(s) the new file is accessible as
>/sys/class/tpm/tpm0/version_major. =A0Does this need to be documented
>anywhere?
>
>

Yes, there should be an entry added to
Documentation/ABI/stable/sysfs-class-tpm.
I will fix that up and the TCG not being uppercase in a v2.

Should Documentation/ABI/stable/sysfs-class-tpm updated in
some way to reflect that those are all links under device
now and not actually there.

>> ---
>>  drivers/char/tpm/tpm-sysfs.c | 34 +++++++++++++++++++++++++++-------
>>  1 file changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
>> index edfa89160010..9372c2d6f0b3 100644
>> --- a/drivers/char/tpm/tpm-sysfs.c
>> +++ b/drivers/char/tpm/tpm-sysfs.c
>> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, st=
ruct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RO(timeouts);
>>
>> -static struct attribute *tpm_dev_attrs[] =3D {
>> +static ssize_t major_version_show(struct device *dev,
>> +=09=09=09=09  struct device_attribute *attr, char *buf)
>> +{
>> +=09struct tpm_chip *chip =3D to_tpm_chip(dev);
>> +
>> +=09return sprintf(buf, "%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
>> +=09=09       ? "2.0" : "1.2");
>> +}
>> +static DEVICE_ATTR_RO(major_version);
>> +
>> +static struct attribute *tpm12_dev_attrs[] =3D {
>>  =09&dev_attr_pubek.attr,
>>  =09&dev_attr_pcrs.attr,
>>  =09&dev_attr_enabled.attr,
>> @@ -320,18 +330,28 @@ static struct attribute *tpm_dev_attrs[] =3D {
>>  =09&dev_attr_cancel.attr,
>>  =09&dev_attr_durations.attr,
>>  =09&dev_attr_timeouts.attr,
>> +=09&dev_attr_major_version.attr,
>>  =09NULL,
>>  };
>>
>> -static const struct attribute_group tpm_dev_group =3D {
>> -=09.attrs =3D tpm_dev_attrs,
>> +static struct attribute *tpm20_dev_attrs[] =3D {
>> +=09&dev_attr_major_version.attr,
>> +=09NULL
>> +};
>> +
>> +static const struct attribute_group tpm12_dev_group =3D {
>> +=09.attrs =3D tpm12_dev_attrs,
>> +};
>> +
>> +static const struct attribute_group tpm20_dev_group =3D {
>> +=09.attrs =3D tpm20_dev_attrs,
>>  };
>>
>>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>>  {
>> -=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> -=09=09return;
>> -
>>  =09WARN_ON(chip->groups_cnt !=3D 0);
>> -=09chip->groups[chip->groups_cnt++] =3D &tpm_dev_group;
>> +=09if (chip->flags & TPM_CHIP_FLAG_TPM2)
>> +=09=09chip->groups[chip->groups_cnt++] =3D &tpm20_dev_group;
>> +=09else
>> +=09=09chip->groups[chip->groups_cnt++] =3D &tpm12_dev_group;
>>  }
>

