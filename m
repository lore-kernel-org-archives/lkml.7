Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3223C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9973D21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5ukSfvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfI3PQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:16:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34263 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3PQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:16:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id d192so1984326ywa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I388+Z01uFqRgCbtUk48+rgrz9rQmtEtuuf2g+o19pY=;
        b=a5ukSfvY6P980pqVkLsW+uEWbZ9VaQLXqugiRcX/MQr1VBPIla0++Qo+7mM1hv4k6w
         vqilxzUFnQvz9ohd+HeDPd7J+oYdWcasbakPijayk83FA1ovIy5xVhRmxzWhM2KfoOS5
         fUuN7TCt2BP3zUBa46ZIHwvCOCJPpI3HKpJWDiP8RuSUNNes+5b7YbBUrpXFCbNyuLVR
         h4iz7768WqAZiH/3v1FJwmdcDeDOoIap2IPhyXE7umYuQoJQbxyS20mpDG8zC0sfWdXf
         mn0CFUr0263Eeng+NhSdMnpEglJic/HJ4s1j6jjeIFZ5jWlqLCTy4THjST0+9S8DRvtg
         jJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I388+Z01uFqRgCbtUk48+rgrz9rQmtEtuuf2g+o19pY=;
        b=RB+qcH9V4t+ey6CzZ8a6XKb6qv8TB5sMy/+7NUkkn5gCRMyBLgDP1312IchGefJ802
         bB8Q7PZx1q12heiOSFbbvh3w4iUlFEEgSmzuXzabkkbkPWAKPGmRtjU6lYDqMlFuJP3u
         8sk84iSpQbnqf8729isbkAuLggX8K7mkikYPUMBBMszh2r1FWz+0ofWNQ5ZhE6k5m2A5
         be0yC1uXFi5UcJK1+0NmCq6+3rzajgZHtlHqukcft6YQTWyETl/v1mZnw2TxCMspzpS8
         921migqGWqQYg6/OGNliLggm3J1F5j0awW1fFjrfTILcvWT9FuWCmZaf6RomsDCfZqfE
         pfiw==
X-Gm-Message-State: APjAAAVcC8fL/7PPjpRmXn3h6F+Y0QVbuCpT0F1tMagZMlnMNezIWUf+
        yK2be9ARADqO8oADDowgMwDxhHsQ
X-Google-Smtp-Source: APXvYqx+YfLBL2xC1gPzuL/SPHhA3pFp1TrWifLPUI/QvbWE/wBzcyZnOWCpQT1XATNCbfC0TPAcag==
X-Received: by 2002:a81:50c5:: with SMTP id e188mr12523940ywb.340.1569856613523;
        Mon, 30 Sep 2019 08:16:53 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id s187sm2888221ywd.27.2019.09.30.08.16.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 08:16:53 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id 129so3626538ywb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:16:52 -0700 (PDT)
X-Received: by 2002:a81:5883:: with SMTP id m125mr12936784ywb.64.1569856611672;
 Mon, 30 Sep 2019 08:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <1569646705-10585-1-git-send-email-srirakr2@cisco.com>
In-Reply-To: <1569646705-10585-1-git-send-email-srirakr2@cisco.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 30 Sep 2019 11:16:14 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfN5=xkYUKiafM3uKF37kV6mg0Cn5WGv2QF887Pyw5A5g@mail.gmail.com>
Message-ID: <CA+FuTSfN5=xkYUKiafM3uKF37kV6mg0Cn5WGv2QF887Pyw5A5g@mail.gmail.com>
Subject: Re: [PATCH] AF_PACKET doesnt strip VLAN information
To:     Sriram Krishnan <srirakr2@cisco.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 1:24 AM Sriram Krishnan <srirakr2@cisco.com> wrote:
>
> When an application sends with AF_PACKET and places a vlan header on
> the raw packet; then the AF_PACKET needs to move the tag into the skb
> so that it gets processed normally through the rest of the transmit
> path.
>
> This is particularly a problem on Hyper-V where the host only allows
> vlan in the offload info.

This sounds like behavior that needs to be addressed in the driver, instead?

> Cc: xe-linux-external@cisco.com
> ---
>  net/packet/af_packet.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e2742b0..cfe0904 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1849,15 +1849,35 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>         return 0;
>  }
>
> -static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
> +static int packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>         if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
>             sock->type == SOCK_RAW) {

If inside this branch, may miss packets with skb->protocol set to one
of the VLAN Ethertypes.

> +               __be16 ethertype;
> +
>                 skb_reset_mac_header(skb);
> +
> +               ethertype = eth_hdr(skb)->h_proto;
> +               /*
> +                * If Vlan tag is present in the packet
> +                *  move it to skb
> +               */
> +               if (eth_type_vlan(ethertype)) {
> +                       int err;
> +                       __be16 vlan_tci;
> +
> +                       err = __skb_vlan_pop(skb, &vlan_tci);
> +                       if (unlikely(err))
> +                               return err;
> +
> +                       __vlan_hwaccel_put_tag(skb, ethertype, vlan_tci);

What happens with multiple tags (QinQ)?

> +               }
> +
>                 skb->protocol = dev_parse_header_protocol(skb);
>         }
>
>         skb_probe_transport_header(skb);
> +       return 0;
>  }
>
>  /*
> @@ -1979,7 +1999,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>         if (unlikely(extra_len == 4))
>                 skb->no_fcs = 1;
>
> -       packet_parse_headers(skb, sock);
> +       err = packet_parse_headers(skb, sock);
> +       if (err)
> +               goto out_unlock;

This only tests the new return value in one of three callers of
packet_sendmsg_spkt.
