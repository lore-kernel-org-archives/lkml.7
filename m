Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D8120835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UUDzN4Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCDT5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:57:49 -0500
Received: from mail.efficios.com ([167.114.142.138]:55402 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:57:49 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 290A81BBC38;
        Mon,  4 Mar 2019 14:57:48 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id KslfnKAy90pO; Mon,  4 Mar 2019 14:57:47 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A2C1C1BBC30;
        Mon,  4 Mar 2019 14:57:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A2C1C1BBC30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551729467;
        bh=TH5ubesnfb1c/kbubK4G3B/KJ4MNpDe09E8yjpKByI8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=UUDzN4Mu7PoTzWlPDoUt9l8ySGU5Eggav2bSToK6vZMBOF3XK3xvmbP/+89MyBdhI
         d3GslJfAxTrtgGEiYmuKUanVdcmZ55Cj47qSlmDhluPYPxZNK6pdGJQ6xAd8bOqHdN
         xi15fUcCHVOLUcZ/Vj+XFvmW9dlKDBsVIonZz7SvB4rHaJ2gS7znS90Ch6yWKt5lXD
         La/FPy6H+WJKYk4SAi7Ynj0OmkNz4YTwsBJswds6UslYcxVcJvonmbbJqcYirID+mJ
         9jEilAXgjTCE5NhaZ4PZR99O9vupXoEcLLOsit8dq7oWsntja6Md2OV2mxY1ej1YDx
         3VXmB/MRsoy5w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Ktd0K1f4Xx73; Mon,  4 Mar 2019 14:57:47 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 7EB4C1BBC1E;
        Mon,  4 Mar 2019 14:57:47 -0500 (EST)
Date:   Mon, 4 Mar 2019 14:57:47 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, shuah <shuah@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <712691085.1137.1551729467392.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFqt6zarwg3NnkbNYKEO-jrdHUw8GwMqUrLDTqgQV3D1dux-qQ@mail.gmail.com>
References: <20190304183827.GA6809@jordon-HP-15-Notebook-PC> <20190304184958.GR32494@hirez.programming.kicks-ass.net> <CAFqt6zarwg3NnkbNYKEO-jrdHUw8GwMqUrLDTqgQV3D1dux-qQ@mail.gmail.com>
Subject: Re: [PATCH] selftest/rseq: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Topic: selftest/rseq: Remove duplicate header
Thread-Index: mh5Zrflal6JYyMUvhsfiXmFbUjIsRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 4, 2019, at 1:53 PM, Souptick Joarder jrdr.linux@gmail.com wrote:

> On Tue, Mar 5, 2019 at 12:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Tue, Mar 05, 2019 at 12:08:27AM +0530, Souptick Joarder wrote:
>> > Remove duplicate header which is included twice
>> >
>> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>
>> That SoB chain is invalid.
> 
> I didn't get why it is invalid ?

I think it's about having the author of the patch (From) as first
Signed-off-by, and then apply following Signed-off-by by maintainers
who pick up the patch. (That's what I am used to see)

What is the intent behind the second Signed-off-by by Sabyasachi Gupta ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
