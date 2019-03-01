Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B89C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FCB20840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSsmg8nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbfCARAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:00:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36988 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389182AbfCARAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:00:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id q3so11761633pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=aTGNXZtZWrszMLPUL2OK6BWeWCHlT5fsDlsF0ZKNHr8=;
        b=SSsmg8nfyaAQEbgIvMyImPoDpLuDinHeF+M2WbV8wfj9g+8nbnML5dPGAj1kbR0CL4
         W+Q95KL5adoVctnXAkYQSoPM8WnBk/MJNxdxaYo4WlHGxm6+NhTRQwocimmJ/TRC5aTo
         ZXz47K6hdaWipv+9KFcfOJAhkD7WZUvMusuW/d2wsds2xsCft11AOiDREZqHHgfKCa8K
         kgz1biqznDOa1Cte/nkHjC38v0Pks0jqRTcKZGsOBTczEHnTAmYpBo1WgMjXUYAVfzjr
         eYYScuT/YUgkSe0sFjlm/n8H5DMtseBsmwCivBJr9e+pAKaigPDqf6vfvxS10wUIKnHF
         7IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=aTGNXZtZWrszMLPUL2OK6BWeWCHlT5fsDlsF0ZKNHr8=;
        b=YQJURClQ7s0CNZZ2q3HGZkrGGYJptKBNlgkCDr6lGynC20spUzxbLozPMzmByCbp3l
         9tj5SJTgK1U88XI6iwqG7eNoD3iFqr56Y/82DiL6Y/ZHzKMFZX0GAOyI8SU725m7J69t
         j8udd/wR1a0525dpJcbXvnab1kH0hp0uf5DPgwhEM2XF8cNx+k31Gm2m+VJo1ZJ74SCS
         iEkkeUGDisv7YfWCzj7icLazYVUWeTQ9PkFuOT0e7D49y914Q6fG0s0sfZEpiWEQtmaU
         ZqO9niPO+9ZKnmwZigv/KNX44vB3GIbjHzy+ylA3oSVxuEIwEMC8dKkTf9ffq5sHU0h2
         +KHQ==
X-Gm-Message-State: APjAAAWWC626NcmcoqMoiwTGnpKxnaTdZFE738ANb8sTqo6NNjFLofm8
        iqPH+Ieu8Dh1wmhzi1pnkEE=
X-Google-Smtp-Source: APXvYqwpbZEI2rK7mN5XRKEDbxdhi8vayufxK8A3TbZL47w6frJOiJqZsbRJDW9blODUHfYutEgSDw==
X-Received: by 2002:a17:902:2903:: with SMTP id g3mr6357893plb.222.1551459608471;
        Fri, 01 Mar 2019 09:00:08 -0800 (PST)
