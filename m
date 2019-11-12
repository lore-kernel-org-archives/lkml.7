Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25305C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDA2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573548187;
	bh=kp1gQPEyoh352TU4+hOLu5HIe5ul8MEwR9nWRggATfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zy78Y47Tjaq2f4GcoPhoGNBJhOwjar2Mhrv9s6zMtq0CNLJgApQ7UHonwnKM5A9h6
	 P/iCMi0/oK5kt/q4GpCxLB7pfP8NpY/z6yqi/QuryGYyY5A2D/mFiMPrUP92DMR8cl
	 LzVC3nnvMgsHjoZY0KPwUS25dI7i3CzF5/SpR0Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKLInF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:43:05 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39607 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:43:05 -0500
Received: by mail-qt1-f179.google.com with SMTP id t8so18933167qtc.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yiLxoY0TiVQXK0Lcl9b02dxhc71Cn/ILF+RTbVBp7BQ=;
        b=GZ8yL3cWwGg7PTIERVFumhZKMIwMHJk35gy2o/L/gVRIHlzH7YxbBDCfbVjCbsBfQC
         E6bMf32EUB8v+RufY+J7RZUV1pHsObXqrMxDQDdRrYYOYzciFp8us1InhXQOusH0qjiB
         0u74NYtZVMOhUVA1q477L0GQ9qSp92gWZ9P2UTHmMNzCfNehfk32T31ueRpnR2YfjOMa
         u0O9ojuC9iFcfsokXyBGzCAit/p4KcH05B/f23LcZ43C4fT7Q6r73WxHM3Lm6ZUfVpKJ
         /9q9PrmSbKtI96Rx0x+V5D4mD0ZZITrDHxA2zdU/7xaZp7uiObJvr1/RpHasH7nWvNf4
         3VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiLxoY0TiVQXK0Lcl9b02dxhc71Cn/ILF+RTbVBp7BQ=;
        b=nDJxOI1g+NiH47ahv3QWzUjUA2XDft9COcKaGl9N2o9cBDjQhlWiyow21P17EtBqju
         /hFqQCxDEycTsXakhnlypiNQhVIxMHtdSseuhFAIVUdz/Ziv3WcmKPw1HiCgmWy59Pgy
         rvuvAbP6mrnaMC+/t7Ys2Il9VcMGytzr7W8rGCwwf6SGEv3vWxeWV3zCNKZZKhm1WbY1
         EXqfvUR7hUqGZOPPHYErG53cZOB/TMSJgvdO4N7HeOnvcX1u1jtLlp7Laqtfi1a1fmdi
         RbDrHz6Amnktlnv5bwNnBJQf4/MzBh8y8emZhR7dOncYXhZZI6Co0EJA8Icrwbp8/gpD
         u5Sw==
X-Gm-Message-State: APjAAAXE4Yj/Cc4zdgzTIUXD+amM757yxTuTmigyJs50bPvuUJphYnzF
        RFcZz+AwgGGJfS+G2n0iy0s=
X-Google-Smtp-Source: APXvYqxEuKzr3Epc8bbXglpd+DiQZ/vfWAJ6bSsbb4/ANkOR8rMRRgdHfwbjvlmERFqVadpTXz5ofg==
X-Received: by 2002:ac8:60cf:: with SMTP id i15mr30519844qtm.339.1573548184331;
        Tue, 12 Nov 2019 00:43:04 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w23sm11917124qtw.87.2019.11.12.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 00:43:03 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:42:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 14/16] x86/iopl: Restrict iopl() permission scope
Message-ID: <20191112084259.GI100264@gmail.com>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.881699933@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111223052.881699933@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +static void task_update_io_bitmap(void)
> +{
> +	struct thread_struct *t = &current->thread;
> +
> +	preempt_disable();
> +	if (t->iopl_emul == 3 || t->io_bitmap) {
> +		/* TSS update is handled on exit to user space */
> +		set_thread_flag(TIF_IO_BITMAP);
> +	} else {
> +		clear_thread_flag(TIF_IO_BITMAP);
> +		/* Invalidate TSS */
> +		tss_update_io_bitmap();
> +	}
> +	preempt_enable();
> +}
> +
>  void io_bitmap_exit(void)
>  {
>  	struct io_bitmap *iobm = current->thread.io_bitmap;
>  
> -	preempt_disable();
>  	current->thread.io_bitmap = NULL;
> -	clear_thread_flag(TIF_IO_BITMAP);
> -	tss_update_io_bitmap();
> -	preempt_enable();
> +	task_update_io_bitmap();

BTW., isn't the preempt_disable()/enable() sequence only needed around 
the tss_update_io_bitmap() call?

->iopl_emul, ->io_bitmap and TIF_IO_BITMAP can only be set by the current 
task AFAICS.

I.e. critical section could be narrowed a bit.

Thanks,

	Ingo
