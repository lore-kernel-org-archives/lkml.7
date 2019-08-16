Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07621C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85A62086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/NT9uWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfHPAqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:46:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHPAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=leeks6l507TTKsLSIQvDvRhjoaoA9WV8r0sEzS/2aAg=; b=h/NT9uWkweUdxK0rmqzgbxnbU
        q5EDmkSUR33BsIwj2jNW1RP1m6mRruRzoAxzZk1aFflJyYG9rYfvKiR6zwr+fzuDqlBcqW4Kbg1dF
        UUMpXpkIaolP++L5N7dU7VRpTzohxCTT6L/wl9Ngnnb2qRFoNJ/5Zi9bdB5sJk/WvAMR4L810h9q1
        okiHrwK+Q1SjmADeuBAp1kGTRIgQX7RumGPiio+ehgkyyH3a6hp4W6uaai38ae92+30yR3YU4VX1b
        g8IPtFAaW8SHH+osZCcdGd5ODsQoUlrCThHES1dM2s+WgmbFkhmUeOt2ViLr1YhS3aY7a1iGsT299
        Q0eAbEutw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyQNi-0004xQ-V8; Fri, 16 Aug 2019 00:46:15 +0000
Subject: Re: [PATCHv6 16/36] fd/proc: Respect boottime inside time namespace
 for /proc/uptime
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-17-dima@arista.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4db5d721-ae09-028e-64b6-4af371000acc@infradead.org>
Date:   Thu, 15 Aug 2019 17:46:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815163836.2927-17-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 9:38 AM, Dmitry Safonov wrote:
> Co-developed-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  fs/proc/uptime.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
> index a4c2791ab70b..5a1b228964fb 100644
> --- a/fs/proc/uptime.c
> +++ b/fs/proc/uptime.c

Please fix $Subject (s/fd/fs/)

thanks.
-- 
~Randy
