Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895B623CB8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u05Zb0tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfE2QBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:01:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36442 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfE2QBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:01:07 -0400
Received: by mail-yw1-f66.google.com with SMTP id e68so1293773ywf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPrHCbcCsNef2jSZM/g/XQcezPiyqyIiC5REnh0/eSU=;
        b=u05Zb0trAPOZWtt+gcSapUiKAhRmlKzjqRravknOondeT/3wa6ADIj8DY7WfXOyOLH
         fMJMu9Q+2QLQKPNqpzfdlikJSWDoozUo+ep+yElgkrB07qG6DxzjbFOGSDR0DDwBdpib
         MV4TCgjHYk7KN0kP42CwWaFEu4bOCRnUJQPF08DFFI04VYgqDROaZ+Ec87P6gS+M+Lyf
         jwl1VZ94mKViet2J/Qz0H2dYP1PRGLJD3JSCqt1g7oorovfWQX5VAWjPX8vjxGtwurcB
         mswhIDPfza+bD3GdvMi8Vl+sGU+u9VECrmn3EpAK6PQzyU29oFdf1iA5x5CaLa3d0XiN
         B+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPrHCbcCsNef2jSZM/g/XQcezPiyqyIiC5REnh0/eSU=;
        b=ovpfLkLQGh0fd3f3VI0Crh2RlyMYB+25j3ujzGbculBwUK7N9D4JRydhqT80cSzrZU
         kOTT6DjWfCEayyE2tYBnWVbGAs/Af8+M4tbclnLr/Tusw+9/Flxm6vDkfuByr17AsPRG
         2naQeYrnd/FEgT06kTKlyrP+ji/vtlmj0PfhPv4GehpGQ0jSDbJLTLabgC2tXAceIsSp
         JgKXPSSSi9emc6wSArjPHUXbZBvNh+uGFRafIJIuyx2M6MTIdETHMDJDBXHH2VCk0dYN
         GU618cacvt7uUmlAo5grCigP+vQnjN2aUqHgM728z3q8L0+cOVjdAn1Mnw5gngTXIhQa
         q1Eg==
X-Gm-Message-State: APjAAAUYpa4xST8Q1hltq7ryUviZEfGXUTFGeLqTY9KWSKeBL7G9zBzl
        B0YjNKI4YpK5l3clU9RZP1a1uTZAT2ryImlySkdOg41wK+HY7Q==
X-Google-Smtp-Source: APXvYqwfxD9KIX8UqVjT1h6eHKGyi7P+1pkf9cBDw9YJsI/OY+BmVcm2eVABC+x9PT5lSCxxPsKn+fs9F+HYQe0nEp8=
X-Received: by 2002:a81:6946:: with SMTP id e67mr44438984ywc.424.1559145665722;
 Wed, 29 May 2019 09:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
 <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com> <eb730f01-0c6d-0589-36cc-7193d64c1ee8@molgen.mpg.de>
In-Reply-To: <eb730f01-0c6d-0589-36cc-7193d64c1ee8@molgen.mpg.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 May 2019 09:00:54 -0700
Message-ID: <CANn89i+VvwMaHy2Br-0CcC3gPQ+PmG3Urpn4KpqL0P7XBykmcw@mail.gmail.com>
Subject: Re: Driver has suspect GRO implementation, TCP performance may be compromised.
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 7:49 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Eric,
>
>
> Thank you for the quick reply.
>
> On 05/28/19 19:18, Eric Dumazet wrote:
> > On 5/28/19 8:42 AM, Paul Menzel wrote:
>
> >> Occasionally, Linux outputs the message below on the workstation Dell
> >> OptiPlex 5040 MT.
> >>
> >>     TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised.
> >>
> >> Linux 4.14.55 and Linux 5.2-rc2 show the message, and the WWW also
> >> gives some hits [1][2].
> >>
> >> ```
> >> $ sudo ethtool -i net00
> >> driver: e1000e
> >> version: 3.2.6-k
> >> firmware-version: 0.8-4
> >> expansion-rom-version:
> >> bus-info: 0000:00:1f.6
> >> supports-statistics: yes
> >> supports-test: yes
> >> supports-eeprom-access: yes
> >> supports-register-dump: yes
> >> supports-priv-flags: no
> >> ```
> >>
> >> Can the driver e1000e be improved?
> >>
> >> Any idea, what triggers this, as I do not see it every boot? Download
> >> of big files?
> >>
> > Maybe the driver/NIC can receive frames bigger than MTU, although this would be strange.
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index c61edd023b352123e2a77465782e0d32689e96b0..cb0194f66125bcba427e6e7e3cacf0c93040ef61 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -150,8 +150,10 @@ static void tcp_gro_dev_warn(struct sock *sk, const struct sk_buff *skb,
> >                 rcu_read_lock();
> >                 dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
> >                 if (!dev || len >= dev->mtu)
> > -                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised.\n",
> > -                               dev ? dev->name : "Unknown driver");
> > +                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised."
> > +                               " len %u mtu %u\n",
> > +                               dev ? dev->name : "Unknown driver",
> > +                               len, dev ? dev->mtu : 0);
> >                 rcu_read_unlock();
> >         }
> >  }
>
> I applied your patch on commit 9fb67d643 (Merge tag 'pinctrl-v5.2-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl):
>
>      [ 5507.291769] TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised. len 1856 mtu 1500


The 'GRO' in the warning can be probably ignored, since this NIC does
not implement its own GRO.

You can confirm this with this debug patch:

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
b/drivers/net/ethernet/intel/e1000e/netdev.c
index 0e09bede42a2bd2c912366a68863a52a22def8ee..014a43ce77e09664bda0568dd118064b006acd67
100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -561,6 +561,9 @@ static void e1000_receive_skb(struct e1000_adapter *adapter,
        if (staterr & E1000_RXD_STAT_VP)
                __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tag);

+       if (skb->len > netdev->mtu)
+               pr_err_ratelimited("received packet bigger (%u) than
MTU (%u)\n",
+                                  skb->len, netdev->mtu);
        napi_gro_receive(&adapter->napi, skb);
 }
