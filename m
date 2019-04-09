Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2CCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA54620820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UunMGqD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDITWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:22:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40531 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDITWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:22:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so21218703qts.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZgRk4oXW6/CmGrrvcpCr56kCO+VlPUKaYiIkmt4dYI=;
        b=UunMGqD23SDCKBC4ofCQcGG+oAyMCBH/rFe3rB2OQIzaRWES/coHlnxMd0mmdRo9yo
         sAJt4Smkr0OlfyhjEZUVPZA2yCSXfr1XO7F1SQ36E9uG3WtQ0ZqYTF5QDWeaf6xD+fvU
         33c9S/ghHz7t+BcHuSC5GKu7MPyA29LwF4Myz1cpR7V/NeKIOrTae3CVc7vvEeIcmdFg
         UvevtE9+LWzZd7T+9pWulPR4gYMRLDYaVBcfU5Qe6cCeRhyVLVp+VRK8gb9b7CTJQTMN
         WwsRkOgLnmwEuP28Ft9nH7xL0a3FvPbRMDkRsQLNkVHQPn8f/v/6VIR/faaKJ4OgW6+I
         +nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZgRk4oXW6/CmGrrvcpCr56kCO+VlPUKaYiIkmt4dYI=;
        b=cnmihKn45a9aM+bdC2IG2MfnjgqR3m/JCzPk/1Oe63juEkSXguH5+eZqu8wm3VHOlY
         lfLX2cZxHUKmIWklAbIBpkjRxwFYWtyNzKxdYS4yJw7GUllzH38A7KDbwz4cbYKLzHpL
         Ybsi7rhuJoMfMlbGe4Lb8q3BiPKk4KBbPwnU7Mwbli+vxYXt59rQIvxfF/QIaeee4+rS
         1ysI6pmoE3Lj1FsNeQNnBWXLmQwyBitemi8o94nu2nsP8xXkUsLINVUYOb7C8ujVw+ER
         DJITwHqX13CWo9MPMknq1vRsM5Kb2l/8k5OuO9fwQEzb/w8QeiNnr4GDupc8TEF+mIyC
         /miQ==
X-Gm-Message-State: APjAAAV9c+u+ECU7bwpQNg8igNWpY8+o5AUENaj90GXDCBx7EzwblRja
        78RMgobigSrGhtk7dYmUcUL1gQ==
X-Google-Smtp-Source: APXvYqz5/E+ggDr8UTrQQBRjKFX1se7UdMOl+20fXzJz6G7FwRhWwfZlv9WogR0CXzBjTW0jzzv7hg==
X-Received: by 2002:ac8:2a2e:: with SMTP id k43mr32595153qtk.353.1554837764746;
        Tue, 09 Apr 2019 12:22:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v39sm21587449qtj.20.2019.04.09.12.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 12:22:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hDwKO-0003Sb-Sf; Tue, 09 Apr 2019 16:22:40 -0300
Date:   Tue, 9 Apr 2019 16:22:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com,
        mark.rutland@arm.com, corbet@lwn.net, robh+dt@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v2 2/3] ftpm: firmware TPM running in TEE
Message-ID: <20190409192240.GA12869@ziepe.ca>
References: <20190409184958.7476-1-sashal@kernel.org>
 <20190409184958.7476-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409184958.7476-3-sashal@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:49:57PM -0400, Sasha Levin wrote:

> +/*
> + * Undo what has been done in ftpm_tee_probe
> + */
> +static void ftpm_tee_deinit(struct ftpm_tee_private *pvt_data)
> +{
> +	/* Release the chip */
> +	tpm_chip_unregister(pvt_data->chip);
> +
> +	/* frees chip */
> +	if (pvt_data->chip)
> +		put_device(&pvt_data->chip->dev);
> +
> +	if (pvt_data->ctx) {
> +		/* Free the shared memory pool */
> +		tee_shm_free(pvt_data->shm);
> +
> +		/* close the existing session with fTPM TA*/
> +		tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +
> +		/* close the context with TEE driver */
> +		tee_client_close_context(pvt_data->ctx);
> +	}

None of these if's are necessary, remove is only called if probe
succeeds. Would also make more sense to put this code into remove
instead of having it call one function..

> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
> new file mode 100644
> index 000000000000..c1dd416d27c9
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation
> + */
> +
> +#ifndef __TPM_FTPM_TEE_H__
> +#define __TPM_FTPM_TEE_H__
> +
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +#include <linux/tpm.h>
> +
> +/* The TAFs ID implemented in this TA */
> +#define FTPM_OPTEE_TA_SUBMIT_COMMAND  (0)
> +#define FTPM_OPTEE_TA_EMULATE_PPI     (1)
> +
> +/* max. buffer size supported by fTPM  */
> +#define  MAX_COMMAND_SIZE       4096
> +#define  MAX_RESPONSE_SIZE      4096
> +
> +/**
> + * struct ftpm_tee_private - fTPM's private data
> + * @chip:     struct tpm_chip instance registered with tpm framework.
> + * @state:    internal state
> + * @session:  fTPM TA session identifier.
> + * @resp_len: cached response buffer length.
> + * @resp_buf: cached response buffer.
> + * @ctx:      TEE context handler.
> + * @shm:      Memory pool shared with fTPM TA in TEE.
> + */
> +struct ftpm_tee_private {
> +	struct tpm_chip *chip;
> +	u32 session;
> +	size_t resp_len;
> +	u8 resp_buf[MAX_RESPONSE_SIZE];
> +	struct tee_context *ctx;
> +	struct tee_shm *shm;
> +};
> +
> +/*
> + * Note: ftpm_tee_tpm_op_recv and ftpm_tee_tpm_op_send are called from the
> + * same routine tpm_try_transmit in tpm-interface.c. These calls are protected
> + * by chip->tpm_mutex => There is no need for protecting any data shared
> + * between these routines ex: struct ftpm_tee_private
> + */
> +
> +/* TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896 */
> +static const uuid_t ftpm_ta_uuid =
> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);

Don't put static variables in header files

Jason
