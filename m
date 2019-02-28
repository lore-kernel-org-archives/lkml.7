Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18546C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE78220857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MAac8nvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfB1VcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:32:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43776 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfB1VcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:32:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so10319577pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:to:subject
         :message-id:references:from:cc:user-agent:date;
        bh=D1h9ezFO3KPZCHArKSsAZm/MhqFHuOM//IIWptMUdNQ=;
        b=MAac8nvzITEjdgwprFXnmCVFB5w062wjvqpzuenii2V/uYZ1GMUZRLF0RY3Z1BEk8L
         DPDu7UrTStm39s66YvmOaigpxJBJrHMS/0+s/6BWe1EZChpwbZU08rCOsZ4moQUGLBPm
         0hSHxEpc1UihBSwxAn8J0RWIk/waDAfoi3nuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:to:subject:message-id:references:from:cc:user-agent
         :date;
        bh=D1h9ezFO3KPZCHArKSsAZm/MhqFHuOM//IIWptMUdNQ=;
        b=r3JfCL/Awkqufb/a1TgLo8oY8wp3kxap5bE6LXIrMrHZ/0IRmNAV8PktivU0HJgDlW
         V/VsvC1cl1NqxAzihosmkvGnPSJH3i/OfWCurdFz0Sr9Ayzdsk2OtLCWThgKfHY9Ayyi
         d5k/OJEGe/rf8R0cUOj9fE8Uwbcc82UNX9CbE2/Wmgsfh1z5zGWaDH4tLihD0x3bkMPo
         ApSeuGF/rCBVtALNQzZInRjB19DrpoZUcoUJ9w7er48gF7fN953mr84VV3y1SOdiEJ1R
         YUO9rpkDax5CskDGCNglkmV34vj4dSmh1463KVa6wjeAvlWYpB33ofsV9hVxv6haKvaO
         GJeQ==
X-Gm-Message-State: APjAAAWn2o3+bBP7WIHKFqLv2gWzFK5PspTzcK2Bs//LUJ2wUreAOunc
        Tn7ld6B3+YjtqgWfvfI6c5KVDA==
X-Google-Smtp-Source: APXvYqx+p9FOuqwj4wZrML0/l6+GL30bFgz4k1t5yO2F8cx3nI8N6hVY5Tv+/TgpcFzo+U9NvGhR1Q==
X-Received: by 2002:a62:f598:: with SMTP id b24mr1790754pfm.72.1551389539529;
        Thu, 28 Feb 2019 13:32:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i126sm10857571pfb.15.2019.02.28.13.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 13:32:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190225065044.11023-5-vaishali.thakkar@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-5-vaishali.thakkar@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
