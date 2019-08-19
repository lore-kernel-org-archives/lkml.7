Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83ADC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AA72070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9vuTLau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfHSEd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:33:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37173 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSEd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:33:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so420264pgp.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=72ELnDTzM6YoNYA5xuMcBDOagLAJM+myxC5fFXnFV48=;
        b=Z9vuTLauhILmFT4izzT0W9vrtgqP/Xr0XOa45NfzQa5oXQEh15wihhLl9XXLTBEyfS
         PGuiI5f1/qyvjSDjE7/U3rMq8VEh/8Z3XlXNAPid/v+5T/L1dckkH4m68hOzakwYsmiS
         DR4jU7yr8VWRNYqwux35MvR3ALybBBLxvrJ29v88gCnILUTZNjv07FH4zuXQZiOE4Bek
         z3AjR4vwfq3poqp2dvl0cnpg6DLBxxeI+YURikqDXfQMxaIYf4C6aFRwebA4kkbqBXYg
         K4S2rOTLfy9dpAB3cPRCdHq8mO5StS09+MNiM/OJkPQrgAKaNxuLijm3Cni0/J+X5E0K
         mUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=72ELnDTzM6YoNYA5xuMcBDOagLAJM+myxC5fFXnFV48=;
        b=kPNSw0QIYHeoI2/ilamAhLNAtwehaXm+G1yk4PC9focXauEVQu9IXzgwAXwYCzvW18
         SVVYS4x3UEjyvSlMQj6fAlD11v2kgVoCuShkZzHZlqtsh4iErNLiuV2FIJ9a7vLNfqma
         1dVxDFobMezFGQyyQX1cCA98g39TdNuxNrPiFbf6s7hWePthtlqGcxyoOCKzHOV98Sii
         WoiuMQDfwQOsAAku1yJB9qsILyI0RV2O3cyPWo2sdPZhxLtGW8ZsMAos6Nh/GuZJsEem
         idcD8Opz/yoM9bMzM0pUdUWVGoTZkcGfrXTY/FRaEuvdSo+39quDnjPVXUBC2z6xHgtG
         h69w==
X-Gm-Message-State: APjAAAX10ghYpT+TnMIQJw+jedLcAHXJZmqZi1l4qEgZUuW2WK26v83p
        zqb0YyrO9bIIjmkUub6gjf8IGg==
X-Google-Smtp-Source: APXvYqx0GITYVJU0+6/P8ffsNYIHIW1krQG1LL8IcUsIyyFWccg1orw3OU3X7LPPaX0vGUeYIUGxjA==
X-Received: by 2002:a63:62c6:: with SMTP id w189mr18101877pgb.312.1566189206207;
        Sun, 18 Aug 2019 21:33:26 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f14sm15192021pfn.53.2019.08.18.21.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 21:33:25 -0700 (PDT)
Date:   Sun, 18 Aug 2019 21:35:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        kernel-build-reports@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: next/master boot: 254 boots: 16 failed, 231 passed with 4
 offline, 1 untried/unknown, 2 conflicts (next-20190726)
Message-ID: <20190819043508.GY26807@tuxbook-pro>
References: <5d3aef79.1c69fb81.111b9.a701@mx.google.com>
 <20190726134843.GC55803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726134843.GC55803@sirena.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Jul 06:48 PDT 2019, Mark Brown wrote:

> On Fri, Jul 26, 2019 at 05:18:01AM -0700, kernelci.org bot wrote:
> 
> The past few versions of -next failed to boot on apq8096-db820c:
> 
> >     defconfig:
> >         gcc-8:
> >             apq8096-db820c: 1 failed lab
> 
> with an RCU stall towards the end of boot:
> 
> 00:03:40.521336  [   18.487538] qcom_q6v5_pas adsp-pil: adsp-pil supply px not found, using dummy regulator
> 00:04:01.523104  [   39.499613] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 00:04:01.533371  [   39.499657] rcu: 	2-...!: (0 ticks this GP) idle=9ca/1/0x4000000000000000 softirq=1450/1450 fqs=50
> 00:04:01.537544  [   39.504689] 	(detected by 0, t=5252 jiffies, g=2425, q=619)
> 00:04:01.541727  [   39.513539] Task dump for CPU 2:
> 00:04:01.547929  [   39.519096] seq             R  running task        0   199    198 0x00000000
> 
> Full details and logs at:
> 
> 	https://kernelci.org/boot/id/5d3aa7ea59b5142ba868890f/
> 
> The last version that worked was from the 15th and there seem to be
> similar issues in mainline since -rc1.

As you might have seen this problem has come and gone on the
apq8096-db820c and I've finally managed to narrow it down a little bit.

The problem first appears on next-20190701, with the introduction of
CONFIG_RANDOMIZE_BASE in the defconfig, but after further efforts I've
concluded that disabling kpti removes or hides the problem.

With kpti=no on the command line I've now successfully booted the db820c
100+ times without problems (a clear improvement from the 75% failure
rate with kpti=yes).


Unfortunately I'm not yet certain why this is causing issues and I'm
also seeing the same rcu stall on SDA845 under certain (erroneous?)
conditions (where I don't expect them). 

Regards,
Bjorn
