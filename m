Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F3C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5274E206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLHQFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:05:24 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:54550
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbfLHQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:05:24 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 11:05:24 EST
Received: from [192.168.0.107] ([195.114.147.136])
        by :SMTPAUTH: with ESMTPSA
        id dywbiGNGbMmCzdywcixeP3; Sun, 08 Dec 2019 08:58:05 -0700
Subject: Re: [PATCH 3/6] procfs: Use all-in-one vtime aware kcpustat accessor
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-4-frederic@kernel.org>
From:   Paul Orlyk <pavel.orlik@smartexe.com>
Message-ID: <14ca94e3-5320-6f95-9d76-101dccb7e1b5@smartexe.com>
Date:   Sun, 8 Dec 2019 17:57:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121024430.19938-4-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPD8UtUrvbG3QCUWJkQl3+Ub9Mw9p7U1V0WH+2kIqr6vtza8PI+UsZKeDLHX6EbO/hDiWcuuXhwqQzE68YfVSDB3BCL3jSePCb6xAqe/2qdU1401kzMj
 3N29B+/sADzfL+Ly/c9uRSD1lm1PwST+zmlwOi58lLnejtHeNLjWpVGtBNBG46EkzpbMlURxpPM9OAiM227MU/dU0jRYTlxM661Iq+TFCzJWTlj2GMcKVGdr
 ddn6RCcsn2tAc86uTLCSBO/wy7e2TLaMyNGpP85aEgtuy+vKCA5r3p1NHAgJmof3YRu6mb6BbFaJZp9IcEVuVsyvyMHVML5485hBVNP1tq185yNvT8ClKg7+
 8cz1ivX3pTU/g8LHKEhTR+vSiLnF7nXaJOG+uTFo3K/VxDd6Q0XKkohUboKKkG3svKScpC5wTUKB7YLABsQFmiAfFSY1vHySvjFzTWfVsFpzlm1HMc8YQuHK
 u/pFpEU7BaVCMHUSlxJ9Wv6vyAO77gwpAsM2UFqoXUJ2T7bYvfWeuO6ZDxgaCfpnsMolC3nQrpfIwRS/t1tsoBb7M4HQn1KxTt/GkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a copy-paste error. I think it should be:

- guest_nice	+= cpustat[CPUTIME_USER];
+ guest_nice	+= cpustat[CPUTIME_GUEST_NICE];

and

- guest_nice	= cpustat[CPUTIME_USER];
+ guest_nice	= cpustat[CPUTIME_GUEST_NICE];

With best regards,
Paul Orlyk

On 11/21/19 4:44 AM, Frederic Weisbecker wrote:
> +		guest		+= cpustat[CPUTIME_GUEST];
> +		guest_nice	+= cpustat[CPUTIME_USER];
> +		sum		+= kstat_cpu_irqs_sum(i);
> 
> +		guest		= cpustat[CPUTIME_GUEST];
> +		guest_nice	= cpustat[CPUTIME_USER];
>   		seq_printf(p, "cpu%d", i);
