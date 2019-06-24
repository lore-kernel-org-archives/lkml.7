Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E62C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D382089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q4CObFjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfFXJYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:24:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfFXJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:To:From:Date:Message-Id:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qrf9JWjlb28WN0niH3eteYC86mW3cqZL27fNmI5mH6I=; b=q4CObFjNY5SC7Kvp+/QWhBFOy9
        t6R1t0RhG9aENDkNUMux7WeoPv7MoHivUhJtOYnpd8qV24hugiBY5VQp3pHkezopzyrKO8cckaUPk
        c6yFZwH3o0uo23qZtwosWwTyHKqY28BzFTLA3TsXOHimIlkLTBxIjOxLdFCRTv7w61W9APZhtOeJq
        DIZTfy4YXppnuQrHN5zxwXdKRAsJfbu4P4jbuMFCOmriSVEymPsUHNSC5WFl523acWErfEePFd2iA
        W0fq6F/XetjWWC4sTVv5uWR69hlTnHA1QONcdFeXdpuR3zyxF5LYTLnaUU75PahQMUl0pl4MsIciO
        rCjUXowQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfLCm-0006uz-Ln; Mon, 24 Jun 2019 09:24:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4F88020A0EF22; Mon, 24 Jun 2019 11:24:02 +0200 (CEST)
Message-Id: <20190624091843.859714294@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Jun 2019 11:18:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, ast@kernel.org, daniel@iogearbox.net,
        akpm@linux-foundation.org, peterz@infradead.org
Subject: [PATCH 0/3] Propagate module notifier errors
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These patches came from the desire to propagate MODULE_STATE_COMING errors.
While looking at that I spotted fail with a number of module notifiers
themselves and with the whole notification business.

Please consider.

