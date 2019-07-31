Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A50C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC6A20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Anx9+7Hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfGaWrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:47:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39462 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGaWrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:47:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so68173065qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mvHjIX1uETmKrf65GxFOMFRsSWX5lIF6LRU3P8/k6+A=;
        b=Anx9+7HbDTku25fwvipty5007KkvXfUfQ99I/9ymi8/C+5tgq0+fqH+ESHDJa5LQQn
         Nhb+HRDiuzm2jlaQUbug3kbBnW9oIiEy+Tdh8Xo5p93buxuOqTJpQBRTiS6NW7NBed4e
         7uEm/qD6l15bMXpx+3emqeF2MIEDiCDCIKIb1jLOwU521e6QthwKGaQym1C9uSI2aYkc
         QIjLgDhmvm2g0T1BQpEcdKlGbyUmoD0Kv9arJfgiYt8RAUvnYP4E1oq805xDVJ65h7ow
         /WY0AqlB0L+dcY4QewRIJhBf0aDlTm6gDdM00CbZyeGURz+EIlY2oYQlzznig4HOlRAO
         J6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mvHjIX1uETmKrf65GxFOMFRsSWX5lIF6LRU3P8/k6+A=;
        b=Pf4cUnOAjDFfM0nceDolZ/7YNjRPkt2RVphLawA4M+0jBjNmcJKwxem/IKcZR8hjor
         tF75L4x59ysCcXwi5GQqUXSk8uvzSEEa/dWe5d3Y9ooulTxZpPcp/PzNjtbf9qY3nR3I
         T7IEWpBn1XQDWbJYAhUe0SAwbWHTEErQLV5DwyLC9eijKiuzjG0OMHKvRU98qQmeCuuu
         9mVt6O0QRqAYIkt7Xd/TtOTy88WczOgQJOJBuT54cTBjwao+dc6O1Kp7PtKSK8q4Hpf+
         OoUDouWebxN4ALfl5zX9KERdCvbHT29CpMNK38BXnOpSj6q/HVFOK31yESQdtBJsTKTi
         q/1w==
X-Gm-Message-State: APjAAAX52eiVhdPvKEHbqRrgYs5t52N/KQvEV3DqtUnKDdgkIbY4QkVG
        KoJnO89bexCAx36xnEGEseHTGg==
X-Google-Smtp-Source: APXvYqwv6haSpTRkt0688fF5HFjqhLzpi63KUyext499GmsFPsTqU/DaoI5/SvZ2OI6nb8Y+Z/XmDg==
X-Received: by 2002:ac8:6b50:: with SMTP id x16mr89322591qts.246.1564613225939;
        Wed, 31 Jul 2019 15:47:05 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n93sm32201850qte.1.2019.07.31.15.47.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 15:47:05 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:46:50 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+f5731e2256eb5130dbd6@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: invalid-free in tls_sk_proto_cleanup
Message-ID: <20190731154650.3766622f@cakuba.netronome.com>
In-Reply-To: <00000000000010fb45058ef5eb52@google.com>
References: <00000000000010fb45058ef5eb52@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 01:29:05 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    fde50b96 Add linux-next specific files for 20190726
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ea7f3fa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4b58274564b354c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5731e2256eb5130dbd6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f5731e2256eb5130dbd6@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: double-free or invalid-free in tls_sk_proto_cleanup+0x216/0x3e0  
> net/tls/tls_main.c:300

FWIW there is a fix in the works for this and all new TLS issues.
I think John and Eric didn't have time yet to look at my theories,
so I'd like to keep it in QA for one extra day before posting.
