Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4791C004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9EE20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfF0Uj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:39:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59815 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfF0UjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:39:24 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgbAo-0007wl-E8; Thu, 27 Jun 2019 22:39:14 +0200
Date:   Thu, 27 Jun 2019 22:39:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Alan Cox <alan.cox@intel.com>, Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordan Borgner <mail@jordan-borgner.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Mohammad Etemadi <mohammad.etemadi@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/2] Speed MTRR programming up when we can
In-Reply-To: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906272238460.32342@nanos.tec.linutronix.de>
References: <1561660997-21562-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Ricardo Neri wrote:
> By measuring the execution time of mtrr_aps_init() (from which MTRRs
> in all CPUs are programmed in lock-step at boot), I find savings in the
> time required to program MTRRs as follows:
> 
> Platform                      time-with-wbinvd(ms) time-no-wbinvd(ms)
> 104-core (208 LP) Skylake            1437                 28
> 2-core (4 LP) Haswell                 114                  2

Impressive!
