Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAAEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833BE216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558427177;
	bh=KRPa00nR4Ldl0DxMuPSToYLVDE816ZV21OEy3V8ULIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hvtDMgoiyezmacDQO2bn0zl4m+qk9dTBMwFvAaFIde8Ql4wiYIkERDlDzl9LZHsho
	 RKCU2olXyqc0PPY1g3CYpuM0EiFtIsPaWBkAFN3ZJv/T8tlwUt4TwmFLl0X8Px3v2Z
	 9ObkFz+UMfNJQr3X+t5izBgpQ9S41ryqByQjIKQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEUI0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:26:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfEUI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:26:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so4530563wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=viWdTQ9tUhJopSAfRBIkklI9VecRmEX6du25WNkr2qI=;
        b=WMH8l2uIrdCX0ML2d36ILtIsa+Y739OvpGMoOcqFiyKZI+NbNLqKHV//aVGCi/Wab0
         whMV8dhZt72pE91lU4vvu4jOwTc4TEoaMXpKi+a6nXNV4CwuWBMov9x2R7kRAj2+JC0d
         i+yre5+BaUJgZh5wjsCokJprjWWTE7Hf7k/fAvqZkv82rC+8XKmMuY6sm96JUSqNoJk9
         JJ0QFSXA6SfOUvPIr6bgcPBN5P5teXuwxc77ABGCPkDuCPuAACfrq402gCYKBHFmNawC
         KQaJwpcIxmlEN59ddnM4zZQqg/S8ahZvoMeeqOEeq29H/ZoufEj2hkl7/LwLZovf+qhE
         0fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=viWdTQ9tUhJopSAfRBIkklI9VecRmEX6du25WNkr2qI=;
        b=Sq+0XHjv0SC1+AQJEm2K2t2yyGahDDQ5uy/6xB6hmFqOOkVmnIitqF3zpirgYU8rcB
         NmnP/s3yCeR+TpWm6wqyLJndMBegfVFWv0+0PsBGqGQm64jCt8rFvqEcfYbWS90ZVVKG
         yeX7JPTnU017DHt3UpxIvMAfk0sr0G+vK1KiY6OOus9H3Qg3J9EKL3cQrHRjPfKHvA5z
         A4GwAAYwasMXJHHNXWalRGkCr/9AO0M+T6kycqG8NQvZ/FCKsVcw0F1hsbcZspv1gMnD
         q7LVLAFVEr7efwEyzAyewEzBdTfvKBrLXoya7kd2KadYEkuFgJL/ZB1rwBW8s5Y16Zmj
         USHg==
X-Gm-Message-State: APjAAAVi+3FtD+thQHgFP6enBq3+Kr2vBaOUj7n09ZFnr+DZCmw4b27n
        j/UVCdFhXA/YRj1cNicYnkA=
X-Google-Smtp-Source: APXvYqw8gIPx4SIjsM20PuAs/2CSML+C3F9B185MKVvhky4GBvtn4BZ6jcDQSvIJxlX8Eq0hSs7Hzw==
X-Received: by 2002:adf:cf03:: with SMTP id o3mr4743916wrj.5.1558427174435;
        Tue, 21 May 2019 01:26:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l14sm18337076wrt.57.2019.05.21.01.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 01:26:13 -0700 (PDT)
Date:   Tue, 21 May 2019 10:26:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com, kan.liang@intel.com, jolsa@redhat.com,
        vincent.weaver@maine.edu
Subject: Re: [PATCH v2] perf/x86/intel/ds: fix EVENT vs. UEVENT PEBS
 constraints
Message-ID: <20190521082611.GA34626@gmail.com>
References: <20190521005246.423-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521005246.423-1-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephane Eranian <eranian@google.com> wrote:

> This patch fixes an issue revealed by the following commit:
> Commit 6b89d4c1ae85 ("perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking")
> 
> That patch modified INTEL_FLAGS_EVENT_CONSTRAINT() to only look at the event code
> when matching a constraint. If code+umask were needed, then the
> INTEL_FLAGS_UEVENT_CONSTRAINT() macro was needed instead.
> This broke with some of the constraints for PEBS events.
> Several of them, including the one used for cycles:p, cycles:pp, cycles:ppp
> fell in that category and caused the event to be rejected in PEBS mode.
> In other words, on some platforms a cmdline such as:
> 
>   $ perf top -e cycles:pp
> 
>   would fail with EINVAL.
> 
> This patch fixes this issue by properly using INTEL_FLAGS_UEVENT_CONSTRAINT()
> when needed in the PEBS constraint tables.
> 
> In v2:
>   - add fixes for Core2, Nehalem, Silvermont, and Atom
> 
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/intel/ds.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Thanks Stephane for the quick fixes!

	Ingo
