Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157F6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35C3206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cv2L1PtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKSUsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:48:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38444 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSUsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:48:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so19187537qkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c788r5NW2qmkzzpVNhlK5wHnib53Ht136kdc4fIJn1U=;
        b=cv2L1PtAFjVVnPC9D4PdLdlDDET6/xRguA93Y3P+533wbzAeR+AMXMUGS8yo5DV0IP
         ZnVUqAjsrUIx9EBobNeEMRAWcDGV5vIp+1AGc8hkg+zl4CE/AFKOWfPkdnnyb4yJ9R4j
         aOBPlQFD+5sp80J1gLzm96SrtJKnAAKCiAvyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c788r5NW2qmkzzpVNhlK5wHnib53Ht136kdc4fIJn1U=;
        b=KuAgDvm2+0Gvyzk63sncjEgcYQygruwNvGsrA6ATLEn9GD6QVIczjiMzgpUW3lYbap
         aWPzZ/IMbPC55zmTEm0PHKB+yr9e5iZdIZHYqw7YkUgXvUVM202FDwVtepae6oQhAQL0
         m6tT1PLXoPY+MyCEyyIWYacbW14e25/flqkOqgU+eBaShbvVARYzXRN1shkXDLuqcg+p
         AFpmx71jxc9Pw811K8ziTmpw1rstVqxmSexrpZlgCXUWpmCg0ccgcblvFEy0ja2PD7HL
         uu3aMNPhar1z8q7Fm2S1sGrLmpJ1SdqAsOiqWXYwgZa4kKpf4OwyBgZQ2UX8jK1eaY/D
         szuw==
X-Gm-Message-State: APjAAAX8k0VJd5APUFjNwJikVThf7Oewv85eAZK1nJCQLjsqdj8OzKgo
        HfU/loyDWL4BHJe4SjO7WBxO4vcusQsZWEldL5jsjg==
X-Google-Smtp-Source: APXvYqx2FAmsLofOin4X6ZxdtxDqBpTxUaLASXaljwcG7oNUFmRwIFPwuYggh3ck8q/SZwFfFoh0kD2NRkYTdCUT2hU=
X-Received: by 2002:a37:d91:: with SMTP id 139mr28574128qkn.79.1574196530821;
 Tue, 19 Nov 2019 12:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <20191118110335.v6.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid> <989EE002-F3F4-441B-BD9B-B460D8B09708@holtmann.org>
In-Reply-To: <989EE002-F3F4-441B-BD9B-B460D8B09708@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 19 Nov 2019 12:48:40 -0800
Message-ID: <CANFp7mWUQFvk=gL5D9N6Fzd8wmfub5O8RF9CcWqwGr03oLJKkw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Bluetooth: btbcm: Support pcm configuration
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 9:35 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > Add BCM vendor specific command to configure PCM parameters. The new
> > vendor opcode allows us to set the sco routing, the pcm interface rate,
> > and a few other pcm specific options (frame sync, sync mode, and clock
> > mode). See broadcom-bluetooth.txt in Documentation for more information
> > about valid values for those settings.
> >
> > Here is an example trace where this opcode was used to configure
> > a BCM4354:
> >
> >        < HCI Command: Vendor (0x3f|0x001c) plen 5
> >                01 02 00 01 01
> >> HCI Event: Command Complete (0x0e) plen 4
> >        Vendor (0x3f|0x001c) ncmd 1
> >                Status: Success (0x00)
> >
> > We can read back the values as well with ocf 0x001d to confirm the
> > values that were set:
> >        $ hcitool cmd 0x3f 0x001d
> >        < HCI Command: ogf 0x3f, ocf 0x001d, plen 0
> >> HCI Event: 0x0e plen 9
> >        01 1D FC 00 01 02 00 01 01
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v6: None
> > Changes in v5: None
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> >
> > drivers/bluetooth/btbcm.c | 47 +++++++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btbcm.h | 16 +++++++++++++
> > 2 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > index 2d2e6d862068..df90841d29c5 100644
> > --- a/drivers/bluetooth/btbcm.c
> > +++ b/drivers/bluetooth/btbcm.c
> > @@ -105,6 +105,53 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> > }
> > EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
> >
> > +int btbcm_read_pcm_int_params(struct hci_dev *hdev,
> > +                           struct bcm_set_pcm_int_params *int_params)
> > +{
>
> the name should be _param and not _params since if I remember correctly that is how Broadcom specified it. Also just use param as variable name.

Technically, you are configuring multiple PCM params :)

>
> > +     struct sk_buff *skb;
> > +     int err = 0;
> > +
> > +     skb = __hci_cmd_sync(hdev, 0xfc1d, 5, int_params, HCI_INIT_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             err = PTR_ERR(skb);
> > +             bt_dev_err(hdev, "BCM: Read PCM int params failed (%d)", err);
> > +             return err;
> > +     }
> > +
> > +     if (!skb->data[0] && skb->len == sizeof(*int_params) + 1) {
> > +             memcpy(int_params, &skb->data[1], sizeof(*int_params));
> > +     } else {
> > +             bt_dev_err(hdev,
> > +                        "BCM: Read PCM int params failed (%d), Length (%d)",
> > +                        skb->data[0], skb->len);
> > +             err = -EINVAL;
> > +     }
> > +
> > +     kfree_skb(skb);
>
> I find these harder to read actually and it can be still fault at data[0] access.
>
>         if (skb->len != sizeof(*param) || skb->data[0]) {
>                 bt_dev_err(hdev, "BCM: Read SCO PCM int parameter failure");
>                 kfree_skb(skb);
>                 return -EIO;
>         }
>
>         memcpy(param, skb->data + 1, sizeof(*param));
>         kfree_skb(skb);
>         return 0;
> }
>

Sure. skb->len should be sizeof(*param) + 1 because there's an extra
byte for the status as well.

> > +
> > +     return err;
> > +}
> > +EXPORT_SYMBOL_GPL(btbcm_read_pcm_int_params);
> > +
> > +int btbcm_write_pcm_int_params(struct hci_dev *hdev,
> > +                            const struct bcm_set_pcm_int_params *int_params)
> > +{
> > +     struct sk_buff *skb;
> > +     int err;
> > +
> > +     /* Vendor ocf 0x001c sets the pcm parameters and 0x001d reads it */
>
> Scrap this comment.
>
> > +     skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             err = PTR_ERR(skb);
> > +             bt_dev_err(hdev, "BCM: Write PCM int params failed (%d)", err);
> > +             return err;
> > +     }
> > +     kfree_skb(skb);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(btbcm_write_pcm_int_params);
> > +
> > int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
> > {
>
> Otherwise this looks good.
>
> Regards
>
> Marcel
>

So generally, I've done a whole new patch series with every change.
Would you prefer to see singular updates on the same email thread or
should I keep doing new patch series?
