Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D3CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C8E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555088834;
	bh=t/QGZ7CMTwVEh95Tz21CeBH1q0YtyGXlOXkq7m6LOVM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1ByTBGh8R4LPW+a7PnLCY6tg81yMMF5dgo/zWmBo4dSd532wSr4gxjdvZdBDcY0U+
	 4XQrsnqm33JW5bvW3cWPPTxAbulrs6MEP1ukYAAkWT6n/zosxUHdaEVQSkqlpbIOea
	 gCMkcCMrWmeVbtcXazM85ex45VEhxRsEwcwMcM8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDLRHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDLRHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:07:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3145020869;
        Fri, 12 Apr 2019 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555088832;
        bh=t/QGZ7CMTwVEh95Tz21CeBH1q0YtyGXlOXkq7m6LOVM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KrLJMqV355/hEkDJzCebFcFA1puyjEOsnk4wPkzPYCuvGKRj2nYIyE0t+qgbGbbPP
         ZOItLSQcvSDTxa1SQ9C5fTre+yTIn547tV8Ie5/1wEYmsBQfjJZi/C6RYi5KR8krkh
         zRNtmqzeqMWndX7QJpgqHJhQ5tNenD2H/QgfMEuw=
Subject: Re: [PATCH] selftests/seccomp: Handle namespace failures gracefully
To:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190411235631.GA31624@beast> <20190412152543.GB25793@cisco>
From:   shuah <shuah@kernel.org>
Message-ID: <8fca6205-4983-2ba1-c1eb-c80be2dc8769@kernel.org>
Date:   Fri, 12 Apr 2019 11:07:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412152543.GB25793@cisco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 9:25 AM, Tycho Andersen wrote:
> On Thu, Apr 11, 2019 at 04:56:31PM -0700, Kees Cook wrote:
>> When running without USERNS or PIDNS the seccomp test would hang since
>> it was waiting forever for the child to trigger the user notification
>> since it seems the glibc() abort handler makes a call to getpid(),
>> which would trap again. This changes the getpid filter to getppid, and
>> makes sure ASSERTs execute to stop from spawning the listener.
>>
>> Reported-by: Shuah Khan <shuah@kernel.org>
>> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Sorry for the delay, thanks for looking at this!
> 
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> 

Thanks both. Should it go into stables. I will pull this and
add stable if that is appropriate.

thanks,
-- Shuah
