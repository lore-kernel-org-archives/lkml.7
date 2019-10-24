Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E84CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC8A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jfPwFPGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504138AbfJXSya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:54:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41162 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504117AbfJXSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:54:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so15693745pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vEVyeTvvTMi6SAS+n9RsmrwWAaiY50FDey46sRKT/sM=;
        b=jfPwFPGykj5dhxLIUWAgVMQEqQ/UTBWqbc41jOIx6udWAfDtGF4quyfWpuuyJMcaQ4
         bm0UFTJiHo44ZvzxDnHWo7DZfVN9fFldQjbB/G/ocd8Ur+QvosJCO1Z2+kJNw4gcwTPl
         tVHKop2VJD6uRvYNvw6PdBRTXSpmYGvY+ksU1tSOSJdQXJg8HXgEXCqchyUfr6JOkST0
         T4sO82n5cS/t4aBJt5TGjIJ6jAgAfY4z/JMYHvEqK1vcZq7nBANGe5MY04Nl3yEOtkJ+
         wo3QMpZt/yn7I/FuN7W4WsmZ8p6opRXzH3ugjVPFdkg51+KsAsIpmznSCiXbtvTaWJ2g
         oaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vEVyeTvvTMi6SAS+n9RsmrwWAaiY50FDey46sRKT/sM=;
        b=NTPbq/blBNaYlEDrCeM8k21WeGjo+RG8HkT8W6gRAeRG9BmQs/oUJngMGgcBq+V7fw
         6ZL4QUq2owCmhdhCXL0bAfgInEixajWOpwVqmxDO0Csrv5m12uaRFQiblNuZVNcInCMO
         mTjC2AykqB1qnxLLZKCFsHM/lKjPXGDJU0yARlKTpnajRUgLmNlJywrlnmPMeXNjkoqZ
         v7RJax1S+uyR8zglDHUM6pnCn8LgN5hE5f3fR6hQxJ/+r1eWli6Sx4/DZYlKTtK1Ucfo
         vKrFfjYglJVWfpxT5Uzb74j+cGlJoDZd40Y65ntDIClShNqTH7SCN0HtZuevfeV8YIkv
         RspQ==
X-Gm-Message-State: APjAAAVQX5D9nPf+X9Ty6+fuIkofJez9h3LW6/qwWtis5wSqe1tXlWeJ
        9k8UGt5n1yQNf/ghl0+PjtOf9g==
X-Google-Smtp-Source: APXvYqwBJyP4z+3uIeoy+lYU8bwkuR/LX939j6JJv4YuAESgml9v+T7vl/O91S6Uw3hGPgAaHYWIUA==
X-Received: by 2002:a17:90a:ff07:: with SMTP id ce7mr9287662pjb.12.1571943266729;
        Thu, 24 Oct 2019 11:54:26 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id b4sm2863506pju.16.2019.10.24.11.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 11:54:26 -0700 (PDT)
Date:   Thu, 24 Oct 2019 11:54:22 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH V3 1/3] firmware: broadcom: add OP-TEE based BNXT f/w
 manager
Message-ID: <20191024115422.5f4e16bc@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <1571895161-26487-2-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1571895161-26487-1-git-send-email-sheetal.tigadoli@broadcom.com>
        <1571895161-26487-2-git-send-email-sheetal.tigadoli@broadcom.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 11:02:39 +0530, Sheetal Tigadoli wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> This driver registers on TEE bus to interact with OP-TEE based
> BNXT firmware management modules
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>

I don't know anything about TEE, but code looks reasonable.

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
