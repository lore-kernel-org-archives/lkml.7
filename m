Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F426C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F87F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfI3NuS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58051 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbfI3NuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AEE33082E10;
        Mon, 30 Sep 2019 13:50:17 +0000 (UTC)
Received: from x2.localnet (ovpn-117-72.phx2.redhat.com [10.3.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7D0E261D1;
        Mon, 30 Sep 2019 13:50:01 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] audit: Report suspicious O_CREAT usage
Date:   Mon, 30 Sep 2019 09:50:00 -0400
Message-ID: <2065829.xbNJnTdZ4q@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhRNmWw1__-haD1ZEekADTho3EJyXQMd6ETpOv4c8Qn9nw@mail.gmail.com>
References: <201909251348.A1542A52@keescook> <CAHC9VhRNmWw1__-haD1ZEekADTho3EJyXQMd6ETpOv4c8Qn9nw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 30 Sep 2019 13:50:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 26, 2019 11:31:32 AM EDT Paul Moore wrote:
> On Wed, Sep 25, 2019 at 5:02 PM Kees Cook <keescook@chromium.org> wrote:
> > This renames the very specific audit_log_link_denied() to
> > audit_log_path_denied() and adds the AUDIT_* type as an argument. This
> > allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
> > report the fifo/regular file creation restrictions that were introduced
> > in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
> > regular files"). Without this change, discovering that the restriction
> > is enabled can be very challenging:
> > https://lore.kernel.org/lkml/CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQO
> > dkFq0PA@mail.gmail.com
> > 
> > Reported-by: Jérémie Galarneau <jeremie.galarneau@efficios.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This is not a complete fix because reporting was broken in commit
> > 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> > audit_dummy_context")
> > which specifically goes against the intention of these records: they
> > should _always_ be reported. If auditing isn't enabled, they should be
> > ratelimited.
> > 
> > Instead of using audit, should this just go back to using
> > pr_ratelimited()?
> 
> I'm going to ignore the rename and other aspects of this patch for the
> moment so we can focus on the topic of if/when/how these records
> should be emitted by the kernel.
> 
> Unfortunately, people tend to get very upset if audit emits *any*
> records when they haven't explicitly enabled audit, the significance
> of the record doesn't seem to matter, which is why you see patches
> like 15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
> audit_dummy_context").  We could consider converting some records to
> printk()s, rate-limited or not, but we need to balance this with the
> various security certifications which audit was created to satisfy.
> In some cases a printk() isn't sufficient.
> 
> Steve is probably the only one who really keeps track of the various
> auditing requirements of the different security certifications; what
> say you Steve on this issue with ANOM_CREAT records?

Common Criteria and other security standards I track do not call out for 
anomoly detection. So, there are no requirements on this. That said, we do 
have other anomaly detections because they give early warning that something 
strange is happening. I think adding this event is a nice improvement as long 
as it obeys audit_enabled before emitting an event - for example, look at the 
AUDIT_ANOM_ABEND event.

-Steve


