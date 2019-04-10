Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FCFC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A9F217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qqHkI44P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfDJEUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:20:51 -0400
Received: from mail.efficios.com ([167.114.142.138]:47014 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfDJEUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:20:51 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F0DE91D5E48;
        Wed, 10 Apr 2019 00:20:49 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 4lpnZ8M89aeY; Wed, 10 Apr 2019 00:20:49 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 961FF1D5E42;
        Wed, 10 Apr 2019 00:20:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 961FF1D5E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554870049;
        bh=TiAMzGmAJm0ScciKXOR3aomQUAKVtUVfBwsaVA/f1ow=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qqHkI44PK7tt7oCUBZCws3kAbN9ztcuhXpvgiDax33jHM/M7X9KEjKPXFh0q2EZ5d
         VU70iO6nBMoVxJNZk0EZzEnrFCPukW3efbqHZqBWL2f+FgaI2mEBEXY7WiSikC8EtR
         SDLrrnHgxC81FYrqqTenQFVyV2hFBZta3dJDiAV81jr8fUR3qgYGg/wwmewS17zAgW
         1bnajV1bMemphSQP8ALuf6yJwWf8sXSSxZeCGRgTqTy/OEHBChb7rYu8A+7Vd1sDpr
         1FTvrv60UXBy69asoijS8B8by2Sy/HBwZfyudbVYYi5DthD05ZSIWcay2P4dQ12Z7I
         xHlzsewg4ks3g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id oRQ38X3Twyhy; Wed, 10 Apr 2019 00:20:49 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 792DC1D5E3C;
        Wed, 10 Apr 2019 00:20:49 -0400 (EDT)
Date:   Wed, 10 Apr 2019 00:20:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening <kernel-hardening@lists.openwall.com>,
        kernel-team <kernel-team@android.com>, rcu <rcu@vger.kernel.org>
Message-ID: <475423743.2834.1554870049461.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJWu+orXgFkJpB8ww9kz_Nzmmj4qXjj2HtN_eDW3x+XPLbH0qw@mail.gmail.com>
References: <20190410011418.76408-1-joel@joelfernandes.org> <20190410011418.76408-2-joel@joelfernandes.org> <20190409223820.511e3671@oasis.local.home> <20190410024103.GA104423@google.com> <20190409224826.308b12a4@oasis.local.home> <CAJWu+orXgFkJpB8ww9kz_Nzmmj4qXjj2HtN_eDW3x+XPLbH0qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: Make srcu_struct ptr array as read-only
 post init
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: module: Make srcu_struct ptr array as read-only post init
Thread-Index: S1oZQGKExjQi6X7deCx2BAyn87KuYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 11:38 PM, Joel Fernandes joelaf@google.com wrote:

> On Tue, Apr 9, 2019 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Tue, 9 Apr 2019 22:41:03 -0400
>> Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> > > Other than that, the two patches look fine to me.
>> >
>> > Could I add your Reviewed-by in the respin?
>>
>> You can add an Acked-by, as I haven't spent enough time to offer a
>> Reviewed-by tag. ;-)
>>
>> Maybe I'll get some time to vet it a bit more tomorrow, and then
>> upgrade the ack to a review.
>>
>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>
> 
> Thanks!
> 
> Also we could possibly consider adding the tracepoint ptrs array as
> well to the list, which would be useful I think, if one were to over
> write that array by accident (and the bpf tps related array too).

Yes, please!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
