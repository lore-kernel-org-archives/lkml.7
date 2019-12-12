Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED5C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB280206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfLLR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:58:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43734 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfLLR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:58:38 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 1bbbbed619a5c005; Thu, 12 Dec 2019 18:58:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PM: Avoid attaching ACPI PM domain to certain devices
Date:   Thu, 12 Dec 2019 18:58:35 +0100
Message-ID: <1834000.7vQ4Mp1vVU@kreacher>
In-Reply-To: <20191211163643.CAFFC214D8@mail.kernel.org>
References: <1773028.iBGNyVBcMc@kreacher> <20191211163643.CAFFC214D8@mail.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 11, 2019 5:36:43 PM CET Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: e5cc8ef31267 ("ACPI / PM: Provide ACPI PM callback routines for subsystems").
> 
> The bot has tested the following trees: v5.4.2, v5.3.15, v4.19.88, v4.14.158, v4.9.206, v4.4.206.
> 
> v5.4.2: Build OK!
> v5.3.15: Build OK!
> v4.19.88: Build OK!
> v4.14.158: Failed to apply! Possible dependencies:
>     001d50c9a14f ("PM / Domains: Remove obsolete "samsung,power-domain" check")
>     919b7308fcc4 ("PM / Domains: Allow a better error handling of dev_pm_domain_attach()")
> 
> v4.9.206: Failed to apply! Possible dependencies:
>     001d50c9a14f ("PM / Domains: Remove obsolete "samsung,power-domain" check")
>     34994692216b ("PM / Domains: Do not print PM domain add error message if EPROBE_DEFER")
>     35241d12f750 ("PM / Domains: Abstract genpd locking")
>     59d65b73a23c ("PM / Domains: Make genpd state allocation dynamic")
>     72038df3c580 ("PM / Domains: Fix error path during attach in genpd")
>     919b7308fcc4 ("PM / Domains: Allow a better error handling of dev_pm_domain_attach()")
> 
> v4.4.206: Failed to apply! Possible dependencies:
>     001d50c9a14f ("PM / Domains: Remove obsolete "samsung,power-domain" check")
>     0106ef5146f9 ("PM / domains: fix lockdep issue for all subdomains")
>     076395cae203 ("PM / Domains: Propagate start and restore errors during runtime resume")
>     1f7371b2a5fa ("drm/amd/powerplay: add basic powerplay framework")
>     25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
>     288912cb95d1 ("drm/amdgpu: use $(src) in Makefile (v2)")
>     34994692216b ("PM / Domains: Do not print PM domain add error message if EPROBE_DEFER")
>     35241d12f750 ("PM / Domains: Abstract genpd locking")
>     39dd0f234fc3 ("PM / Domains: Allow genpd to power on during system PM phases")
>     3fe577107ccf ("PM / Domains: Add support for removing PM domains")
>     4d23a5e84806 ("PM / Domains: Allow runtime PM during system PM phases")
>     53af16f79fbc ("PM / Domains: Silence compiler warning for an unused function")
>     59d65b73a23c ("PM / Domains: Make genpd state allocation dynamic")
>     624c8df7d282 ("PM / Domains: Remove redundant pm_runtime_get|put*() in pm_genpd_prepare()")
>     72038df3c580 ("PM / Domains: Fix error path during attach in genpd")
>     7eb231c337e0 ("PM / Domains: Convert pm_genpd_init() to return an error code")
>     8f9945558785 ("drm/amdgpu/acp: fix resume on CZ systems with AZ audio")
>     919b7308fcc4 ("PM / Domains: Allow a better error handling of dev_pm_domain_attach()")
>     a8fe58cec351 ("drm/amd: add ACP driver support")
>     cdb300a041f5 ("PM / Domains: Fix potential deadlock while adding/removing subdomains")
>     fc5cbf0c94b6 ("PM / Domains: Support for multiple states")
> 
> 
> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?

This has been present in linux-next for some time and the commit carries a Cc: stable
tag.  No need to do anything special AFAICS.

Thanks!



