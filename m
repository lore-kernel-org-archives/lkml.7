Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA926C74A46
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA624208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="BXakk6i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfGKF2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:28:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43997 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfGKF2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:28:44 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so9805770ios.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 22:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vPpImF5Vqld0BhLorZ2UCiGiPMT4QstG+jkRU93BArE=;
        b=BXakk6i+B/mMk1ySsZ/qSH7ctqYMX1lGtyLprFUsVqXsqlzjkdwSL8qS4OZPWsze6I
         o3V51LLVzqNAFGO4TOH9ujPEFFBZrJeEAvfOBs6GWxT2fZz4C/XtbPhi7/373AcjrRXn
         nE7clX0bDFFqeP/0qnL19V0821T0Z8gDynmpQSpVbvm9O6MHxKHz3qBzs33M/JABp3nT
         o04BZT/eoUGJixfuXumycJIpVSY+9P0QtM7GwnzT+vG55y/HR7o8y+0+r5cZKhM2maN7
         X6pCUiBtEHGDT7dnk2GbKXK/L+MdCJZjpKkzkZvagfmlOwcsPuXfnSBvB5Yss+GBab+1
         GIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vPpImF5Vqld0BhLorZ2UCiGiPMT4QstG+jkRU93BArE=;
        b=WofZHZ55Th+D2Ovoki+ynoLSgT7em7UStoLs+OrxPL9epq1acIJuY68K1OCYopZVku
         ggD+IrynxLwVUbEb53Fbr7FhX4s9e2StuEeQAYuwIUjLoZWQOZnfxWkm1AfVOFPgmR0i
         AeB0D1mUQLAldSLrUYgBceFAogBgecjVS+9NLRhJgNCyCvFZX3kKzI9K0v/KtiZSGYE0
         ICbJpkXrb7eLIpo6b+HzydUB/b7Pq8RnNG903pQ709zL8G2dYXX7gWmSSJx/E+l7jYl6
         a2jHiiS5v1VPtdR1qNJqXF2Ql+PzLOj0erlOmGY9AbXfW8MvRWikGlaRCeJpGXhqg0JA
         9spQ==
X-Gm-Message-State: APjAAAUTCY2mWjlCW2Bz1K64Tu76aJju9PmRVR2b7PcnlSMdMt30kjku
        vQGlOGEN89wBcPZojQKWnTsfTcpQp4s9jplbNedXRw==
X-Google-Smtp-Source: APXvYqyHmEbuz1Uj55NEuGO/TWtnoSaURWNYW+nMCYQIcZ52vGdo2OnUVAyO6h+soskohwMN93tfdQFAKxErBh4s0z8=
X-Received: by 2002:a02:b016:: with SMTP id p22mr1195853jah.121.1562822923206;
 Wed, 10 Jul 2019 22:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPpJ_edDcaBq+0DocPmS-yYM10B4MkWvBn=f6wwbYdqzSGmp_g@mail.gmail.com>
 <20190711052427.5582-1-jian-hong@endlessm.com>
In-Reply-To: <20190711052427.5582-1-jian-hong@endlessm.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 11 Jul 2019 13:28:06 +0800
Message-ID: <CAPpJ_edQRMiBcdB-dTxhti8nK0eX4GPRUOgimzWW1JC3ZZjRHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rtw88: pci: Rearrange the memory usage for skb in
 RX ISR
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-wireless@vger.kernel.org,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian-Hong Pan <jian-hong@endlessm.com> =E6=96=BC 2019=E5=B9=B47=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Testing with RTL8822BE hardware, when available memory is low, we
> frequently see a kernel panic and system freeze.
>
> First, rtw_pci_rx_isr encounters a memory allocation failure (trimmed):
>
> rx routine starvation
> WARNING: CPU: 7 PID: 9871 at drivers/net/wireless/realtek/rtw88/pci.c:822=
 rtw_pci_rx_isr.constprop.25+0x35a/0x370 [rtwpci]
