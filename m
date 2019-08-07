Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30682C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C0021BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfHGLlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:41:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfHGLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:41:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0860A28;
        Wed,  7 Aug 2019 04:41:21 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B16A3F575;
        Wed,  7 Aug 2019 04:41:20 -0700 (PDT)
Date:   Wed, 7 Aug 2019 12:41:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Al Stone <ahs3@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
Message-ID: <20190807114118.GJ16546@e107155-lin>
References: <20190805170338.29493-1-ahs3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805170338.29493-1-ahs3@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:03:38AM -0600, Al Stone wrote:
> According to the ACPI 6.3 specification, the _PSD method is optional
> when using CPPC.  The underlying assumption appears to be that each CPU
> can change frequency independently from all other CPUs; _PSD is provided
> to tell the OS that some processors can NOT do that.
>
> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
> method present, or an ACPI error status if an error occurs when evaluating
> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
> in violation of the specification, and only on Linux.
>
> This has forced some firmware writers to provide a dummy _PSD, even though
> it is irrelevant, but only because Linux requires it; other OSPMs follow
> the spec.  We really do not want to have OS specific ACPI tables, though.
>
> So, correct acpi_get_psd() so that it does not return an error if there
> is no _PSD method present, but does return a failure when the method can
> not be executed properly.  This allows _PSD to be optional as it should
> be.
>

Makes sense to me. FWIW,

Reviewed-by: Sudeep Holla < sudeep.holla@arm.com>

--
Regards,
Sudeep
