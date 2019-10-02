Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B647C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFC221920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfJBQZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:45746 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfJBQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:37 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 00A4A491;
        Wed,  2 Oct 2019 16:25:36 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:25:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] docs: Programmatically render MAINTAINERS into
 ReST
Message-ID: <20191002102535.1e518877@lwn.net>
In-Reply-To: <20191001182532.21538-1-keescook@chromium.org>
References: <20191001182532.21538-1-keescook@chromium.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Oct 2019 11:25:30 -0700
Kees Cook <keescook@chromium.org> wrote:

> v1: https://lore.kernel.org/lkml/20190924230208.12414-1-keescook@chromium.org
> 
> v2: fix python2 utf-8 issue thanks to Jonathan Corbet
> 
> 
> Commit log from Patch 2 repeated here for cover letter:
> 
> In order to have the MAINTAINERS file visible in the rendered ReST
> output, this makes some small changes to the existing MAINTAINERS file
> to allow for better machine processing, and adds a new Sphinx directive
> "maintainers-include" to perform the rendering.

OK, I've applied this.  Some notes, none of which really require any
action...

It adds a new warning:

  /stuff/k/git/kernel/MAINTAINERS:40416: WARNING: unknown document: ../misc-devices/xilinx_sdfec           

I wonder if it's worth checking to be sure that documents referenced in
MAINTAINERS actually exist.  OTOH, things as they are generate a warning,
which is what we want anyway.

I did various experiments corrupting the MAINTAINERS file and got some
fairly unphotogenic results.  Again, though, I'm not sure that adding a
bunch of code to generate warnings is really worth the trouble.

The resulting HTML file is 3.4MB and definitely makes my browser sweat when
loading it :)

It adds about 20 seconds to a full "make htmldocs" build, which takes just
over 3 minutes on the system in question.  So a 10% overhead, essentially.

All told, it does what it's expected to do.  Thanks for doing this.

jon
