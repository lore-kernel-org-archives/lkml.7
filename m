Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DDECA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928FE2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ0QPOn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKAORK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:17:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39217 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726229AbfKAORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572617829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bSMiX1ypW1OILzlSeuIV46rslZY2mLw6nq+CHipEz4=;
        b=EQ0QPOn+npPonSFq92wKHVT00rT5t8EM93rRNRfx2D2eePxIk4iUazRuHZA+seBOpzBfS6
        H48m+lg2VaS/pU0/HadQ0a7HmYFVqB7KHOnAAJUHzwq1aCLiVOUGdpkmg5JDzI2OFVfJdJ
        qz574vmnqLAuG/VHUuXwdysqacMunsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-f-5z6rJkPTuEgMjs-4OY5Q-1; Fri, 01 Nov 2019 10:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7218A5EA;
        Fri,  1 Nov 2019 14:17:04 +0000 (UTC)
Received: from x2.localnet (ovpn-116-239.phx2.redhat.com [10.3.116.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2302608D0;
        Fri,  1 Nov 2019 14:16:58 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-audit@redhat.com
Cc:     Chris Mason <clm@fb.com>, Paul Moore <paul@paul-moore.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Kyle McMartin <jkkm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set context->dummy even when audit is off
Date:   Fri, 01 Nov 2019 10:16:56 -0400
Message-ID: <3063279.ZKBa9cPvsK@x2>
Organization: Red Hat
In-Reply-To: <B63048C4-3158-453B-859A-C5574AACDC36@fb.com>
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com> <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com> <B63048C4-3158-453B-859A-C5574AACDC36@fb.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: f-5z6rJkPTuEgMjs-4OY5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 1, 2019 9:24:17 AM EDT Chris Mason wrote:
> On 31 Oct 2019, at 19:27, Paul Moore wrote:
> > On Thu, Oct 31, 2019 at 12:40 PM Chris Mason <clm@fb.com> wrote:
> > [ ... ]
> > Hi Chris,
> > 
> > This is a rather hasty email as I'm at a conference right now, but I
> > wanted to convey that I'm not opposed to making sure that the NTP
> > records obey the audit configuration (that was the original intent
> > after all), I think it is just that we are all a little confused as to
> > why you are seeing the NTP records *and*only* the NTP records.
> 
> This part is harder to nail down because there's a window during boot
> where journald has enabled audit but chef hasn't yet run in and turned
> it off, so we get a lot of logs early and then mostly ntp after that.

This is the root of the problem. Journald should never turn on audit since it 
has no idea if auditd even has rules to load. What if the end user does not 
want auditing? By blindly enabling audit without knowing if its wanted, it 
causes a system performance hit even with no rules loaded. It would be best 
if journald leaves audit alone. If it wants to listen on the multicast 
socket, so be it. It should just listen and not try to alter the system.

Back to ntp, it sounds like the ntp record needs to check for audit_enabled 
rather than the dummy context.

-Steve



