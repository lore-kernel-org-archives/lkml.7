Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA4AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8A206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lvNoWPFy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lvNoWPFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfG3OoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:44:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfG3OoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:44:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AAB6E601D3; Tue, 30 Jul 2019 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564497840;
        bh=M03F65jyV0IM4iE8DiDtYX8S/b79aWNuWpDyLYqLxI0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lvNoWPFyviqYLN/4X7WnGrYD4Aatgf3/MfkshfhXunP7fw6kV/9pXrPQRG8fxsxgE
         uJHjuid74m37e9CBEZMgj2c4u+sbqrUd31Yfee5i6tqBmDXLWTthP20G03pf1J7hxQ
         su9VSzKIrNn2x76l2qOM2YdNa59+HieZWHiJVTag=
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E996601D3;
        Tue, 30 Jul 2019 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564497840;
        bh=M03F65jyV0IM4iE8DiDtYX8S/b79aWNuWpDyLYqLxI0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lvNoWPFyviqYLN/4X7WnGrYD4Aatgf3/MfkshfhXunP7fw6kV/9pXrPQRG8fxsxgE
         uJHjuid74m37e9CBEZMgj2c4u+sbqrUd31Yfee5i6tqBmDXLWTthP20G03pf1J7hxQ
         su9VSzKIrNn2x76l2qOM2YdNa59+HieZWHiJVTag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E996601D3
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
        <877e80ne9n.fsf@codeaurora.org>
Date:   Tue, 30 Jul 2019 17:43:55 +0300
In-Reply-To: <877e80ne9n.fsf@codeaurora.org> (Kalle Valo's message of "Tue, 30
        Jul 2019 11:00:04 +0300")
Message-ID: <87blxbmvkk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
>
>> On 7/27/19 1:08 PM, Linus Torvalds wrote:
>>
>>> 
>>> Ok, I have tried re-pulling and if it passes my build tests cleanly
>>> I'll push the result out.
>>> 
>>
>> Awesome. :)
>
> BTW, now when using ccache 3.2.4 (which I admit is an old release from
> 2015 but included still in Ubuntu 16.04) I see a lot of fall-through
> warnings when building the kernel. I reported this to Gustavo before but
> didn't find the time to answer back to his extra questions, sorry about
> that.
>
> I did investigate the issue at the time and IIRC it was because ccache
> strips away the comments (including the fallback comments) before
> feeding the source file to the compiler. Apparently newer ccache
> versions has a setting to avoid that but I have not tried upgrading yet.
> But anyone using old ccache should definitely upgrade.

I just installed ccache 3.4.1-1 from Ubuntu 18.04 and that seemed to fix
the problem, the big number of fallthrough warnings are now gone. No
extra configuration needed.

-- 
Kalle Valo
