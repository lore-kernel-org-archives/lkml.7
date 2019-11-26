Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3FAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8C52064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKZGSt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:18:49 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42178 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKZGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:18:48 -0500
Received: from marcel-macpro.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 59B6ECECF6;
        Tue, 26 Nov 2019 07:27:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Fix invalid-free in bcsp_close()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAG_fn=Xqb1KoAvV==F5sODUYHDsxCxaz72n6qucdkR70XGCkig@mail.gmail.com>
Date:   Tue, 26 Nov 2019 07:18:46 +0100
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8376D008-EA21-49EA-AF5A-DDDCB179EAC5@holtmann.org>
References: <000000000000109f9605964acf6c@google.com>
 <20191101204244.14509-1-tomasbortoli@gmail.com>
 <E16896E5-B946-450F-BF42-04665D219EEA@holtmann.org>
 <CAG_fn=Xqb1KoAvV==F5sODUYHDsxCxaz72n6qucdkR70XGCkig@mail.gmail.com>
To:     Alexander Potapenko <glider@google.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

>>> Syzbot reported an invalid-free that I introduced fixing a memleak.
>>> 
>>> bcsp_recv() also frees bcsp->rx_skb but never nullifies its value.
>>> Nullify bcsp->rx_skb every time it is freed.
>>> 
>>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>>> Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
>>> ---
>>> drivers/bluetooth/hci_bcsp.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>> 
>> patch has been applied to bluetooth-next tree.
> I believe this bug requires stable tags, as it can potentially provide
> an arbitrary write (via __skb_unlink) and is triggerable locally with
> user privileges.

I do not have a reproducer for it, but if you do, feel free to propose it for -stable inclusion.

Regards

Marcel

