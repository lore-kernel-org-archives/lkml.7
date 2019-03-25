Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01986C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C662070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="a+YHEmd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfCYVdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:33:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41183 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfCYVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:33:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id 64so9489342otb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kI1cgbogsjrEoGMCL0RQUjw+UhPR/W1g5aVXTRUmpEM=;
        b=a+YHEmd6q3x3r7xhfe5V6NBMKGgOubkzc1Gs+RX1Ls/aa4luvDZvUwlgoUsTgwbm3o
         j0MnE2lTvC96noGsvcANxNnW0mjwsjQUHDS+ychSCn85FwLPdCYwUOmIHVN2ghgUetoN
         TSXdzmVFE93EZIW4idpDHfbM9IdxF0VTg7H4vFgOabUsNjEkuIZIoFmTxbXR62Vlji7+
         jMxZeKGI+Vy/8oLTyVlFSGLVOP6W92hGBiO7Yoqxc8x5w5daqtpydmsTDDvhXxgmHDFd
         CQoOPVGXQEuFard+91BssIsbm7nc7s0CuLayrqyDh7TLBIfGGK3i10wsdQpWl0x+ExTY
         z2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kI1cgbogsjrEoGMCL0RQUjw+UhPR/W1g5aVXTRUmpEM=;
        b=WslaPMQfeOWOLp30x+hAWkyXphgRnXG+4KiPcwHqYV2KQ/mK/H6ztx0Gc2Qy7SxWpT
         fT0mcC0zpAR0MgKSDF6eTDdVL4IzIGE/TTep9Ai6NkS/ubaYMR2AJebJQwOJJrvTXCgf
         wRLcpyY2rqW1r0NgR3hbXpUSgDYqf6SWS5G2bopbCABwvvmMvoh0siHMaMym+ib1/etT
         0Ms/Jm3pzNvhdE1t9D9/VpnWnV/n5RR1QNs/BXLz4c+Q6Szc8uC9HSOWBXRL9gUGSG7h
         9sFySbo1jAN4vY0p3Wiz4I9vjhx1yvdhl48obB6r1MrNAFqyKckGmi9M+46Lh0G0vjHJ
         yfBA==
X-Gm-Message-State: APjAAAWwjY7QV/DT4D/l8H2i2ncJQ7ytWQi4cDAc1QRkt9SMlTuuRI2j
        1YJ2eFvdfcGOv5ZwYXqcXk4vj7q5MiROR4NaOxePwA==
X-Google-Smtp-Source: APXvYqyPHqiNfzE9hZgC5qTZcOdyG7VxnXKECXCqkUFHSwHYzZniEM6XzuLj/8PbFOAbmnmWuZjd2RSZHiQDURb0HGQ=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr20457271ota.214.1553549629694;
 Mon, 25 Mar 2019 14:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 14:33:38 -0700
Message-ID: <CAPcyv4gCvqkAUSb2sC1+hoHF=bu5X8AXvJuRoqcEt4OQGvWk5A@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:48 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
> key type callbacks and exported functions to fail when a TPM is not
> available.
>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reported-and-tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks Jarkko!
