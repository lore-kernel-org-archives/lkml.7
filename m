Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA7C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3953E206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556211165;
	bh=UXofT20xgzmBYv7GbYFOx7dER5s3KDgC41078w7OyMk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z6dOkuNnM0QoXQneH8P+pA/1/oBNE/9ataBFQPdGxS35a8cqCyqoKQGngJJTYkhOY
	 hQijJOwgWDALcBkcevGpnoiVadWg2OGyhP0vvG6HL10dhZvq8E9UGwCXKcJC+a27/l
	 1HZ+w9HoySIy69S2PPJOGLf6JkIZIIO4nlJFyMkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfDYQwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfDYQwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:52:42 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7171120679;
        Thu, 25 Apr 2019 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556211163;
        bh=UXofT20xgzmBYv7GbYFOx7dER5s3KDgC41078w7OyMk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FmH3Cuzl89A1bY3mX2wn49baxo57E9RqhiwPoIU2aAiMTP4hK37s89tUYWmn7qp/a
         DuWhacdUjFpge4BsM7KKSN7Q52GZ9EIQ1on/VtlwtQdqTZPi6H+opojetEQIGbfXQS
         udfA0ZfT07wLnBkNHtZZdVz6Qo22whdPvt1210ik=
Subject: Re: [PATCH v2 0/8] selftests: Move test output to diagnostic lines
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190424231237.14776-1-keescook@chromium.org>
From:   shuah <shuah@kernel.org>
Message-ID: <a3ca267e-8e1e-65da-77c8-c7010a39354b@kernel.org>
Date:   Thu, 25 Apr 2019 10:52:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 5:12 PM,  wrote:
> This refactors the selftest Makefiles to extract the test running logic
> to be reused between "run_tests" and "emit_tests", while also fixing
> up the test output to be TAP version 13 compliant:
> - added "plan" line
> - fixed result line syntax
> - moved all test output to be "# "-prefixed as TAP "diagnostic" lines
> 
> The prefixing code includes a fallback mode for limited execution
> environments.
> 
> Additionally, the plan lines are fixed for all callers of kselftest.h.
> 
> -Kees
> 

Kees,

Just about to apply these to a topic branch to do testing and ran into
checkpatch errors:


WARNING: line over 80 characters - a few
WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
#141: FILE: tools/testing/selftests/kselftest/runner.sh:2:

Can fix them and resend - SPDX one is my main concern.

The plan is to apply these to linux-kselftest ksft-tap-refactor topic
first. I don't want to rush these until we do some testing.

thanks,
-- Shuah
