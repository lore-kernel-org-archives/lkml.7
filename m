Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC59C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B96218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKijpGCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:32:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfKRQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574094757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CON1qBDJa/YQvur/tHGGxfdyheVcZXsC9K2a2ZC3UXU=;
        b=SKijpGCjYmq6iX5ZGXmYXSYJ83hKvcuVrmTUx15pYD9FRzLyWSZ2BEU9wbrFDdswy/kclJ
        7KGgzm1UYOXqLMGE2tUtupE8O/mWUoQubmwYomhqoBa4+dlXiqMrI9DQwXG0WR9S6Z11pE
        6WMUPyMEGjqhbi2pywvWVKzIt/9ssx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-eAxzJkGxOsiYU3TcIlyDzw-1; Mon, 18 Nov 2019 11:32:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70C9E1902C48;
        Mon, 18 Nov 2019 16:32:32 +0000 (UTC)
Received: from agk-dp.fab.redhat.com (agk-dp.fab.redhat.com [10.33.15.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02830643E4;
        Mon, 18 Nov 2019 16:32:20 +0000 (UTC)
Received: from agk by agk-dp.fab.redhat.com with local (Exim 4.69)
        (envelope-from <agk@redhat.com>)
        id 1iWjwo-0006wm-FL; Mon, 18 Nov 2019 16:32:18 +0000
Date:   Mon, 18 Nov 2019 16:32:18 +0000
From:   Alasdair G Kergon <agk@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: linux-next: Tree for Nov 15 (drivers/md/dm-integrity)
Message-ID: <20191118163218.GF1800@agk-dp.fab.redhat.com>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
References: <20191115190525.77efdf6c@canb.auug.org.au> <f368f431-b741-d04f-440b-3d8c3c035537@infradead.org> <d3a96436-0d9c-a13f-7524-33b203910367@infradead.org>
MIME-Version: 1.0
In-Reply-To: <d3a96436-0d9c-a13f-7524-33b203910367@infradead.org>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
        03798903. Registered Office: Peninsular House, 30-36 Monument
        Street, 4th Floor, London, England, EC3R 8NB.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eAxzJkGxOsiYU3TcIlyDzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:19:53AM -0800, Randy Dunlap wrote:
> BTW, dm-devel@redhat.com seems to be invalid or dead.

Red Hat made a few changes to its mail configuration over the last
week.

If anyone reading this still has problems that might be related to
this, please send me the relevant details privately (e.g. full headers
of messages) and I'll try to engage the right people to help.

Alasdair

