Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F7AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABB52067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPKHs0lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfLPOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:34:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40703 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:34:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so4379793lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pM2vtMGjkCHmIe0oJgiVI/NviBKKoDB9ui06H9LZlIA=;
        b=UPKHs0lmOKBXfEUAz/nm8tJeuBAUhG+Q8xBdh6P1yIaLaqQcJ4oaFdfHx7gGB4Btbv
         PefH04cuGeHFP/hb7JH0+cAldzLHfRvP/2c741fs0Y5bLwJt+v6gP6JcrRqfKjuY8MqP
         xgOspbEnFfY4mqB3b6yok0rFPrK+RxmeZ65Xzbq4gODp2mXFhPWfImhIqH9j3knrXqYU
         RQIOw/IFFzoUylacaB0yYbF8P1B6Lpo9BpnduA0m/Q1L1VxM/0AXnZ71/kAIPKueWSMr
         pkOLjo8K8yqEAbWlnwnuuQ0Ff8NytFtRqrfgnLP5hCuBzTsfuvEvYRQnoZWMDY38IXsQ
         dkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pM2vtMGjkCHmIe0oJgiVI/NviBKKoDB9ui06H9LZlIA=;
        b=A+4mnErybr+GGKhIzJrlmLWmI2CphHmDkqGRVsruL1XIY91crp7P7CfcxpB2d/a2fT
         Y1nd4osh48U+Rhj/gA95lug6LXBhwy+l5wFct4C8DGSaoMzzK0HVngW3xSJft/YB3sSE
         pf770Gkt54RzD4QPNVMyYxmYpkEZVGeHK8bgg6cldYEOQ3mm7rhH7jG1vwdts6m6gk6E
         MQZRi2IDmTRNesP/nNdl9GiY1uY8ZNV42hZaZqQ5VN5xu+6he5tTklnUkgMLye1Ea7qL
         gYwqRMu7wYoAqWlTh39h2XEfyjhizrWTWr8ozTAuSlhiU/7O2Muy6yZGnCigsa6+DjKH
         qb8A==
X-Gm-Message-State: APjAAAUoEdsa1N/Tu00wvmsDqq6Aq5FqG0yM7vvhs1+Vr2jXs/2Nv/Qb
        54cqBabhS2BOJ/faQ6SUvVWo6A==
X-Google-Smtp-Source: APXvYqxRcFIIGONztiy383ZxnDP9vz3zR6MiHbKV+4KoqbQF19r49AHUHnsw5SeXQCbbNTOTAFsdpQ==
X-Received: by 2002:a19:2213:: with SMTP id i19mr16742484lfi.83.1576506856999;
        Mon, 16 Dec 2019 06:34:16 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id c23sm10773958ljj.78.2019.12.16.06.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 06:34:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:34:14 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v3 0/4] TEE driver for AMD APUs
Message-ID: <20191216143413.GA22435@jax>
References: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
 <f7803de4-b09d-cfb7-9289-7abf5dde37c0@amd.com>
 <20191216123911.GA11788@jax>
 <d09adcce-3004-bc3f-b9d1-69b57107b468@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d09adcce-3004-bc3f-b9d1-69b57107b468@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Olof and Arnd, who are usually taking my pull requests.

On Mon, Dec 16, 2019 at 06:35:03PM +0530, Thomas, Rijo-john wrote:
> +Herbert
> 
> Hi Jens,
> 
> On 16/12/19 6:09 pm, Jens Wiklander wrote:
> > Hi Rijo,
> > 
> > On Thu, Dec 12, 2019 at 06:04:24PM +0530, Thomas, Rijo-john wrote:
> >> Hi Jens,
> >>
> >> Please let me know if there are any comments for this patch series. I
> >> shall address them, if any, and post for next review.
> > 
> > This looks good, I have no further comments.
> > 
> > How do you intend to upstream this? There's the dependency towards "Add
> > TEE interface support to AMD Secure Processor driver"
> > (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F12%2F4%2F42&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C3be32c79103640faefdc08d78224f703%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637120967585713342&amp;sdata=I2lQNxu%2BBeIrL3Yk09IOYlUGsxWeCmLJhCcFuyqSJkA%3D&amp;reserved=0) to take into account too.
> 
> Thanks! If you are okay, can you give an Acked-by so that I can ask the crypto
> subsystem maintainer to pull these patches as well.

Sounds good. The risk for merge conflicts with other patches via the
normal path (arm-soc) should be minimal, if there's any I expect them to
be trivial to resolve.

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

