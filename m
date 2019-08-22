Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627A52064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEeYXn5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392779AbfHVRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:32:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47097 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392340AbfHVRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:32:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id p13so5835637qkg.13;
        Thu, 22 Aug 2019 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FtduzNMNJFnI5g1RLjKgEXAg+yuPVumc8YVJkrfUPo=;
        b=qEeYXn5zbDKeUYzAE395iJhxBSXY28NfVitbQtYAB3PyhcKFqVr0X8Y3AjTCXoMcUW
         5Q6LV4kVvOVUcpwcdQd+RF2OffQr24rN0eQZq3BDv/35RQTRjTQUYxMeKsFlsZsXaPfH
         YrcMBwU0UhDNBbqSYOlRU++IvVq++BtYBmhkts46VzrTmF8KclLlqgc+CHt2WtCJO2r6
         nIM7cD6wO544OQZp10ybXnkdiDQ+maOQ5nEjLFxf8tHi/wSXZ8JobjexChhEQFQRQPbi
         sY2neb0g/idAF/SUszOnQGAazwU50BHbnfUixRgwyyGMg7ihYlA73k5zIOtKUusHsRHS
         B4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FtduzNMNJFnI5g1RLjKgEXAg+yuPVumc8YVJkrfUPo=;
        b=omjU5eRsKW89ppqvusB+XjarLHZrKkQZ7FQ2qBQO1EZ5i3FiqN2uCFR3uog7vZqhgl
         QhgIWiwB3q4ElHQSJ/IlGJGkLi6NYYnH2wU8IiAxOLX7HFUILkL1NNv7ZZkMAaDbXATg
         9/8KjEWBC0dFh9KuiwRaF9HX6958poq52WwO1nZvnYW003aDwQuKzpmm+YDafbSAhs8N
         08mfLdwOUUhvfJ9cBOOPC0cdN1ct6d0kEbDaa/YsnWuvTqOzB77QDbAp/9hORUupP+N8
         Nfpb1yXISXxL8dGnWS9FEEocrHz5/GkPCoZWpm0RvWJomF1zTIdWGOEINlM+nis9nZTj
         26Zw==
X-Gm-Message-State: APjAAAV1rIPbhMutmHiI6uR45Z/Py/IdeWvmom+UqUIXmTC/UX6LUzX3
        TzMKMN4IKXsICk0twvHouYVr+/zz3Dztn+3usKc=
X-Google-Smtp-Source: APXvYqyZflRkrgrTQAX1CVrQ2mJ3BeQg/IFnw+nskWRQ/EeD1oK9/Sz/YX7dvuHcw7OXa0C9CcbV+WlmtaA2P/RjI/E=
X-Received: by 2002:a37:690:: with SMTP id 138mr101661qkg.184.1566495158839;
 Thu, 22 Aug 2019 10:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190822171243eucas1p12213f2239d6c36be515dade41ed7470b@eucas1p1.samsung.com>
 <20190822171237.20798-1-i.maximets@samsung.com> <CAKgT0UepBGqx=FiqrdC-r3kvkMxVAHonkfc6rDt_HVQuzahZPQ@mail.gmail.com>
In-Reply-To: <CAKgT0UepBGqx=FiqrdC-r3kvkMxVAHonkfc6rDt_HVQuzahZPQ@mail.gmail.com>
From:   William Tu <u9012063@gmail.com>
Date:   Thu, 22 Aug 2019 10:32:00 -0700
Message-ID: <CALDO+SYhU4krmBO8d4hsDGm+BuUAR4qMv=WzVa=jAx27+g9KnA@mail.gmail.com>
Subject: Re: [PATCH net v3] ixgbe: fix double clean of tx descriptors with xdp
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Ilya Maximets <i.maximets@samsung.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:21 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Thu, Aug 22, 2019 at 10:12 AM Ilya Maximets <i.maximets@samsung.com> wrote:
> >
> > Tx code doesn't clear the descriptors' status after cleaning.
> > So, if the budget is larger than number of used elems in a ring, some
> > descriptors will be accounted twice and xsk_umem_complete_tx will move
> > prod_tail far beyond the prod_head breaking the completion queue ring.
> >
> > Fix that by limiting the number of descriptors to clean by the number
> > of used descriptors in the tx ring.
> >
> > 'ixgbe_clean_xdp_tx_irq()' function refactored to look more like
> > 'ixgbe_xsk_clean_tx_ring()' since we're allowed to directly use
> > 'next_to_clean' and 'next_to_use' indexes.
> >
> > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> > ---
> >
> > Version 3:
> >   * Reverted some refactoring made for v2.
> >   * Eliminated 'budget' for tx clean.
> >   * prefetch returned.
> >
> > Version 2:
> >   * 'ixgbe_clean_xdp_tx_irq()' refactored to look more like
> >     'ixgbe_xsk_clean_tx_ring()'.
> >
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 29 ++++++++------------
> >  1 file changed, 11 insertions(+), 18 deletions(-)
>
> Thanks for addressing my concerns.
>
> Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Thanks.

Tested-by: William Tu <u9012063@gmail.com>
