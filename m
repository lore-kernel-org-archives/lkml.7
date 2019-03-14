Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AF3217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0NzHasW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfCNLZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:25:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38214 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCNLZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:25:28 -0400
Received: by mail-io1-f65.google.com with SMTP id v4so3689957ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tl12S5A0bYl2gsUIG24KL6UulAl78iVVb8K1SJX8F1k=;
        b=A0NzHasWp5rD0t7eam+XtHjzjhlPJgrM3PuF7aKA6++oYGVdG49FTdmqs3RLMK+/pG
         MoDcYlHpTTdWmswT2b1Ur1q1PhT34I51JT1tcS8ntwFnEUerZeJTIPurcQhvz2vAUAeh
         GeKQ2WcINiTj04eHuyy0PEudPHhOZrQyzhFV151IbHaXnebmvGMGPodWLArv7m7JwH8y
         TrFwEoqOG5bggKCgX+6lrM5extExoDY3kKDJWxx/eYfQ0U5I4FGhjow8A6+z+FzO/1mn
         +d1ItRzrpZiGAkagxj/t9mWjYuDdmRpVc6QD9tAPahOovPow3Lct5BMIrGkAzHtqZdFG
         5Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl12S5A0bYl2gsUIG24KL6UulAl78iVVb8K1SJX8F1k=;
        b=RMPCsSHQMLNkgcL+hJlK55Y8V7AAtZxwSn7PnJHKFMlgQ2/w7PZ1+FZm2vJ/cP67Ww
         VDl5xTBGIAaNYvgaekii8p+r6O87Y6np3cy6o+GFSuf0Cx7v/vO4ebg/dxDu6Mmf7l8E
         0dF7QTmWiBOjEzO7AFRr/bt3zqv9fDO5/hXiiD6E7AF3qUTn1M3yd4IiO/6h3M6gThRJ
         8I35BUVGcTfm7mIg/Ajw38c/ShCTH6u2yOiCGyz6UtFXLBB2ZhX0X8abkNnC018PVW5V
         +VBND+rPwqOnsV1phmpI8rcs0eidBl4LJ5+yq+L7E2G0noGiyJJgV/3nDlc3h30LRZI0
         vjuA==
X-Gm-Message-State: APjAAAXxDwbh4qXKy8fTHy3POR2wqXpVjZkCGdYtO16ej/T5LDw1n9lb
        spsaXCewdl/+vJS6wGnFoYm9V8dyRi3zfM2o9LD1VFolJm8=
X-Google-Smtp-Source: APXvYqwBzEoCI7U7T3osZs/DZQHBPlXkYU2fWQnDqzEeRowCiRl9lAifDOTmYR7N0dZ8baX50luMhh4jGIybeJfmhrk=
X-Received: by 2002:a6b:e705:: with SMTP id b5mr16142105ioh.73.1552562727087;
 Thu, 14 Mar 2019 04:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com>
