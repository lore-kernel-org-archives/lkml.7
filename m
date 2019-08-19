Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BFDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152E6214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="V5066buQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfHSVQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:16:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39171 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfHSVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:16:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so3584816qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7VHtZbwbPt3cU09BBgYw7poQEOj3jlMhPLiN2OljcMA=;
        b=V5066buQuRr78wQdPzw8kd+m7x1GprMPKKsq8UvUXMqKs6THmRiYon3hdSop+Iv3Nf
         QH08Eu+ZO8EjMIWyXXqmm44G9qd2I6gX3z8JNztDWPSHtPUR/5KYjuRSs78jtR4IXbtX
         rQ9TCsSBzZWdyQTXN9nVpBALK8CpMJvN6SCKPjySg5wGzt2nEgkoLLDBGOZgUgQX2W1u
         H9YycO2D1CULesTI+IibqTeaI3bEjg9pxdGQ10UMBT8bJ1ToDA8Jhwlx6EdNJ1X+NPmT
         5CanvyJJUq5MUN+GlXxf5Zm84mDDZpAezdiLU5c1JGci9+gl/2j484nsVWLXygexSZzM
         dRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7VHtZbwbPt3cU09BBgYw7poQEOj3jlMhPLiN2OljcMA=;
        b=V9hmpnaL6H3/gowaDatD65fuck39/SkQl9QuhYuWag0A98SE4/zi+RJW59fl13V20X
         +tpiKXmp3fWiJn7agiHUY5JoRJsniA6zLLsiObzv7f1kmy/AXxNNy6Uw/FOOb9h7fUY/
         EOXWN7fJviE5nn/UMdvfZLLV99/jTTVspd3/KNJVUQBbzNbaftQIR15XhszKfyZR07sc
         aOuT7RgIjTrpRAJy+tti9T0Sp1EMM1h2g8WhoVPpnVErBY9rR6xykscziXoE1bo6q92B
         bS98ciPrC5euE1Lq6dOdipJ0SXnbPpR5PBgRaN6aUKtCByCeyhm0zxtIAI5ITgjQL4K1
         x4rg==
X-Gm-Message-State: APjAAAV4REQqeH0d6H2XFptpjfvhrnX+ydVMvCTEDpKnVJRPvnEqGfq0
        uU9yOpeW1HtOu/08VKlBf4nICQ==
X-Google-Smtp-Source: APXvYqzNa4SUZDJ+Yo86loQ5/oKVNPe+0jCMpvUbyIavjYFzElEFIq6jpHvEwVtf2Aj0Pc1imbxMMw==
X-Received: by 2002:aed:2667:: with SMTP id z94mr23843274qtc.343.1566249381868;
        Mon, 19 Aug 2019 14:16:21 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id j50sm9644271qtj.30.2019.08.19.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:16:21 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:16:14 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+503339bf3c9053b8a7fc@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Eric Biggers <ebiggers@kernel.org>
Subject: Re: INFO: task hung in tls_sw_free_resources_tx
Message-ID: <20190819141614.10d5c07c@cakuba.netronome.com>
In-Reply-To: <000000000000cab053057c2e5202@google.com>
References: <000000000000cab053057c2e5202@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 00:48:02 -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6915bf3b002b net: phy: don't allow __set_phy_supported to ..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177085a3400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
> dashboard link: https://syzkaller.appspot.com/bug?extid=503339bf3c9053b8a7fc
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6996d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e2125400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+503339bf3c9053b8a7fc@syzkaller.appspotmail.com

#syz dup: INFO: task hung in aead_recvmsg
