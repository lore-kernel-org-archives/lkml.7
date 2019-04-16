Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DD620821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfDPP0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:26:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:39154 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:26:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9932D537;
        Tue, 16 Apr 2019 15:26:11 +0000 (UTC)
Date:   Tue, 16 Apr 2019 09:26:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: kselftest: Fix KBUILD_OUTPUT usage instructions
Message-ID: <20190416092610.78b462de@lwn.net>
In-Reply-To: <20190416142651.7048-1-shuah@kernel.org>
References: <20190416142651.7048-1-shuah@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 08:26:51 -0600
Shuah Khan <shuah@kernel.org> wrote:

> Fix KBUILD_OUTPUT usage instructions. The current documentation
> is incorrect.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>

So I'll confess to being a little confused by this one...

>  Documentation/dev-tools/kselftest.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index c8c03388b9de..6c910ddaa9f9 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -39,9 +39,9 @@ Build and run from user specific object directory (make O=dir)::
>  
>    $ make O=/tmp/kselftest kselftest
>  
> -Build and run KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
> +Build and run from KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
>  
> -  $ make KBUILD_OUTPUT=/tmp/kselftest kselftest
> +  $ export KBUILD_OUTPUT=/tmp/kselftest; make kselftest

Is there a particular reason why this variable needs to be set in the
environment rather than just in make?  More importantly, though, I don't
think this would work if you run it from the KBUILD_OUTPUT directory.  What
you're really doing is running with a separate output directory, right?

Thanks,

jon
