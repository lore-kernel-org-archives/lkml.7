Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A24AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BF720706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575595421;
	bh=+snBBNFYQv8xmYqi1k67brmlOE46FSD3M+ydplTWD0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=udExsehN4WXRfMB4jxqLqI8bzUX/mnNFZWhpcOl3hoZTNzdH8/vMDHk62LXMzRjaZ
	 Klhrx95OgGp3L3eFguYPLFIWpcGWxuskH/sdXwDqYKnWvVZrzAaGcaBZqRVe2TWf6t
	 /2fAnK8Zv3KvlrPLPk98MO1DyeeAZbrFovjscrsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFBXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfLFBXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:23:39 -0500
Received: from devnote2 (unknown [180.22.253.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B4020706;
        Fri,  6 Dec 2019 01:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575595419;
        bh=+snBBNFYQv8xmYqi1k67brmlOE46FSD3M+ydplTWD0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k8cjoOPvcX3iBd3/y/6lsJSEI91mBnpHgvQa8SMeOJplIiGkjdxAcKLes6qlLz08v
         yD1iboa/DygvAy7yPkH4aU54IMmrAf/TFnFAnZuNNVi5y8BvKlvbJaDK2y96AMLR7o
         h4pFnHjAHA2wgNAUsLjd6zN0L9HszCMEAZAhLx7A=
Date:   Fri, 6 Dec 2019 10:23:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH v2 0/3] selftests: safesetid: Fix some bugs in
 safesetid test
Message-Id: <20191206102334.35f578b1e79e57740e56a5b8@kernel.org>
In-Reply-To: <3bad79d5-eada-7e96-4210-c4888bfb710f@kernel.org>
References: <157554844882.11018.13436399905210284553.stgit@devnote2>
        <CAJ-EccNKk30b_wtvz=PUVmMVfF8YNagXMcy3Uhj53DzFbgmb6A@mail.gmail.com>
        <3bad79d5-eada-7e96-4210-c4888bfb710f@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 09:44:52 -0700
shuah <shuah@kernel.org> wrote:

> On 12/5/19 9:40 AM, Micah Morton wrote:
> > On Thu, Dec 5, 2019 at 4:20 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>
> >> Hi,
> >>
> >> Here is the v2 series to fix build warnings and erorrs on
> >> kselftest safesetid.
> >> This version includes a fix for a runtime error.
> >>
> >> Thank you,
> >>
> >> ---
> >>
> >> Masami Hiramatsu (3):
> >>        selftests: safesetid: Move link library to LDLIBS
> >>        selftests: safesetid: Check the return value of setuid/setgid
> >>        selftests: safesetid: Fix Makefile to set correct test program
> > 
> > These 3 fixes look good, thanks. Were you thinking they would go
> > through my SafeSetID tree or is there a dedicated one for selftests? I
> > guess if you're not sure someone else on here can chime in, or I can
> > just take them through my tree if I don't hear anything.
> > 
> 
> Yes. There is a linux-kselftest tree dedicated to selftests.
> I can take them.

Thanks Micah and Shuah!

> 
> 
> >>
> >>
> >>   tools/testing/selftests/safesetid/Makefile         |    5 +++--
> >>   tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
> >>   2 files changed, 13 insertions(+), 7 deletions(-)
> >>
> >> --
> 
> thanks,
> -- Shuah
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
