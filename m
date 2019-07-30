Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE2CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAE9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EEApQTjw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QAcUrPRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfG3IAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:00:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3IAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:00:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29A6A6047C; Tue, 30 Jul 2019 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564473610;
        bh=oYWp8GGhkJZ/Gq0TvA+iUl2CLPf5vkT5xim0i1Wuekg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EEApQTjwz9KIIErDBnldqazoA2BSw0Nu6RRnzUGXXEoro6iISx3jFIURHiwpJAeJE
         r4mAyD26CTAlvsFbfmINT2MzunpIa2wfuiyFeyoMn32I2bjQhEeqJaAXHkEdT8SfA3
         BMNp+tcpYB3Evlq1QcISL6VV5bhY1BWc27b0ZNgg=
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E140B6047C;
        Tue, 30 Jul 2019 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564473609;
        bh=oYWp8GGhkJZ/Gq0TvA+iUl2CLPf5vkT5xim0i1Wuekg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QAcUrPRh7eiUn4umUMgE0oYi87MRVknJO/QvBKalE/MUOKA4HNdw4+rT2k63O0GiM
         PaJVzJYUKaOQIdN3FqaO6yA1nlKfWFOiQTIWhSXj3MlyXSaI5vitiEAwQx2U83ff86
         jaV/vXQnx98AR3FEL5Wl+d8jWLjXaDIV0mntwEJc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E140B6047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc2
References: <20190726025521.GA1824@embeddedor>
        <CAHk-=whw2Pdh-gAObS2wt4pF6Pgus9aHNS2WaVBkgYGsmaZyJw@mail.gmail.com>
        <d324cb7d-9991-e913-8254-48cab2066f76@embeddedor.com>
Date:   Tue, 30 Jul 2019 11:00:04 +0300
In-Reply-To: <d324cb7d-9991-e913-8254-48cab2066f76@embeddedor.com> (Gustavo A.
        R. Silva's message of "Sat, 27 Jul 2019 14:38:26 -0500")
Message-ID: <877e80ne9n.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> On 7/27/19 1:08 PM, Linus Torvalds wrote:
>
>> 
>> Ok, I have tried re-pulling and if it passes my build tests cleanly
>> I'll push the result out.
>> 
>
> Awesome. :)

BTW, now when using ccache 3.2.4 (which I admit is an old release from
2015 but included still in Ubuntu 16.04) I see a lot of fall-through
warnings when building the kernel. I reported this to Gustavo before but
didn't find the time to answer back to his extra questions, sorry about
that.

I did investigate the issue at the time and IIRC it was because ccache
strips away the comments (including the fallback comments) before
feeding the source file to the compiler. Apparently newer ccache
versions has a setting to avoid that but I have not tried upgrading yet.
But anyone using old ccache should definitely upgrade.

-- 
Kalle Valo
