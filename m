Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110BEC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58EC218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfGCIm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:42:59 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:35944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfGCIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:42:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 204E2283D;
        Wed,  3 Jul 2019 08:42:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wing47_36df97e909a43
X-Filterd-Recvd-Size: 1658
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Jul 2019 08:42:56 +0000 (UTC)
Message-ID: <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: avoid default n
From:   Joe Perches <joe@perches.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Date:   Wed, 03 Jul 2019 01:42:55 -0700
In-Reply-To: <20190703083031.2950-1-miles.chen@mediatek.com>
References: <20190703083031.2950-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 16:30 +0800, Miles Chen wrote:
> This change reports a warning when "default n" is used.
> 
> I have seen several "remove default n" patches, so I think
> it might be helpful to add this test in checkpatch.
> 
> tested:
> WARNING: 'default n' is the default value, no need to write it explicitly.
> +       default n

I don't think this is reasonable as there are
several uses like:

		default y
		default n if <foo>

For instance:

arch/alpha/Kconfig-config ALPHA_WTINT
arch/alpha/Kconfig-     bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
arch/alpha/Kconfig-     default y if ALPHA_QEMU
arch/alpha/Kconfig:     default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
arch/alpha/Kconfig:     default n if !ALPHA_SRM && !ALPHA_GENERIC


