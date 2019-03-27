Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ABCC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D9820700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfC0Uab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:30:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26373 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfC0Uaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:30:30 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2RKU9wd052787;
        Thu, 28 Mar 2019 05:30:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 28 Mar 2019 05:30:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126072090247.bbtec.net [126.72.90.247])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2RKU4cv052765
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 28 Mar 2019 05:30:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Linux 5.1-rc2
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
 <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
 <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
Date:   Thu, 28 Mar 2019 05:30:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/28 4:16, Kees Cook wrote:
> The part I don't understand is what you've said about TOMOYO being
> primary and not wanting the others stackable? That kind of goes
> against the point, but I'm happy to do that if you want it that way.

Automatically enabling multiple legacy major LSMs might result in a confusion like
Jakub encountered. For a few releases from 5.1 (about one year or so?), since
CONFIG_DEFAULT_SECURITY_* will be ignored after CONFIG_LSM is once defined in
their kernel configs, I guess that it is better not to enable TOMOYO automatically
until most people complete migrating from CONFIG_DEFAULT_SECURITY_* to CONFIG_LSM
and get used to use lsm= kernel command line option rather than security= kernel
command line option.

