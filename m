Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E687206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqrTUt/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfLPMjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:39:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34023 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfLPMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:39:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so6650791ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 04:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKf0W4NjHQUiuvilYzfhj/3BW1yQqhyv7Ie5yqLaNQ8=;
        b=MqrTUt/wNyR0oRK72R+OH1Iev1NCQHbs+HmJMh9trhvx66GQV6e8XMNoMpJIJt1GK7
         3HjKJJPiGkfCjMFx7SAdooUO+NKMGDEba2QL1oHoz/CTtvTG8KHjShw83YIVi1F0XehQ
         HzZ2INzezWvhnBc1QQpH+oUHi+cQ1Mz+3PItLc+QLSPk+1IsRWpYnBCruNCWEULoFUMo
         C6vFC4WhZ1walcKdCpSPP3rw71Y31p7g/c/anlOlpeBoOfXejmlLDj8CA4KjXs9koI36
         9H76TYtzKSY2Q3j+W+5Ac3aSYSiJJdC9OTU1FnpK9WH7M3gD4aKOnmXPKZSdEPZ1KNOL
         ETtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKf0W4NjHQUiuvilYzfhj/3BW1yQqhyv7Ie5yqLaNQ8=;
        b=oJhoF5xGwoZ3QCU04tqYiHVmFm6DQRDUzMqbD29qakXV1IbJDFS2oFaLplnkgsK1+u
         jW6VJzDl+j13w9vacc0gSJ2TxT+vYMQiR92Spy9o/qjtHh08CtYG6q1/UGG7B5BP0Ym/
         8Loub9v6zMxh8Oj0LHGbBWzDbO/w4824+1LcBC46w6MUzDIZTPmhEK4qBTCRYPmBz3V3
         UrxMoDbPqXu1+U6Q6yJCrnGMJABKxH+1xB/tk8oeiyrfJNmEQtuifAHvpfJ2WG5WNTdm
         XwiFqiE7OaOfq2rwZgh5oRCcbXKodjpG9gDVWwOz/i7WrgMZuqVecI/cLajvJ5ZAroiV
         eXuQ==
X-Gm-Message-State: APjAAAUooXtgMAf1lauX0pwe0vtdd99l4+9Wphh/mEotWYQnqiGD4R1C
        oh3TAxEtnYdyOTb58x7poEInAA==
X-Google-Smtp-Source: APXvYqwPveZoSiBcunAIimbnrqhqNcQFq0uZY6i9c+Em0aJ9NR1qxf7gSPBFZVgGtJuk9KKxrra9eQ==
X-Received: by 2002:a2e:144b:: with SMTP id 11mr19475576lju.216.1576499954726;
        Mon, 16 Dec 2019 04:39:14 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id v7sm8754292lfa.10.2019.12.16.04.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 04:39:14 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:39:12 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Subject: Re: [RFC PATCH v3 0/4] TEE driver for AMD APUs
Message-ID: <20191216123911.GA11788@jax>
References: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
 <f7803de4-b09d-cfb7-9289-7abf5dde37c0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7803de4-b09d-cfb7-9289-7abf5dde37c0@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rijo,

On Thu, Dec 12, 2019 at 06:04:24PM +0530, Thomas, Rijo-john wrote:
> Hi Jens,
> 
> Please let me know if there are any comments for this patch series. I
> shall address them, if any, and post for next review.

This looks good, I have no further comments.

How do you intend to upstream this? There's the dependency towards "Add
TEE interface support to AMD Secure Processor driver"
(https://lkml.org/lkml/2019/12/4/42) to take into account too.

Thanks,
Jens

> 
> Thanks,
> Rijo
> 
> On 06/12/19 10:48 am, Rijo Thomas wrote:
> > This patch series introduces Trusted Execution Environment (TEE) driver
> > for AMD APU enabled systems. The TEE is a secure area of a processor which
> > ensures that sensitive data is stored, processed and protected in an
> > isolated and trusted environment. The AMD Secure Processor is a dedicated
> > processor which provides TEE to enable HW platform security. It offers
> > protection against software attacks generated in Rich Operating
> > System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
> > running on AMD Secure Processor allows loading and execution of security
> > sensitive applications called Trusted Applications (TAs). An example of
> > a TA would be a DRM (Digital Rights Management) TA written to enforce
> > content protection.
> > 
> > Linux already provides a tee subsystem, which is described in [1]. The tee
> > subsystem provides a generic TEE ioctl interface which can be used by user
> > space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
> > and implements tee function callbacks in an AMD platform specific manner.
> > 
> > The following TEE commands are recognized by AMD-TEE Trusted OS:
> > 1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
> >    environment
> > 2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
> > 3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
> > 4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
> > 5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
> > 6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
> > 7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory
> > 
> > Each command has its own payload format. The AMD-TEE driver creates a
> > command buffer payload for submission to AMD-TEE Trusted OS.
> > 
> > This patch series has a dependency on another patch set titled - Add TEE
> > interface support to AMD Secure Processor driver.
> > Link: https://lkml.org/lkml/2019/12/4/42
> > 
> > v3:
> > * Updated [1] with driver details
> > 
> > v2:
> > * Added a helper API in AMD Secure Processor driver, which can be
> >   called by AMD-TEE driver during module init to check if TEE is
> >   present on the device
> > * Added proper checks for parameter attribute variable
> > * Used tee_shm_pool_alloc() to allocate struct tee_shm_pool data structure
> > * Removed all references to tee_private.h header file in driver code,
> >   except for the file drivers/tee/amdtee/core.c. The driver loads TA binary
> >   by calling request_firmware(), which takes struct device* as one of its
> >   arguments. The device 'dev' field is part of struct tee_device, defined
> >   in tee_private.h
> > 
> > [1] https://www.kernel.org/doc/Documentation/tee.txt
> > 
> > Rijo Thomas (4):
> >   tee: allow compilation of tee subsystem for AMD CPUs
> >   tee: add AMD-TEE driver
> >   tee: amdtee: check TEE status during driver initialization
> >   Documentation: tee: add AMD-TEE driver details
> > 
> >  Documentation/tee.txt               |  81 ++++++
> >  drivers/crypto/ccp/tee-dev.c        |  11 +
> >  drivers/tee/Kconfig                 |   4 +-
> >  drivers/tee/Makefile                |   1 +
> >  drivers/tee/amdtee/Kconfig          |   8 +
> >  drivers/tee/amdtee/Makefile         |   5 +
> >  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
> >  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
> >  drivers/tee/amdtee/call.c           | 373 ++++++++++++++++++++++++++
> >  drivers/tee/amdtee/core.c           | 516 ++++++++++++++++++++++++++++++++++++
> >  drivers/tee/amdtee/shm_pool.c       |  93 +++++++
> >  include/linux/psp-tee.h             |  18 ++
> >  include/uapi/linux/tee.h            |   1 +
> >  13 files changed, 1451 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/tee/amdtee/Kconfig
> >  create mode 100644 drivers/tee/amdtee/Makefile
> >  create mode 100644 drivers/tee/amdtee/amdtee_if.h
> >  create mode 100644 drivers/tee/amdtee/amdtee_private.h
> >  create mode 100644 drivers/tee/amdtee/call.c
> >  create mode 100644 drivers/tee/amdtee/core.c
> >  create mode 100644 drivers/tee/amdtee/shm_pool.c
> > 
> > --
> > 1.9.1
> > 
