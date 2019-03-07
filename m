Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A3F20652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCGP7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:59:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfCGP7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:59:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFE6236807;
        Thu,  7 Mar 2019 15:59:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4859F5C1A1;
        Thu,  7 Mar 2019 15:59:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190306235913.6631-3-matthewgarrett@google.com>
References: <20190306235913.6631-3-matthewgarrett@google.com> <20190306235913.6631-1-matthewgarrett@google.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     dhowells@redhat.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] Add a SysRq option to lift kernel lockdown
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15832.1551974371.1@warthog.procyon.org.uk>
Date:   Thu, 07 Mar 2019 15:59:31 +0000
Message-ID: <15833.1551974371@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Mar 2019 15:59:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <matthewgarrett@google.com> wrote:

> +		/* Ban synthetic events from some sysrq functionality */
> +		if ((from == SYSRQ_FROM_PROC || from == SYSRQ_FROM_SYNTHETIC) &&
> +		    op_p->enable_mask & SYSRQ_DISABLE_USERSPACE)
> +			printk("This sysrq operation is disabled from userspace.\n");
>  		/*
>  		 * Should we check for enabled operations (/proc/sysrq-trigger
>  		 * should not) and is the invoked operation enabled?
>  		 */
> -		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
> +		if (from == SYSRQ_FROM_KERNEL || sysrq_on_mask(op_p->enable_mask)) {

There's some missing logic here.  Probably an else is missing, but it seems
more than that.

David
