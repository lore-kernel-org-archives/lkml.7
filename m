Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D0C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E9620645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701050;
	bh=OJUozbvJf6TFUOSbI2y5FkOLnt1vCDq9viiiVS27mYs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KmjMG0wv2a0T0sseS/KVyr8saSmBakK/7lU/PKAnKIVolghC3BkkOMabPaoJzEJSo
	 d6oOMVFD32Vi+1FENqUFRLI6N702TveeguZ+mJTroRZqSifeR36gFpNndpy/qiXo22
	 +hmaUrCo8xGuF4a94txp7RtFg/g9d4Cn0uWT7S+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfDSTKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfDSTKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:44 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031B620645;
        Fri, 19 Apr 2019 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701044;
        bh=OJUozbvJf6TFUOSbI2y5FkOLnt1vCDq9viiiVS27mYs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BhuXA/4chxW5VAupLS0knkM6balmQwRUJWC1W8cFS4SZLMYpavAKT5u+9Et4Xsxzv
         y2iuTjdHePZKNkQuJ3SIeZFV5vpskzjKe5gyDKJwhWFedXJcwdUp6NNGQVnCE1N5wA
         e6b2Sh/aLM9AL4YKTXlSJJPceOyNTpCHjPAO3rYE=
Subject: Re: [PATCH] selftests/ipc: Fix msgque compiler warnings
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
Cc:     Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190408171344.GA22803@beast>
 <20190408200141.uusxqlqly6tab6h7@linux-r8p5>
From:   shuah <shuah@kernel.org>
Message-ID: <a53346cd-9eec-7ca6-3a09-a5558a5c9aa8@kernel.org>
Date:   Fri, 19 Apr 2019 13:10:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408200141.uusxqlqly6tab6h7@linux-r8p5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 2:01 PM, Davidlohr Bueso wrote:
> On Mon, 08 Apr 2019, Kees Cook wrote:
> 
>> This fixes the various compiler warnings when building the msgque
>> selftest. The primary change is using sys/msg.h instead of linux/msg.h
>> directly to gain the API declarations.
>>
>> Fixes: 3a665531a3b7 ("selftests: IPC message queue copy feature test")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> (Not really related to this patch)
> 
> Given that the selftest/ipc/ only consists of this test, I wonder if
> the test should just be moved to ltp, where the ipc tests are a lot
> more complete and robust -- and which I've been using for years for
> basic testing code changes.
> 

Having this test in here helps us find regressions quickly. It does good
and no harm keeping this test in here.

I don't think it is a good idea to remove it all together.

thanks,
-- Shuah

