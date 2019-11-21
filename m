Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD78DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B17206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574356233;
	bh=TQAp31TQd/PoRMrUY4PZZ23vT+rNXRT1+XjHUhV+gt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzNwq4xUhBjOHLmfLBit7aRhCEHhWrUH5LQ7bhvGRfQ2/PbZx0jRZTjcGWwfGa3Qp
	 V5IDhUfgE46/1Z0V2P8fEcB7uLNEtvAyMWI1UglE1nFuuoP7AQcX/U3ZviJsx4HFzO
	 xc8WJ/BV4ufWvJmK3KZreU3Fjf0+Hu0WMdApdbXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKURKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:10:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKURKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:10:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so4589724wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CsAplDPH9gsq/5aIIvzeOKFIV0+PufrPE2reytqBkLQ=;
        b=RgK+f1sqhppZpaZg6rVzFW21T0sRFoUdcjIB2T9WSOck+wRtqHahgzj+CVwOZgrnRL
         Y2cqNRySjUCdHjdCICv9refzgRH/duSyzk0Zi0WK9w8JYEWcjDLsY9gmhpWswJISxRPW
         A2q9C1RT2cxRTqI+ajQWYIUKUB99p7DmTGRMln0zEibgd9PfW0lgR9CVc9dyfQFI1eYF
         xmgEqUkcbxPNO6jrLGmVsytU6Y72lggSh+aEz57fbmvigovXLMcSgHW8fqwLazkCWqEW
         6NHl2mQTOpNhJCSuxf20/SDMc1Quruz8DQ7XRKjF2pPvit9FNGPWL5wj6NaEXzU/uj+f
         GjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CsAplDPH9gsq/5aIIvzeOKFIV0+PufrPE2reytqBkLQ=;
        b=tiHg6bFN8y1ssFMGtLbKY3TOVUgLpnBWKIN770OMhqss+nXJ5PZtgJXfdSNKyG0/dx
         uW2l7vah0zuMim3uPEnyZkfoIGf2JLHQHstFlnWFmTb8Jvm3+7713vySafJXbtPngvb2
         wGbCVf3r1OpbmvVbSFihONT3DCfecwfD5sM0S89b/A6Ntsg6EDQDD02Xs6ZbUBAmO6Pp
         HEHhioMPkYoH1FataCPtTl9w9WPyes2ah/xlwLt8MUumr2qDdjYN/HNatSHRz4neCJsY
         +6VxQmyDyVNzQHAx8LmgkerrM5n6MOHnRckA4u4S2CA9pVi/J+8aHtiYbY4acRaOzrLP
         tblw==
X-Gm-Message-State: APjAAAXGgsbjCe4itxTn2d2lZuJwCgLwvRTe9V2FsPvQEWNP9U3USlqZ
        EDsOpI7OtQBpmLVvU7gcSZY=
X-Google-Smtp-Source: APXvYqx+RMx6bin2BSJxxRUgccxdw/fvt4Q8Diu78zAXHtZCXS4M9rrSczBYZj6Zti6HIPXGjSfaFg==
X-Received: by 2002:a05:600c:214c:: with SMTP id v12mr11218627wml.124.1574356230064;
        Thu, 21 Nov 2019 09:10:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 19sm4774546wrc.47.2019.11.21.09.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:10:29 -0800 (PST)
Date:   Thu, 21 Nov 2019 18:10:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/4] x86/mm, pat: Cleanup some of the local memtype_rb_*
 calls
Message-ID: <20191121171027.GC12042@gmail.com>
References: <20191121011601.20611-1-dave@stgolabs.net>
 <20191121011601.20611-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121011601.20611-3-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Davidlohr Bueso <dave@stgolabs.net> wrote:

> Cleanup by both getting rid of passing the rb_root down the helper
> calls; there is only one. Secondly rename some of the calls from
> memtype_rb_*.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Note that the changelog doesn't match what the patch does - in reality 
the renames are done in a separate patch.

I fixed up the changelog as you can see it from the tip-bot notification.

Thanks,

	Ingo
