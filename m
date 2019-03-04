Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B4C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD8F20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCDQWY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:22:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfCDQWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:22:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8685C882F5;
        Mon,  4 Mar 2019 16:22:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 110755D6B3;
        Mon,  4 Mar 2019 16:22:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1551715930.10911.468.camel@linux.ibm.com>
References: <1551715930.10911.468.camel@linux.ibm.com> <155171231301.4764.5429281379303710262.stgit@warthog.procyon.org.uk>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Move kernel_read_file() to fs/read_write.c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Mon, 04 Mar 2019 16:22:20 +0000
Message-ID: <12096.1551716540@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 04 Mar 2019 16:22:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> > Move kernel_read_file() to fs/read_write.c and out of fs/exec.c as it's not
> > actually used by anything in the execve subsystem.
> 
> All files being opened by the kernel should be calling one of these
> helper routines.  Has that changed?

prepare_binprm() uses kernel_read() and has done since at least 2014.  The
binfmt drivers also use kernel_read().

Since kernel_read_file() is used by a bunch of things that aren't exec, even
if we switch exec to it, it should probably still go in fs/read_write.c since
it seems generic.

David
