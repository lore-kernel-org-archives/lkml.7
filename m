Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D300120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDIPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:37:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIPhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:37:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24D0A3018ECF;
        Tue,  9 Apr 2019 15:37:25 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-27.ams2.redhat.com [10.36.117.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C927B272D1;
        Tue,  9 Apr 2019 15:37:16 +0000 (UTC)
Date:   Tue, 9 Apr 2019 17:37:16 +0200
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>, omosnace@redhat.com,
        eparis@parisplace.org, ebiederm@xmission.com, oleg@redhat.com
Subject: Re: [PATCH ghak111 V1] audit: deliver siginfo regarless of syscall
Message-ID: <20190409173716.1a0308fb@ivy-bridge>
In-Reply-To: <20190409140259.n4t6rxb24eu3uzvp@madcap2.tricolour.ca>
References: <c7b092894ac6d611f8c5083e712da41e6685f94a.1554781852.git.rgb@redhat.com>
        <20190409080138.745d18a1@ivy-bridge>
        <20190409140259.n4t6rxb24eu3uzvp@madcap2.tricolour.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Apr 2019 15:37:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 10:02:59 -0400
Richard Guy Briggs <rgb@redhat.com> wrote:

> On 2019-04-09 08:01, Steve Grubb wrote:
> > On Mon,  8 Apr 2019 23:52:29 -0400 Richard Guy Briggs
> > <rgb@redhat.com> wrote:  
> > > When a process signals the audit daemon (shutdown, rotate, resume,
> > > reconfig) but syscall auditing is not enabled, we still want to
> > > know the identity of the process sending the signal to the audit
> > > daemon.  
> > 
> > Why? If syscall auditing is disabled, then there is no requirement
> > to provide anything. What is the real problem that you are seeing?  
> 
> Shutdown messages with -1 in them rather than the real values.

OK. We can fix that by patching auditd to see if auditing is enabled
before requesting signal info. If auditing is disabled, the proper
action is for the kernel to ignore any audit userspace messages except
the configuration commands.

-Steve
