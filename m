Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4DC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC488223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563856530;
	bh=AQsp9oSHDzpg8J1OlQ5PcMgGVnkDTGm7+PlHh0iIzGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VcyKdZKws4LO2AkeD7Snxf4cMbYUaIztmNngNTImnYE8hu1XSQTEt2RmaYXZ/K+Xx
	 q6tJilNHd23H96YyDRMVKNRvi4pZU6uJGf8vtugTmUoB1DqFzxBFSSbVrCZttXIKME
	 pptQ9EAGUSxulzA7D8Co4uXzapdwEj6NJRgmA/zE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfGWEf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfGWEf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:35:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1092239E;
        Tue, 23 Jul 2019 04:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563856527;
        bh=AQsp9oSHDzpg8J1OlQ5PcMgGVnkDTGm7+PlHh0iIzGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EhNhxh+G/R7iHdl9olwT2jJMO290P22pFxI4m+8/TVXtNhohSKKQWJwwkMk24ufOc
         m5mpCkj8b8w4CgZAoql0aZ9wbzRrjh5iDAWE9RhRp1TOf4VO4QvYoHAtDnqhwM73Nu
         XkgYNlcpF9aw4SPADa8wNfh/ix8qJAqFOoDZQycc=
Date:   Mon, 22 Jul 2019 21:35:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Message-Id: <20190722213527.18deeaf07ae036cce57035ea@linux-foundation.org>
In-Reply-To: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
References: <cover.1563841972.git.joe@perches.com>
        <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 17:38:15 -0700 Joe Perches <joe@perches.com> wrote:

> Several uses of strlcpy and strscpy have had defects because the
> last argument of each function is misused or typoed.
> 
> Add macro mechanisms to avoid this defect.
> 
> stracpy (copy a string to a string array) must have a string
> array as the first argument (to) and uses sizeof(to) as the
> size.
> 
> These mechanisms verify that the to argument is an array of
> char or other compatible types like u8 or unsigned char.
> 
> A BUILD_BUG is emitted when the type of to is not compatible.
> 

It would be nice to include some conversions.  To demonstrate the need,
to test the code, etc.

