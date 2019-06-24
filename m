Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EBFC48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC32C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfFXJaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:30:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46784 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfFXJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:30:09 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 789321dd4d6a6982; Mon, 24 Jun 2019 11:30:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/6] cpufreq: Use existing stub functions instead of IS_ENABLED macro
Date:   Mon, 24 Jun 2019 11:30:07 +0200
Message-ID: <2097869.93pjHihJNk@kreacher>
In-Reply-To: <b817a599-6564-b3d0-9c91-59c3fd5b5eb1@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org> <CAJZ5v0j0q+Z+FRpVuj39ML_c5ijo-veMMMSANdoDz1ZxAK3RgQ@mail.gmail.com> <b817a599-6564-b3d0-9c91-59c3fd5b5eb1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 24, 2019 11:22:19 AM CEST Daniel Lezcano wrote:
> On 22/06/2019 11:12, Rafael J. Wysocki wrote:
> > On Fri, Jun 21, 2019 at 3:23 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The functions stub already exist for the condition the IS_ENABLED
> >> is trying to avoid.
> >>
> >> Remove the IS_ENABLED macros as they are pointless.
> > 
> > AFAICS, the IS_ENABLED checks are an optimization to avoid generating
> > pointless code (including a branch) in case CONFIG_CPU_THERMAL is not
> > set.
> > 
> > Why do you think that it is not useful?
> 
> I agree but I'm not a big fan of IS_ENABLED macros in the code when it
> is possible to avoid them.
> 
> What about adding a stub for that like:

Well,

> #ifdef CPU_THERMAL
> static inline int cpufreq_is_cooling_dev(struct cpufreq_driver *drv)
> {
> 	return drv->flags & CPUFREQ_IS_COOLING_DEV;
> }
> #else
> static inline int cpufreq_is_cooling_dev(struct cpufreq_driver *drv)
> {
> 	return 0;
> }
> #endif

This may as well be defined as

static inline int cpufreq_is_cooling_dev(struct cpufreq_driver *drv)
{
	return IS_ENABLED(CPU_THERMAL) && drv->flags & CPUFREQ_IS_COOLING_DEV;
}

which is fewer lines of code.

And I would call it something like cpufreq_thermal_control_enabled().



