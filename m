Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA515C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07BF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmmSqETE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfC0Ee1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:34:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36631 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0Ee1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:34:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so9326566pgr.3;
        Tue, 26 Mar 2019 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toSWhE00Xr0/wIvSa3qttgpNCiF6Z0j0KVMIBMwT5OM=;
        b=QmmSqETEMHbM1JREaB4QowN34jTM5i4400FzbiZibHEZ704PiR2FzBIi5Wh5kozJlz
         giiSqhJM8jOvirRHciIep9K4VkevQsof1ooNHySH417IIeXqmie3nUVhD5v6ZFKRMarS
         YlE93gBG4pVjlxU65e31fJB8Ewg9AMpa6QCxrP/62KjFe74nUCeImdCw2jVjHf3dHXEx
         7++STjH+T7nY/fnmhNWeOKUZk7wWAAW675ZQGbPP4qTx86TxiMdgow69z6jKc2V20DmJ
         /XBc8oEc3An0JLr+OltT7n8yKsIO0b6acsuIuYeggqSqS5iDPgk4Rw184nISGnGVD1E9
         G8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toSWhE00Xr0/wIvSa3qttgpNCiF6Z0j0KVMIBMwT5OM=;
        b=rbI+2ng7SQPm7ZTY7HcTaJEKa/OGvD3rfHQqTCs5rJ2dUy+hlF/600A9tvNBii2H6L
         4Ndhp8wW5+Ws7+u+7mLv69tTMVwsnUJNRSDG3PlTzPwpqt2rh1NqqIYmnXmUxo5yc4FK
         moopqtlelLD4saM23HNWRhhJK5TiuavLlRS1XkLPaO0UweJbEeoZQEkiLHhquX8rb/pY
         CTe/TfDY/MswKxf+g+apLePYNywOlfHCcftPvSzuSsP/KX0Bi/E+aNkIk451OPJL+NgY
         webL15avAqDWfK3+aUTMrfaCNr+XAnYzZFIf7xid8KnqaQ7/k9Uhhz1eFa9eRda4G/+B
         gdQQ==
X-Gm-Message-State: APjAAAXxbZy+hp3QwBZwkBblAVXcH/pVlvLJ0W86xeXHbW+RLMnYV36P
        TBxCyp+KCaUv6HtvS9YDpTk=
X-Google-Smtp-Source: APXvYqyAMPE97OtFW/ft1FNU++reN6FcVpz3BEu11fB11JfgrNP1a3ayiy7Fw2ExpQ4yTMXmfAYa5A==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr17884011pff.35.1553661266355;
        Tue, 26 Mar 2019 21:34:26 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e14sm30698119pga.61.2019.03.26.21.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 21:34:25 -0700 (PDT)
Date:   Tue, 26 Mar 2019 21:34:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     KT Liao <kt.liao@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ulrik.debie-os@e2big.org, Roger.Whittaker@suse.com
Subject: Re: [PATCH] Input: elan_i2c - Add i2c_reset in sysfs for ELAN
 touchpad recovery
Message-ID: <20190327043423.GD40550@dtor-ws>
References: <1549094096-4082-1-git-send-email-kt.liao@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549094096-4082-1-git-send-email-kt.liao@emc.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KT,

On Sat, Feb 02, 2019 at 03:54:56PM +0800, KT Liao wrote:
> Roger from SUSE reported the touchpad on Lenovo yoga2 crush sometimes.
> He found that rmmod/modprobe elan_i2c will recover the issue.
> He add the workaround on SUSE and solve the problem.
> Recently, the workaround fails in kernel 4.20 becasue IRQ mismatch.
> genirq: Flags mismatch irq 0. 00002002 (ELAN0600:00) vs. 00015a00 (timer)
> I can't reproduce the issue in SUSE with the same kernel.
> And it's a 5 years old laptop, ELAN can't find the module for testing.
> Instead of IRQ debugging IRQ, I tried another approach.
> I added i2c_reset in sysfs to avoid IRQ requesting in probe.

How will users discover this flag? I do not think this is the best
approach. Can we detect that the touchpad firmware crashed from the
kernel and reset automatically?

Thanks.

> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> Acked-by: Roger Whittaker <Roger.Whittaker@suse.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 2690a4b..388b1f0 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -670,6 +670,29 @@ static ssize_t calibrate_store(struct device *dev,
>  	return retval ?: count;
>  }
>  
> +static ssize_t i2c_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct elan_tp_data *data = i2c_get_clientdata(client);
> +	int retval;
> +
> +	retval = mutex_lock_interruptible(&data->sysfs_mutex);
> +	if (retval)
> +		return retval;
> +
> +	disable_irq(client->irq);
> +
> +	retval = elan_initialize(data);
> +	if (retval)
> +		dev_err(dev, "failed to re-initialize touchpad: %d\n", retval);
> +
> +	enable_irq(client->irq);
> +	mutex_unlock(&data->sysfs_mutex);
> +	return retval ?: count;
> +}
> +
>  static ssize_t elan_sysfs_read_mode(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
> @@ -702,6 +725,7 @@ static DEVICE_ATTR(mode, S_IRUGO, elan_sysfs_read_mode, NULL);
>  static DEVICE_ATTR(update_fw, S_IWUSR, NULL, elan_sysfs_update_fw);
>  
>  static DEVICE_ATTR_WO(calibrate);
> +static DEVICE_ATTR_WO(i2c_reset);
>  
>  static struct attribute *elan_sysfs_entries[] = {
>  	&dev_attr_product_id.attr,
> @@ -710,6 +734,7 @@ static struct attribute *elan_sysfs_entries[] = {
>  	&dev_attr_iap_version.attr,
>  	&dev_attr_fw_checksum.attr,
>  	&dev_attr_calibrate.attr,
> +	&dev_attr_i2c_reset.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_update_fw.attr,
>  	NULL,
> -- 
> 2.7.4
> 

-- 
Dmitry
