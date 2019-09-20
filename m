Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9772DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712602054F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437604AbfITHsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437580AbfITHsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:48:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D71DA811DC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:48:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k9so833973wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKORzqIRH8UFUe4Xtmmfu6KCmszYBGYE6BwrxWii7Vw=;
        b=RvjXeXalP7U6BgX0g3ChcHI2hqxmpsjV510ftitSeOAVVUUBHzrBifja3dPqY2ktze
         0jb0fZSNCqPg+QZlaGlCiOHrndTZs4CMXMMgdmbodQ8C5izUOXMgi1stKtxUepdGX7Of
         NNm0wgGNggJKzPJ8pB9SmGB0up3Kypghhss2oCMbk0qvdLDWcX/VRkK5brUOFXhIrwEU
         Eb4Yoq4gEfPgFTlip6YQ0LkwTlwS2Sx+Jujp7yIBwnl+MAj/q4+fc0zU6fC1gLG1FpXG
         XN0GujpIArA1QK8O9c0pPiD2m5fMkN1uKZ1ddWxeo64VR2mkHzTfwK/AFKvdjVrSOosB
         mZyg==
X-Gm-Message-State: APjAAAVXDwuyjj7f418k+S2a38bn4+DrCxPZDdr0400W1RCNG33m5TTk
        BxR02hzXlxt4OOVA0zqOD+5+WpUD+aLXhPubQBm0wSjdm3zeR+rEZmlix4BemJaH3a31XchOQdb
        EPIuDwtWOKv3syDlh9VK6KRTv
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr11317093wru.89.1568965683591;
        Fri, 20 Sep 2019 00:48:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydSp1q3IPC5Ee/GOcfWjH/pT4DM0fXSnx1nHrzzgH37xFQc+n72/iPZHmbuMH5HvPeGLyqsQ==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr11317074wru.89.1568965683377;
        Fri, 20 Sep 2019 00:48:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id w125sm1665640wmg.32.2019.09.20.00.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 00:48:02 -0700 (PDT)
Subject: Re: [RFC 0/2] kvm: Use host timekeeping in guest.
To:     Suleiman Souhlal <suleiman@google.com>, rkrcmar@redhat.com,
        tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20190920062713.78503-1-suleiman@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1ec0b238-61a7-8353-026e-3a2ee23e6240@redhat.com>
Date:   Fri, 20 Sep 2019 09:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920062713.78503-1-suleiman@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 08:27, Suleiman Souhlal wrote:
> To do that, I am changing kvmclock to request to the host to copy
> its timekeeping parameters (mult, base, cycle_last, etc), so that
> the guest timekeeper can use the same values, so that time can
> be synchronized between the guest and the host.
> 
> Any suggestions or feedback would be highly appreciated.

I'm not a timekeeping maintainer, but I don't think the
kernel/time/timekeeping.c changes are acceptable.

Is the PTP driver not enough?

Paolo
