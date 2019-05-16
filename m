Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36340C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC2420843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ce87YEoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEPBqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37430 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfEPAbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:31:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id d10so1224486qko.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xM+RFeuYKRxsIgkngGYK7F1nhOVwIknDUHFDYwBWS4M=;
        b=ce87YEoHQ3gEM1Pzl/OZnHRrbCQNF03DWhlezURYXEiSlkgU4w4mEO67/poVC2z5le
         a7DclrrqaCnPRhZ2hMIjN2Ax7PaZGQci2kVFNksfsJ7RnluEd6LDYlf3M9b871fljHW8
         4IwjunFUffu8qlpNONdUAYqTISgTgNo/vgKWZWhVNEKDLJeuQ7YzpmGht/RfwqaWBs0W
         xui8kjZq2sEEOlRIiENHuG6jlYQ24vX5rQyKSmP2pAHBBvk3Bh4P30TSBVU6dpTS/M1B
         5zKkeAtsOJF7coQpXiBHJpQM2FeqGxb/MyBSa+Ab3Mq1STKRb06LMCoh1j4bRjVF3so5
         9A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xM+RFeuYKRxsIgkngGYK7F1nhOVwIknDUHFDYwBWS4M=;
        b=gvUg2xX9exLf6N0OqEYepOVvdF2LmxIsvGLBHlvfHG5mOPHmm26F55uQAnBjmlsOZZ
         mluGoN8lUIElBlEsToFgUbBLhVW73XF8f1VtaGkbP9d1VztL7kuVFbNq0hX0ZFOwxAwC
         BwAZgkiuJsQwOECNvgUjkGsDS5bqpVCYak7FYREZyZu6UHIuZv5Vr1TS9NWGGzy8Sqrx
         wYTegJ9esEq+OKN14j1pQQ9HU2TBS7wpIhiUAorh4m72yMImmaLFBhHwF13iNlU7KyQg
         sLGHqtq4wp1tji4BSzkxi+LCwQC8vy12U78YrPcdb62XKa0mK+EFn8JaVMN73LgVC3JF
         zXsg==
X-Gm-Message-State: APjAAAW24Gb33LTWW4oyPZfNdvRu+nL1BpF3a6M3YepBKTcXQLkypfcg
        04B/VXfAAa+dJt3BWfSPVGbE1Q==
X-Google-Smtp-Source: APXvYqz3fHzTPnf64v8pB/ZHAteLVwxI4396VUH6eGzP3onjT97IZWc+DOk95vqA8DE+NZSD0H/6lw==
X-Received: by 2002:a37:aa42:: with SMTP id t63mr35422129qke.353.1557966692992;
        Wed, 15 May 2019 17:31:32 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m18sm1842826qki.21.2019.05.15.17.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 17:31:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Date:   Wed, 15 May 2019 20:31:31 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D0A6725-A738-4778-BB5B-1617B6184337@lca.pw>
References: <20190514150735.39625-1-cai@lca.pw>
 <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>                }
>>=20
>> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
>> index 7ff684159f29..2eb6a6cfe9e4 100644
>> --- a/drivers/nvdimm/bus.c
>> +++ b/drivers/nvdimm/bus.c
>> @@ -642,7 +642,7 @@ static struct attribute *nd_device_attributes[] =3D=
 {
>>        NULL,
>> };
>>=20
>> -/**
>> +/*
>>  * nd_device_attribute_group - generic attributes for all devices on =
an nd bus
>>  */
>> struct attribute_group nd_device_attribute_group =3D {
>> @@ -671,7 +671,7 @@ static umode_t nd_numa_attr_visible(struct =
kobject *kobj, struct attribute *a,
>>        return a->mode;
>> }
>>=20
>> -/**
>> +/*
>>  * nd_numa_attribute_group - NUMA attributes for all devices on an nd =
bus
>>  */
>=20
> Lets just fix this to be a valid kernel-doc format for a struct.
>=20
> @@ -672,7 +672,7 @@ static umode_t nd_numa_attr_visible(struct kobject
> *kobj, struct attribute *a,
> }
>=20
> /**
> - * nd_numa_attribute_group - NUMA attributes for all devices on an nd =
bus
> + * struct nd_numa_attribute_group - NUMA attributes for all devices
> on an nd bus
>  */
> struct attribute_group nd_numa_attribute_group =3D {
>        .attrs =3D nd_numa_attributes,

This won=E2=80=99t work because kernel-doc is to explain a struct =
definition, but this is a just an assignment.
The "struct attribute_group=E2=80=9D kernel-doc is in =
include/linux/sysfs.h.=
