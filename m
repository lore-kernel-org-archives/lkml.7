Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61545C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 00:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2635E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 00:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnONe+iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfE2ATI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 20:19:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42074 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE2ATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 20:19:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id 188so614377ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtTsiX9fLP1ilIjEBEUD3JJBC+K61VnyY/gr7l2/6Ws=;
        b=NnONe+izAdPLfKUy8Po++z1ngR/rXmo0Qsl+xByZnGpvVdobMUqZHmA5KwfW7WvWn+
         3ANkzwb2vuN5lZMvzrHLkb+z4R+UVi8444eOuoN5YW4HeBzb8Z2ZJAWD69jp6XUnHar1
         +qNsraJtJTttKc32/+WD3i0TVrlFXtFKXk+jc37zgkA+cqBcCfGpqCAMo35/NJ4l2bsd
         O12WI/FQQAfYCWItMDxaZTQFN3AKY88Rif42fUDNgbOVSGUJge4tIMx2SCB0GioKjJXY
         9eQvgJudtOsEagr/IGzUNyv1kzMbDwpA4Ln4bQ/v5PcIdgTOKT6D+P/I4DS1JyUEU/X+
         T/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtTsiX9fLP1ilIjEBEUD3JJBC+K61VnyY/gr7l2/6Ws=;
        b=R9A1sVo7Syju7LFHbOvaPn0olXhbCD7rbf3mdsipqd7a2ZUTQE0/Iv6JrRgOpKE7ih
         f/M0Zx5xaQOKk/kUzF5035QjUmFL5/Y/IIU2h8lA30b5Kondk09zT6hDmW4mX14Ip3Kh
         /3VYFDMx2XqhcTRzYmaw4XhLtnWpw438E4mN3kCTzEKlodGQepZanxIXhvnehJpc5E0q
         k6myGs/BwHIKZTjU5/L8po/wHdp3GP8iuJsW5QX200wsXArZx2c2Q5Y1Jhk32VttsQ3C
         gRdfZPfYavW7knUm/E34xee2/0MUPpSjquIaqR2XnM/8ykD1RIGdyT2y7PRgk1a08Q6C
         DqPw==
X-Gm-Message-State: APjAAAX2432hNA4nUjFZMyVnOhgQIdwXk+ZNt7ijSvld7X7HbpTJCYZB
        wcLZTDtE+DNBZU2ixIS5X+QWXU4es2oEvZ7+XLQ=
X-Google-Smtp-Source: APXvYqwplNqkarrINTuU9IxbWBiqARqN45Gt9GkeoXDEmXe+Phow9DEhwG8Xi+THEJBYMpPcbgnAI2uVS2yJev3oqO0=
X-Received: by 2002:a2e:9b54:: with SMTP id o20mr4446799ljj.95.1559089145667;
 Tue, 28 May 2019 17:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190522004655.20138-1-fabiolima39@gmail.com> <20190522094130.GS31203@kadam>
In-Reply-To: <20190522094130.GS31203@kadam>
From:   Fabio Lima <fabiolima39@gmail.com>
Date:   Tue, 28 May 2019 21:18:47 -0300
Message-ID: <CAAM19CGt1UoAXgQWoO85k7UQ8r3rBx6S7-po1aC5OfQZbcO55Q@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Add missing blank lines
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em qua, 22 de mai de 2019 06:41, Dan Carpenter
<dan.carpenter@oracle.com> escreveu:
>
> On Tue, May 21, 2019 at 09:46:55PM -0300, Fabio Lima wrote:
> > This patch resolves the following warning from checkpatch.pl
> > WARNING: Missing a blank line after declarations
> >
> > Signed-off-by: Fabio Lima <fabiolima39@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_debug.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> > index 9f8446ccf..853362381 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
> > @@ -382,6 +382,7 @@ ssize_t proc_set_roam_tgt_addr(struct file *file, const char __user *buffer, siz
> >       if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
> >
> >               int num = sscanf(tmp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", addr, addr+1, addr+2, addr+3, addr+4, addr+5);
> > +
> >               if (num == 6)
> >                       memcpy(adapter->mlmepriv.roam_tgt_addr, addr, ETH_ALEN);
> >
>
> I'm sorry but this function is really such nonsense.  Can you send a
> patch to re-write it instead?
>
> drivers/staging/rtl8723bs/core/rtw_debug.c
>    371  ssize_t proc_set_roam_tgt_addr(struct file *file, const char __user *buffer, size_t count, loff_t *pos, void *data)
>    372  {
>    373          struct net_device *dev = data;
>    374          struct adapter *adapter = (struct adapter *)rtw_netdev_priv(dev);
>    375
>    376          char tmp[32];
>    377          u8 addr[ETH_ALEN];
>    378
>    379          if (count < 1)
>
> This check is silly.  I guess the safest thing is to change it to:
>                 if (count < sizeof(tmp))
>
>    380                  return -EFAULT;
>
> It should be return -EINVAL;
>
>    381
>    382          if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
>
> Remove the check for if the user passes a NULL buffer, because that's
> already handled in copy_from_user().  Return -EFAULT if copy_from_user()
> fails.
>
>         if (copy_from_user(tmp, buffer, sizeof(tmp)))
>                 return -EFAULT;
>
>
>    383
>
> Extra blank line.
>
>    384                  int num = sscanf(tmp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", addr, addr+1, addr+2, addr+3, addr+4, addr+5);
>
> You will need to move the num declaration to the start of the function.
>
>    385                  if (num == 6)
>    386                          memcpy(adapter->mlmepriv.roam_tgt_addr, addr, ETH_ALEN);
>
> If num != 6 then return -EINVAL;
>
>    387
>    388                  DBG_871X("set roam_tgt_addr to "MAC_FMT"\n", MAC_ARG(adapter->mlmepriv.roam_tgt_addr));
>    389          }
>    390
>    391          return count;
>    392  }
>
> regards,
> dan carpenter

Thanks for your feedback.
This is my first patch and I will send the second patch with
modifications that you suggest.

Fabio Lima
