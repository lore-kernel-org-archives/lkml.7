Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2622C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4E20651
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556360541;
	bh=yFxUqGZfvP30OujG83ka+08WSj3cOU16hsLHCDixXog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8LaqSvfOughu9UmLZU3klN3WNoAphjOeUIsg+bqhKqXhutJIVgdnrqqz8w2D+IQI
	 YJU+iocMe9s4BnCFlGNtrFUToE8Y3uUpOXFSyjph/9QpO0F61hrUhDSg4hVp3Qjgxr
	 fiSFIjEMW+StOKkL18xGhlBdC7t/VKe0gZtS0sq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfD0KWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:22:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39135 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0KWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:22:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so7952056wmk.4;
        Sat, 27 Apr 2019 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=de/pNKGKEgMYXZXH86ILziX1rd53UXodWw8hsowIUv8=;
        b=FHS55DQa7HVVSxloxBDHY12J9GGU3TjeKB6GK1roRSZM4TMRfM9dYUlqrluVFxih7k
         iqu3tTBkjTimmoUUtRc9/3kuRbifUQxHT8LeZx+3LiD5TMcOcCNzsKRhSkft2PMnPL90
         Vq7F63S3Kk/KiYW3nP3OGcmjIyvV1UhWBerCN544Ts7nwYpebY5UhaYNAcmZAxFT/J8R
         UKBu4UL+M9o669No1gk+IM/qFwaWfD17ifFjhxENuLAmPXM7CnsSd3smT++LnH3M3sJn
         Y4o3DE6SPT1Yxd9AwUXeqYCObbDwq5rB1DHi/FXl3JAY0c54wEc4nLvawZwVSQ5PJZ9e
         +/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=de/pNKGKEgMYXZXH86ILziX1rd53UXodWw8hsowIUv8=;
        b=aMrj/UXK6IDoKs0Da9W82w5bj5l6Mv/xV6s4UQBdEEAHkA9M6hB5hhuxTIZLLXsUbA
         B1fddk3XmjI8wqgnZBrJoCoIUwQZFaHXrkWXBVf/RbMeaVJFTWEJhUNqj0omkZJEKmST
         eKse0fFMEg9IIz4vDIvZtQUHadlFZ1BiMvKQXGjzp+eI/69vpmYov6yR5GbnVNhP/Viv
         UdEe2Kh39E15ALkSy1q3eijvJ6rmbBsSP8OXhrJ/iyit3eV/2K7aWkH0LXr7y56x1dq+
         KTQux9z/nYT8ywCIRqQKRXd3mOWlgeDDKsWNRbgPtyeVnHV9Wji5f6jbGTg+0swIr9Fm
         wucg==
X-Gm-Message-State: APjAAAXkRrEBvuqgdVfNKsncR3FrqdPmCt7fmYamc2Xt0FaYm3icGA4s
        wDV25bzbdE4wADPyBv85c4U=
X-Google-Smtp-Source: APXvYqz9DACRCDQQ8Go5wbjbYqQ8/ZE2Kbv27Orbu2KzfOAXTXxbqBkygu2CrWu329RFlIYxLpfm2Q==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr10741651wmg.56.1556360534355;
        Sat, 27 Apr 2019 03:22:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r16sm22477270wrx.37.2019.04.27.03.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 03:22:13 -0700 (PDT)
Date:   Sat, 27 Apr 2019 12:22:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     nadav.amit@gmail.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v6 00/24] x86: text_poke() fixes and executable lockdowns
Message-ID: <20190427102210.GA130188@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* nadav.amit@gmail.com <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> *
> * This version fixes failed boots on 32-bit that were reported by 0day.
> * Patch 5 is added to initialize uprobes during fork initialization.
> * Patch 7 (which was 6 in the previous version) is updated - the code is
> * moved to common mm-init code with no further changes.
> *
> 
> This patchset improves several overlapping issues around stale TLB
> entries and W^X violations. It is combined from "x86/alternative:
> text_poke() enhancements v7" [1] and "Don't leave executable TLB entries
> to freed pages v2" [2] patchsets that were conflicting.

Which tree is this again? It doesn't apply to Linus's latest nor to -tip 
cleanly.

Thanks,

	Ingo
