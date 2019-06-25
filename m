Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14009C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB3D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfFYKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:41:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfFYKlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:41:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32D393D953;
        Tue, 25 Jun 2019 10:41:36 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-223.ams2.redhat.com [10.36.116.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0492F600CD;
        Tue, 25 Jun 2019 10:41:34 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>, bpf@vger.kernel.org
Subject: Re: ebpf: BPF_ALU32 | BPF_ARSH on BE arches
References: <xunyo92mox9h.fsf@redhat.com> <87ef3i9dbc.fsf@netronome.com>
Date:   Tue, 25 Jun 2019 13:41:34 +0300
In-Reply-To: <87ef3i9dbc.fsf@netronome.com> (Jiong Wang's message of "Tue, 25
        Jun 2019 11:20:07 +0100")
Message-ID: <xuny7e9aoskh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 25 Jun 2019 10:41:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiong!

>>>>> On Tue, 25 Jun 2019 11:20:07 +0100, Jiong Wang  wrote:

 > Yauheni Kaliuta writes:

 >> Hi!
 >> 
 >> Looks like the code:
 >> 
 >> ALU_ARSH_X:
 >> DST = (u64) (u32) ((*(s32 *) &DST) >> SRC);
 >> CONT;
 >> ALU_ARSH_K:
 >> DST = (u64) (u32) ((*(s32 *) &DST) >> IMM);
 >> CONT;
 >> 
 >> works incorrectly on BE arches since it must operate on lower
 >> parts of 64bit registers.
 >> 
 >> See failure of test_verifier test 'arsh32 on imm 2' (#23 on
 >> 5.2-rc6).

 > Ah, thanks for reporting this.

 > Should not taken the address directly, does the following fix resolved the
 > failure?

 >         ALU_ARSH_X:
 >                 DST = (u64) (u32) ((s32) DST) >> SRC);
 >                 CONT;
 >         ALU_ARSH_K:
 >                 DST = (u64) (u32) ((s32) DST) >> IMM);
 >                 CONT;

Yes, thanks (just add the missing braces).

-- 
WBR,
Yauheni Kaliuta
