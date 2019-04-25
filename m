Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42375C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDA9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556184056;
	bh=YWNgoYyvCvDtcwIuALETbrxlr2Zdva1s/UiTX6pH9s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xq9I7Uf/8g3tjCun1lUp6BjmUrv/hAxbmTUTvKy3QYGtB6S50EV1NDoXX7vozHj0K
	 oM5k/EfWqymJaw4CRKDj6M8W4s3/HWqqOoBSBV8JkHIg5RlvIlKjL3ASx1njhm4OE8
	 hZg5jLnMxE6ERKgrCdWkj5XPPFkHZT6kCItWs+qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfDYJUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:20:54 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42567 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:20:54 -0400
Received: by mail-wr1-f51.google.com with SMTP id g3so29243060wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eb82By7WJcjCw1HAkKQys/AOupScDfH4sCDLQWxV+Cw=;
        b=lRTDxnkS960ZPY/XLARBw7DDqaK79Jrz97/CzTbrSs/em8cCo377ezwpnZFVQK5T3P
         lAkddWoChS9XTe+r+taRPp6n6UwM0TCfyZRChtm+CMn5PKbB533sA/9XM0iWVkiXOK/R
         bAc8hjGu9rFz6RoCpB6zDL+gO2cYdNalN5VuxlaYuwQnkpteVFIyte7AbdmR1xHPTHtu
         t36D1zCF24GmD6k5qaI3Uco/VWSQI8O+2giCZydMBBQtljzZH+o3mWI79MWqz0KwcAPq
         2j0/li9urdXCaUHP1JGDZWLDycFrC0iaALgysLsAmOLEWWm+aT5Kwnl1Kev1kDtYWYc7
         rgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eb82By7WJcjCw1HAkKQys/AOupScDfH4sCDLQWxV+Cw=;
        b=PQv5rZ04EdyumkSURZKRzRLWvVB4lQsPjpdz3MIThAqT820FzkHDW1ngn6Me+Vst5s
         YKHyzZxLm4r2/qkKZfjh5yHQ+Vq762yau5FjTmLSI8Zlh95jXmBjL+poJpw2972tkV5Z
         m+EJEnfLIHHl1DRF3v7dKxuSuOSLwcdLEVKBtynoMHutM9WIiMJzukSg+UMo5Dly6R9H
         1sdR4k+oLcY+ZIyG6CNC8JbWprE8lwpk9BGHU91jgsmoaZ4a6v/b1G6G4U4C/ylq2C+8
         NBwyAUwqoiHcj6d+dXYDDo/WZQNJUIYuQx3YQeA5YufmtM0pI5ZRaFjsraWn/c/C7SHF
         aEJw==
X-Gm-Message-State: APjAAAUaZPP0e+iC/pJLBPa89AwQpMgtu/eSKUb4mpYp4dDxeEnJ4lkB
        ZUd5RaFYD/BcChexkhrvN+p3J7br
X-Google-Smtp-Source: APXvYqxcSQV8Aq6MHEA0zGVuKKwkv4u0l+8mIDLfRExXCp1/Lay6quXVMfSi64rAN4LeYeK0RmF4yw==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr25145081wrj.16.1556184052374;
        Thu, 25 Apr 2019 02:20:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m17sm2010092wrq.27.2019.04.25.02.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:20:51 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:20:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [patch 3/3] x86/paravirt: Replace paravirt patch asm magic
Message-ID: <20190425092049.GB115378@gmail.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <20190425080810.GY11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425080810.GY11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > I think these open-coded hexa versions are somewhat fragile as well, how 
> > about putting these into a .S file and controlling the sections in an LTO 
> > safe manner there?
> > 
> > That will also allow us to write proper asm, and global labels can be 
> > used to extract the patchlets and their length?
> 
> While I'm not fan either; I think that will be worse still, because it
> splits the information over multiple files.

Yeah, so that's a drawback of the .S files.

> The advantage of this form is that it is clear how long the instructions
> are, which is important for the patching. These immediates have to be
> shorter than 5 bytes because they overwrite the CALL/JMP to the paravirt
> function.
> 
> /me eyes .cpu_usergs_sysret64 and goes wtf..

I just posted a patch that adds an assert to detect too large patching 
attempt: we'd silently ignore them before, which isn't healthy.

With the two patches I now like the .c version better.

Thomas, want me to organize all these changes, or do you want to?
1
Thanks,

	Ingo
