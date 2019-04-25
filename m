Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A9C20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220893;
	bh=mG8xN3W1XIlLRA9yqVi+oxVSsHjkQT2l8cvRN/yGC+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sO8RFjd9Dny1lHWFDu3rKCcAb6SgCIoLymRbFeINnYx7OjO+HoqRljwh8w46tUY9J
	 G+IM6aQQP+EBRUwqhnYJ2yDTTPbsJM/HNBchqHT0eayXL/xVgelodiwP/hRpSRanlw
	 fXA2QLwkidswClKslLsTU5xSWk3P3Vam7LxyRBAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDYTev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:34:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYTeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:34:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so920540wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLa64zhlXxMyC2Tir99IyG526INuSRHP5IVsq0Po6r8=;
        b=dsQVzcVw5oduW5rMqps2yFvwW1g6653YJKIHakrbvwX22KQg/vLLwyhVHJY6lcD/2z
         s9tvG8JeaXxDL7JBItyScC8BI/oswkHc5wmJcOVf0wIXBzc/nij5sRAEG9Q74ocSGKVn
         Hygrzpp9kwHCvHfDZ/tTSqpBuuKKzlJPqZOEn6hfa7gAelmBcTu3u87qgAJoODTCoa0V
         gz269gOQ7FSWdVZjt9DpRvTGA0nmn+5E3AN9P1/UuoEbXIUQyTP/FUa460c7kYw9Gq+f
         d8SFwpj0ApdBwAUAsir5Jp9XCywRXlz51v3g+4bxAhQjp7Z5DpNFIPSW3WBP7v25krLc
         86Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLa64zhlXxMyC2Tir99IyG526INuSRHP5IVsq0Po6r8=;
        b=QNhunP4KRwSyOxhaNHT5D3p2iN/X3RvHI0jVp/Inlbm10m+4svnW/kFQl72XKocekn
         U44RchmhpH1vG3arx0anTj6TCF80nGUXmzX0l9bhS8zbyOskxi6GytKsP8YfhCep02rn
         csWAGHWje+nFXetQKg+OAESy/SC8FlMEvw8Y2rwv7ynzyO0YW2zN+Ki8YVouRV/nDnQU
         ONeRje9CdmDcGfStRZzvMFDlZQuN+Ncx6bscV+fhUuZOePpueTI2jHj+8JjDx9tAhHBH
         LEuoFEbiG3eg40E0yyDrZGaPweJbF1Un4iy6zDL7BYjTejmsXA/VPI3G3VR+TQIKnx6x
         lafA==
X-Gm-Message-State: APjAAAXV0q4TX2oQNu+CrTUANUBWomPj8lfYcQfXW13rxiync3Wm6Pnf
        4dllSAmbEE7bMKWEPI34fow=
X-Google-Smtp-Source: APXvYqxTvxrf/QIlHZbDx1Kj2iK/CBWPtKOxMIBY1fslg/6oxMcTHefxmcYcFo99D9k2gM1p3vrIGQ==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr2427398wrn.157.1556220888979;
        Thu, 25 Apr 2019 12:34:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e1sm21562109wrw.66.2019.04.25.12.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:34:48 -0700 (PDT)
Date:   Thu, 25 Apr 2019 21:34:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190425193445.GB91578@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <alpine.DEB.2.21.1904252054560.1768@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904252054560.1768@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> It exists already: /sys/devices/system/cpu/smt/control
> 
> Setting it to off will offline all siblings, on will online them again.

Indeed, added by 05736e4ac13c last year (and I promptly forgot about it 
...) - I was thrown off a bit by the 'nosmt' flag Mel used, but that's 
probably because he used an older kernel.

Thanks,

	Ingo
