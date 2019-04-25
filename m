Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C73C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF45A206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221534;
	bh=bPEAUJDyBvUf8AltpxAry/bQks3Hu97PoWYxCg9+Hl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fmoj9R1MBdKgk5VRNfQ5+0DNcj8K18jY3AN+pNXq5kffNbc9S9W4g2GBjVsZpHIZi
	 zDbScBw8BpO3/ky/qouE/Mf9a55HH6RiP/oPXd/u5rRJAbKwCcx1BdkB/HKZ/idXhd
	 dyunOAjZQ7JlR0Mo5WJomN4ltDD19SlTM1ltALEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfDYTpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:45:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDYTpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:45:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so909301wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXk5Ga/40fhOgGWBcQAdXFUoBO2iyNeEsE+jvULtyeA=;
        b=bOcTCgpklpQ/GOOSTjxYyPgYsma1GNyuLOyZaDr05F/RJYv8w8uHa1l3at/LKxFv3P
         0IWbc9dtYfkyaYSm4ojTiLIwGZNh/SxGqFFml07y0OrZjoqt6Zi0cDe9cX8a0aF5+AUG
         C8xqiLDpkmJ0Pm12b9Iuer4zb6ay38TEb/aytcSUYvcFogO5Dp1BghKwVHBy/mF2yCVt
         t3obrrU1SbSDMLJjlMgwFYxzTM+UKQcur8lcaTG/ubt4kyPhEhZDqAsj5oqFSsIV6YH9
         /TDXN1x/FERLHLWMYZPxa1XlAL0Ah3+RRFTr39og7HKI1FOu0E0hJaB3tfqA9terrfdD
         9VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXk5Ga/40fhOgGWBcQAdXFUoBO2iyNeEsE+jvULtyeA=;
        b=f6AQ0tKShCaACV4Jhrq/ORqhJCDuN+tTggdIwaR2XHLti2mpZUBz8bcdvsIsRuwu3t
         SJGJ3lA5MMFY/11WtXxuF08bt+k50GKyhN9hBQWZbAzy5RbaZwF3svCoPrOCB8dlZ7rj
         yrhcvSUXKOTYKoeNPdfJ8B4DJsbC5mCEf+flsySfwNUNqdMQZid/nTBvvthMxmxmpBOx
         5W+ZMnc/xGCSMpWRxALMALjifcItG1KgsOCWa5xECZ4tQMaHJ3Atid+eFJB1geH7Cy9r
         V8wLojfYuO8fQT9EvCfDYsLyDN2S1vP3yNcA6VdxdCxW0SaWckvb8g38xGG1YNbtAfhO
         Ac6w==
X-Gm-Message-State: APjAAAWeln8rZzXubTFjlV4fK8jSVhA5sHwQ4Twf2HlOMq6zQwS3/Sfg
        6gdto9n8EIKl7GrNhkSUzwM=
X-Google-Smtp-Source: APXvYqyCn6yb/OK3xDIWaessZ+rR3jRw9xGHN6Hx3ucvCCb4URKS/J8MeLWvXfdS0xlcZWicmrTfIA==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr5038817wme.53.1556221530560;
        Thu, 25 Apr 2019 12:45:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y125sm34217832wmc.39.2019.04.25.12.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:45:29 -0700 (PDT)
Date:   Thu, 25 Apr 2019 21:45:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 ACRN guest upcall vector
Message-ID: <20190425194527.GA52659@gmail.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
 <20190425071700.GB57256@gmail.com>
 <a206d93b-9c9e-3cfd-d34f-b9d373edb09e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a206d93b-9c9e-3cfd-d34f-b9d373edb09e@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhao, Yakui <yakui.zhao@intel.com> wrote:

> > > +	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
> > > +			acrn_hv_callback_vector);
> > 
> > Why is this on two lines, not a single line?
> 
> At first it used the long function name for acrn_hv_callback_vector.
> As it exceeds 80 columns, it is split into two lines.

No, it doesn't exceed 80 columns - the last character of that line is on 
column 71.

> > Does the hypervisor model the APIC EOI command, i.e. does it require the
> > APIC to be acked? I.e. would not acking the APIC create an IRQ storm?
> 
> The hypervisor requires that the APIC EOI should be acked. If the EOI APIC
> is not acked, the APIC ISR bit for the HYPERVISOR_CALLBACK_VECTOR will not
> be cleared and then it will block the interrupt whose vector is lower than
> HYPERVISOR_CALLBACK_VECTOR.

Ok!

Thanks,

	Ingo
