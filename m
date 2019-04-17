Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97937206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbfDQVTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:19:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50894 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDQVTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:19:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGrxu-0007ui-LE; Wed, 17 Apr 2019 21:19:34 +0000
Date:   Wed, 17 Apr 2019 22:19:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/26] compat_ioctl: add compat_ptr_ioctl()
Message-ID: <20190417211934.GW2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-9-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:46PM +0200, Arnd Bergmann wrote:
> Many drivers have ioctl() handlers that are completely compatible between
> 32-bit and 64-bit architectures, except for the argument that is passed
> down from user space and may have to be passed through compat_ptr()
> in order to become a valid 64-bit pointer.
> 
> Using ".compat_ptr = compat_ptr_ioctl" in file operations should let
> us simplify a lot of those drivers to avoid #ifdef checks, and convert
> additional drivers that don't have proper compat handling yet.

You forgot to mention that it even gets the previous commit to build ;-)
IOW, that needs to be reordered.

