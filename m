Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C7720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013579;
	bh=2mkObEo6LlmxjBd2w3s6aTYaklo2G5gAs02cLz8ru/o=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=ZobGZywaBguBc0pzI3P9fypxo7bzZTG/tYdkwePDPqFsoVRq/5oTIFu8VXeDGZgtn
	 l86+DnUFr5barykUDPh5rQb13lB5pxBDooQT7XFrJwerAplItQDryV1uh2n2a0oFRQ
	 sXWcyfHX/62j7ZgijXXtITcwQiVLekeDI0bQfNfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDKUM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:12:57 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BAC32084D;
        Thu, 11 Apr 2019 20:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013576;
        bh=2mkObEo6LlmxjBd2w3s6aTYaklo2G5gAs02cLz8ru/o=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=Y3SJrBf22cTLq0O9QPdjW8fvcl8rphwGSVzEeJS3WD71veMPW7RXQknHaha1dBvHM
         UmpD5y33SX9QiY8edZAsdyvY9GA2QXbnaGCh+TJsqueJQnW4Zy4b/PavFzuj88DHnJ
         a59tNaCVAQVd7NfzL1k9ohCdFZsgejGWnCpsu/Eo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANMq1KCBnvscDcwvV-dqFbn+TTxZ97WXMdGZdmPOOter-0HxnQ@mail.gmail.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-4-weiyi.lu@mediatek.com> <CANMq1KCBnvscDcwvV-dqFbn+TTxZ97WXMdGZdmPOOter-0HxnQ@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 2/9] clk: mediatek: Add new clkmux register API
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        stable@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155501357547.20095.14128079106803580356@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:12:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Please trim replies to save me time)

Quoting Nicolas Boichat (2019-03-14 16:21:26)
> On Tue, Mar 5, 2019 at 1:06 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > +static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
> > +{
> > +       struct mtk_clk_mux *mux =3D to_mtk_clk_mux(hw);
> > +       u32 mask =3D GENMASK(mux->data->mux_width - 1, 0);
> > +       u32 val;
> > +
> > +       regmap_read(mux->regmap, mux->data->mux_ofs, &val);
> > +       val =3D (val >> mux->data->mux_shift) & mask;
> > +
> > +       return val;
> > +}
> > +
> > +static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> > +{
> > +       struct mtk_clk_mux *mux =3D to_mtk_clk_mux(hw);
> > +       u32 mask =3D GENMASK(mux->data->mux_width - 1, 0);
> > +       unsigned long flags;
>=20
> Guenter reported the following issue
> (https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel=
/+/1524422):
> ""
> The construct conditionally acquiring a spinlock is too complex for
> gcc to understand. This results in the following build warning.
>=20
> drivers/clk/mediatek/clk-mux.c: In function
> 'mtk_clk_mux_set_parent_lock': ./include/linux/spinlock.h:279:3:
> warning: 'flags' may be used uninitialized in this function
>=20
> Other clock drivers avoid the problem by initializing flags with 0.
> Lets do that here as well.
> """

Ok. I'll squash in this fix.

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 877a883fa616..76f9cd039195 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -76,7 +76,7 @@ static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw,=
 u8 index)
 {
 	struct mtk_clk_mux *mux =3D to_mtk_clk_mux(hw);
 	u32 mask =3D GENMASK(mux->data->mux_width - 1, 0);
-	unsigned long flags;
+	unsigned long flags =3D 0;
=20
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
@@ -99,7 +99,7 @@ static int mtk_clk_mux_set_parent_setclr_lock(struct clk_=
hw *hw, u8 index)
 	struct mtk_clk_mux *mux =3D to_mtk_clk_mux(hw);
 	u32 mask =3D GENMASK(mux->data->mux_width - 1, 0);
 	u32 val, orig;
-	unsigned long flags;
+	unsigned long flags =3D 0;
=20
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
