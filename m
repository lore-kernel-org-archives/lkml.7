Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56042222B5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKSNRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:17:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:39670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKSNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:17:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 732B3B297;
        Tue, 19 Nov 2019 13:17:43 +0000 (UTC)
Subject: Re: [PATCH 1/2] x86/Xen/32: make xen_iret_crit_fixup independent of
 frame layout
To:     Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
 <32d8713d-25a7-84ab-b74b-aa3e88abce6b@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f45354ff-4755-1884-444d-007ea46bb847@suse.com>
Date:   Tue, 19 Nov 2019 14:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <32d8713d-25a7-84ab-b74b-aa3e88abce6b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.19 15:32, Jan Beulich wrote:
> Now that SS:ESP always get saved by SAVE_ALL, this also needs to be
> accounted for in xen_iret_crit_fixup. Otherwise the old_ax value gets
> interpreted as EFLAGS, and hence VM86 mode appears to be active all
> the time, leading to random "vm86_32: no user_vm86: BAD" log messages
> alongside processes randomly crashing.
> 
> Since following the previous model (sitting after SAVE_ALL) would
> further complicate the code _and_ retain the dependency of
> xen_iret_crit_fixup on frame manipulations done by entry_32.S, switch
> things around and do the adjustment ahead of SAVE_ALL.
> 
> Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
