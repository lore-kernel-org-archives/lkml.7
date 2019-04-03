Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67197C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307EB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ofL9xh8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDCMkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:40:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36777 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDCMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:40:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id k130so10012402qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B2LGbGNy82+HNqlZmbGsF3LJX7qAAyCm7XTnYaIPA3Q=;
        b=ofL9xh8b12klEZfKeIcN0jMmgPpksCAageVPDvPx8TGC6vDf5sLsiUerAnLm39Fzzs
         iwm+A1uyOCKc1rTlsSQpoXgc6DQGKvoI0/i2b5nxVrE0Tbjk7Tm2pixV6w0JcAHAG8FW
         IJwSrxUwf5D1mvbXVINWxYx++NKlopO7GncLicr3PwxKAyrKjMadJyOVXn+VM9e2Purq
         AbsGYEQsPtxWs/EuNaCNyz4qF9GT2w38iYs1plGdDgyhOyachclGd8MExcEHpoA0XmNu
         Rd6iGMwYVRu3n1KFkNpgaUlUiKI/hEWLitx0Sn234tW6tQFgMPXW/UH7+pX/mK2pq5Gw
         kA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2LGbGNy82+HNqlZmbGsF3LJX7qAAyCm7XTnYaIPA3Q=;
        b=kqaOkhPfNXobNJYNIBiYKCpXJmIcuE9lm37H1MIYj5cojOBDimXqozbZTbCpNIoelS
         JO/ClTKMQOKAGb5kHqQXR33jGtAhCagA8f8KTSluhKVTHWeLxrMQFMb9pXc3C+spdsKo
         S/hoAIJ4k0lSdPSdDkE+W9mDlUaGwsPdcu632BraZBQOEVu2p2LOZvbp6O6DSItj9gvR
         K3TDH2sBRiU75DV+VylV+fcW4OnWEZoSHfMsCZ7xed33xN8IaE8xcafGPjdHORWaBnM/
         D8R9WD1jijFIgMhCma8MbwZe2DStxmyTDTT9n7OUqrW4fPdWCSlY9rSYmY9K57GzFLiQ
         1EhA==
X-Gm-Message-State: APjAAAXnQoRvsEtwSW1yqJn00/A0fJMg48EJH2dN5hPCKXlxdxxCCleV
        n7b8SMevkfXOSqQs+9MgNct5bA==
X-Google-Smtp-Source: APXvYqx+OruPW09bIbJNgP6dxsH1k+8tutdF68NTl2EV2hpXUgfwkk52iDxPcUyP53YbtJnwWkHEjA==
X-Received: by 2002:a37:a656:: with SMTP id p83mr61877322qke.91.1554295246143;
        Wed, 03 Apr 2019 05:40:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id l6sm8731678qtd.0.2019.04.03.05.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 05:40:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hBfC8-00054G-Mn; Wed, 03 Apr 2019 09:40:44 -0300
Date:   Wed, 3 Apr 2019 09:40:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sasha Levin <sashal@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, linux-kernel@microsoft.com,
        bryankel@microsoft.com, thiruan@microsoft.com,
        suredd@microsoft.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190403124044.GA15230@ziepe.ca>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402193316.15144-2-sashal@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:33:16PM -0400, Sasha Levin wrote:

> +/*
> + * Undo what has been done in ftpm_tee_probe
> + */
> +static void ftpm_tee_deinit(struct ftpm_tee_private *pvt_data)
> +{
> +	/* Release the chip */
> +	if (pvt_data->state & STATE_REGISTERED_FLAG)
> +		tpm_chip_unregister(pvt_data->chip);
> +
> +	if (pvt_data->ctx != NULL)	{
> +
> +		/* Free the shared memory pool */
> +		if (pvt_data->state & STATE_TEE_SHMALLOC_FLAG)
> +			tee_shm_free(pvt_data->shm);
> +
> +		/* close the existing session with fTPM TA*/
> +		if (pvt_data->state & STATE_TEE_OPENED_FLAG)
> +			tee_client_close_session(pvt_data->ctx,
> +				pvt_data->session);
> +
> +		/* close the context with TEE driver */
> +		tee_client_close_context(pvt_data->ctx);
> +	}

all these flags are ugly, just use a normal goto unwind during probe
please


> +
> +	/* memory allocated with devm_kzalloc() is freed automatically */
> +}
> +
> +/*
> + * ftpm_tee_probe initialize the fTPM
> + * @param: pdev, the platform_device description.
> + * @return: 0 in case of success.
> + *	 or a negative value describing the error.
> + */
> +static int ftpm_tee_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct tpm_chip *chip;
> +	struct device *dev = &pdev->dev;
> +	struct ftpm_tee_private *pvt_data = NULL;
> +	struct tee_ioctl_open_session_arg sess_arg;
> +
> +	dev_dbg(dev, "%s++\n", __func__);

Please don't push tracing like this to the upstream kernel, we have
ftrace and what not to do this generally :(

> +	pvt_data = devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
> +				GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pvt_data);
> +
> +	/* Open context with TEE driver */
> +	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
> +						NULL);
> +	if (IS_ERR(pvt_data->ctx))	{
> +		dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/* Open a session with fTPM TA*/
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> +	sess_arg.num_params = 0;
> +
> +	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "%s:tee_client_open_session failed, err=%x\n",
> +			__func__, sess_arg.ret);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	pvt_data->session = sess_arg.session;
> +	pvt_data->state |= STATE_TEE_OPENED_FLAG;
> +
> +	/* Allocate dynamic shared memory with fTPM TA */
> +	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
> +				(MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE),
> +				TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	if (IS_ERR(pvt_data->shm)) {
> +		dev_err(dev, "%s:tee_shm_alloc failed\n", __func__);
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	pvt_data->state |= STATE_TEE_SHMALLOC_FLAG;
> +
> +	/* Allocate new struct tpm_chip instance */
> +	chip = tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);

Why not tpmm_chip_alloc ? Using devm in other places

Doesn't this leak memory? I don't see a put_device cleanup for chip_alloc?

> +	if (IS_ERR(chip)) {
> +		dev_err(dev, "%s:tpm_chip_alloc failed\n", __func__);
> +		rc = PTR_ERR(chip);
> +		goto out;
> +	}
> +
> +	pvt_data->chip = chip;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
> +
> +	/* Create a character device for the fTPM */
> +	rc = tpm_chip_register(pvt_data->chip);

It is a bad idea to do things after tpm_chip_register, it should be
the last thing done during probe except for error cleanup via a goto
unwind.

Jason
