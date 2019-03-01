Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFC32084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551472022;
	bh=3Pg0I8cnBjw7Gy6dPSZmcN/Ku4jygC2WYMukHlVBACE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a34G46xQ1gI4DO+k9LPhxNyPR6C6A52E3FYipcEp9d77OlSoTkHHSafIEhJNpm5EJ
	 y20D3KrrRROvz2KeXSsTRHZbCEvrpRCmkSV2eIPw/qIpZUfzQYvHTlklLtVbbfRdxS
	 J3/fSyStISRtdusql3EPgVbOtM81GwNBuvRdNEIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCAU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:27:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:27:01 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 629DCB4BA;
        Fri,  1 Mar 2019 20:27:00 +0000 (UTC)
Date:   Fri, 1 Mar 2019 12:26:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] log2: make is_power_of_2() integer constant expression
 when possible
Message-Id: <20190301122659.1776b678fadcc16c1fb2ab61@linux-foundation.org>
In-Reply-To: <20190301125207.30973-1-jani.nikula@intel.com>
References: <20190301125207.30973-1-jani.nikula@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Mar 2019 14:52:07 +0200 Jani Nikula <jani.nikula@intel.com> wrote:

> While is_power_of_2() is an inline function and likely gets optimized
> for compile time constant arguments, it still doesn't produce an integer
> constant expression that could be used in, say, static data
> initialization or case labels.

hm, what code wants to do these things?

> Make is_power_of_2() an integer constant expression when possible,
> otherwise using the inline function to avoid multiple evaluation of the
> parameter.

Spose so.  But I fear that some gcc versions will get it right and
others will mess it up.  While this patch is under test I think it
would be best to also have at least one or two callsites which actually
use the compile-time evaluation feature.  Possible?

