Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4DBC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2999221479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cCC2AIeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfEVHzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:55:07 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53213 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfEVHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:55:06 -0400
Received: by mail-wm1-f46.google.com with SMTP id y3so1119040wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ry1vtEMs73ySB4IEwRFPk9gg/6GEvmW81gAJ82XtyKU=;
        b=cCC2AIeEsfYLIRfiGfOtmJBhJPhWGBOUCheRj8Cgesibj5/WKA3xQ4h2sfT2LmYxZ5
         RxyiDIwu82X7Rx8mCWmjhJvXEOTwTB0pEZZN9B2izYYOQj2dLPiTET+uT+ke/nxLIADh
         EiJbqIrarynTrYwvZOzkQO2iADLd6Ea+LcgXQxj34pwlmCwtPEBPz+JNtVCiw9JQKTfI
         ErmBg4JOWIeVtmMN9SXAYEfwbp+9p3oxyIaTG+Bx60TDGK2sQZoakwlmeVKIUeP/RvAd
         bUYxFxnzNXVFcs73iI3N0BgmNWyA47dkgmpZBVdOI4DoqS/fHOpz77RAYw5Z2hJEdubq
         q51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=ry1vtEMs73ySB4IEwRFPk9gg/6GEvmW81gAJ82XtyKU=;
        b=GUV3NYa0q3zflM1x9p2z3OYCsL4Lj5OcAkWOEXOxVexUiftVZJzBL0UF2FCT1X6kXD
         v3kpiXEGOtjBPzQ626jkuuFjWqMSaFCWT7D9LkBCMpuC8tSmdDT0emiVNModZarIz3fI
         5EjhqMHWkdUUR+aDVAT0boIR+SX92s/fJk7ZE3TdpSZ3ArD1On1rFDR79YFwHNgxFt7y
         LwHYfuRu/csvhXuG3nBhUFzNoC9L+bNxOVdtHPxlMXV+VX6M6/ryStzEaC2LMmIocmxb
         WKdNjfy/01/hkWv9RxX2HxUjg5qTox8C8mHOm6xAzlkS5rxdY/5HigJnrOOwdKwoqfvh
         Ohng==
X-Gm-Message-State: APjAAAVRxvtfJqum5AcxjW6QfCU4mBJhFeSnqgc/d+ZcqLpVsz36iIYl
        kUe59RIUHKhXIEBlQC5FbcwU1PWgiborRA==
X-Google-Smtp-Source: APXvYqxtKsUWUjbxbtXDH2OVSGWICDMPDDqQOpSsKeXv/wcmBemF7E9KFHMvbtMalq9XHlWPXsBAuQ==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr6032224wmd.98.1558511704748;
        Wed, 22 May 2019 00:55:04 -0700 (PDT)
Received: from HUAWEI-nova-2-351a175292c.fritz.box ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id y40sm44784272wrd.96.2019.05.22.00.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 00:55:04 -0700 (PDT)
Date:   Wed, 22 May 2019 09:55:00 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190522174725.6bfd51bd@canb.auug.org.au>
References: <20190522110115.7350be3e@canb.auug.org.au> <20190522055235.GC13702@kroah.com> <20190522174725.6bfd51bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <CEB120FD-547A-4D92-92AE-43E6AF8E767B@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2019 9:48:33 AM GMT+02:00, Stephen Rothwell <sfr@canb=2Eauug=2Eo=
rg=2Eau> wrote:
>Hi Greg,
>
>On Wed, 22 May 2019 07:52:35 +0200 Greg Kroah-Hartman
><gregkh@linuxfoundation=2Eorg> wrote:
>>
>> Sorry, you are going to get a number of these types of minor
>conflicts
>> now=2E  That's the problem of touching thousands of files :(
>
>Yeah, I expected that one I saw the commits=2E  At least is is just after
>-rc1, hopefully most maintainers will start their -next branches after
>today :-)

I can just rebase if that helps you out=2E

Christian
