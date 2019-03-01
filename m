Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B302C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3121C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f733MznZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCATmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:42:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfCATmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:42:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so11918629pgd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Y1dXKIdcDRHKlZKO/DO+DfTFCqmKYo0R7wnYH7c+6Y=;
        b=f733MznZz6Tj/j68uuaTVUa4Ahb1qK7hS34ZlxIj3RuHaVfkvdbZtCh/kdYiA/4S27
         /NTBnvXm6oNxAeSvxkJ5EUP5/LeYTvV1IJLV7zDAKRb7e8DWuX8EBVfdfLHOIRB9rTo1
         hmvjFPDZXrRxWFeoTpyMiABBYwJz2h5OpWH8O/YIXyMYDWKBS6zW8XL8VqkJ7zeRUCu9
         4Tw/SEENbRdSxI/7gUowjIZ/Kngy2iZgqvkrNEjWbt3/+hRdBaMgBi6Na9cq6DfSm4hx
         wfScpuF9bHGJ9CKcGbAlhHG99t9HDNAelqXaSSUIeCHKJ4krZYpQCBd87QpDehtd8EpV
         hfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Y1dXKIdcDRHKlZKO/DO+DfTFCqmKYo0R7wnYH7c+6Y=;
        b=IA2mM+OHrOH6p1v2HbMXz/CiRxAKEEjtrzrhRS5fITSTY0YZlN4Um0I3fuccm8y/Pe
         eL12MN2dIaUGhCaHSHi+a/pCHxk+c8ZllBnPolK6npRjSEqMcU9BCNtANJc9mqFVG5/1
         6m+jnTow1YbauXSE+9gehTJKDfYn77dOhLSmY297+yF3cxHXwtlTZnqMkvykUD669dqb
         F19bvxVa89X5L46sG/FnpPxLoWUlVJmjhHdQYSfwwqHR4aHaGPuJjBtCX7gkD1qxzm6w
         ZFdTBBfVMAAJteK18pS4e87lLwr2PIVN4qWo/HPYv82VVyaG/a56Nnu1hwZH+FHeIqyL
         /MoQ==
X-Gm-Message-State: APjAAAW4hnW1eIrd8CQNYVC3Rm36zFO6RiiejJ9VPakJNeLwjM7EKw/0
        Nssb1lZ8sv42p/mkPsBNf8TQAA==
X-Google-Smtp-Source: AHgI3Iazxi2cIktO6kBp9OV4nPr/tp5OI+rCvumqrQCDUERiVBVEugHWSSwvYg29/S5EghEWLXiQGQ==
X-Received: by 2002:a62:5444:: with SMTP id i65mr7404090pfb.193.1551469330720;
        Fri, 01 Mar 2019 11:42:10 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x23sm24168750pgf.10.2019.03.01.11.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 11:42:09 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:42:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190301194249.GD27005@builder>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-5-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225065044.11023-5-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Feb 22:50 PST 2019, Vaishali Thakkar wrote:

> +#ifdef CONFIG_DEBUG_FS
> +/* pmic model info */

Please drop this comment and make "pmic_model" plural.

> +static const char *const pmic_model[] = {
> +	[0]  = "Unknown PMIC model",
> +	[9]  = "PM8994",
> +	[11] = "PM8916",
> +	[13] = "PM8058",
> +	[14] = "PM8028",
> +	[15] = "PM8901",
> +	[16] = "PM8027",
> +	[17] = "ISL9519",
> +	[18] = "PM8921",
> +	[19] = "PM8018",
> +	[20] = "PM8015",
> +	[21] = "PM8014",
> +	[22] = "PM8821",
> +	[23] = "PM8038",
> +	[24] = "PM8922",
> +	[25] = "PM8917",
> +};
> +#endif /* CONFIG_DEBUG_FS */
[..]
> +static int qcom_show_pmic_model(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +	int model = SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
> +
> +	if (model < 0)
> +		return -EINVAL;

You need to deal with the fact that model might be >=
ARRAY_SIZE(pmic_model) and that pmic_mode[model] might be NULL, in the
event that you missed entries in the list or this driver is used on
newer platforms.

> +
> +	seq_printf(seq, "%s\n", pmic_model[model]);
> +
> +	return 0;
> +}
> +
> +static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
> +{
> +	struct socinfo *socinfo = seq->private;
> +
> +	seq_printf(seq, "%u.%u\n",
> +		   SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
> +		   SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
> +
> +	return 0;
> +}
> +
> +UINT_SHOW(raw_version, raw_ver);
> +UINT_SHOW(hardware_platform, hw_plat);
> +UINT_SHOW(platform_version, plat_ver);
> +UINT_SHOW(foundry_id, foundry_id);
> +HEX_SHOW(chip_family, chip_family);
> +HEX_SHOW(raw_device_family, raw_device_family);
> +HEX_SHOW(raw_device_number, raw_device_num);
> +QCOM_OPEN(build_id, qcom_show_build_id);
> +QCOM_OPEN(accessory_chip, qcom_show_accessory_chip);
> +QCOM_OPEN(pmic_model, qcom_show_pmic_model);
> +QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
> +QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
> +
> +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
> +{
> +	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
> +
> +	DEBUGFS_UINT_ADD(raw_version);
> +	DEBUGFS_UINT_ADD(hardware_platform);

Note that the content of struct socinfo has grown over time, so based on
the comments in the struct the size of the struct would not cover
hw_plat if version < 3.

So you should make the addition of these conditional on socinfo->ver.
As each version adds more entries I suggest that you do this with a:

switch (qcom_socinfo->socinfo->ver) {
case 12:
	add v12 entries;
case 11:
	add v11 entries;
case 10:
	add v10 entries;
...
};

> +	DEBUGFS_UINT_ADD(platform_version);
> +	DEBUGFS_UINT_ADD(foundry_id);
> +	DEBUGFS_HEX_ADD(chip_family);
> +	DEBUGFS_HEX_ADD(raw_device_family);
> +	DEBUGFS_HEX_ADD(raw_device_number);
> +	DEBUGFS_ADD(build_id);
> +	DEBUGFS_ADD(accessory_chip);
> +	DEBUGFS_ADD(pmic_model);
> +	DEBUGFS_ADD(platform_subtype);
> +	DEBUGFS_ADD(pmic_die_revision);
> +}
> +

Regards,
Bjorn
