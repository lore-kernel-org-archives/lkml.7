Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D645C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AF521556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgDonxsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLKX0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:26:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47750 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727085AbfLKX0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576106811;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=xIBtoo8ZOmm+jwrAM70WjwrXU/X7efOhZSB/CmsOthA=;
        b=DgDonxslg3M4xrm4HYiU/RIPweHccAVr9Hpb/QJ7xD+1ZKFbjsNAkJPSLYJII6pgANMmxy
        kWXDIxsddN8wIlYVZh7PcRnt297Q903BU+GMh01Oen8muYYLixJcZbwlkS5w8CHEbosMP+
        dtTeSxNnFjtbOkwM9VCEN89+aQT8LBw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-nKe3NGlPOg-vPC-e8ZIxZw-1; Wed, 11 Dec 2019 18:26:50 -0500
X-MC-Unique: nKe3NGlPOg-vPC-e8ZIxZw-1
Received: by mail-pl1-f197.google.com with SMTP id z9so268025plo.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 15:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xIBtoo8ZOmm+jwrAM70WjwrXU/X7efOhZSB/CmsOthA=;
        b=DFFwZ2yI0A9GtOdk82qUjJiRMIjDxWWIERgUTtI/8q2OoGMaitHGcEyXQJoj5Cs1dV
         xHCkV1fb94t5WIKROKsTJNj5MITUdIDv8c3qF/VdQSMSM9+MfoK+SXBc4z+Sx2L4JGmh
         OqndysLmKd7UjUXCDfvy3DieuGwIrAv2rKgH74XxQWddsvLJZwuTqeoMlVGPGCQ6UY+l
         98256VJYxjOKJaiXzs27WMoNwQPs+HZ0gewC9ctPaAkUVbJ4yVmSICBQGurnp5D97A7v
         EsNnyiihK7GUfeOYxeb5T25YmZdN0Jlf/3eXHaWhSqsfu5bQs5i1E6XFfTz2708TgFia
         Jqjw==
X-Gm-Message-State: APjAAAXc4XxOOo+Z3DUjcIKWrVlvXar8RTmlOV1cBSiA1rYUBBtR6rGQ
        3NB0A9xfaOHC2x89aHUBj3EG3tgEx2nUMpmtSM0/HbKurLK9Mq4+82WQBOUR6m9AO33ai+HiPt8
        Se2gYcAF2V8F+5D135wwBt5h6
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr6164074plj.287.1576106808595;
        Wed, 11 Dec 2019 15:26:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqBrhVo8B0NkfhTA7qmWNMDe2NS+bkpJjXqPqOxnEvLKUmHEM6HPU81t6PZa+dDB2P6rEGHg==
X-Received: by 2002:a17:902:59da:: with SMTP id d26mr6164051plj.287.1576106808281;
        Wed, 11 Dec 2019 15:26:48 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r62sm4469451pfc.89.2019.12.11.15.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:26:47 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:26:12 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: reserve chip for duration of tpm_tis_core_init
Message-ID: <20191211232612.miaizaxxikhlgvfj@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20191211231758.22263-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191211231758.22263-1-jsnitsel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 11 19, Jerry Snitselaar wrote:
>Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>issuing commands to the tpm during initialization, just reserve the
>chip after wait_startup, and release it when we are ready to call
>tpm_chip_register.
>
>Cc: Christian Bundy <christianbundy@fraction.io>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Peter Huewe <peterhuewe@gmx.de>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>Cc: stable@vger.kernel.org
>Cc: linux-intergrity@vger.kernel.org

Typo on the list address, do you want me to resend Jarkko?

>Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---

I did some initial testing with both a 1.2 device and a 2.0 device here.
Christian, can you verify that this still solves your timeouts problem
you were seeing? Dan, can you try this on the internal system with
the interrupt issues? I will see if I can get the t490s owner to run
it as well.

Thanks,
Jerry

