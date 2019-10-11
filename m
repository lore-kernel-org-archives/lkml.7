Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1193ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7852421A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570808004;
	bh=NQZN68RxCKcJkzW1s3gFdeTrbhdEj1wIh0TR9/+K+qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pp+LbSWAD7EUDGDaiJS+XyXCq24Ua4ZuqDCGQhH4M1+Q2jFcCWixxRzo+02oyIA4p
	 MCnBwzgw1TB50YlRq6e9l8maweAKxmiCk4QNAs5lAxFq0YwDeXSsr9yjoysSZ86ap7
	 xi0586elGQEC30lpMcx8N4YzB1AhMZEUXzs6mRy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJKPdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfJKPdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:33:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4820206A1;
        Fri, 11 Oct 2019 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570808002;
        bh=NQZN68RxCKcJkzW1s3gFdeTrbhdEj1wIh0TR9/+K+qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tz03FhijMzybaUjcRLnyARmWhnjL4zawrMNjqenOQ2brweq6ww9pf0P/lwIVNZFwK
         L4HMwQSvOgVfANpq/ZXodjDiuq6PgVAiOWONjFL9iFfBk0h1hNWvN7O0zVWT+xPV+O
         hRpkxIf65rIB2WhICnqeOGNjdDFUtpuehZ42Boqw=
Date:   Fri, 11 Oct 2019 17:33:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/4] modpost: make updating the symbol namespace explict
Message-ID: <20191011153319.GC1283883@kroah.com>
References: <20191010151443.7399-1-maennich@google.com>
 <20191010151443.7399-3-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010151443.7399-3-maennich@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:14:41PM +0100, Matthias Maennich wrote:
> Setting the symbol namespace of a symbol within sym_add_exported feels
> displaced and lead to issues in the current implementation of symbol
> namespaces. This patch makes updating the namespace an explicit call to
> decouple it from adding a symbol to the export list.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
