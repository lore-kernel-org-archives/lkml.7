Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3218DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EB1208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfFGSDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:03:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfFGSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:03:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZJCg-0000wP-E8; Fri, 07 Jun 2019 12:03:02 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZJCf-0000GN-HK; Fri, 07 Jun 2019 12:03:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Eric Wong <e@80x24.org>, linux-aio@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190607103122.GA22167@redhat.com>
        <20190607103154.GA22159@redhat.com>
        <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
        <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com>
Date:   Fri, 07 Jun 2019 13:02:50 -0500
In-Reply-To: <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 7 Jun 2019 10:37:27 -0700")
Message-ID: <87imthclyt.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZJCf-0000GN-HK;;;mid=<87imthclyt.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LaBG0WsnybgxQHMjPvl4DUw1XVaU+Nt0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] aio: simplify the usage of restore_saved_sigmask_unless()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 7, 2019 at 10:33 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Are they actually nonrestartable? I think the current EINTR is just a mistake.
>
> Oh, I guess they are, because of the relative timeout thing that
> shouldn't reset to the original value.
>
> And I don't think this is worth a ERESTAR_RESTARTTBLOCK.

Unless I am misreading things io_pgetevents isn't restartable
either and ERESTARTNOHAND is a bug in that case.

Is the bug going the other way?

Eric