> [ 2356.580313] RIP: 0010:rtw_pci_rx_isr.constprop.25+0x35a/0x370 [rtwpci]
>
> Then we see a variety of different error conditions and kernel panics,
> such as this one (trimmed):
>
> rtw_pci 0000:02:00.0: pci bus timeout, check dma status
> skbuff: skb_over_panic: text:00000000091b6e66 len:415 put:415 head:000000=
00d2880c6f data:000000007a02b1ea tail:0x1df end:0xc0 dev:<NULL>
> ------------[ cut here ]------------
> kernel BUG at net/core/skbuff.c:105!
> invalid opcode: 0000 [#1] SMP NOPTI
> RIP: 0010:skb_panic+0x43/0x45
>
> When skb allocation fails and the "rx routine starvation" is hit, the
> function returns immediately without updating the RX ring. At this
> point, the RX ring may continue referencing an old skb which was already
> handed off to ieee80211_rx_irqsafe(). When it comes to be used again,
> bad things happen.
>
> This patch allocates a new, data-sized skb first in RX ISR. After
> copying the data in, we pass it to the upper layers. However, if skb
> allocation fails, we effectively drop the frame. In both cases, the
> original, full size ring skb is reused.
>
> In addition, to fixing the kernel crash, the RX routine should now
> generally behave better under low memory conditions.
>
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D204053
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Cc: <stable@vger.kernel.org>
> ---

Sorry, I forget to place the version difference here.

v2:
 - Allocate new data-sized skb and put data into it, then pass it to
   mac80211. Reuse the original skb in RX ring by DMA sync.
 - Modify the commit message.
 - Introduce following [PATCH v3 2/2] rtw88: pci: Use DMA sync instead
   of remapping in RX ISR.

v3:
 - Same as v2.

v4:
 - Fix comment: allocate a new skb for this frame, discard the frame
if none available

>  drivers/net/wireless/realtek/rtw88/pci.c | 49 +++++++++++-------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wirel=
ess/realtek/rtw88/pci.c
> index cfe05ba7280d..c415f5e94fed 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -763,6 +763,7 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, st=
ruct rtw_pci *rtwpci,
>         u32 pkt_offset;
>         u32 pkt_desc_sz =3D chip->rx_pkt_desc_sz;
>         u32 buf_desc_sz =3D chip->rx_buf_desc_sz;
> +       u32 new_len;
>         u8 *rx_desc;
>         dma_addr_t dma;
>
> @@ -790,40 +791,34 @@ static void rtw_pci_rx_isr(struct rtw_dev *rtwdev, =
struct rtw_pci *rtwpci,
>                 pkt_offset =3D pkt_desc_sz + pkt_stat.drv_info_sz +
>                              pkt_stat.shift;
>
> -               if (pkt_stat.is_c2h) {
> -                       /* keep rx_desc, halmac needs it */
> -                       skb_put(skb, pkt_stat.pkt_len + pkt_offset);
> +               /* allocate a new skb for this frame,
> +                * discard the frame if none available
> +                */
> +               new_len =3D pkt_stat.pkt_len + pkt_offset;
> +               new =3D dev_alloc_skb(new_len);
> +               if (WARN_ONCE(!new, "rx routine starvation\n"))
> +                       goto next_rp;
> +
> +               /* put the DMA data including rx_desc from phy to new skb=
 */
> +               skb_put_data(new, skb->data, new_len);
>
> -                       /* pass offset for further operation */
> -                       *((u32 *)skb->cb) =3D pkt_offset;
> -                       skb_queue_tail(&rtwdev->c2h_queue, skb);
> +               if (pkt_stat.is_c2h) {
> +                        /* pass rx_desc & offset for further operation *=
/
> +                       *((u32 *)new->cb) =3D pkt_offset;
> +                       skb_queue_tail(&rtwdev->c2h_queue, new);
>                         ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_wor=
k);
>                 } else {
> -                       /* remove rx_desc, maybe use skb_pull? */
> -                       skb_put(skb, pkt_stat.pkt_len);
> -                       skb_reserve(skb, pkt_offset);
> -
> -                       /* alloc a smaller skb to mac80211 */
> -                       new =3D dev_alloc_skb(pkt_stat.pkt_len);
> -                       if (!new) {
> -                               new =3D skb;
> -                       } else {
> -                               skb_put_data(new, skb->data, skb->len);
> -                               dev_kfree_skb_any(skb);
> -                       }
> -                       /* TODO: merge into rx.c */
> -                       rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
> +                       /* remove rx_desc */
> +                       skb_pull(new, pkt_offset);
> +
> +                       rtw_rx_stats(rtwdev, pkt_stat.vif, new);
>                         memcpy(new->cb, &rx_status, sizeof(rx_status));
>                         ieee80211_rx_irqsafe(rtwdev->hw, new);
>                 }
>
> -               /* skb delivered to mac80211, alloc a new one in rx ring =
*/
> -               new =3D dev_alloc_skb(RTK_PCI_RX_BUF_SIZE);
> -               if (WARN(!new, "rx routine starvation\n"))
> -                       return;
> -
> -               ring->buf[cur_rp] =3D new;
> -               rtw_pci_reset_rx_desc(rtwdev, new, ring, cur_rp, buf_desc=
_sz);
> +next_rp:
> +               /* new skb delivered to mac80211, re-enable original skb =
DMA */
> +               rtw_pci_reset_rx_desc(rtwdev, skb, ring, cur_rp, buf_desc=
_sz);
>
>                 /* host read next element in ring */
>                 if (++cur_rp >=3D ring->r.len)
> --
> 2.22.0
>
