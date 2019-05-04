Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA1C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218C92084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQJ7k8vQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfEDNpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 09:45:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfEDNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 09:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4gDCXfgTJSqU8RmWI0QY4FMBFtSttEc0rnua7bpTTkg=; b=tQJ7k8vQHX8oaEuWuMTwZ78FE
        gjbjNmJPo8R4/B2TzzwD33A+ZjgMCywLP2thvtedAapodW2fIqKvMqhdSsfBBkFCxzfIlFC3I1c9u
        omDICDobhOjZxImAa5R/gpoCtDcUX6SAH9VOTouVd/YkoPmyAO8THRlIxTbZaAyhWqglFblOpsw+H
        bzCJlCh29xc5FVIN8FRRyUfAQLQ+VK2BXwyZZZ4AypktQ1PQ8K2Y1SF+rEDhDVeqHuiOc1iTpltoi
        hhr6HCCOXyRUC/dFsrGOkvTRAESap88FK9og8y/KrG6Wtar9duEa85z3DzBlv/gM9hwrhUv4XRC7/
        M77GV0wkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMuyO-00069C-1i; Sat, 04 May 2019 13:45:04 +0000
Date:   Sat, 4 May 2019 06:45:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Use list.h instead of file_system_type next
Message-ID: <20190504134503.GA16963@bombadil.infradead.org>
References: <20190504094549.10021-1-carmeli.tamir@gmail.com>
 <20190504094549.10021-2-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504094549.10021-2-carmeli.tamir@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 05:45:48AM -0400, Carmeli Tamir wrote:
> Changed file_system_type next field to list_head and refactored
> the code to use list.h functions.

What might be interesting is getting rid of this list and using an XArray
instead.  This would be a more in-depth change; getting rid of the rwlock
in favour of using RCU accesses for the read-side and the xa_lock for
write accesses to the filesystem list.
