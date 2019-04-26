Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4259B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556258275;
	bh=VNfjvmJre88DFOWWEUupYXEiVY0nfyXMkPbOFklaGV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wdwvRekjtd9pbPUEVcdpvR5kSJJ2wc2A3sFvuaFn09+xSdVbtkpJVw5RZng04dEUe
	 7638yRTGg4IRW1rwNuXxkNFzoE1d98xNTOoKUntbi1w03OjZ5sgTe2Xh5IFGS3aro4
	 R9Q4fS5HS2VF+D3ASES0lBooTE6itRiQGlAkU5XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDZF5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:57:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46655 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZF5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:57:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so2615903wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dpMAGAN1vbb6z/4n5l2p731u/9zMe56bSxcsSdswaqA=;
        b=hRDbhdANTEa47hbmLO6xILJFp5awe+3uRxHDR7Jobxm8laa1oEZPOm39KcjGXkFmch
         CKH7Obl+PoCcbyNvEp2mAGzqTX+tuF8F9JHYAIOimOd5Qtg36sMKvQDoqgwj4W8z5oSD
         LWMPX6nwuPbNPy+jMiJj24qrl4vL/m+hirDxGJUZJ4MthlZ5V5VvixLC/ctHGteB7Tr/
         r02RGWxJUriMU4FirephR1U174c59Pfh0pLpyPLXBvTrc6LeZY4hGnvIgEt7OQsxkYrR
         QvtqMRqhO/9Tahnt4lBDtRmK4XSJ7uNpuYYIf3olE2nuTLQjoTWwwMWDKxOOKA9fXJU+
         TRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dpMAGAN1vbb6z/4n5l2p731u/9zMe56bSxcsSdswaqA=;
        b=a8waC34PSwp9FmAYmMFGqOdGLTUC+Irp2omREL6V5dGIkcu9/Sn8k3V4v8QauuqYor
         x6Xk+gAfXLxIE88FY+AMTRfDkcLnzHWrkh1utx9XM/qoIimzDMPMEcxXN6+703000k0a
         tminBsbY5lDUWpbwX1l2fTfRICwx5xnrOMeESYv3RYutp7Ix+uUS5JKTi1Of5ThT9trM
         bgZTgliM4qmqW3G9yVUgjqE1m0cpJV7sW2FekJIRSI6EtDtVq8UGcUat7sHoEyog8XLn
         t3qN+ACeKrMxZx7oXt/zXJq+fDtfJsuwzkw/4TcxF0jzx9EK88ZqEsVdU1O/NSunMQoO
         +UDw==
X-Gm-Message-State: APjAAAVRueP3cV/2oj1KD0zdAJhdsLVTkDi11zISOF216UMNCebntykU
        W4TiHuyiJRjMAhVe6hwXqeI=
X-Google-Smtp-Source: APXvYqzw7Zf/W3h7X3u59NKor1wpOJVw37KCukPuKexdu0J14mRTpZl7RBWL8L1p6h7U+uOn/KiGQw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr25516837wrr.275.1556258271388;
        Thu, 25 Apr 2019 22:57:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z11sm23181125wmf.12.2019.04.25.22.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 22:57:50 -0700 (PDT)
Date:   Fri, 26 Apr 2019 07:57:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 ACRN guest upcall vector
Message-ID: <20190426055748.GA122831@gmail.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
 <20190425071700.GB57256@gmail.com>
 <a206d93b-9c9e-3cfd-d34f-b9d373edb09e@intel.com>
 <20190425194527.GA52659@gmail.com>
 <12c00f28-a1a8-8642-6912-ec9b706b589e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c00f28-a1a8-8642-6912-ec9b706b589e@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhao, Yakui <yakui.zhao@intel.com> wrote:

> > > > Does the hypervisor model the APIC EOI command, i.e. does it require the
> > > > APIC to be acked? I.e. would not acking the APIC create an IRQ storm?
> > > 
> > > The hypervisor requires that the APIC EOI should be acked. If the EOI APIC
> > > is not acked, the APIC ISR bit for the HYPERVISOR_CALLBACK_VECTOR will not
> > > be cleared and then it will block the interrupt whose vector is lower than
> > > HYPERVISOR_CALLBACK_VECTOR.
> > 
> > Ok!
> > 
> 
> I will add some comments for calling entering_ack_irq in
> acrn_hv_callback_handler. Is this ok to you?

Yeah, thanks!

	Ingo
