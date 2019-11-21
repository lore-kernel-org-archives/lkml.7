Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F57C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC71206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574356449;
	bh=Ti/dngwhJigigI0vZvNQ4kqW2wZg+aYllS0eHqXlFSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GDd147hiboFq1SOXBzNt8wm0GT583r/51I8t+6Zzv52xRf60dixla2igm3YJwLZwS
	 ZuOg3yDeprfvlldA5iSYRyDTQn+eae/mPilkcR9Pkrxp+CbGkn6sHdnGh3vz4zATbz
	 /iHAXsxVQNQvRMpTIElgQZLWUlC22GPtFpHZlCLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKUROI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:14:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfKUROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:14:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so5401522wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3dXbaeM8/fgEzXWHf4j73/qD2/JvKlKOG24q2kDLhU=;
        b=GcLaoiocTB43exyz2Sw7c1bE8QYr4ZxVv8UNC56FfbxP3Gkhhfz5i0jLfiYUPQCMoa
         AUGVKhWAFxYXZdN3aWMfWxjEZQOZ+8ggRIzXKkCUzea0eV45bxX5v+DssT28edUaD12Z
         ls5k4OgXVu/SKelNO5qo4NtGYWuTVY+CDVaN192Wx6SoGGJh1M7uWrQHTMZ6xM2lY9Le
         TD7KveNHoXLh5htI3rXzHQL5xCcrG9uSqeXNA/qgfqBCgssLx3zUQ5qRE39PwtS2f0qw
         OtPwq2v51cjIdhQJcex+IkJBSUZwEomo3oqSSjcKQp/m6LqYcKXAQgB9vzQnfk3F1RvE
         zrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3dXbaeM8/fgEzXWHf4j73/qD2/JvKlKOG24q2kDLhU=;
        b=DV2Qt4gOt2kBjfo+XkbxfSJbEIkaDIKiL81r0yvDi6FeGLP5R/C4TjVsnhk4xesCEs
         6S6RYfNHk17WYMa751aYLD+iTYoqWN0pN0pngBHNIXhzEfNGsdoFC6B5hoIQ+iHwGSlk
         yJQrIxM9iaNI5KNJRwzEJw6j4euEVMYKm2a84NIkbe85zCl+ha9xyNAG0ES/raXoK/aq
         9ZuXSxqkZHAAvZDtjRdaMiQWiBqYipXyHUNpdEcM6rCU+lIFnuMbWNBgb27CWJyhCWwm
         YRNB0dRM9rk9PoIdKrA5v8m8vb3XuOx5Q123Etzzt5UDcBjdkZj4wD147Gi3RnT/04kl
         1ZzA==
X-Gm-Message-State: APjAAAV8MClJ4QAVW8pRV39wfYGb4zVySr9t6fpm07n74Q1fTc8JYc/s
        1e3jBIQWipWMpNJLgVrA8uk=
X-Google-Smtp-Source: APXvYqxEpvzKJM8+RiUL39rs/NOLQBXQix4AlKzUu9X1je8OxVPAWunSU7INi5WBD4jktiReGQop1A==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr1519815wrp.363.1574356444030;
        Thu, 21 Nov 2019 09:14:04 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v184sm297255wme.31.2019.11.21.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:14:03 -0800 (PST)
Date:   Thu, 21 Nov 2019 18:14:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121171401.GE12042@gmail.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121161410.GA199273@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121161410.GA199273@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Fenghua Yu <fenghua.yu@intel.com> wrote:

> > This feature MUST be default enabled, otherwise everything will 
> > be/remain broken and we'll end up in the situation where you can't 
> > use it even if you wanted to.
> 
> The usage scope of this patch set is largely reduced to only real time. 
> The long split lock processing time (>1000 cycles) cannot be tolerated 
> by real time.
> 
> Real time customers do want to use this feature to detect the fatal 
> split lock error. They don't want any split lock issue from BIOS/EFI/ 
> firmware/kerne/drivers/user apps.
> 
> Real time can enable the feature (set bit 29 in TEST_CTRL MSR) in BIOS 
> and don't need OS to enable it. But, #AC handler cannot handle split 
> lock in the kernel and will return to the faulting instruction and 
> re-enter #AC. So current #AC handler doesn't provide useful information 
> for the customers. That's why we add the new #AC handler in this patch 
> set.

Immaterial - for this feature to be useful it must be default-enabled, 
with reasonable quirk knobs offered to people who happen to be bitten by 
such bugs and cannot fix the software.

But default-enabled is a must-have, as Peter said.

Thanks,

	Ingo