User-Agent: alot/0.8
Date:   Thu, 28 Feb 2019 13:32:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-02-24 22:50:43)
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 02078049fac7..ccadeba69a81 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -70,6 +93,10 @@ struct socinfo {
>  struct qcom_socinfo {
>         struct soc_device *soc_dev;
>         struct soc_device_attribute attr;
> +#ifdef CONFIG_DEBUG_FS
> +       struct dentry *dbg_root;
> +#endif /* CONFIG_DEBUG_FS */
> +       struct socinfo *socinfo;

This doesn't look necessary, instead just pass it through to the
functions that need the pointer.

>  };
> =20
>  struct soc_of_id {
> @@ -133,6 +160,171 @@ static const char *socinfo_machine(struct device *d=
ev, unsigned int id)
>         return NULL;
>  }
> =20
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define UINT_SHOW(name, attr)                                          \
> +static int qcom_show_##name(struct seq_file *seq, void *p)             \
> +{                                                                      \
> +       struct socinfo *socinfo =3D seq->private;                        =
 \
> +       seq_printf(seq, "%u\n", le32_to_cpu(socinfo->attr));            \
> +       return 0;                                                       \
> +}                                                                      \
> +static int qcom_open_##name(struct inode *inode, struct file *file)    \
> +{                                                                      \
> +       return single_open(file, qcom_show_##name, inode->i_private);   \
> +}                                                                      \
> +                                                                       \
> +static const struct file_operations qcom_ ##name## _ops =3D {           =
 \
> +       .open =3D qcom_open_##name,                                      =
 \
> +       .read =3D seq_read,                                              =
 \
> +       .llseek =3D seq_lseek,                                           =
 \
> +       .release =3D single_release,                                     =
 \
> +}

Why can't we use the debugfs_create_u32 function? It would make things
clearer if there was either a debugfs_create_le32() function or if the
socinfo structure stored in smem was unmarshalled from little endian
to the cpu native endian format during probe time and then all the rest
of the code can treat it as a native endian u32 values.

> +
> +#define DEBUGFS_UINT_ADD(name)                                         \
> +       debugfs_create_file(__stringify(name), 0400,                    \
> +                           qcom_socinfo->dbg_root,                     \
> +                           qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> +
> +#define HEX_SHOW(name, attr)                                           \
> +static int qcom_show_##name(struct seq_file *seq, void *p)             \
> +{                                                                      \
> +       struct socinfo *socinfo =3D seq->private;                        =
 \
> +       seq_printf(seq, "0x%x\n", le32_to_cpu(socinfo->attr));          \

Use "%#x\n" format?

> +       return 0;                                                       \
> +}                                                                      \
> +static int qcom_open_##name(struct inode *inode, struct file *file)    \
> +{                                                                      \
> +       return single_open(file, qcom_show_##name, inode->i_private);   \
> +}                                                                      \
> +                                                                       \
> +static const struct file_operations qcom_ ##name## _ops =3D {           =
 \
> +       .open =3D qcom_open_##name,                                      =
 \
> +       .read =3D seq_read,                                              =
 \
> +       .llseek =3D seq_lseek,                                           =
 \
> +       .release =3D single_release,                                     =
 \
> +}
> +
> +#define DEBUGFS_HEX_ADD(name)                                          \
> +       debugfs_create_file(__stringify(name), 0400,                    \
> +                           qcom_socinfo->dbg_root,                     \
> +                           qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> +
> +
> +#define QCOM_OPEN(name, _func)                                         \
> +static int qcom_open_##name(struct inode *inode, struct file *file)    \
> +{                                                                      \
> +       return single_open(file, _func, inode->i_private);              \
> +}                                                                      \
> +                                                                       \
> +static const struct file_operations qcom_ ##name## _ops =3D {           =
 \
> +       .open =3D qcom_open_##name,                                      =
 \
> +       .read =3D seq_read,                                              =
 \
> +       .llseek =3D seq_lseek,                                           =
 \
> +       .release =3D single_release,                                     =
 \
> +}
> +
> +#define DEBUGFS_ADD(name)                                              \
> +       debugfs_create_file(__stringify(name), 0400,                    \
> +                           qcom_socinfo->dbg_root,                     \
> +                           qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> +
> +
> +static int qcom_show_build_id(struct seq_file *seq, void *p)
> +{
> +       struct socinfo *socinfo =3D seq->private;
> +
> +       seq_printf(seq, "%s\n", socinfo->build_id);
> +
> +       return 0;
> +}
> +
> +static int qcom_show_accessory_chip(struct seq_file *seq, void *p)
> +{
> +       struct socinfo *socinfo =3D seq->private;
> +
> +       seq_printf(seq, "%d\n", le32_to_cpu(socinfo->accessory_chip));
> +
> +       return 0;
> +}
> +
> +static int qcom_show_platform_subtype(struct seq_file *seq, void *p)
> +{
> +       struct socinfo *socinfo =3D seq->private;
> +       int subtype =3D le32_to_cpu(socinfo->hw_plat_subtype);
> +
> +       if (subtype < 0)
> +               return -EINVAL;

Can it ever be negative? Why is it assigned to int type at all?

> +
> +       seq_printf(seq, "%u\n", subtype);

And then we print it as an unsigned value? Why not use %d to match the
type?

> +
> +       return 0;
> +}
> +
> +static int qcom_show_pmic_model(struct seq_file *seq, void *p)
> +{
> +       struct socinfo *socinfo =3D seq->private;
> +       int model =3D SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
> +
> +       if (model < 0)
> +               return -EINVAL;
> +
> +       seq_printf(seq, "%s\n", pmic_model[model]);

Is there a debugfs_create_file_string()?

> +
> +       return 0;
> +}
> +
> +static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
> +{
> +       struct socinfo *socinfo =3D seq->private;
> +
> +       seq_printf(seq, "%u.%u\n",
> +                  SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
> +                  SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
> +
> +       return 0;
> +}
> +