> 
> Thanks,
> Rijo
> 
> > 
> > Thanks,
> > Jens
> > 
> >>
> >> Thanks,
> >> Rijo
> >>
> >> On 06/12/19 10:48 am, Rijo Thomas wrote:
> >>> This patch series introduces Trusted Execution Environment (TEE) driver
> >>> for AMD APU enabled systems. The TEE is a secure area of a processor which
> >>> ensures that sensitive data is stored, processed and protected in an
> >>> isolated and trusted environment. The AMD Secure Processor is a dedicated
> >>> processor which provides TEE to enable HW platform security. It offers
> >>> protection against software attacks generated in Rich Operating
> >>> System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
> >>> running on AMD Secure Processor allows loading and execution of security
> >>> sensitive applications called Trusted Applications (TAs). An example of
> >>> a TA would be a DRM (Digital Rights Management) TA written to enforce
> >>> content protection.
> >>>
> >>> Linux already provides a tee subsystem, which is described in [1]. The tee
> >>> subsystem provides a generic TEE ioctl interface which can be used by user
> >>> space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
> >>> and implements tee function callbacks in an AMD platform specific manner.
> >>>
> >>> The following TEE commands are recognized by AMD-TEE Trusted OS:
> >>> 1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
> >>>    environment
> >>> 2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
> >>> 3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
> >>> 4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
> >>> 5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
> >>> 6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
> >>> 7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory
> >>>
> >>> Each command has its own payload format. The AMD-TEE driver creates a
> >>> command buffer payload for submission to AMD-TEE Trusted OS.
> >>>
> >>> This patch series has a dependency on another patch set titled - Add TEE
> >>> interface support to AMD Secure Processor driver.
> >>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F12%2F4%2F42&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C3be32c79103640faefdc08d78224f703%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637120967585713342&amp;sdata=I2lQNxu%2BBeIrL3Yk09IOYlUGsxWeCmLJhCcFuyqSJkA%3D&amp;reserved=0
> >>>
> >>> v3:
> >>> * Updated [1] with driver details
> >>>
> >>> v2:
> >>> * Added a helper API in AMD Secure Processor driver, which can be
> >>>   called by AMD-TEE driver during module init to check if TEE is
> >>>   present on the device
> >>> * Added proper checks for parameter attribute variable
> >>> * Used tee_shm_pool_alloc() to allocate struct tee_shm_pool data structure
> >>> * Removed all references to tee_private.h header file in driver code,
> >>>   except for the file drivers/tee/amdtee/core.c. The driver loads TA binary
> >>>   by calling request_firmware(), which takes struct device* as one of its
> >>>   arguments. The device 'dev' field is part of struct tee_device, defined
> >>>   in tee_private.h
> >>>
> >>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2FDocumentation%2Ftee.txt&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C3be32c79103640faefdc08d78224f703%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637120967585713342&amp;sdata=3nmaMDGsdbqRdR3ocM0xoEFsNRbd2IgUj6tvCKJhk2w%3D&amp;reserved=0
> >>>
> >>> Rijo Thomas (4):
> >>>   tee: allow compilation of tee subsystem for AMD CPUs
> >>>   tee: add AMD-TEE driver
> >>>   tee: amdtee: check TEE status during driver initialization
> >>>   Documentation: tee: add AMD-TEE driver details
> >>>
> >>>  Documentation/tee.txt               |  81 ++++++
> >>>  drivers/crypto/ccp/tee-dev.c        |  11 +
> >>>  drivers/tee/Kconfig                 |   4 +-
> >>>  drivers/tee/Makefile                |   1 +
> >>>  drivers/tee/amdtee/Kconfig          |   8 +
> >>>  drivers/tee/amdtee/Makefile         |   5 +
> >>>  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
> >>>  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
> >>>  drivers/tee/amdtee/call.c           | 373 ++++++++++++++++++++++++++
> >>>  drivers/tee/amdtee/core.c           | 516 ++++++++++++++++++++++++++++++++++++
> >>>  drivers/tee/amdtee/shm_pool.c       |  93 +++++++
> >>>  include/linux/psp-tee.h             |  18 ++
> >>>  include/uapi/linux/tee.h            |   1 +
> >>>  13 files changed, 1451 insertions(+), 2 deletions(-)
> >>>  create mode 100644 drivers/tee/amdtee/Kconfig
> >>>  create mode 100644 drivers/tee/amdtee/Makefile
> >>>  create mode 100644 drivers/tee/amdtee/amdtee_if.h
> >>>  create mode 100644 drivers/tee/amdtee/amdtee_private.h
> >>>  create mode 100644 drivers/tee/amdtee/call.c
> >>>  create mode 100644 drivers/tee/amdtee/core.c
> >>>  create mode 100644 drivers/tee/amdtee/shm_pool.c
> >>>
> >>> --
> >>> 1.9.1
> >>>
