Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E5AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C8B2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391418AbfHBQuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:50:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391366AbfHBQuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:50:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3C99B2DDB;
        Fri,  2 Aug 2019 16:50:51 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C72AD5D961;
        Fri,  2 Aug 2019 16:50:46 +0000 (UTC)
Date:   Fri, 2 Aug 2019 18:50:44 +0200
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802165044.GF18263@dcbz.redhat.com>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190731174135.GA30225@redhat.com>
 <20190802072511.GD18263@dcbz.redhat.com>
 <20190802124738.GC20111@redhat.com>
 <20190802132419.GD20111@redhat.com>
 <20190802134611.GF20111@redhat.com>
 <20190802135248.gbtkh5sgjzmbup5h@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802135248.gbtkh5sgjzmbup5h@brauner.io>
X-Operating-System: Linux (5.1.19-300.fc30.x86_64)
X-Load-Average: 1.75 1.91 1.91
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 02 Aug 2019 16:50:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:52:49PM +0200, Christian Brauner wrote:
> On Fri, Aug 02, 2019 at 03:46:11PM +0200, Oleg Nesterov wrote:
> > On 08/02, Oleg Nesterov wrote:
> > >
> > > So Adrian, sorry for confusion, I think your patch is fine.

Good to know.

> > Yes... but do we really need the new CLONE_SET_TID ?
> > 
> > set_tid == 0 has no effect, can't we simply check kargs->set_tid != 0
> > before ns_capable() ?
> 
> Yeah, I agree that sounds much better and aligns with exit_signal.

Let me remove CLONE_SET_TID from the patch and I will try out
idr_is_empty().

I will also address Dmitry's comment about accessing smaller parameter
structs.

		Adrian
