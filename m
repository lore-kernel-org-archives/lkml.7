Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC11C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B112054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOFpZ+eM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDCPjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:39:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37127 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:39:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id c16so15894075otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c83XSw9WZmj5Jn3nE1s5Y6yhi4CSNfQxb9DVAsE/PB8=;
        b=pOFpZ+eM9eKk2CMnhLYp8yeHteIg11aWOzZbXxLsmCY9Yp7/mgS4uF/7hzEM0F80Jd
         Dd9A1MUY3JE99Re7sOvXdqDw2blcRhnwE5VUjS0L4XimtwxmTV50xbZQE8/ftjqBcV0G
         jrUCDXrjn2NSd3Az4CblVD5/jg3GJYEsG6y3s/6EVgzv+JvxSbzFCz98dL6i/8Ue0bfT
         1RVp3N/rKXh1y8JyREyBPNYbkWSbbRG6sYt5UhCDC2W3Mtg/RK3YX3dcN1x8VznF1zrV
         g9bj8FwEJ/WRIYmJGDivViCQMTa1GjQtUtqGY9wSfY9I5j7lGEC/m5o7Zoy+5wNYJgRc
         yl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c83XSw9WZmj5Jn3nE1s5Y6yhi4CSNfQxb9DVAsE/PB8=;
        b=HytbFFdbkkl1KLOqkEDLJEYdMo63zN1eXKz0Kvpj+dB+c55IrsPlbVMEKQrJXeV/Qv
         tCJAT2eNg7eeDC22uFN3Bu4IQeNq5Uq59FDdjnTljKuo1mDelUOH2naQ+dcFKtIOavYD
         Btcs5ty09K8k5Vi9OojagJgzeJp3iyA/kYbCEL0gfjnBMQqRQNhH4NPa4DXlNWWM1lPb
         3n8g+4OpkpI7TCXHolH6iHUjR9YIr1KayF3S2MO0Zv8iYVuCedxbV+G0bYO5j3Nf9ew7
         dF/DENK66Fa9YezomvHcDWCAhkEjyzCV+TLw1eX5SAPGUOgPL1xiyY6eWPcHH8LUj5Lw
         7ZgA==
X-Gm-Message-State: APjAAAUeDxiychSmkhgMgIF0l5WDqK8iRDk6E/lSKVz1X35myIKy8CyY
        EuahmS3PIlwclaiLAv6BeBkCBwrIFzYJ3MIBiqdBSQ==
X-Google-Smtp-Source: APXvYqwidvCXB5zNkH15Z6Zr49ppZ+RA2hGPCZjGNr+aTzorwLS16L6ET4tztUC+wbp8mL20tXsnEhXWAExBHPCQ+nk=
X-Received: by 2002:a9d:dc4:: with SMTP id 62mr80988ots.211.1554305991662;
 Wed, 03 Apr 2019 08:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
In-Reply-To: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Wed, 3 Apr 2019 11:39:34 -0400
Message-ID: <CADVnQy=m7REuTMd7kOs95DwaG8A6gR+hDRfMsSKcyvB4M+PWzQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Accept ECT on SYN in the presence of RFC8311
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     Bob Briscoe <research@bobbriscoe.net>,
        "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:50 AM Tilmans, Olivier (Nokia - BE/Antwerp)
<olivier.tilmans@nokia-bell-labs.com> wrote:
>
> Linux currently disable ECN for incoming connections when the SYN
> requests ECN and the IP header has ECT(0)/ECT(1) set, as some
> networks were reportedly mangling the ToS byte, hence could later
> trigger false congestion notifications.
>
> RFC8311 =C2=A74.3 relaxes RFC3168's requirements such that ECT can be set
> one TCP control packets (including SYNs). The main benefit of this
> is the decreased probability of losing a SYN in a congested
> ECN-capable network (i.e., it avoids the initial 1s timeout).
> Additionally, this allows the development of newer TCP extensions,
> such as AccECN.
>
> This patch relaxes the previous check, by enabling ECN on incoming
> connections using SYN+ECT if at least one bit of the reserved flags
> of the TCP header is set. Such bit would indicate that the sender of
> the SYN is using a newer TCP feature than what the host implements,
> such as AccECN, and is thus implementing RFC8311. This enables
> end-hosts not supporting such extensions to still negociate ECN, and
> to have some of the benefits of using ECN on control packets.
>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> Suggested-by: Bob Briscoe <research@bobbriscoe.net>
> Cc: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>

Acked-by: Neal Cardwell <ncardwell@google.com>

Thank you for this patch, Olivier and Bob.

thanks,
neal
