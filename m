Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3B20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393794AbfHBNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:46:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfHBNqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:46:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 969EC3087958;
        Fri,  2 Aug 2019 13:46:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA17F60BF4;
        Fri,  2 Aug 2019 13:46:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Aug 2019 15:46:14 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:46:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802134611.GF20111@redhat.com>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190731174135.GA30225@redhat.com>
 <20190802072511.GD18263@dcbz.redhat.com>
 <20190802124738.GC20111@redhat.com>
 <20190802132419.GD20111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802132419.GD20111@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 02 Aug 2019 13:46:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Oleg Nesterov wrote:
>
> So Adrian, sorry for confusion, I think your patch is fine.

Yes... but do we really need the new CLONE_SET_TID ?

set_tid == 0 has no effect, can't we simply check kargs->set_tid != 0
before ns_capable() ?

and to remind, I still think alloc_pid() should use idr_is_empty(), but
I won't insist.

Oleg.

