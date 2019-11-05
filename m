Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B84C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAF21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7Y8siEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbfKEPRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:17:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40519 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbfKEPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:17:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id f4so15420630lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=um+FEJWRM7Kk9nLxT4Q9zy1gGwENFETv0P8aLH+m+l8=;
        b=b7Y8siEXYXLlrS1sxcr3XwfDL1AsTpfLKjtCZwWdBfuYS1WPyDGdr3mTR6kzmvupNr
         GdG3xxXtABRKEVYqRIbrmcNssvAaIV7ipFdjs9BsTA3KE5NolkRPwkTLPPJGbcxbGc5f
         TgLyjrtOxzvv1H82ZJMBMPkTDSPCJYZPd57k1AydHYscPrRcLue83he09qsiLzM7u+B5
         A2V3jewigjlY0DbkPjGMrGb0rvOBvp/75sSkZeAPgV2DpKQ2s3WyokGV1Ozm9jG6kbif
         OxGhpkv8fqJaJbecLU1anoqLfTviL9DJGwGbMS9LV+29YdTPiC4xEIDYzfMjzco/mq0+
         PFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=um+FEJWRM7Kk9nLxT4Q9zy1gGwENFETv0P8aLH+m+l8=;
        b=s1wckqHSHlDaa12mpl/imKmUkoCc5VZSI2pw59d+EX4pkCggKNIO9eFxKWUYHtVF0I
         YkKrGqKhjvy6UUk3k0ukOLGWd//B07Mn3EVHMelrULBrQETan1+5o8mLxEUEvsZLtr9V
         YP1RZSOndqVVp4WYAaiy8crJDZVnBb4WsuinoxaDALX85kSKdwV8jAT24RveNRkHfj4e
         VS3JJY3Tt+0OxSFshhR3LZB27dZeKF5F3lkFxxuYOBR5j7ofCatbdOX7Z4E3GBgKevCX
         rC/A1O1XMXcQV+/Zc14J/LWAH/0f2EotjjRFMyY6hQcHGbwaqrASTDrhUawXn7A9j9FQ
         6Jiw==
X-Gm-Message-State: APjAAAUX7dAvmaKbJYW81+yIaEsQaS0/75lS8b9wVkM9tSSq3d9FWy8e
        48jh8RbDHn5fw9glnS04ysxSprNBrhM=
X-Google-Smtp-Source: APXvYqz3suLfrXgS3cM/8vpPsoBiCWdVcmO2EkPCGgISX37wEMHGcsRr5zWfolEmonn+hqd/hbq3ow==
X-Received: by 2002:a19:148:: with SMTP id 69mr22476983lfb.76.1572967054506;
        Tue, 05 Nov 2019 07:17:34 -0800 (PST)
Received: from jax ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id w20sm9605054lff.46.2019.11.05.07.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 07:17:33 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:17:31 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Cc:     "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
Subject: Re: [RFC PATCH 0/2] TEE driver for AMD APUs
Message-ID: <20191105151731.GA22448@jax>
References: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rijo,

On Wed, Oct 23, 2019 at 11:30:56AM +0000, Thomas, Rijo-john wrote:
> This patch series introduces Trusted Execution Environment (TEE) driver
> for AMD APU enabled systems. The TEE is a secure area of a processor which
> ensures that sensitive data is stored, processed and protected in an
> isolated and trusted environment. The AMD Secure Processor is a dedicated
> processor which provides TEE to enable HW platform security. It offers
> protection against software attacks generated in Rich Operating
> System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
> running on AMD Secure Processor allows loading and execution of security
> sensitive applications called Trusted Applications (TAs). An example of
> a TA would be a DRM (Digital Rights Management) TA written to enforce
> content protection.
> 
> Linux already provides a tee subsystem, which is described in [1]. The tee
> subsystem provides a generic TEE ioctl interface which can be used by user
> space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
> and implements tee function callbacks in an AMD platform specific manner.
> 
> The following TEE commands are recognized by AMD-TEE Trusted OS:
> 1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
>    environment
> 2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
> 3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
> 4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
> 5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
> 6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
> 7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory
> 
> Each command has its own payload format. The AMD-TEE driver creates a
> command buffer payload for submission to AMD-TEE Trusted OS.
> 
> This patch series has a dependency on another patch set titled - Add TEE
> interface support to AMD Secure Processor driver.
> 
> [1] https://www.kernel.org/doc/Documentation/tee.txt

Please add a section in Documentation/tee.txt describing the AMD-TEE driver.

Cheers,
Jens

> 
> Rijo Thomas (2):
>   tee: allow compilation of tee subsystem for AMD CPUs
>   tee: add AMD-TEE driver
> 
>  drivers/tee/Kconfig                 |   4 +-
>  drivers/tee/Makefile                |   1 +
>  drivers/tee/amdtee/Kconfig          |   8 +
>  drivers/tee/amdtee/Makefile         |   5 +
>  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
>  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
>  drivers/tee/amdtee/call.c           | 370 ++++++++++++++++++++++++++
>  drivers/tee/amdtee/core.c           | 510 ++++++++++++++++++++++++++++++++++++
>  drivers/tee/amdtee/shm_pool.c       | 130 +++++++++
>  include/uapi/linux/tee.h            |   1 +
>  10 files changed, 1369 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/tee/amdtee/Kconfig
>  create mode 100644 drivers/tee/amdtee/Makefile
>  create mode 100644 drivers/tee/amdtee/amdtee_if.h
>  create mode 100644 drivers/tee/amdtee/amdtee_private.h
>  create mode 100644 drivers/tee/amdtee/call.c
>  create mode 100644 drivers/tee/amdtee/core.c
>  create mode 100644 drivers/tee/amdtee/shm_pool.c
> 
> -- 
> 1.9.1
> 
