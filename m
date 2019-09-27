Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461F21850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfI0Mov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:44:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:43326 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0Mov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:44:51 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iDpc8-0004dT-ND; Fri, 27 Sep 2019 14:44:48 +0200
Date:   Fri, 27 Sep 2019 14:44:48 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Allan Zhang <allanzhang@google.com>
Cc:     songliubraving@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 1/1] bpf: Fix bpf_event_output re-entry issue
Message-ID: <20190927124448.GA22184@pc-66.home>
References: <20190925234312.94063-1-allanzhang@google.com>
 <20190925234312.94063-2-allanzhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925234312.94063-2-allanzhang@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25585/Fri Sep 27 10:25:33 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:43:12PM -0700, Allan Zhang wrote:
> BPF_PROG_TYPE_SOCK_OPS program can reenter bpf_event_output because it can
> be called from atomic and non-atomic contexts since we don't have
> bpf_prog_active to prevent it happen.
> 
> This patch enables 3 level of nesting to support normal, irq and nmi
> context.
> 
> We can easily reproduce the issue by running neper crr mode with 100 flows
> and 10 threads from neper client side.
> 
> Here is the whole stack dump:
[...]
> 
> Fixes: a5a3a828cd00 ("bpf: add perf event notificaton support for sock_ops")
> 
> Effort: BPF
> Signed-off-by: Allan Zhang <allanzhang@google.com>
> Reviewed-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Applied, thanks!
