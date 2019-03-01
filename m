Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54103C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA8120848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpUZjUNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfCATvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:51:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCATvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:51:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so11900451pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TIeh58av+oczFebD9H/A96Nf5dNjFu0r9dI+Pf1oUbI=;
        b=JpUZjUNaB58YJC+3yf7Rvi1U2QyP5U3ckMzUaWlThgwaGwmU6MM+bPRSc4FJ4nSVc2
         qntywIXY3Jr0IU4JV7We/rFPz08P0KSZ/9HsgkHOYZhAW1/Str5nuAJl2MIDJI+LC+LW
         92v4P6IkyQdsWvoFcn4ultko41I2NpQbL4ygxzGgmUwoCPlGLcQYOk8rv9YsC0I5g3Q/
         +2F2uCvm1CSiRq/x/N8bJKHwwbYlvDmLNrxESJ3eMd+8zH1Q/rSfc0gSSImCzEn5YR7D
         4PtS0dpsT/0PGjcSdgEEzDatktM7HtJOGSOsrp4wLT2Pz/Qtp1BgYmsaL+ET3dF2UAvt
         7f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIeh58av+oczFebD9H/A96Nf5dNjFu0r9dI+Pf1oUbI=;
        b=N5D0Clafg8ohwzp7kXOMGKyk1ffuBbUCqORuzGBP+O13ojAgnNdoEnM/k57AtP+gZY
         IrIw1P9o3lBhrLqyCa0YM0HD7s0y3ZxvvDQnyesKX1YmhP7jmbcOwelYR9bzSObPw/Xy
         8YOxMpFsBuyBvsOZRbA7Rr45BvTiTbsWCGZ9M2AJfnKQYWLm4JIKN0+2LHPxCu1G7CXd
         tQjjOhqkPAAPyzYEZmUAn9keaxgFOV+T1flsMr+efb+Q/d77DuYMC92V2u8djTidoAku
         NmBnmJEAkXLnLxcZlUzURq7jqW1Jxoi7ktAb5QWjHmZE/lPMtLPEXcX0zCX+w10Y2tB8
         d09A==
X-Gm-Message-State: APjAAAUH8alcGk2BFKTNLAQEwALFwPG3w0o920CG06D9qk5U8wNCWi2O
        IIyGit3DlT/x2Gp8As0XyRaL6g==
X-Google-Smtp-Source: AHgI3IYO0/yGzuTaZylvOmzk9OrhrZv6NMRUWCF+B6QcdBkNcMYvSomlJOCMDf8TyU7bpWU7firCUw==
X-Received: by 2002:a62:7602:: with SMTP id r2mr7215313pfc.191.1551469862175;
        Fri, 01 Mar 2019 11:51:02 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s4sm22457444pfe.16.2019.03.01.11.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 11:51:01 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:51:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v4 5/5] soc: qcom: socinfo: Expose image information
Message-ID: <20190301195140.GE27005@builder>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-6-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225065044.11023-6-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Feb 22:50 PST 2019, Vaishali Thakkar wrote:
> +#define IMAGE_SHOW_OEM(attr)						 \
> +static int show_ ##attr## _oem(struct seq_file *seq, void *p)		 \
> +{									 \
> +	struct smem_image_version *image_version = seq->private;	 \
> +	seq_puts(seq, image_version->oem);				 \
> +	seq_puts(seq, "\n");						 \
> +	return 0;							 \
> +}									 \
> +static int open_ ##attr## _oem(struct inode *inode, struct file *file)	 \
> +{									 \
> +	return single_open(file, show_ ##attr## _oem, inode->i_private); \
> +}									 \
> +									 \
> +static const struct file_operations qcom_ ##attr## _oem_ops = {		 \
> +	.open = open_ ##attr## _oem,					 \
> +	.read = seq_read,						 \
> +	.llseek = seq_lseek,						 \
> +	.release = single_release,					 \
> +}
> +
> +#define DEBUGFS_IMAGE_OEM(fname, attr, index)				 \
> +debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	 \
> +		    &smem_image_version[index], &qcom_ ##attr## _oem_ops)
> +
> +#define IMAGE_SHOW(name)	  \
> +	IMAGE_SHOW_NAME(name);    \
> +	IMAGE_SHOW_VARIANT(name); \
> +	IMAGE_SHOW_OEM(name)	  \
> +
> +IMAGE_SHOW(boot);

Given that you pass &smem_image_version[index] as "data" it seems that
these instances will only differ in the function name. So you should be
able to have one set of these functions to handle all the images.

> +IMAGE_SHOW(tz);
> +IMAGE_SHOW(rpm);
> +IMAGE_SHOW(apps);
> +IMAGE_SHOW(mpss);
> +IMAGE_SHOW(adsp);
> +IMAGE_SHOW(cnss);
> +IMAGE_SHOW(video);
> +

Regards,
Bjorn
