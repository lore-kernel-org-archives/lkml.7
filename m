Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE3C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519D420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GteYQ77L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfHFD1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:27:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39806 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHFD1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:27:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so83117241qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 20:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7I+W1IHQoXT5wG6AmL/uplOOrHiM/gS299fH35smI2I=;
        b=GteYQ77LCE+NXYg+K4be284RsKS1h1ELviGK0SVws/hdbk8Fdkh2Nw9bZCAcgNioFe
         NjKyEUSuQbZ1NB88MRZbBeTB8ciGwJVaUxl+6HuOqH0xiq49WzSAn0qpTCeY6w9Faj3F
         oXbkZWMYN3kV0ralkzNxBlNqs03+hoYHwK28kRjSsmdz1/kziwXhF0c71rtnpWBA6pE+
         W+8BVTX1c2gf/qLtOF3JezTFjk7Lm0jIcMG9amp05PRI6UpGiF+u+njxfV0wT9tKqKYb
         7opepZB2hnAdfEOBFz91arf6uRQYeDnaxqfsXEEA/wEmWFRyf+XInMCaRU6lP0/lQRkL
         WYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7I+W1IHQoXT5wG6AmL/uplOOrHiM/gS299fH35smI2I=;
        b=nakx8AQgtBgHBQUf5Y40/D7ZOLqQj8POHROqTbnBuNHykNkfOxSAC/OZ4K7hJajTAG
         Ugdk8Psh3+NkE44DdfhueG/0sxrI42BovtwyOBQ9uVOwAzvwYROi7AoW6GumpLqXxzK+
         FRWV+x6C/HQYvhE8EHENYGh7CETtttC466nPEkm6qtdpGVl2DpK+ddIEl+y6KEs1sDZ7
         1x9OVy2cfU82AGtm5kllNCrBVVDUWVeTDFGrk7/CBzvS6o9wAqpUgseeWlrg7zxy/6x5
         x3vvHDlmTSX40YFniPd9+AdBZyGdR/a6q67B+2vRkbpgphN6fTdVbRiulCzxtn7fgtvZ
         NuSQ==
X-Gm-Message-State: APjAAAXQB9T5/rNLkzDSw+ORqtQ38ICOrs/SSVzybZPiEgktrbI8jbeC
        yUIkYoFUhgijNHoWX6apzo+Aeg==
X-Google-Smtp-Source: APXvYqxr9YCL08+FHp/K5Wy5t/sLEwyqKoNQgzetzS19x8cuoy4vyiAzic0dcnLG7XC4Dx5guujpsA==
X-Received: by 2002:ac8:35f6:: with SMTP id l51mr1190044qtb.109.1565062054968;
        Mon, 05 Aug 2019 20:27:34 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m5sm35790115qke.25.2019.08.05.20.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 20:27:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] scsi/megaraid_sas: fix a compilation warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <1564151143-22889-1-git-send-email-cai@lca.pw>
Date:   Mon, 5 Aug 2019 23:27:32 -0400
Cc:     jejb@linux.ibm.com, Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B961A6AE-2377-406C-891D-4363DCD9827C@lca.pw>
References: <1564151143-22889-1-git-send-email-cai@lca.pw>
To:     martin.petersen@oracle.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Please take a look at this trivial patch.

> On Jul 26, 2019, at 10:25 AM, Qian Cai <cai@lca.pw> wrote:
>=20
> The commit de516379e85f ("scsi: megaraid_sas: changes to function
> prototypes") introduced a comilation warning due to it changed the
> function prototype of read_fw_status_reg() to take an instance pointer
> instead, but forgot to remove an unused variable.
>=20
> drivers/scsi/megaraid/megaraid_sas_fusion.c: In function
> 'megasas_fusion_update_can_queue':
> drivers/scsi/megaraid/megaraid_sas_fusion.c:326:39: warning: variable
> 'reg_set' set but not used [-Wunused-but-set-variable]
>  struct megasas_register_set __iomem *reg_set;
>                                       ^~~~~~~
> Fixes: de516379e85f ("scsi: megaraid_sas: changes to function =
prototypes")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c =
b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index a32b3f0fcd15..e8092d59d575 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -323,9 +323,6 @@ inline void megasas_return_cmd_fusion(struct =
megasas_instance *instance,
> {
> 	u16 cur_max_fw_cmds =3D 0;
> 	u16 ldio_threshold =3D 0;
> -	struct megasas_register_set __iomem *reg_set;
> -
> -	reg_set =3D instance->reg_set;
>=20
> 	/* ventura FW does not fill outbound_scratch_pad_2 with queue =
depth */
> 	if (instance->adapter_type < VENTURA_SERIES)
> --=20
> 1.8.3.1
>=20

