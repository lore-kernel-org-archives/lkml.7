Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6F0C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD0820862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ab15QBgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEWIaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:30:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42555 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:30:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so5215569wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CWRQ0EYJjfxMbJnmKcTI7ZG0fOWBb9XCDQzcnCHm0dk=;
        b=ab15QBgCx0Q1cdYfe/azNEfujud37wvKO/QjSgnTFVRKW8FQCv4j3HFI6ob+hKLDsu
         dKiIHDHhQBPT/N3J44Eesz9o9jfESxiznCGA4rzGg1FQX7UTouFMJ7Ca45N/QCYCAfMc
         ImnuUxTy+ZuY6lXykGMoA9Zi0XYGG7QCApeh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CWRQ0EYJjfxMbJnmKcTI7ZG0fOWBb9XCDQzcnCHm0dk=;
        b=OApNbJq96spPFCOV7U/BL5gJX07uJzloyCT+CyAcHdIkOXr0uQ1tiohyy01fngsjA+
         WWLj17fL692+EA5ELRFUvryAWgMtMqc78ZrilW8Ed0/Xbmqaxu9ryPOUsC/HEdU+vD68
         ypYbF0xrpjN9k8R9V2sHodbwPg8D69gjHbigF7yg7yt3yIWiLnyNuT3GDXXUSIT0TuJP
         X8sKuqbqZwIdlOwchxR2HDdKErjlNOLare6DaZBVyJlif1SaJHUZVi/QluT/U1FIBaYC
         Y3A4cmdIL5gUGuoTg80A2l2F39nXTsu9xNPX2PC6yhfai56y18AQqyZEJvoGbb3z8IS6
         wP4A==
X-Gm-Message-State: APjAAAVX6ahzAB4haNFvZrd7GqHZU8p2araJikeI5VLrztVIqG9GaYwG
        J3UE6YGNkJuxwbkFMEjxdCp1QA==
X-Google-Smtp-Source: APXvYqwek6Tl0tiKwDs0xQJs11UWCKfT0GBtpbpuH2Rtwvb8IKmaXLyamsDRFPj5dEubkjO1mx22Qw==
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr110557wrq.64.1558600222084;
        Thu, 23 May 2019 01:30:22 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id m10sm9287874wmf.40.2019.05.23.01.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 01:30:21 -0700 (PDT)
Date:   Thu, 23 May 2019 10:30:13 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com, aou@eecs.berkeley.edu, arnd@arndb.de,
        bp@alien8.de, catalin.marinas@arm.com, davem@davemloft.net,
        fenghua.yu@intel.com, heiko.carstens@de.ibm.com,
        herbert@gondor.apana.org.au, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, linux@armlinux.org.uk, mattst88@gmail.com,
        mingo@kernel.org, mpe@ellerman.id.au, palmer@sifive.com,
        paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org,
        rth@twiddle.net, stable@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vgupta@synopsys.com
Subject: Re: [PATCH 00/18] locking/atomic: atomic64 type cleanup
Message-ID: <20190523083013.GA4616@andrea>
References: <20190522132250.26499-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522132250.26499-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, May 22, 2019 at 02:22:32PM +0100, Mark Rutland wrote:
> Currently architectures return inconsistent types for atomic64 ops. Some return
> long (e..g. powerpc), some return long long (e.g. arc), and some return s64
> (e.g. x86).

(only partially related, but probably worth asking:)

While reading the series, I realized that the following expression:

	atomic64_t v;
        ...
	typeof(v.counter) my_val = atomic64_set(&v, VAL);

is a valid expression on some architectures (in part., on architectures
which #define atomic64_set() to WRITE_ONCE()) but is invalid on others.
(This is due to the fact that WRITE_ONCE() can be used as an rvalue in
the above assignment; TBH, I ignore the reasons for having such rvalue?)

IIUC, similar considerations hold for atomic_set().

The question is whether this is a known/"expected" inconsistency in the
implementation of atomic64_set() or if this would also need to be fixed
/addressed (say in a different patchset)?

Thanks,
  Andrea