Received: from ikegamiPC (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.gmail.com with ESMTPSA id n1sm54935115pfi.123.2019.03.01.09.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:00:07 -0800 (PST)
From:   "Tokunori Ikegami" <ikegami.t@gmail.com>
To:     "'Vignesh Raghavendra'" <vigneshr@ti.com>,
        "'Boris Brezillon'" <boris.brezillon@collabora.com>,
        "'liujian \(CE\)'" <liujian56@huawei.com>
Cc:     "'Tokunori Ikegami'" <ikegami.t@gmail.com>,
        <keescook@chromium.org>, <bbrezillon@kernel.org>,
        <ikegami@allied-telesis.co.jp>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com> <016001d4cf71$865e7b60$931b7220$@gmail.com> <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com> <20190228164228.734ede80@collabora.com> <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp> <4b3bc01a-3632-5dde-f683-94744ee7179d@ti.com>
In-Reply-To: <4b3bc01a-3632-5dde-f683-94744ee7179d@ti.com>
Subject: RE: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Date:   Sat, 2 Mar 2019 01:59:41 +0900
Message-ID: <000501d4d050$38eca160$aac5e420$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Content-Language: ja
Thread-Index: AQHOptjmAmqem5WpXlLpfOi8uScBsQIgzkq5Atg5CjYCPRAs9gF4c9/ZAXvgv0ulsf4HgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [...]
> >>>>> In function do_write_buffer(), in the for loop, there is a case
> >>>>> chip_ready() returns 1 while chip_good() returns 0, so it never =
break
> >>>>> the loop.
> >>>>> To fix this, chip_good() is enough and it should timeout if it =
stay
> >>>>> bad for a while.
> >>>>>
> >>>>> Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write buffer =
to
> >>>>> check correct value")
> >>>>> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> >>>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
> >>>>> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
> >>>>> ---
> >>>>> v2->v3:
> >>>>> Follow Vignesh's advice:
> >>>>> add one more check for check_good() even when time_after() =
returns
> >> true.
> >>>>>
> >>>>>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> >>>>> b/drivers/mtd/chips/cfi_cmdset_0002.c
> >>>>> index 72428b6..3da2376 100644
> >>>>> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> >>>>> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> >>>>> @@ -1876,7 +1876,7 @@ static int __xipram do_write_buffer(struct
> >>>>> map_info *map, struct flchip *chip,
> >>>>>  			continue;
> >>>>>  		}
> >>>>>
> >>>>> -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> >>>>> +		if (time_after(jiffies, timeo) && !chip_good(map, adr,
> >>>>> datum))
> >>>>
> >>>>   Just another idea to understand easily.
> >>>>
> >>>>     unsigned long now =3D jiffies;
> >>>>
> >>>>     if (chip_good(map, adr, datum)) {
> >>>>         xip_enable(map, chip, adr);
> >>>>         goto op_done;
> >>>>     }
> >>>>
> >>>>     if (time_after(now, timeo) {
> >>>>         break;
> >>>>     }
> >>>>
> >>>
> >>> Thank you~. It is more easier to understand=EF=BC=81
> >>> If there are no other comments, I will send new patch again ):
> >>
> >> Except this version no longer does what Vignesh suggested. See how =
you
> >> no longer test if chip_good() is true if time_after() returns true. =
So,
> >> imagine the thread entering this function is preempted just after =
the
> >> first chip_good() test, and resumed a few ms later. time_after() =
will
> >> return true, but chip_good() might also return true, and you ignore =
it.
> >
> > I think that the following 3 versions will be worked for =
time_after()
> as a same result and follow the Vignesh-san suggestion.
> >
>=20
> As Boris explained above version 3 does not really follow my
> suggestion... Please see below
>=20
> > 1. Original Vignesh-san suggestion
> >
> > 	if (chip_good(map, adr, datum)) {
> > 		xip_enable(map, chip, adr);
> > 		goto op_done;
> > 	}
> >
> > 	if (time_after(jiffies, timeo)) {
> > 		/* Test chip_good() if TRUE incorrectly again so write
> failure by time_after() can be avoided. */
> > 		if (chip_good(map, adr, datum)) {
> > 			xip_enable(map, chip, adr);
> > 			goto op_done;
> > 		}
> > 		break;
> > 	}
> >
>=20
>=20
> Right, here we check chip_good() once _even when time_after() is true_
> to avoid _spurious_ timeout
>=20
> > 2. Liujian-san v3 patch
> >
> > 	/* Test chip_good() if FALSE correctly so write failure by
> time_after() can be avoided. */
> > 	if (time_after(jiffies, timeo) && !chip_good(map, adr))
> > 		break;
> >
> > 	if (chip_good(map, adr, datum)) {
> > 		xip_enable(map, chip, adr);
> > 		goto op_done;
> > 	}
> >
>=20
> This is a better version of 1
>=20
> > 3. My idea
> >
> > 	/* Save current jiffies value before chip_good() to avoid write
> failure by time_after() without testing chip_good() again. */
> > 	unsigned long now =3D jiffies;
> >
> > 	if (chip_good(map, adr, datum)) {
> > 		xip_enable(map, chip, adr);
> > 		goto op_done;
> > 	}
> >
>=20
> What if thread gets pre-empted at this point and is re-scheduled =
exactly
> after timeo jiffies have elapsed? Below check would be true and exit =
loop

  I think that the jiffies value now is save before chip_good() so below =
check would be false and not exit loop.

Regards,
Ikegami

>=20
> > 	if (time_after(now, timeo))
> > 		break;
> >
>=20
> So, code does not check for check chip_good() after timeoout has
> elapsed. But chip_good() might be true at this point. Therefore =
leading
> to spurious timeout.  So this version is still not right.
>=20
> >           Note: Some brackets have been fixed from the previous =
mail.
> >
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

