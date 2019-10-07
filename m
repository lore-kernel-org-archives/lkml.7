Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B88C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279B520867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJlkGPf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfJGLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:33:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfJGLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xJdKMNyeUPUM6hZzv3H2mgyVj95E5kK58/OZUP7jnFE=; b=qJlkGPf8Pr9BRrVIsnzX5kHhu
        nJ8qbdl6gGBxCieiDbtLEl8MWRT6oRV6ehgHbCZ2DKa4xInwOUYoe6VVeStUaPe7m2mwoQR6oqbJ5
        YiqpLiJFF7tH5uvwsh0CWIRX5YzCQeVlf9EedeeHAU7zWj3dA+I9wKM4dmvaXDwHSk7WILWWPm6fi
        NgskFbUQ4OfiITyPEIgARUdFzjXWifK7+QJll7wDuIqSUNIDcKxsUrFnYLpBerUDHKgBtsvWtULZR
        V1UVy3C5glYKRIOL3N54/jwpjk/Cc+7QEloIxEANW1meIA2bYPsEwE9dGe/o9EJOTrVpogAX8otsK
        FPGHLuoSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHRGt-0002RQ-En; Mon, 07 Oct 2019 11:33:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9DE301B59;
        Mon,  7 Oct 2019 13:32:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4088320245BAF; Mon,  7 Oct 2019 13:33:46 +0200 (CEST)
Date:   Mon, 7 Oct 2019 13:33:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v2 02/13] static_call: Add basic static call
 infrastructure
Message-ID: <20191007113346.GD2311@hirez.programming.kicks-ass.net>
References: <20191007082708.01393931.1@infradead.org>
 <20191007083830.64667428.5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007083830.64667428.5@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:27:10AM +0200, Peter Zijlstra wrote:

> +#define STATIC_CALL_PREFIX	____static_call_

Yesterday I got an allmodconfig build complaining about symbols being
too long, in part due to this prefix. Should we change it to something
like: "__SC__" ?