In-Reply-To: <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com>
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
Date:   Thu, 14 Mar 2019 16:55:16 +0530
Message-ID: <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 at 03:02, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Vaishali Thakkar (2019-02-24 22:50:43)
> > diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> > index 02078049fac7..ccadeba69a81 100644
> > --- a/drivers/soc/qcom/socinfo.c
> > +++ b/drivers/soc/qcom/socinfo.c
> > @@ -70,6 +93,10 @@ struct socinfo {
> >  struct qcom_socinfo {
> >         struct soc_device *soc_dev;
> >         struct soc_device_attribute attr;
> > +#ifdef CONFIG_DEBUG_FS
> > +       struct dentry *dbg_root;
> > +#endif /* CONFIG_DEBUG_FS */
> > +       struct socinfo *socinfo;
>
> This doesn't look necessary, instead just pass it through to the
> functions that need the pointer.
>
> >  };
> >
> >  struct soc_of_id {
> > @@ -133,6 +160,171 @@ static const char *socinfo_machine(struct device *dev, unsigned int id)
> >         return NULL;
> >  }
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +#define UINT_SHOW(name, attr)                                          \
> > +static int qcom_show_##name(struct seq_file *seq, void *p)             \
> > +{                                                                      \
> > +       struct socinfo *socinfo = seq->private;                         \
> > +       seq_printf(seq, "%u\n", le32_to_cpu(socinfo->attr));            \
> > +       return 0;                                                       \
> > +}                                                                      \
> > +static int qcom_open_##name(struct inode *inode, struct file *file)    \
> > +{                                                                      \
> > +       return single_open(file, qcom_show_##name, inode->i_private);   \
> > +}                                                                      \
> > +                                                                       \
> > +static const struct file_operations qcom_ ##name## _ops = {            \
> > +       .open = qcom_open_##name,                                       \
> > +       .read = seq_read,                                               \
> > +       .llseek = seq_lseek,                                            \
> > +       .release = single_release,                                      \
> > +}
>
> Why can't we use the debugfs_create_u32 function? It would make things
> clearer if there was either a debugfs_create_le32() function or if the
> socinfo structure stored in smem was unmarshalled from little endian
> to the cpu native endian format during probe time and then all the rest
> of the code can treat it as a native endian u32 values.

Thanks for the review. I've worked on the next version with all the
changes you suggested in the patchset but I'm kind of not sure
what would be the best solution in this case.

I'm bit skeptical about introducing debugfs_create_le32 as we don't
really have any endian specific functions in the debugfs core at the
moment. And if I do that, should I also introduce debugfs_create_be32
[and to an extent debugfs_create_le{16,64}]? More importantly, would
it be useful to introduce them in core?

In the case of converting it to cpu native during probe, I'll need to
declare an extra struct with u32 being the parsed version for it to be
correct. Wouldn't it add extra overhead?

> > +
> > +#define DEBUGFS_UINT_ADD(name)                                         \
> > +       debugfs_create_file(__stringify(name), 0400,                    \
> > +                           qcom_socinfo->dbg_root,                     \
> > +                           qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> > +
> > +#define HEX_SHOW(name, attr)                                           \
> > +static int qcom_show_##name(struct seq_file *seq, void *p)             \
> > +{                                                                      \
> > +       struct socinfo *socinfo = seq->private;                         \
> > +       seq_printf(seq, "0x%x\n", le32_to_cpu(socinfo->attr));          \
>
> Use "%#x\n" format?
>
> > +       return 0;                                                       \
> > +}                                                                      \
> > +static int qcom_open_##name(struct inode *inode, struct file *file)    \
> > +{                                                                      \
> > +       return single_open(file, qcom_show_##name, inode->i_private);   \
> > +}                                                                      \
> > +                                                                       \
> > +static const struct file_operations qcom_ ##name## _ops = {            \
> > +       .open = qcom_open_##name,                                       \
> > +       .read = seq_read,                                               \
> > +       .llseek = seq_lseek,                                            \
> > +       .release = single_release,                                      \
> > +}
> > +
> > +#define DEBUGFS_HEX_ADD(name)                                          \
> > +       debugfs_create_file(__stringify(name), 0400,                    \
> > +                           qcom_socinfo->dbg_root,                     \
> > +                           qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> > +
> > +
> > +#define QCOM_OPEN(name, _func)                                         \
> > +static int qcom_open_##name(struct inode *inode, struct file *file)    \
> > +{                                                                      \
> > +       return single_open(file, _func, inode->i_private);              \
> > +}                                                                      \
> > +                                                                       \
> > +static const struct file_operations qcom_ ##name## _ops = {            \
> > +       .open = qcom_open_##name,                                       \
> > +       .read = seq_read,                                               \
> > +       .llseek = seq_lseek,                                            \
> > +       .release = single_release,                                      \
> > +}
> > +
> > +#define DEBUGFS_ADD(name)                                              \
> > +       debugfs_create_file(__stringify(name), 0400,                    \
> > +                           qcom_socinfo->dbg_root,                     \
> > +                           qcom_socinfo->socinfo, &qcom_ ##name## _ops)
> > +
> > +
> > +static int qcom_show_build_id(struct seq_file *seq, void *p)
> > +{
> > +       struct socinfo *socinfo = seq->private;
> > +
> > +       seq_printf(seq, "%s\n", socinfo->build_id);
> > +
> > +       return 0;
> > +}
> > +
> > +static int qcom_show_accessory_chip(struct seq_file *seq, void *p)
> > +{
> > +       struct socinfo *socinfo = seq->private;
> > +
> > +       seq_printf(seq, "%d\n", le32_to_cpu(socinfo->accessory_chip));
> > +
> > +       return 0;
> > +}
> > +
> > +static int qcom_show_platform_subtype(struct seq_file *seq, void *p)
> > +{
> > +       struct socinfo *socinfo = seq->private;
> > +       int subtype = le32_to_cpu(socinfo->hw_plat_subtype);
> > +
> > +       if (subtype < 0)
> > +               return -EINVAL;
>
> Can it ever be negative? Why is it assigned to int type at all?
>
> > +
> > +       seq_printf(seq, "%u\n", subtype);
>
> And then we print it as an unsigned value? Why not use %d to match the
> type?
>
> > +
> > +       return 0;
> > +}
> > +
> > +static int qcom_show_pmic_model(struct seq_file *seq, void *p)
> > +{
> > +       struct socinfo *socinfo = seq->private;
> > +       int model = SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
> > +
> > +       if (model < 0)
> > +               return -EINVAL;
> > +
> > +       seq_printf(seq, "%s\n", pmic_model[model]);
>
> Is there a debugfs_create_file_string()?
>
> > +
> > +       return 0;
> > +}
> > +
> > +static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
> > +{
> > +       struct socinfo *socinfo = seq->private;
> > +
> > +       seq_printf(seq, "%u.%u\n",
> > +                  SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
> > +                  SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
> > +
> > +       return 0;
> > +}
> > +
