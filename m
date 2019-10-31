Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46032CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210712173E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfJaSQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:16:53 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:40826 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726602AbfJaSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:16:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 354811822563C;
        Thu, 31 Oct 2019 18:16:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sea16_75aca35dfcc57
X-Filterd-Recvd-Size: 1678
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Oct 2019 18:16:48 +0000 (UTC)
Message-ID: <734ef2833e4e4e7bded92e9d964bc2415aadf3c4.camel@perches.com>
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
From:   Joe Perches <joe@perches.com>
To:     Andrea Righi <andrea.righi@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        security@kernel.org, Kees Cook <keescook@chromium.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Date:   Thu, 31 Oct 2019 11:16:39 -0700
In-Reply-To: <20191030201201.GA3209@xps-13>
References: <20191029182320.GA17569@mwanda>
         <87zhhjjryk.fsf@x220.int.ebiederm.org> <20191030074321.GD2656@xps-13>
         <87r22ujaqq.fsf@x220.int.ebiederm.org> <20191030201201.GA3209@xps-13>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 21:12 +0100, Andrea Righi wrote:
> Then memset() + memcpy() is probably the best option,
> since copying all those fields one by one looks quite ugly to me...

A memset of an automatic before a memcpy to the same
automatic is unnecessary.


