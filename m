Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A447C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F32218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfCUTm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbfCUTm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3554AF46;
        Thu, 21 Mar 2019 19:42:55 +0000 (UTC)
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, nelson.dsouza@intel.com
References: <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <20190321171047.GR5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
 <20190321182011.GT5996@hirez.programming.kicks-ass.net>
From:   Tony Jones <tonyj@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.com; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QbVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5jb20+iGMEExECACMFAlZxtcMCGwMHCwkIBwMCAQYVCAIJCgsEFgID
 AQIeAQIXgAAKCRCxWFshH+JKF0LzAJ4nV13dNEuh00Txem/YNg5CCgop3QCeJPkAXh12H/1a
 pLADSewpCEOjH9+5Ag0ESRCZvBAIAM6/WXd7+wddDg7VXO18WzHt1uqNRXQpS/WSIC7+tc4V
 nLWnygzLvzFEr8ZmBatNKXnA/0n1/KMQKwNNvrENhPv2W+CezQFiAMQn5su1RNMAwa2R/4QW
 qSMfy4FamH2fUcPmuBV65ZNcvKEAsIb4/pFq5u1e6JUdGjzstTRRjVMkxUjI/qW5sYjTl3Qs
 VVEHt1BNZPcgPpiC48mkWp8JIgiwozb0Ty/PENNewXYVQVmZs/KocFzf0a4wnAx7D1+TtHr+
 vDC8rrIeZn7pLrwqs1tWN0JfosH8BMOZTZkBnaFfXLIOyT+7Gg4nEhTtinGbzG7wzKrTxYqX
 ReVFqH2Smd8AAwUH/2+XFTcm+YvECNBuwTxgTZ+FZUF+Z+uk7DwZ60TTotzIU01RAQqfLPo6
 lIyY1xI4wPjuISJu0KnbKM7q8OxpXENANOnSMzv9UVIJWWTKAtCS+N2UJift/shay41oBh+n
 r+gDm2Cx+2bo4AAeZ9B8tmSAoc7Ciymx6bRbQb6QygfLqXavhrp7GOKDd8Bmuu4fbB6g748q
 euAs4J/Bubhi8Md3/3nWxAis+ZD1EswoRJN7Liu+NkhD9Nb+K2uVl/PB5/NTYxgckDM/WnCS
 3QuxXy8172zWtCoLw2kpZWH7CSKBgs93ilTrk1lzomhCCrsvN9/t5q9j7pSwsiysrABHXSqI
 SQQYEQIACQUCSRCZvAIbDAAKCRCxWFshH+JKF4YEAJ9RBgEy2T0udwLfbfqd0vAZDSPckQCf
 QNDpi5Yr/q8BHrGBpRnhjWih0yc=
Message-ID: <fa2d8695-f87c-b141-a19b-2ed4b80df987@suse.com>
Date:   Thu, 21 Mar 2019 12:42:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321182011.GT5996@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 11:20 AM, Peter Zijlstra wrote:

> Might be best to have someone test this.. someone with ucode and a
> machine etc.. :-)

If your own company can't oblige you here Peter :-) I'm sure I can make some time to test it.
