Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF36C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BEF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556613779;
	bh=7o7DZwJEOripkUNr9As7Pg/o4reVXy70s+lqUnjJVJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FvI2EQQ+Y11JOgTJNwviPsG3kjrksq6G97LWN0mtOH6QyA95wDrpIkKk6MkmGTRaW
	 UZK2yQ+pFlMpFYaRMf4wlLHFzCjse29vT0iymol2GoGz8WArBpKti6UIe7hV5VZR6+
	 Pzg22lhVlzbiEMfl7hCxO+k2VFTuzivK6eOD3P38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfD3Im6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfD3Im5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:42:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9BC92080C;
        Tue, 30 Apr 2019 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556613777;
        bh=7o7DZwJEOripkUNr9As7Pg/o4reVXy70s+lqUnjJVJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtQ3efFrzbYXBRfbiJGPj+G83y9rGU5I9w+BoXWL+C/1NJjp7OAj3dpgXe4eAuMo5
         ZKYr3jn5ysbaPvnLontEDZtEJiZGNyE9ZVuovs1rgVaqzqjJnfA2ZmzjHvMzrc3Iy8
         ytIgyUJRPe1EMlwtkGeK0i4Ugx8rmicU2JDtJqG0=
Date:   Tue, 30 Apr 2019 10:42:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Fix kobject memleak
Message-ID: <20190430084254.GB11737@kroah.com>
References: <20190430001534.26246-1-tobin@kernel.org>
 <20190430001534.26246-2-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430001534.26246-2-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:15:33AM +1000, Tobin C. Harding wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
