Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C48C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9A8213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCRXhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCRXha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 275D436809;
        Mon, 18 Mar 2019 23:37:30 +0000 (UTC)
Received: from treble (ovpn-120-200.rdu2.redhat.com [10.10.120.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D18D35D704;
        Mon, 18 Mar 2019 23:37:27 +0000 (UTC)
Date:   Mon, 18 Mar 2019 18:37:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190318233720.76j6ywkdulmnhu2o@treble>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318155140.058627431@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 18 Mar 2019 23:37:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:38:42PM +0100, Peter Zijlstra wrote:
> With CONFIG_PROFILE_ALL_BRANCHES, the "if" macro converts the
> conditional to an array index.  This can cause GCC to create horrible
> code.  When there are nested ifs, the generated code uses register
> values to encode branching decisions.
> 
> Make it easier for GCC to optimize by keeping the conditional as a
> conditional rather than converting it to an integer.  This shrinks the
> generated code quite a bit, and also makes the code sane enough for
> objtool to understand.
> 
> Cc: rostedt@goodmis.org
> Cc: valentin.schneider@arm.com
> Cc: luto@amacapital.net
> Cc: brgerst@gmail.com
> Cc: catalin.marinas@arm.com
> Cc: mingo@kernel.org
> Cc: dvlasenk@redhat.com
> Cc: will.deacon@arm.com
> Cc: julien.thierry@arm.com
> Cc: torvalds@linux-foundation.org
> Cc: dvyukov@google.com
> Cc: bp@alien8.de
> Cc: tglx@linutronix.de
> Cc: james.morse@arm.com
> Cc: luto@kernel.org
> Cc: hpa@zytor.com
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20190307174802.46fmpysxyo35hh43@treble

Missing "From" me.

-- 
Josh
