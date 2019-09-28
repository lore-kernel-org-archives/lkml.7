Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94D3C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8C22086A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfI1Rpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 13:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfI1Rpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 13:45:47 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3424A883C2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 17:45:47 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id i2so19838494ioo.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 10:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iG/YHVcFqQVe7mP6cE9UwyWSN4iynxZhaekQHviCFmw=;
        b=YCe+gEeA7HxywXu1L+JGiVS5fdU64d9ZFawtrWA047b0JUKjjN4X1cbUWFrz9t5UDI
         Xou1KfcoLEeXJFkVEv4Hr8s3BvhlCNAUpX/tiZ0JU2wQ2ArMS7oEWGKOanqLuZ9+VMg+
         +IHuRAv/+09kWckGr6muPeNKqHSGIuNVes9qyQmpRsNUH0K/kydxeyyaMRIMORvGemE1
         rvB9zDLcv3x51JPfDNGmoq+DrbJGVL/2A75kaMhY2rYua3IoarCuH5Zvy5RS1j9h+NNZ
         hzlXfVEbx9F5gjL2irNvEHV2071cGmJrmLB/rTCBQgXDoLRiPEJL9z4z8jkVkr0z//HK
         6gtQ==
X-Gm-Message-State: APjAAAXVQNNOXJurI2tdoNFMi7x7N5DUnBGIqaDHIvTTO/NfsmWfi6uv
        DUFkbalzezSeSVgPrieRGE7HIeJ2dGDA1vceuqaibFL1T3DUyDMVh7xcT1/WT7OTSurLdJm9anE
        iowD6p2UQCrPRlEhavCCz5N6W
X-Received: by 2002:a92:498b:: with SMTP id k11mr12162587ilg.105.1569692746611;
        Sat, 28 Sep 2019 10:45:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqze0HjOplNBn9SWhXTQMRBHd0phxnym4QSz29LhtpIKrf3+QQSVqTXxYoBpkDsRICWONJi3Fw==
X-Received: by 2002:a92:498b:: with SMTP id k11mr12162573ilg.105.1569692746369;
        Sat, 28 Sep 2019 10:45:46 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g79sm3452208ilf.14.2019.09.28.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 10:45:45 -0700 (PDT)
Date:   Sat, 28 Sep 2019 10:45:43 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/4] tpm: add update_durations class op to allow
 override of chip supplied values
Message-ID: <20190928174543.6msskzuyhirtjxwe@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190902142735.6280-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 02 19, Jerry Snitselaar wrote:
>We've run into a case where a customer has an STM TPM 1.2 chip
>(version 1.2.8.28), that is getting into an inconsistent state and
>they end up getting tpm transmit errors.  In really old tpm code this
>wasn't seen because the code that grabbed the duration values from the
>chip could fail silently, and would proceed to just use default values
>and move forward. More recent code though successfully gets the
>duration values from the chip, and using those values this particular
>chip version gets into the state seen by the customer.
>
>The idea with this patchset is to provide a facility like the
>update_timeouts operation to allow the override of chip supplied
>values.
>
>changes from v3:
>    * Assign value to version when tpm1_getcap is successful for TPM 1.1 device
>      not when it fails.
>
>changes from v2:
>    * Added patch 1/3
>    * Rework tpm_tis_update_durations to make use of new version structs
>      and pull tpm1_getcap calls out of loop.
>
>changes from v1:
>    * Remove unneeded newline
>    * Formatting cleanups
>    * Change tpm_tis_update_durations to be a void function, and
>      use chip->duration_adjusted to track whether adjustment was
>      made.
>
>Jarkko Sakkinen (1):
>      tpm: Remove duplicate code from caps_show() in tpm-sysfs.c
>
>Jerry Snitselaar (2):
>      tpm: provide a way to override the chip returned durations
>      tpm_tis: override durations for STM tpm with firmware 1.2.8.28
>
>

Anyone else have any feedback on this patchset?
